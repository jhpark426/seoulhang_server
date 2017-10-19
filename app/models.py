#-*- coding: utf-8 -*-
from datetime import datetime
from app import db
import sqlalchemy
from sqlalchemy.types import Integer, String, Unicode
####   플레이어정보 by jpark, ssm   ####
#####################################
class Grade(db.Model):
    __tablename__='grades'
    id=db.Column(db.Integer,primary_key=True)
    correct=db.Column(db.Integer)
    grade=db.Column(db.String(64))

    def __init__(self,id,correct,grade):
        self.id=id
        self.correct=correct
        self.grade=grade

class Player(db.Model):
    __tablename__='players'
    id=db.Column(db.String(64),primary_key=True)
    name=db.Column(db.String(64))
    password=db.Column(db.String(64))
    nickname=db.Column(db.String)
    email=db.Column(db.String(64))
    point=db.Column(db.Integer)
    questionstatus=db.Column(db.Integer)
    grade=db.Column(db.String(64))
    hint=db.Column(db.Integer)
    language=db.Column(db.Integer)
    logininfo=db.Column(db.String)
    create_time=db.Column(db.DateTime)

    def __init__(self,id,name,password,nickname,email,point=0,questionstatus=0,grade="Unrank",hint=1,language=0,logininfo="normal",create_time=None):
        self.id=id
        self.name=name
        self.password=password
        self.nickname=nickname
        self.email=email
        self.point=point
        self.questionstatus=questionstatus
        self.grade=grade
        self.hint=hint
        self.logininfo=logininfo
        self.language=language
        if create_time is None:
            create_time=datetime.utcnow()
            self.create_time=create_time

    player=db.relationship('Inventory',backref='post',cascade='all,delete-orphan',lazy='dynamic')

class EngRegion(db.Model):
    __tablename__='regions_eng'
    region_code=db.Column(db.Integer,primary_key=True)
    region_name=db.Column(db.String(64))
    explain=db.Column(db.String(64))

    def __init__(self,region_code, region_name, explain):
        self.region_code=region_code
        self.region_name=region_name
        self.explain=explain


    questions_eng=db.relationship('Eng',backref='post',cascade='all,delete-orphan',lazy='dynamic')


class Region(db.Model):
    __tablename__='regions'
    region_code=db.Column(db.Integer,primary_key=True)
    region_name=db.Column(db.String(64))
    explain=db.Column(db.String(64))

    def __init__(self,region_code, region_name, explain):
        self.region_code=region_code
        self.region_name=region_name
        self.explain=explain

    question=db.relationship('Question',backref='post',cascade='all,delete-orphan',lazy='dynamic')

class Question(db.Model):
    __tablename__='questions'
    question_code=db.Column(db.Integer,primary_key=True)
    region_code=db.Column(db.Integer,db.ForeignKey("regions.region_code"))
    train_code=db.Column(db.String(64))
    question_name=db.Column(db.String(64))
    line=db.Column(db.String(64))
    foreign_code=db.Column(db.String(64))
    x_coordinate=db.Column(db.Float)
    y_coordinate=db.Column(db.Float)
    question=db.Column(db.String(64))
    answer=db.Column(db.String(64))
    hint=db.Column(db.String(64))
    content_type=db.Column(db.String(64))

    def __init__(self,question_code,region_code, train_code, question_name, line, foreign_code, x_coordinate, y_coordinate, question,answer,hint,content_type):
        self.question_code=question_code
        self.region_code=region_code
        self.train_code=train_code
        self.question_name=question_name
        self.line=line
        self.foreign_code=foreign_code
        self.x_coordinate=x_coordinate
        self.y_coordinate=y_coordinate
        self.question=question
        self.answer=answer
        self.hint=hint
        self.content_type=content_type

class Eng(db.Model):
    __tablename__='questions_eng'
    question_code=db.Column(db.Integer,primary_key=True)
    region_code=db.Column(db.Integer,db.ForeignKey("regions_eng.region_code"))
    train_code=db.Column(db.String(64))
    question_name=db.Column(db.String(64))
    line=db.Column(db.String(64))
    foreign_code=db.Column(db.String(64))
    x_coordinate=db.Column(db.Float)
    y_coordinate=db.Column(db.Float)
    question=db.Column(db.String(64))
    answer=db.Column(db.String(64))
    hint=db.Column(db.String(64))
    content_type=db.Column(db.String(64))

    def __init__(self,question_code,region_code, train_code, question_name, line, foreign_code, x_coordinate, y_coordinate, question,answer,hint,content_type):
        self.question_code=question_code
        self.region_code=region_code
        self.train_code=train_code
        self.question_name=question_name
        self.line=line
        self.foreign_code=foreign_code
        self.x_coordinate=x_coordinate
        self.y_coordinate=y_coordinate
        self.question=question
        self.answer=answer
        self.hint=hint
        self.content_type=content_type

class Inventory(db.Model):
    __tablename__='inventory'
    id=db.Column(db.Integer,primary_key=True)
    player_code=db.Column(db.String,db.ForeignKey('players.id'))
    question_code=db.Column(db.Integer)
    status=db.Column(db.String(64),default=0)
    hintflag=db.Column(db.Integer)
    start_time=db.Column(db.DateTime)
    finish_time=db.Column(db.DateTime)

    def __init__(self,id,player_code,question_code,status,hintflag=0,start_time=None,finish_time=None):
        self.id=id
        self.player_code=player_code
        self.question_code=question_code
        self.status=status
        self.hintflag=hintflag
        if start_time is None:
            start_time=datetime.utcnow()
        self.start_time=start_time
        self.finish_time=finish_time

class FindInfo(db.Model):
    __tablename__='findinfo'
    id=db.Column(db.Integer,primary_key=True)
    player_id=db.Column(db.String,db.ForeignKey('players.id'))
    key=db.Column(db.String)

    def __init__(self, id, player_id, key):
        self.id =id
        self.player_id = player_id
        self.key = key

class Notice(db.Model):
    __tablename__='notice'
    id=db.Column(db.Integer,primary_key=True)
    title=db.Column(db.String)
    contents=db.Column(db.String)
    create_time=db.Column(db.DateTime,default=datetime.now)

    def __init__(self,id,title,contents,create_time):
        self.id=id
        self.title=title
        self.contents=contents
        if create_time is None:
            create_time=datetime.utcnow()
            self.create_time=create_timetime.now

class QuestionNum(db.Model):
    __tablename__='question_num'
    id = db.Column(db.Integer, primary_key=True)
    question_count = db.Column(db.Integer)

    def __init__(self, id, question_count=0):
        self.id = id
        self.question_count = question_count


class Profile(db.Model):
    __tablename__='profiles'
    id=db.Column(db.Integer,primary_key=True)
    function_name=db.Column(db.String(64))
    execution_sec=db.Column(db.Float)
    create_time=db.Column(db.DateTime,default=datetime.now)

    def __init__(self,id,function_name,execution_sec,create_time=None):
        self.id=id
        self.function_name=function_name
        self.execution_sec=execution_sec
        if create_time is None:
            create_time=datetime.utcnow()
            self.create_time=create_time
