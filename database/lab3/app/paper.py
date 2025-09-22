from email import message
import time
from collections import defaultdict
from flask import Flask, redirect, render_template
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy, query
from inflection import titleize
from sqlalchemy import create_engine, extract
from zmq import NULL
from model import *
from datetime import date
from flask import flash

DB_URL = 'mysql+pymysql://root:123456@localhost/lab3'

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = DB_URL
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

project_trans_type = {1:"国家级项目",2:"省部级项目",3:"市厅级项目",4:"企业合作项目",5:"其他项目类型"}
paper_trans_type = {1:"full paper", 2:"short paper", 3:"poster paper", 4:"demo paper"}
paper_trans_level = { 1:"CCF-A", 2:"CCF-B", 3:"CCF-C", 4:"中文 CCF-A", 5:"中文 CCF-B", 6:"无级别"}
crouse_trans_term = {1:"春季学期",2:"夏季学期",3:"秋季学期"}
course_trans_type = {1:"本科生课程",2:"研究生课程"}
gender_trans = { 1:"男", 2:"女"}
title_trans = {1:"博士后",2:"助教",3:"讲师",4:"副教授",5:"特任教授",6:"教授",7:"助理研究员",8:"特任副研究员",9:"副研究员",10:"特任研究员",11:"研究员"}

# papers_global = []
# author_map = defaultdict(list)
# type_map = defaultdict(list)
# level_map = defaultdict(list)
# 查询paper 教师论文发表信息的查询，通过作者，年份，类型，级别，论文名查询
@app.route('/paper/search', methods=['POST'])
def get_papers():
    # papers_global.clear()
    # author_map.clear()
    # type_map.clear()
    # level_map.clear()

    paper_id = request.form.get('paper_id') or None
    paper_name = request.form.get('paper_name') or None
    paper_min_year = request.form.get('paper_min_year') or None
    paper_max_year = request.form.get('paper_max_year') or None
    paper_type = request.form.get('paper_type') or None
    paper_level = request.form.get('paper_level') or None
    teacher_name = request.form.get('teacher_name') or None

    query = db.session.query(Paper,PaperPublish,  Teacher).join(PaperPublish, Paper.P_id == PaperPublish.paper_id).join(Teacher, Teacher.T_id == PaperPublish.teacher_id)
    if teacher_name:
        query = query.filter(Teacher.T_name.like(f"%{teacher_name}"))
    if paper_id:
        query = query.filter(Paper.P_id == paper_id)
    if paper_name:
        query = query.filter(Paper.P_name.like(f"%{paper_name}"))
    if paper_min_year:
        query = query.filter(extract('year', Paper.P_year) >= int(paper_min_year))
    if paper_max_year:
        query = query.filter(extract('year', Paper.P_year) <= int(paper_max_year))
    if paper_type:
        query = query.filter(Paper.P_type == paper_type)
    if paper_level:
        query = query.filter(Paper.P_level == paper_level)
    results = query.distinct().all()

    paper_dict = {}
    final_paper = []
    for paper, publish,teacher in results:
        if paper.P_id not in paper_dict:
            type_map[paper.P_id] = paper_trans_type[paper.P_type]
            level_map[paper.P_id] = paper_trans_level[paper.P_level]
            final_paper.append(paper)
            paper_dict[paper.P_id] = paper
        author_map[paper.P_id].append([teacher.T_name, teacher.T_id, publish.rank, publish.is_rel])

    # global papers_global
    papers_global = final_paper
    return render_template('paper.html', papers=final_paper, author=author_map,type=type_map,level=level_map)
'''
根据添加的结果显示弹窗
'''
# 增加paper
@app.route('/paper/add', methods=['POST'])
def add_paper():
    # 获取信息
    paper_id = request.form.get('paper_id') or None
    paper_name = request.form.get('paper_name') or None
    paper_source = request.form.get('paper_source') or None
    paper_year = request.form.get('paper_date') or None
    paper_type = request.form.get('paper_type') or None
    paper_level = request.form.get('paper_level') or None

    teachers = request.form.getlist('teachers')  or None # 获取作者
    rel_id = request.form.get('corresponding_author') or None # 获取通讯作者id
    # print("paper_id   ", paper_id)
    # print("paper_name   ", paper_name)
    # print("paper_source   ", paper_source)
    # print("paper_year    ", paper_year)
    # print("paper_type    ", paper_type)
    # print("paper_level    ", paper_level)
    # print("teachers   ", teachers)
    # print("rel_id    ", rel_id)
    
    new_paper = Paper(P_id = paper_id,P_name=paper_name,P_source=paper_source, P_year=paper_year,P_type=paper_type, P_level=paper_level)

    # 更新paper表
    db.session.add(new_paper)
    db.session.commit()

    '''
    需要进行错误处理
    '''
    rank = 0
    rel = False
    for teacher in teachers:
        rank += 1
        if rank == rel_id:
            rel = True
        new_paper_publish = PaperPublish(teacher_id=teacher,paper_id=paper_id,rank=rank,is_rel=rel)
        db.session.add(new_paper_publish)
        db.session.commit()
    
    # 最终效果，希望是可以显示添加成功/失败等
    return redirect('/paper/show')

@app.route('/paper/update', methods=['POST'])
def update_paper():
    paper_id = request.form.get('paper_id') or None
    teacher_id = request.form.getlist('teacher_ids')
    teacher_name = request.form.getlist('teacher_names')
    teacher_rank = request.form.getlist('teacher_rank')
    is_corr = request.form.getlist('corresponding_author')
    print("paper_id", paper_id)
    print("teacher_id", teacher_id)
    print("teacher_names", teacher_name)
    print("teacher_names", teacher_rank)
    print("teacher_names", is_corr)
    count = 0
    for corr in is_corr:
        if corr:
            count += 1
    
    if count > 1:
        result = "通讯作者数量大于一"
    elif count == 0:
        result = "无通讯作者"

    for i in len(teacher_id):
        id = teacher_id[i]
        if id:
            t = db.session.get(Teacher,id)
            if t == None:
                result = f"教师{id}不存在"
            if t.T_name != t.T_name:
                result = f"教师{id}的姓名不匹配"
        try:
            publish = db.session.get(PaperPublish,(id,int(paper_id)))
            if publish:
                try:
                    publish.teacher_id = id
                    publish.rank = teacher_rank[i]
                    publish.is_rel = is_corr[i]
                    db.session.commit()
                except:
                    result = "编辑失败"
            else:
                new_publish = PaperPublish(teacher_id=id, paper_id=int(paper_id),rank=teacher_rank[i], is_rel=is_corr[i])
                db.session.add(new_publish)
                db.session.commit()
                result = "编辑成功"
        except:
            result = "编辑失败"


    return render_template('paper.html', papers=papers_global, author=author_map,type=type_map,level=level_map, result= result)

# 删除paper
@app.route('/paper/delete', methods=['POST'])
def delete_paper():
    paper_id = request.form.get('paper_id') or None
    # papers_global = request.form.get('paper') or None
    # print("global  ",papers_global)
    # print('paper   ', paper)
    try:
        paper = db.session.get(Paper, int(paper_id))
        # paper = Paper.query.get(paper_id)
        db.session.delete(paper)
        db.session.commit()
        result = "success"
    except:
        result = "fail"
    global author_map 
    global type_map 
    global level_map 
    global papers_global 
    final_paper = []
    for item  in papers_global:
        if item.P_id != int(paper_id):
            final_paper.append(item)

    return render_template('paper.html', result=result, papers = final_paper, author=author_map,type=type_map,level = level_map)
    # return redirect(f"/paper/search?result={result}")
