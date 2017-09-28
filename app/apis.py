from flask import request
from flask_restful import Resource, Api
from sqlalchemy import or_, and_
from app import app
from .common import profiling, make_plain_dict
from .models import Player,Question,Region,Inventory,Grade,Eng,EngRegion,FindInfo
from tornado.ioloop import IOLoop
import tornado.web
from json import dumps
from json import JSONEncoder
import random
import operator
from datetime import datetime
from app import db
import time
from send_mail import SendMail
api = Api(app)

@app.route('/')
def hello_world():
    return 'Hello World!'

class PlayerFindUnit(Resource):
    # @profiling
    def get(self, player_id, password):
        print("ok", player_id)
        print("pok", password)
        pid = Player.query.filter(player_id == Player.id).first()
        ppass = Player.query.filter(password == Player.password).first()

        if pid is None:
            print("아디 확인하셈")
            return "No such player", 204

        if ppass is None:
            print("비번 확인하셈")
            return "No such player", 204

        player = make_plain_dict(pid)
        print("player get!: ", player['name'])
        return player

class PlayerUnit(Resource):
    @profiling
    def get(self, player_id):
        if len(request.args) == 0: return "TEST-CASE", 204

        if request.args['platform'] == 'android':
            p = Player.query.filter(player_id == Player.id).first()

            if p is None: return "No such player", 204

            player_pass = p.password
            player_birth = p.birth
            player = make_plain_dict(p)

            return player
        if request.args['platform'] == 'ios':
            p = Player.query.filter(player_id == Player.id).first()
            if p is None: return "No such player", 204

            return player

    @profiling
    def put(self, player_id):
        #player name이 null이 아니면 입력
        player_row = Player.query.filter(player_id == Player.id).first()
        if player_row is None: return "No such player.", 204

        player = make_plain_dict(player_row)
        player.update(add_prefix_to_dict("point", make_plain_dict(position_row)))

        add_to_db(player_row)
        return player

class QuestionCollection(Resource):
#   @profiling
    def get(self, player_id, question_code):
        print('---Call QuestionCollection %s %d---'%(player_id,question_code))

        player=Player.query.filter(Player.id==player_id).first()

        all_index=Inventory.query.order_by(Inventory.id)
        print("allindex1", all_index)
        all_index=list(all_index)

        if player.language==0:
            get_question=Question.query.filter(Question.question_code==question_code).first()
        else:
            get_question=Eng.query.filter(Eng.question_code==question_code).first()

        check_inven = Inventory.query.filter(Inventory.question_code==question_code).first()

        if check_inven == None:
            temp_inven=Inventory(id=len(all_index)+1, player_code=player_id, question_code=get_question.question_code, status='start')
            db.session.add(temp_inven)
            db.session.commit()

            player.questionstatus=1
            db.session.commit()

            return 1
        else:
            print('%s player already has question'%player_id)
            return 1

class Inventoryupdating(Resource):
    def get(self,player_id,question_code):

        print("---%s player call %s question inventory_updating---"%(player_id,question_code))

        get_player_index=Inventory.query.filter(Inventory.player_code==player_id).all()

        if len(get_player_index)==0:
            print('%s player is not exist in Inventory'%player_id)
            return 0

        for s in get_player_index:

            if s.question_code==question_code and s.status=='start':
                s.status='finish'
                s.finish_time=datetime.utcnow()
                db.session.commit()

                update_player_point=Player.query.filter(Player.id==player_id).first()
                update_player_point.point=update_player_point.point+10
                point=update_player_point.point

                db.session.commit()

                print(point/10)
                search_point=Grade.query.filter(Grade.correct==int(point/10)).first()

                if not search_point is None:
                    update_player_point.grade=search_point.grade
                    update_player_point.hint=update_player_point.hint+search_point.hint
                    db.session.commit()
                    print("%s player rank up"%player_id)
                    return 2

                print('%s player inventory updating success'%player_id)
                return 1

        print('%s player is not has start question'%player_id)
        return 0

#show player information
class MyInformation(Resource):
    def get(self,player_id):
        print("---%s player call selfInformation---"%player_id)

        get_player=Player.query.filter(Player.id==player_id).first()

        if get_player is None:
            print('Not in %s player'%player_id)
            return 0

        else:
            information=make_plain_dict(get_player)
            return information

