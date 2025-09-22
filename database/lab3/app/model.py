from flask import Flask, render_template
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy, query
from sqlalchemy import create_engine


DB_URL = 'mysql+pymysql://root:123456@localhost/lab3'

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = DB_URL
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class Teacher(db.Model):
    __tablename__ = 'Teacher'
    T_id = db.Column(db.String(5), primary_key=True)
    T_name = db.Column(db.String(256), nullable=False)
    T_gender = db.Column(db.Integer, nullable=False)
    T_title = db.Column(db.Integer, nullable=False)
    paper_publishes = db.relationship(
        'PaperPublish',
        backref='teacher',
        cascade='all, delete',
        passive_deletes=True
    )
    project_participates = db.relationship(
        'ProjectParticipate',
        backref='teacher',
        cascade='all, delete',
        passive_deletes=True
    )
    course_teaches = db.relationship(
        'CourseTeach',
        backref='teacher',
        cascade='all, delete',
        passive_deletes=True
    )

class Paper(db.Model):
    __tablename__ = 'Paper'
    P_id = db.Column(db.Integer, primary_key=True)
    P_name = db.Column(db.String(256), nullable=False)
    P_source = db.Column(db.String(256))
    P_year = db.Column(db.Date)
    P_type = db.Column(db.Integer, nullable=False, comment="论文类型: 1-full paper,2-short paper,3-poster paper,4-demo")
    P_level = db.Column(db.Integer, nullable=False,comment="论文级别: 1-CCF-A,2-CCF-B,3-CCF-C,4-中文CCF-A,5-中文CCF-B,6-无级别")

    publishes = db.relationship(
        'PaperPublish',
        backref='paper',
        cascade='all, delete',  # <--- 关键点
        passive_deletes=True    # <--- 对应外键 ON DELETE CASCADE
    )

class Project(db.Model):
    __tablename__ = 'Project'
    Pro_id = db.Column(db.String(256), primary_key=True)
    Pro_name = db.Column(db.String(256), nullable=False)
    Pro_source = db.Column(db.String(256))
    Pro_type = db.Column(db.Integer, nullable=False, comment="项目类型: 1-国家级项目,2-省部级项目,3-市厅级项目,4-企业合作项目.5-其它类型项目")
    Pro_money = db.Column(db.Float,comment="总经费")
    Pro_start_year = db.Column(db.Integer)
    Pro_end_year = db.Column(db.Integer)
    # 项目参与关系
    participants = db.relationship(
        'ProjectParticipate',
        backref='project',
        cascade='all, delete',
        passive_deletes=True
    )

class Course(db.Model):
    __tablename__ = 'Course'
    C_id = db.Column(db.String(256), primary_key=True)
    C_name = db.Column(db.String(256), nullable=False)
    C_time = db.Column(db.Integer)
    C_property = db.Column(db.Integer)
    teachers = db.relationship(
        'CourseTeach',
        backref='course',
        cascade='all, delete',
        passive_deletes=True
    )

class PaperPublish(db.Model):
    __tablename__ = 'paper_publish'
    teacher_id = db.Column(db.String(5), db.ForeignKey('Teacher.T_id', ondelete='CASCADE'),primary_key=True)
    paper_id = db.Column(db.Integer, db.ForeignKey('Paper.P_id', ondelete='CASCADE'),primary_key=True)
    rank = db.Column(db.Integer)
    is_rel = db.Column(db.Boolean)
    
class ProjectParticipate(db.Model):
    __tablename__ = 'project_participate'
    teacher_id = db.Column(db.String(5), db.ForeignKey('Teacher.T_id', ondelete='CASCADE'),primary_key=True)
    project_id = db.Column(db.String(256), db.ForeignKey('Project.Pro_id', ondelete='CASCADE'),primary_key=True)
    rank = db.Column(db.Integer)
    fund = db.Column(db.Float)
    
class CourseTeach(db.Model):
    __tablename__ = 'course_teach'
    teacher_id = db.Column(db.String(5), db.ForeignKey('Teacher.T_id', ondelete='CASCADE'),primary_key=True)
    course_id = db.Column(db.String(256), db.ForeignKey('Course.C_id', ondelete='CASCADE'),primary_key=True)
    year = db.Column(db.Integer)
    term = db.Column(db.Integer)
    hours = db.Column(db.Integer)

with app.app_context():
    # db.drop_all()
    # db.create_all()
    db.create_all()

