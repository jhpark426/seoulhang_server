#####################################
###   by jpark, nolgong changsu   ###
#####################################

from random import randint
from app import db
from json import JSONEncoder
from datetime import datetime
from datetime import timedelta
from .models import Player, Profile
from json import dumps, JSONEncoder
from sqlalchemy import or_, and_
from datetime import datetime
from math import log2
import logging
import tornado
import time
## by nolgong changsu ##
class JSONEncoder(JSONEncoder):
    def default(self, o):
        # print("object : ", o)
        if isinstance(o, datetime):
            return int(mktime(o.timetuple()))
        return JSONEncoder.default(self, o)

class Command:
    def __init__(self, command, data):
        eval("self."+command+"(command, data)")

def make_plain_dict(obj):
    row = obj.__dict__.copy()
    del row['_sa_instance_state']
    for key in row:
        if isinstance(row[key], datetime):
            row[key] = int(row[key].strftime("%s"))
    return row

def convert_as_camel_case(obj):
    row = obj.__dict__.copy()
    del row['_sa_instance_state']
    for key in row.keys():
        # print("======")
        # print("old : " + key)
        new = "".join([ i for i in map(lambda x:x[0].upper() + x[1:], key.split("_"))])
        new = new[:][0].lower() + new[1:]
        # print("new : " + new)
        # print("======")
        row[new] = row.pop(key)
    return row

def profiling(f):
    # print("in profile f : ", f)
    def wrap(*args, **kwargs):
        # print("args : ", *args)
        time1 = time.time()
        result = f(*args, **kwargs)
        time2 = time.time()
        profile = Profile(function_name=f.__qualname__, execution_sec=(time2-time1))
        add_to_db(profile)
        # print('%s function took %0.3f ms' % (f.__qualname__, (time2-time1)*1000.0))
        return result
    return wrap

def add_to_db(row):
    db.session.add(row)
    db.session.commit()

def add_prefix_to_dict(prefix, dict_type):
    assert(type(dict_type)==dict)
    obj = {}
    for k in dict_type.keys():
        obj[str(prefix)+"_"+k] = dict_type[k]
    return obj

def jsonify(obj):
    row = obj.__dict__.copy()
    del row['_sa_instance_state']
    for key in row:
        if isinstance(row[key], datetime):
            row[key] = int(row[key].strftime("%s"))
    return row
