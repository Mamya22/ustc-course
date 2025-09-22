from flask import Flask, render_template
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy, query
from sqlalchemy import create_engine
import pymysql
from datetime import date
app = Flask(__name__)

def get_db_connection():
    connection = pymysql.connect(
        host='localhost',
        user='root',
        password='123456',
        database='lab3'
    )
    return connection

def init_teacher(connection, cursor):
    teacher_db = [
        ["T1","a",1,1],
        ["T2","b",2,2],
        ["T3","c",1,3],
        ["T4","d",2,4],
        ["T5","e",1,5],
        ["T6","f",2,6],
    ]
    for record in teacher_db:
        cursor.execute('INSERT INTO Teacher VALUES (%s, %s, %s, %s)', (record[0], record[1], record[2], record[3]))
        connection.commit()

def init_course(connection, cursor):
    course_db = [
        ["C1","ca",100,1],
        ["C2","cb",80,2],
        ["C3","cc",160,1],
        ["C4","cd",120,2],
        ["C5","ce",30,1],
    ]
    for record in course_db:
        cursor.execute('INSERT INTO Course VALUES (%s, %s, %s, %s)', (record[0], record[1], record[2], record[3]))
        connection.commit()  

def init_paper(connection, cursor):
    paper_db = [
        [1,"p1","ch",date(2020,1,1),1,1],
        [2,"p2","ch",date(2021,1,1),2,5],
        [3,"p3","ch",date(2019,1,1),4,2],
        [4,"p4","ch",date(2022,1,1),3,3],
        [5,"p5","ch",date(2023,1,1),2,4],
        [6,"p6","ch",date(2022,1,1),1,1],

    ]
    for record in paper_db:
        cursor.execute('INSERT INTO Paper VALUES (%s, %s, %s, %s, %s, %s)', (record[0], record[1], record[2], record[3], record[4], record[5]))
        connection.commit()  

def init_project(connection, cursor):
    project = [
        ["pro1","pro1","ch",1,200,2019,2020],
        ["pro2","pro2","ch",3,200,2019,2020],
        ["pro3","pro3","ch",2,200,2019,2020],
        ["pro4","pro4","ch",4,200,2019,2020],
        ["pro5","pro5","ch",5,200,2019,2020],
        ["pro6","pro6","ch",2,200,2019,2020],
    ]
    for record in project:
        cursor.execute('INSERT INTO project VALUES (%s, %s, %s, %s, %s, %s, %s)', (record[0], record[1], record[2], record[3], record[4], record[5], record[6]))  
        connection.commit()
def init_paperPublish(connection, cursor):
    paperPublish = [
        ["T1",1, 1, 1],
        ["T2",1, 2, 0],
        ["T3",2, 1, 1],
        ["T2",2, 2, 0],
        ["T4",2, 3, 0],
        ["T5",3, 1, 1],

    ]
    for record in paperPublish:
        cursor.execute('INSERT INTO paper_publish VALUES (%s, %s, %s, %s)', (record[0], record[1], record[2], record[3])  )
        connection.commit()

def init_projectParticipate(connection, cursor):
    projectParticipate = [
        ["T1",'pro1',1,200],
        ["T2",'pro2',1,100],
        ["T3",'pro2',2,100],
        ["T4",'pro3',1,200],
    ]
    for record in projectParticipate:
        cursor.execute('INSERT INTO project_participate VALUES (%s, %s, %s, %s)', (record[0], record[1], record[2], record[3])  )
        connection.commit()

def init_courseTeach(connection, cursor):
    courseTeach = [
        ["T2",'C4',2020,1,60],
        ["T5",'C4',2020,1,60], 
        ["T1",'C1',2020,1,100],

        ["T1",'C2',2020,1,80],
        ["T2",'C3',2021,1,160],
    ]
    for record in courseTeach:
        cursor.execute('INSERT INTO course_teach VALUES (%s, %s, %s, %s, %s)', (record[0], record[1], record[2], record[3], record[4])  )
        connection.commit()

connection = get_db_connection()
cursor = connection.cursor()
init_teacher(connection,cursor)
init_paper(connection,cursor)
init_course(connection,cursor)
init_project(connection,cursor)
init_paperPublish(connection,cursor)
init_courseTeach(connection,cursor)
init_projectParticipate(connection,cursor)
