####################
###   by jpark   ###
####################
import os
basedir = os.path.abspath(os.path.dirname(__file__))

USERNAME = 'seoulhang'
PASSWORD = '1234'
DATABASE_NAME = "seoulhang"
SQLALCHEMY_DATABASE_URI = 'sqlite:///{0}/{1}.sqlite'.format(os.getcwd(),DATABASE_NAME)
# SQLALCHEMY_DATABASE_URI = 'postgresql://{0}:{1}@localhost:5432/{2}'.format(USERNAME, PASSWORD, DATABASE_NAME)
SQLALCHEMY_TRACK_MODIFICATIONS = True
DEBUG = True
# SQLALCHEMY_ECHO = True
SECRET_KEY = "d3*/wi32^sdxs0^$"

HOST = '0.0.0.0'
PORT = 500