#ranking
class Ranking(Resource):
    def get(self,player_id):
        player_rank=Player.query.filter(Player.id==player_id).first()

        print("---call ranking---")
        get_rank=Player.query.order_by(Player.point)
        print(get_rank)
        get_rank=list(get_rank)
        if len(get_rank)==0:
            print("Not in player")
            return 0
        ranking={}
        for s in get_rank:
            ranking[s.id]=s.point

        sorted_ranking=sorted(ranking.items(),key=operator.itemgetter(1),reverse=True)

        rank=1
        for s in sorted_ranking:
            if player_id in s:
                break
            rank+=1

        return_rank=[]
        temp={}

        search_player= Player.query.filter(Player.id==player_id).first()
        temp={
            "player_id":search_player.id,
            "player_name":search_player.nickname,
            "point":search_player.point,
            "rank":rank,
            "grade":search_player.grade
        }

        return_rank.append(temp)

        present_rank=1

        for s in sorted_ranking:
            temp={}
            search_player= Player.query.filter(Player.id==s[0]).first()
            temp={
                "player_id":search_player.id,
                "player_name":search_player.nickname,
                "point":search_player.point,
                "rank":present_rank,
                "grade":search_player.grade
            }
            present_rank+=1
            return_rank.append(temp)

        return return_rank

class Achievementrate(Resource):
    def get(self,player_id):

        print("---%s player call Achievement rate---"%player_id)


        player_question_list=Inventory.query.filter(Inventory.player_code==player_id).all()

        eng_player=Player.query.filter(Player.id==player_id).first()

        if eng_player.language==0:
            reference_list=Question.query.order_by(Question.question_code)
            region_list=Region.query.order_by(Region.region_code)
        else:
            reference_list=Eng.query.order_by(Eng.question_code)
            region_list=EngRegion.query.order_by(EngRegion.region_code)

        region_list=list(region_list)
        reference_list=list(reference_list)

        question_reference_dict={}
        for s in reference_list:
            question_reference_dict[s.question_code]=s.region_code

        check_dict={}
        for s in region_list:
            check_dict[s.region_code]=0


        for s in player_question_list:
            if s.status=='finish':
                check_dict[question_reference_dict[s.question_code]]+=1

        return_dict=[]
        rate_list=[]
        for s in region_list:
            count=0
            for w in reference_list:
                if s.region_code==w.region_code:
                    count=count+1
            rate_list.append(count)

        for index,val in enumerate(region_list):
            temp={}
            for w in reference_list:
                if val.region_code==w.region_code:
                    temp={
                    "region_name":val.region_name,
                    "explain":val.explain,
                    "rate":int(check_dict[val.region_code]/rate_list[index]*100)
                    }
            return_dict.append(temp)
        return return_dict

#show player have finish question_list
class Questionfinishlist(Resource):
    def get(self,player_id):

        print("---%s player call finish_question_list---"%player_id)
        question=[]
        get_question=Inventory.query.filter(Inventory.player_code==player_id).all()
        search_player=Player.query.filter(Player.id==player_id).first()

        if len(get_question)==0:
            print('%s player has No Question'%player_id)

            temp={
                "player_code":search_player.id,
                "player_name":search_player.nickname,
                "point":search_player.point,
                "hint":search_player.hint,
                "region_name":"0",
                "question_code":0,
                "question":"",
                "grade":search_player.grade
                }
            question.append(temp)
            return question

        else:

            for s in get_question:
                temp={}
                flag=0
                if s.status=='finish':
                    #eng_player=Player.query.filter(Player.id==player_id).first()
                    #search_player=Player.query.filter(Player.id==player_id).first()

                    if search_player.language==0:
                        get_region=Question.query.filter(Question.question_code==s.question_code).first()
                        get_region_name = Region.query.filter(Region.region_code==get_region.region_code).first()

                    else:

                        get_region=Eng.query.filter(Eng.question_code==s.question_code).first()
                        get_region_name = EngRegion.query.filter(EngRegion.region_code==get_region.region_code).first()


                    temp={
                        "player_code":search_player.id,
                        "player_name":search_player.nickname,
                        "point":search_player.point,
                        "hint":search_player.hint,
                        "region_name":get_region_name.region_name,
                        "question_code":get_region.question_code,
                        "question":get_region.question,
                        "grade":search_player.grade
                        }
                    question.append(temp)

            if len(question)==0:
                print("%s player has No finished question"%player_id)
                search_player=Player.query.filter(Player.id==player_id).first()
                temp={
                    "player_code":search_player.id,
                    "player_name":search_player.nickname,
                    "point":search_player.point,
                    "hint":search_player.hint,
                    "region_name":"0",
                    "question_code":0,
                    "question":"",
                    "grade":search_player.grade
                    }
                question.append(temp)
                return question

        for one_idx,one_val in enumerate(question):
            for two_idx,two_val in enumerate(question):
                if question[one_idx]['question_code']<question[two_idx]['question_code']:
                    question[one_idx],question[two_idx]=question[two_idx],question[one_idx]

        return question

