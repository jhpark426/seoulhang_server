# coding:UTF-8
from os import path
from xlrd import open_workbook
from .models import Player,Region,Question,Inventory,Grade,Eng,EngRegion,QuestionNum
from app import db

XL_PATH = '/import/DB_seoulhang.xlsx'
cwd_xl = path.dirname(path.abspath(__file__)) + XL_PATH
dir_strings = cwd_xl.split("/")
dir_strings = [i for i in dir_strings]
import_xl_path = "/".join(dir_strings)

def load_wb(path):
    return open_workbook(path)

def load_worksheet(wb, sheet_name):
    return wb.sheet_by_name(sheet_name)

def load_keys(sheet):
    return [ sheet.cell_value(0,i) for i in range(sheet.ncols)]

def _check_previous_populated():
    return Region.query.count()+Question.query.count()+Grade.query.count()+Eng.query.count()+EngRegion.query.count()

nh_wb = load_wb(import_xl_path)

db.create_all()


def _create_region():
    create_region=load_worksheet(nh_wb,"regions")
    for r in range(create_region.nrows-1):
        row={}
        for c,key in enumerate(load_keys(create_region)):
            row[key]=create_region.cell_value(r+1,c)

        s=Region(region_code=int(row["region_code"]),region_name=row["region_name"], explain=row["explain"])
        db.session.add(s)
    db.session.commit()

def _create_question():
    create_question=load_worksheet(nh_wb,"questions")
    for r in range(create_question.nrows-1):
        row={}
        for c, key in enumerate(load_keys(create_question)):
            row[key]=create_question.cell_value(r+1,c)
        q=Question(question_code=int(row["question_code"]),
                    region_code=int(row["region_code"]),
                    train_code=row["train_code"],
                    question_name=row["question_name"],
                    line=row["line"],
                    foreign_code=row["foreign_code"],
                    x_coordinate=float(row["x_coordinate"]),
                    y_coordinate=float(row["y_coordinate"]),
                    question=row["question"],
                    answer=row["answer"],
                    hint=row["hint"],
                    content_type=row["content_type"])
        db.session.add(q)
    db.session.commit()

def _create_grade():
    create_grade=load_worksheet(nh_wb,"grades")
    for r in range(create_grade.nrows-1):
        row={}
        for c,key in enumerate(load_keys(create_grade)):
            row[key]=create_grade.cell_value(r+1,c)
        g=Grade(id=int(row["id"]),correct=int(row["correct"]),grade=row["grade"])
        db.session.add(g)
    db.session.commit()

def _create_eng():
    create_eng=load_worksheet(nh_wb,"questions_eng")
    i=0
    for r in range(create_eng.nrows-1):
        i=i+1
        print(i)
        row={}
        for c,key in enumerate(load_keys(create_eng)):
            row[key]=create_eng.cell_value(r+1,c)
        q=Eng(question_code=int(row["question_code"]),
                    region_code=int(row["region_code"]),
                    train_code=row["train_code"],
                    question_name=row["question_name"],
                    line=row["line"],
                    foreign_code=row["foreign_code"],
                    x_coordinate=float(row["x_coordinate"]),
                    y_coordinate=float(row["y_coordinate"]),
                    question=row["question"],
                    answer=row["answer"],
                    hint=row["hint"],
                    content_type=row["content_type"])
        db.session.add(q)
    db.session.commit()

def _create_eng_region():
    create_eng_region=load_worksheet(nh_wb,"regions_eng")
    for r in range(create_eng_region.nrows-1):
        row={}
        for c,key in enumerate(load_keys(create_eng_region)):
            row[key]=create_eng_region.cell_value(r+1,c)
        s=EngRegion(region_code=int(row["region_code"]),region_name=row["region_name"], explain=row["explain"])
        db.session.add(s)
    db.session.commit()

def _create_count():
    create_count=load_worksheet(nh_wb, "question_num")
    for r in range(create_count.nrows-1):
        row={}
        for c,key in enumerate(load_keys(create_count)):
            row[key]=create_count.cell_value(r+1,c)
        s = QuestionNum(id=int(row["question_code"]), question_count=int(row["question_count"]))
        db.session.add(s)
    db.session.commit()

def create_all():
    if _check_previous_populated():
        return
    _create_region()
    _create_question()
    _create_grade()
    _create_eng_region()
    _create_eng()
    _create_count()
create_all()
