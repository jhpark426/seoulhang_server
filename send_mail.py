import sys
import smtplib
import os
import xlrd
import json
import gmail

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.mime.base import MIMEBase
from email import encoders
from bson.objectid import ObjectId
from email.mime.text import MIMEText

translate_data = {}

class SendMail() :
    # data = {}
    def __init__(self,data):
        self.send_confirm_mail(data)

    def get_email_content(self, lost):
        f = open("app/import/find_"+lost+".txt","rb")
        raw_title = f.readline()
        title = raw_title.decode(encoding='UTF-8')
        content = ''
        # print("title is ",title)
        f.seek(f.tell())
        lines = f.readlines()
        for line in lines:
            new_string = line.decode(encoding='UTF-8')
            content += new_string
        # print("point location : ", f.tell())
        f.close()
        return (title,content)

    def send_confirm_mail(self,data):
        # user_index = data['user_index']
        # player = db.players.find_one({'userIndex':user_index})
        print ("여긴왓니!!!!")
        gmail_user = "hwipark426@gmail.com"
        gmail_pwd = "p1379|46q"
        # gmail_user = "cwh6272@naver.com"
        # gmail_pwd = "whwrkxek22##" #레드플랜트커피맛있다.

        lost = data['lost']
        FROM = gmail_user
        TO = data['email']
        email = data['email']
        password = data['password']
        name = data['name']
        pid = data['id']
        key = data['key']
        print ("여긴왓니!!")
        title = self.get_email_content(lost)[0]
        content = self.get_email_content(lost)[1]
        print ("여긴왓니!")
        content = content.replace("{name}", name)
        content = content.replace("{pid}", pid)
        content = content.replace("{password}", password)
        content = content.replace("{key}", key)
        content = content.replace("<br>", "\n")
        # # print("s smtplib 하기전에")
        print ("여긴왓니!!!!!")
        s = smtplib.SMTP('smtp.gmail.com',587)
        # s = smtplib.SMTP_SSL('smtp.naver.com',465)
        print ("여긴왓니!!@@@")
        try:
            msg = MIMEMultipart()
            msg["From"] = FROM
            msg["To"] = TO
            msg["Subject"] = title
            msg.attach(MIMEText(content,'html'))

            s.ehlo()
            s.starttls()
            s.login(gmail_user,gmail_pwd)
            s.sendmail(gmail_user,TO,msg.as_string())
            print('success!!!')


        except AttributeError as e:
            pass
            print("I/O error(): ",e)
        except smtplib.SMTPException as e:
            pass
            print("smtplib.SMTPException : ",e)
        except:
            pass
            # print("Unexpected error:", sys.exc_info()[0])
            print("failed...")

        s.close()