#show player have start question_list
class Questionstartlist(Resource):
    def get(self,player_id):
        print("---%s player call start_question_list---"%player_id)
        get_inventory=Inventory.query.filter(Inventory.player_code==player_id).all()
        question=[]
        if len(get_inventory)==0:
            print("%s player has No question"%player_id)
            temp = {
                "regionname":"0",
                "questioncode":0,
                "question":"",
                "answer":"",
                "hint":"",
                "questiontype":""
            }
            question.append(temp)
            return question

        else:
            print("show me the Inventory")
            search_first_question=Inventory.query.order_by(Inventory.start_time)

            flag=0
            for s in search_first_question:
                if s.player_code==player_id and s.status=='start':
                    temp=s
                    flag=1
            print("flag", flag)

            if flag!=1:
                temp = {
                    "regionname":"0",
                    "questioncode":0,
                    "question":"",
                    "answer":"",
                    "hint":"",
                    "questiontype":""
                }
                question.append(temp)
                return question

            else:
                print("come0")
                search_player=Player.query.filter(Player.id==player_id).first()

                if search_player.language==0:
                    print("한글1")
                    get_question=Question.query.filter(Question.question_code==temp.question_code).first()
                    get_region = Region.query.filter(Region.region_code==get_question.region_code).first()
                else:
                    print("영어다1")
                    get_question = Eng.query.filter(Eng.question_code==temp.question_code).first()
                    print("asdfdsadsafads")
                    print("get_region", get_question.region_code)
                    get_region = EngRegion.query.filter(EngRegion.region_code==get_question.region_code).first()
                    print("come1")

                temp={}
                temp={
                    "regionname":get_region.region_name,
                    "questioncode":get_question.question_code,
                    "question":get_question.question,
                    "answer":get_question.answer,
                    "hint":get_question.hint,
                    "questiontype": str(get_question.content_type)
                }
                question.append(temp)
                print("com2")

                for s in get_inventory:
                    temp={}
                    flag=0
                    if s.status=='start':
                        if search_player.language==0:
                            print("한글2")
                            get_question = Question.query.filter(Question.question_code==s.question_code).first()
                            get_region = Region.query.filter(Region.region_code==get_question.region_code).first()
                        else:
                            print("영어다2")
                            get_question = Eng.query.filter(Eng.question_code==s.question_code).first()
                            get_region = EngRegion.query.filter(EngRegion.region_code==get_question.region_code).first()
                        print("come3")
                        temp = {
                            "regionname":get_region.region_name,
                            "questioncode":get_question.question_code,
                            "question":get_question.question,
                            "answer":get_question.answer,
                            "hint":get_question.hint,
                            "questiontype": str(get_question.content_type)
                        }

                        question.append(temp)
                        print("come4")
                if len(question)==0:
                    print("%s player has no start question"%player_id)
                    temp = {
                        "regionname":"0",
                        "questioncode":0,
                        "question":"",
                        "answer":"",
                        "hint":"",
                        "questiontype":""
                    }
                    question.append(temp)
                    return question

            return question

class SettingLanguage(Resource):
    #'/set_language/<string:player_id>/language/<int:language>')
    def get(self,player_id,language):
        search_player=Player.query.filter(Player.id==player_id).first()

        print("%s player call SettingLanguage"%player_id)
        if search_player is None:
            return 0
        else:
            search_player.language=language
            db.session.commit()

            return 1

class Checking(Resource):
    def get(self,player_id):
        search_player=Player.query.filter(Player.id==player_id).first()

        print("%s player call checking"%player_id)
        if search_player is None:
            return 0
        else:
            if search_player.questionstatus==1:
                search_player.questionstatus=0
                db.session.commit()
                print("call success")
                return 1
            else:
                print("call fail")
                return 0

class Hint(Resource):
    def get(self,player_id,question_code):
        search_player=Player.query.filter(Player.id==player_id).first()

        print("%s player call hint_update"%player_id)

        return_hint={}
        if search_player.hint==0:
            search_question=Inventory.query.filter(Inventory.question_code==question_code).first()
            return_hint={
                "hintcount":0,"hintflag":search_question.hintflag
            }
            return return_hint

        else:
            search_player.hint-=1
            db.session.commit()
            search_question=Inventory.query.filter(Inventory.question_code==question_code).first()
            search_question.hintflag=1
            db.session.commit()

            return_hint={
                "hintcount":1,
                "hintflag":search_question.hintflag
            }

            return return_hint

class CheckID(Resource):
    def get(self,player_id):
        search_player=Player.query.filter(Player.id==player_id).first()

        if not search_player is None:
            print("아이디가 겹친다.")
            return "already id", 204
        print("아이디가 안겹친다.")
        return player_id

class Regist(Resource):
    def get(self, player_id, password, name ,email, logininfo):

        print("회원가입한다. %s"%player_id)
        print("이름%s"%name)
        print("로그인정보", logininfo)

        if logininfo != 'normal':
            print("로그인정보", logininfo)
            player = Player.query.filter(Player.id == player_id).first()
            if player is None:
                insert_player=Player(id=player_id, password=password, nickname='', name=name, email=email, logininfo=logininfo, point=0)
                db.session.add(insert_player)
                db.session.commit()
                print("playerid : %s"%player_id)

                return player_id
            return player_id
        else:
            insert_player=Player(id=player_id, password=password, nickname='', name=name, logininfo=logininfo, email=email, point=0)
            db.session.add(insert_player)
            db.session.commit()
            print("playerid : %s"%player_id)

            return player_id
        return player_id

class FindId(Resource):
    def get(self, name, email):
        pname = Player.query.filter(name == Player.name).all()

        if pname is None:
            print("이름 확인하셈")
            return "No such player", 204

        pinfo = []
        pemail = ""
        pid = ""
        ppass = ""

        for b in pname:
            player = make_plain_dict(b)
            pinfo.append(player)

        for a in pinfo:
            if a['email'] == email:
                pemail = a['email']
                pname = a['name']
                pid = a['id']
                ppass = a['password']
                print("bbbb", pemail)

        print('aaaaaa', pemail)
        if pemail == "":
            print("이메일 확인하셈")
            return "No such player", 204

        print("찾기 성공")

        data = {'lost' : "id",
                'name' : pname,
                'id' : pid,
                'password' : ppass,
                'email' : pemail,
                'key' : ""
                }

        SendMail(data)

        info = {'id': pid, 'password' : ppass, 'name':pname, 'code': ""}
        return info

class FindPassword(Resource):
    def get(self, name, email, player_id):
        pid = Player.query.filter(player_id == Player.id).first()

        if pid is None:
            print("id 확인하셈")
            return "No such player", 204

        player = make_plain_dict(pid)
        print("get plyer!", player)

        pid = player['id']
        pname = player['name']
        pemail = player['email']
        ppass = player['password']

        if pemail != email:
            print("메일 확인하셈")
            return "No such player", 204

        if pname != name:
            print("이름 확인하셈")
            return "No such player", 204

        print("찾기 성공")

        key = ""
        for i in range(0,6):
            rand = random.randint(65,99)
            if rand > 90:
                temp = rand - 90
                key = key + str(temp)
            else:
                key = key + chr(rand)

        print ("여긴왓니1")
        data = {'lost' : "password",
                'name' : pname,
                'id' : pid,
                'password' : ppass,
                'email' : pemail,
                'key' : key
                }

        SendMail(data)

        all_index=FindInfo.query.order_by(FindInfo.id)
        all_index=list(all_index)

        finfo = FindInfo.query.filter(player_id == FindInfo.player_id).first()

        print("aaaa", finfo)

        if finfo is None:
            temp_add=FindInfo(id=len(all_index)+1, player_id=str(pid) , key = str(key))
            db.session.add(temp_add)

        else:
            finfo.player_id == player_id
            finfo.key = key

        db.session.commit()

        info = {"id": pid, "password" : ppass, "name":pname, "code": key}
        return info

class EnterCode(Resource):
    def get(self, player_id, code):
        fid = FindInfo.query.filter(player_id == FindInfo.player_id).first()
        player = make_plain_dict(fid)

        print("aaa", player['key'])
        code = code.upper()
        print("bbb", code)

        if player['key'] != code:
            print("실패")
            return "No such player", 204

        print("찾기 성공")
        return player

class UpdatePassword(Resource):
    def get(self, player_id, password):
        pid = Player.query.filter(player_id == Player.id).first()
        pid.password = password
        db.session.commit()
        print("비밀번호 변경")
        info = {"id": 'aa', "password" : 'aa', "name":'pname', "code": 'key'}
        return info

class Withdrawal(Resource):
    def get(self, player_id, password):
        pinfo = Player.query.filter(Player.id == player_id).first()
        if pinfo.password != password:
            return "password error", 204

        print("회원탈퇴를 시도한다..")
        return "success"

class RealWithdrawal(Resource):
    def get(self, player_id):
        Player.query.filter(Player.id == player_id).delete()
        db.session.commit()
        print("회원탈퇴를 했다.")
        return "success"

class EditProfile(Resource):
    def get(self, player_id, password, nickname, email):
        print("정보를 수정한다.")
        player = Player.query.filter(Player.id == player_id).first()
        if player.password != password:
            return "password error", 204
        player.nickname = nickname
        player.email = email
        db.session.commit()
        print("수정 성공")
        return "success"

class SendQuestionNumber(Resource):
    def get(self, player_id):
        pinven = Inventory.query.filter(Inventory.player_code == player_id).all()
        pinvenlist = []
        for i in pinven:
            pinvenlist.append(int(i.question_code))

        print("plyer inven", pinvenlist)
        return pinvenlist

class StartGame(Resource):
    def get(self, player_id):
        player = Player.query.filter(Player.id ==player_id).first()
        print("nickname", player.nickname)
        if player.nickname == "":
            print("nickname없다.")
            return 1
        print("nickname 있다.")
        return 0

class NewNickname(Resource):
    def get (self, player_id, nickname):
        player = Player.query.filter(Player.id == player_id).first()
        nickname = player.query.filter(Player.nickname == nickname).first()
        if not nickname is None:
            return "already nickname", 204

        player.nickname = nickname
        db.session.commit()
        print("수정 성공")
        return "success"

api.add_resource(Hint,'/hint_player/<string:player_id>/call_code/<int:question_code>')
api.add_resource(Checking,'/check_player/<string:player_id>')
api.add_resource(PlayerUnit, '/playerunit/<string:player_id>')
api.add_resource(PlayerFindUnit, '/players/<string:player_id>/password/<string:password>') #plural //로그인단.
api.add_resource(Achievementrate,'/rate/<string:player_id>')
api.add_resource(Ranking,'/ranking/<string:player_id>')
api.add_resource(MyInformation,'/information/<string:player_id>')
api.add_resource(QuestionCollection,'/collect/<string:player_id>/call_code/<int:question_code>')
api.add_resource(Inventoryupdating,'/update_player/<string:player_id>/call_code/<int:question_code>')
api.add_resource(Questionstartlist,'/start_player/<string:player_id>')
api.add_resource(Questionfinishlist,'/finish_player/<string:player_id>')
api.add_resource(SettingLanguage, '/setting_language/<string:player_id>/language/<int:language>')
api.add_resource(Regist,'/id/<string:player_id>/pass/<string:password>/name/<string:name>/email/<string:email>/logininfo/<string:logininfo>')
api.add_resource(CheckID,'/checkid/<string:player_id>')
api.add_resource(FindId,'/name/<string:name>/email/<string:email>')
api.add_resource(FindPassword,'/name/<string:name>/email/<string:email>/id/<string:player_id>')
api.add_resource(EnterCode,'/id/<string:player_id>/code/<string:code>')
api.add_resource(UpdatePassword, '/id/<string:player_id>/password/<string:password>')
api.add_resource(Withdrawal, '/withdrawal/id/<string:player_id>/password/<string:password>')
api.add_resource(RealWithdrawal, '/realwithdrawal/id/<string:player_id>')
api.add_resource(EditProfile, '/editprofile/id/<string:player_id>/password/<string:password>/nickname/<string:nickname>/email/<string:email>')
api.add_resource(SendQuestionNumber, '/quiznum/id/<string:player_id>')
api.add_resource(StartGame, '/startgame/id/<string:player_id>')
api.add_resource(NewNickname,'/newnickname/id/<string:player_id>/nickname/<string:nickname>')
