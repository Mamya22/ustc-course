from ast import Try
from email import message
import glob
from multiprocessing import resource_tracker
# from sre_constants import SUCCESS
import time
from collections import defaultdict
from unittest import result
from flask import Flask, redirect, render_template, session,send_file
from flask import Flask, request,jsonify
from flask_sqlalchemy import SQLAlchemy, query
from inflection import titleize
from sqlalchemy import create_engine, extract
from wandb import summary
from zmq import NULL
from model import *
from datetime import date
from flask import flash
import pdfkit
DB_URL = 'mysql+pymysql://root:123456@localhost/lab3'

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = DB_URL
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
app.secret_key = 'a-super-secret-key-2025-06-01'


project_trans_type = {1:"国家级项目",2:"省部级项目",3:"市厅级项目",4:"企业合作项目",5:"其他项目类型"}
paper_trans_type = {1:"full paper", 2:"short paper", 3:"poster paper", 4:"demo paper"}
paper_trans_level = { 1:"CCF-A", 2:"CCF-B", 3:"CCF-C", 4:"中文 CCF-A", 5:"中文 CCF-B", 6:"无级别"}
crouse_trans_term = {1:"春季学期",2:"夏季学期",3:"秋季学期"}
course_trans_type = {1:"本科生课程",2:"研究生课程"}
gender_trans = { 1:"男", 2:"女"}
title_trans = {1:"博士后",2:"助教",3:"讲师",4:"副教授",5:"特任教授",6:"教授",7:"助理研究员",8:"特任副研究员",9:"副研究员",10:"特任研究员",11:"研究员"}

papers_global = []
author_map = defaultdict(list)
type_map = defaultdict(list)
level_map = defaultdict(list)
# 查询paper 教师论文发表信息的查询，通过作者，年份，类型，级别，论文名查询
@app.route('/paper/search', methods=['POST'])
def get_papers():
    global papers_global
    
    papers_global.clear()
    author_map.clear()
    type_map.clear()
    level_map.clear()

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
    paper_year = request.form.get('paper_year') or None
    paper_type = request.form.get('paper_type') or None
    paper_level = request.form.get('paper_level') or None

    teachers = request.form.getlist('teacher_names')  or None # 获取作者
    ids = request.form.getlist('teacher_ids')  or None # 获取作者
    ranks = request.form.getlist('teacher_rank')  or None # 获取作者
    rel_id = request.form.get('corresponding_author') or None # 获取通讯作者id
    if ranks:
        is_rel = [i == int(rel_id)-2 for i in range(len(ranks))]
    print("paper_id   ", paper_id)
    print("paper_name   ", paper_name)
    print("paper_source   ", paper_source)
    print("paper_year    ", paper_year)
    print("paper_type    ", paper_type)
    print("paper_level    ", paper_level)
    print("teachers   ", teachers)
    print("rel_id    ", rel_id)
    ranks = [int(rank) for rank in ranks]
    result = ""
    val = [0 for i in range(len(ranks)+1)]
    for rank in ranks:
        if val[rank] == 0:
            val[rank] = 1
        else:
            result = "排名重复"
            return render_template('add_paper.html', result = result)
    paper = db.session.get(Paper, int(paper_id))
    if paper:
        result = "论文已存在"
        return render_template('add_paper.html', result = result)
    try:
        # with db.session.begin():
            new_paper = Paper(P_id = int(paper_id),P_name=paper_name,P_source=paper_source, P_year=paper_year,P_type=paper_type, P_level=paper_level)
            # 更新paper表
            db.session.add(new_paper)
            for i in range(len(teachers)):
                if ids[i] == None:
                    continue
                t = db.session.get(Teacher, ids[i])
                if t==None:
                    db.session.rollback()
                    result = "该教师不存在"
                    return render_template('add_paper.html', result = result)
                if t.T_name != teachers[i]:
                    db.session.rollback()
                    result = f"{ids[i]}的姓名不对"
                    return render_template('add_paper.html', result = result)

                new_paper_publish = PaperPublish(teacher_id = ids[i], paper_id = int(paper_id), rank = int(ranks[i]), is_rel= is_rel[i])
                db.session.add(new_paper_publish)
            db.session.commit()

            result = "添加成功"
    except:
        db.session.rollback()
        result = "添加失败"

    '''
    需要进行错误处理
    '''

    
    # 最终效果，希望是可以显示添加成功/失败等
    return render_template('add_paper.html', result = result)

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
    result = ""
    if count > 1:
        result = "通讯作者数量大于一"
    elif count == 0:
        result = "无通讯作者"
    teacher_rank = [int(rank) for rank in teacher_rank]
    # 判断是否重复
    length = len(teacher_rank)
    value = [0 for i in range(length+1)]
    # if max(value) != 
    if result == "":
        for rank in teacher_rank:
            if value[rank] == 0:
                value[rank] = 1
            else:
                result = "论文作者排名重复"

    is_rel = [i == int(is_corr[0]) for i in range(length)]

    if result == "":
        try:
            with db.session.begin():
                for i in range(len(teacher_id)):
                    print(i)
                    id = teacher_id[i]
                    if id:
                        print(id)
                        t = db.session.get(Teacher,id)
                        print(t)
                        if t == None:
                            result = f"教师{id}不存在"
                            break
                        if t.T_name != teacher_name[i]:
                            result = f"教师{id}的姓名不匹配"
                            break
                        
                        publish = db.session.get(PaperPublish,(id,int(paper_id)))
                        print(publish)
                        if publish:
                            db.session.delete(publish)
                            # publish.teacher_id = id
                            # publish.rank = int(teacher_rank[i])
                            # publish.is_rel = int(is_corr[i])
                            # # db.session.commit()
                            # result = "编辑成功"
                        # else:
                        new_publish = PaperPublish(teacher_id=id, paper_id=int(paper_id),rank=int(teacher_rank[i]), is_rel=is_rel[i])
                        db.session.add(new_publish)
                        # db.session.commit()
                        result = "编辑成功"

        except:
            result = "编辑失败"
    print(result)
    return render_template('paper.html', papers=papers_global, author=author_map,type=type_map,level=level_map, result= result)

# 删除paper
@app.route('/paper/delete', methods=['POST'])
def delete_paper():
    paper_id = request.form.get('paper_id') or None
    try:
        with db.session.begin():
            paper = db.session.get(Paper, int(paper_id))
            # paper = Paper.query.get(paper_id)
            db.session.delete(paper)
            # db.session.commit()
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


@app.route("/paper/delete_publish", methods=["POST"])
def delete_paper_publish():
    data = request.get_json()
    teacher_id = data.get("teacher_id")
    paper_id = data.get("paper_id")
    print(teacher_id)
    print(paper_id)

    if not teacher_id or not paper_id:
        return jsonify({"success": False, "message": "缺少必要信息"})
    try:
        with db.session.begin():
            record = db.session.get(PaperPublish,(teacher_id,paper_id))
            print(record)
            if record:
                db.session.delete(record)
                # db.session.commit()
                return jsonify({"success": True})
            else:
             return jsonify({"success": False, "message": "记录不存在"})
    except:
        return  jsonify({"success": False, "message": "删除失败"})


@app.route('/project/add', methods=['POST'])
def add_project():
    project_name = request.form.get('project_name') or None
    project_type = request.form.get('project_type') or None
    project_source = request.form.get('project_source') or None
    project_id = request.form.get('project_id') or None
    project_amount = request.form.get('project_amount') or None
    teachers = request.form.getlist('teacher_names') or None
    teacher_ids = request.form.getlist('teacher_ids') or None
    teacher_ranks = request.form.getlist('teacher_rank') or None
    money = request.form.getlist('money') or None
    project_start_year = request.form.get('project_start_year') or None
    project_end_year = request.form.get('project_end_year') or None
    # 创建project实例
    money = [float(m) for m in money]
    teacher_ranks = [int(rank) for rank in teacher_ranks]
    total = 0
    for m in money:
        total += m
    
    result = ""
    if total != float(project_amount):
        result = "总金额不匹配"
        return render_template('add_project.html', result = result)
    print(result)
    val = [0 for i in range(100)]
    for i in teacher_ranks:
        if val[i] == 0:
            val[i] = 1
        else:
            result = "排名重复"
            return render_template('add_project.html', result = result)
    
    # try:
    with db.session.begin():
        new_project = Project(Pro_id=project_id, Pro_name=project_name, Pro_source=project_source, Pro_type=project_type, Pro_money=project_amount, Pro_start_year=project_start_year, Pro_end_year=project_end_year)
        db.session.add(new_project)
        # print(new)
        for i in range(len(teacher_ranks)):
            if teacher_ids[i] == None:
                continue
            t = db.session.get(Teacher, teacher_ids[i])
            if t.T_name != teachers[i]:
                result = f"教师{teacher_ids[i]}姓名不对"
                raise Exception
            new_pp = ProjectParticipate(teacher_id = teacher_ids[i], project_id = project_id, rank= teacher_ranks[i],fund = money[i])
            db.session.add(new_pp)
            
        result = "添加成功"
    # except:
    #     result = "添加失败"
    print(result)
    return render_template('add_project.html', result = result)

type_map_project = defaultdict(list)        
teacher_map_project = defaultdict(list)     
project_list = []   
@app.route('/project/search', methods=['POST'])
def search_project():

    project_name = request.form.get('project_name') or None
    project_type = request.form.get('project_type') or None
    project_source = request.form.get('project_source') or None
    project_id = request.form.get('project_id') or None
    project_amount_min = request.form.get('project_amount_min') or None
    project_amount_max = request.form.get('project_amount_max') or None
    teachers = request.form.getlist('teachers') or None
    # ID = request.form.getlist('ID') or None
    project_min_year = request.form.get('project_min_year') or None
    project_max_year = request.form.get('project_max_year') or None
    
    query = db.session.query(Project,ProjectParticipate,Teacher).join(ProjectParticipate, Project.Pro_id == ProjectParticipate.project_id).join(Teacher,Teacher.T_id == ProjectParticipate.teacher_id)

    if project_name:
        query = query.filter(Project.Pro_name.like(f"%{project_name}"))
    if project_type:
        query = query.filter(Project.Pro_type == project_type)
    if project_source:
        query = query.filter(Project.Pro_source.like(f"%{project_source}") )
    if project_id:
        query = query.filter(Project.Pro_id == project_id)
    if project_amount_max:
        query = query.filter(Project.Pro_money <= project_amount_max)
    if project_amount_min:
        query = query.filter(Project.Pro_money >= project_amount_min)
    if project_min_year:
        query = query.filter(Project.Pro_start_year >= project_min_year)
    if project_max_year:
        query = query.filter(Project.Pro_end_year <= project_max_year)
    if teachers:
        for item in teachers:
            # query = query.join(Teacher,Teacher.T_id == ProjectParticipate.teacher_id)
            query = query.filter(Teacher.T_name.like(f"%{item}"))
    # query.column_descriptions
    results = query.distinct().all()
    # print(results)
    global type_map_project
    global teacher_map_project
    global project_list
    project_list.clear()
    type_map_project.clear()
    teacher_map_project.clear()
    project_dict = {}
    for project, project_participate, teacher in results:
        if project.Pro_id not in project_dict:
            type_map_project[project.Pro_id] = project_trans_type[project.Pro_type]
            project_list.append(project)
            project_dict[project.Pro_id] = project
        teacher_map_project[project.Pro_id].append([teacher.T_name, teacher.T_id,project_participate.rank, project_participate.fund])
    print( type_map_project)

    return render_template('project.html', projects = project_list,teachers=teacher_map_project, type = type_map_project)

@app.route('/project/update', methods=['POST'])
def update_project():
    project_id = request.form.get("project_id") or None
    deleted_teachers = request.form.get("deleted_teachers") or None
    teacher_names = request.form.getlist("teacher_names") or None
    teacher_ids = request.form.getlist("teacher_ids") or None
    teacher_ranks = request.form.getlist("teacher_rank") or None
    teacher_fund = request.form.getlist("teacher_fund") or None
    total_fund = request.form.get("project_fund") or None

    print("project_id", project_id)
    print("deleted", deleted_teachers)
    print(teacher_names)
    print(teacher_ids)
    print(teacher_ranks)
    print(teacher_fund)
    result = "更新成功"
    teacher_ranks = [int(rank) for rank in teacher_ranks]
    teacher_fund = [ float(fund) for fund in teacher_fund]
    if deleted_teachers:
        deleted_teachers = deleted_teachers.split(',')

    total = 0
    print(teacher_fund)
    for fund in teacher_fund:
        total += fund
    print(fund)
    print(total_fund)

    if total != float(total_fund):
        result = "负责总金额不匹配"
        return jsonify({"success": False, "message": result})

    val = [0 for i in range(100)]
    for i in range(len(teacher_ranks)):
        if val[teacher_ranks[i]] == 0:
            val[teacher_ranks[i]] = 1
        else:
            result = "排名重复"
            return jsonify({"success": False, "message": result})
    try:    
        with db.session.begin(): # 启动事务
            if deleted_teachers:
                for t in deleted_teachers:
                    pp = db.session.get(ProjectParticipate, (t,project_id))
                    db.session.delete(pp)

            for i in range(len(teacher_ranks)):
                id = teacher_ids[i]
                name = teacher_names[i]
                if id == None:
                    continue

                if name:
                    teacher = db.session.get(Teacher, id)
                    if teacher.T_name != name:
                        result = f"负责人{id}姓名不对"
                        break
                    
                teacher = db.session.get(Teacher, id)
                if teacher == None:
                    result = f"负责人{id}不存在"
                    break

                prop = db.session.get(ProjectParticipate, (id, project_id))
                if prop:
                    db.session.delete(prop)
                    newP = ProjectParticipate(teacher_id=id, project_id=project_id, rank = teacher_ranks[i], fund = teacher_fund[i])
                    db.session.add(newP)
                else:
                    newP = ProjectParticipate(teacher_id=id, project_id=project_id, rank = teacher_ranks[i], fund = teacher_fund[i])
                    db.session.add(newP)
        teacher_map_project[project_id].clear()
        for i in range(len(teacher_fund)):
            teacher_map_project[project_id].append([teacher_names[i], teacher_ids[i], teacher_ranks[i], teacher_fund[i]])

    except:
        result = "更新失败"

    print(result)
    
    # teacher_map_project[project_id].clear()
    # for i in range(len(teacher_fund)):
    #     teacher_map_project[project_id].append([teacher_names[i], teacher_ids[i], teacher_ranks[i], teacher_fund[i]])
    return render_template('project.html', projects = project_list,teachers=teacher_map_project, type = type_map_project, result=result)     

@app.route('/project/delete', methods=['POST'])
def delete_project():
    project_id = request.form.get('project_id') or None
    print(project_id)
    try:
        project = db.session.get(Project, project_id)
        # project = Project.query.get(project_id)
        db.session.delete(project)
        db.session.commit()
        result = "success"
    except:
        result = "fail"
    global type_map_project
    global teacher_map_project
    global project_list
    final_project = []
    for project in project_list:
        if project.Pro_id != project_id:
            final_project.append(project)
    # print(papers)
    return render_template('project.html', projects = final_project,teachers=teacher_map_project, type = type_map_project, result=result)


course_list = []
course_term = defaultdict(list)
course_year = defaultdict(list)
course_teacher = defaultdict(list)
course_types = defaultdict(list)
teacher_list = {}

@app.route('/course/search', methods=['POST'])
def search_course():
    course_list.clear()
    course_term.clear()
    course_year.clear()
    course_teacher.clear()
    course_types.clear()
    course_name = request.form.get('course_name') or None
    course_id = request.form.get('course_id') or None
    course_min_year = request.form.get('course_min_year') or None
    course_max_year = request.form.get('course_max_year') or None
    course_type = request.form.get('course_type') or None
    teacher_name = request.form.get('teacher_name') or None
    term = request.form.get('term') or None
    query = db.session.query(Course, CourseTeach, Teacher).join(CourseTeach, Course.C_id == CourseTeach.course_id).join(Teacher, Teacher.T_id == CourseTeach.teacher_id)
    if course_name:
        query = query.filter(Course.C_name.like(f"{course_name}"))
    if course_id:
        query = query.filter(Course.C_id == course_id)
    if course_max_year:
        query = query.filter(CourseTeach.year <= course_max_year)
    if course_min_year:
        query = query.filter(CourseTeach.year >= course_min_year)
    if course_type:
        query = query.filter(Course.C_property == course_type)
    if term:
        query = query.filter(CourseTeach.term == term)
    if teacher_name:
        query = query.filter(Teacher.T_name.like(f"{teacher_name}"))
    results = query.distinct().all()
    course_id_list = {}
    # temp = []
    for course, ct, teacher in results:
        if course.C_id not in course_id_list:
            course_id_list[course.C_id] = course
            course_term[course.C_id] = crouse_trans_term[ct.term]
            course_types[course.C_id] = course_trans_type[course.C_property]
            course_year[course.C_id] = ct.year
            course_list.append(course)
            
        course_teacher[course.C_id].append([teacher.T_id,teacher.T_name,ct.hours])
    print(course_teacher)

        # teacher_list[course.C_id] 
        
    return render_template('course.html', courses =course_list,year=course_year, term = course_term, type = course_types, teacher= course_teacher)

@app.route('/course/delete', methods=['POST'])
def delete_course():
    course_id = request.form.get('course_id') or None
    courses = course_list
    try:
        # 删除有问题
        course = db.session.get(CourseTeach, course_id)
        # course = Course.query.get(course_id)
        print(course)
        db.session.delete(course)
        db.session.commit()
        
        courses.clear()
        for course in course_list:
            if course.C_id != course_id:
                courses.append(course)
        result = "success"
    except:
        result = "fail"
    print(course_id)
    print(result)
    # courses = course_list
    # for course in course_list:
    #     if course.C_id != course_id:
    #         courses.append(course)
    course_list = courses

    return render_template('course.html', courses =courses,year=course_year, term = course_term, type = course_types, teacher= course_teacher, result= result)


@app.route('/course/add', methods=['POST'])
def add_course():
    course_name = request.form.get('course_name') or None
    course_id = request.form.get('course_id') or None

    course_type = request.form.get('course_type') or None
    course_time = request.form.get('course_time')
    
    try:
        new_course = Course(C_id= course_id, C_name= course_name, C_time=course_time, C_property = course_type)
        db.session.add(new_course)
        db.session.commit()
        result = "success"
    except:
        result = "fail"
    
    print(result)

    return render_template('add_course.html', result = result)

@app.route('/course/add_teach', methods=['POST'])
def add_teach():
    course_year = request.form.get('course_year') or None
    course_id = request.form.get('course_id') or None
    print(course_id)
    # teacher_name = request.form.get('teacher_name') or None
    term = request.form.get('term') or None
    # teacher_id = request.form.get('teacher_id') or None
    teachers = request.form.getlist('teachers')
    course_times = request.form.getlist('course_times')
    # teachers
    result = ""
    course = db.session.get(Course, course_id)
    if course == None:
        result = "该课程不存在"
        return render_template('add_teach.html', result = result)
    print(course)
    count = 0
    print(result)
    for time in course_times:
        count += int(time)
    if count != course.C_time:
        result = "总学时不对等"
    else:
        try:
            for i in range(len(teachers)):
                new_courseTeach=CourseTeach(teacher_id=teachers[i], course_id=course_id,  year=course_year, term= term, hours= course_times[i])
                db.session.add(new_courseTeach)
                db.session.commit()
            result = "success"
        except:
            result = "fail"
    return render_template('add_teach.html', result = result)

@app.route('/course/update', methods=['POST'])
def update_course():
    year = request.form.get('course_year') or None
    course_id = request.form.get('course_id') or None
    course_name = request.form.get('course_name') or None

    term = request.form.get('course_term') or None
    teacher_ids = request.form.getlist('teacher_ids') or None
    teacher_names = request.form.getlist('teacher_names') or None
    teacher_times = request.form.getlist('teacher_times') or None
    course_type = request.form.get('course_type') or None # 课程性质
    course_time = request.form.get('course_time') or None # 总学时
    print(course_time)
    deleted_teachers = request.form.getlist("deleted_teachers") or None
    result = "更新成功"
    count = 0
    teacher_times = [int(t) for t in teacher_times]
    for t in teacher_times:
        count += t
    if count != int(course_time):
        result = "总学时不匹配"
        return render_template('course.html', courses =course_list,year=course_year, term = course_term, type = course_types, teacher= course_teacher, result= result)
    length = len(teacher_times)
    try:
        with db.session.begin():
            if deleted_teachers:
                for i in range(len(deleted_teachers)):
                    if deleted_teachers[i] == None:
                        continue
                    ct = db.session.get(CourseTeach, (deleted_teachers[i], course_id))
                    db.session.delete(ct)

            for i in range(length):
                ct = db.session.query(CourseTeach).filter(CourseTeach.teacher_id == teacher_ids[i], CourseTeach.course_id == course_id).first()
                print("ct", ct)
                if ct:
                    db.session.delete(ct)
                new_ct = CourseTeach(teacher_id = teacher_ids[i], course_id= course_id, year = year, term = term, hours = teacher_times[i])
                print("new_ct", new_ct)
                db.session.add(new_ct)
            course_year[course_id] = year
            course_teacher[course_id].clear()
            for i in range(len(teacher_ids)):
                course_teacher[course_id].append([teacher_ids[i], teacher_names[i], teacher_times[i]])
            
            # course_teacher[course_id] = teacher_names
            
            result = "更新成功"
    except:
        result = "更新失败"
    print(course_year)
    print(course_id)
    print(course_name)
    print(course_type)
    print(term)
    print(deleted_teachers)
    print(teacher_names)
    print(teacher_ids)
    print(teacher_times)
    # print(teachers)

    return render_template('course.html', courses =course_list,year=course_year, term = course_term, type = course_types, teacher= course_teacher, result= result)
    

course_res = []
paper_res = []
pro_res = []
@app.route('/id/search', methods=['POST'])
def id_search():
    teacher_id = request.form.get('teacher_id') or None
    min_year = request.form.get('course_min_year') or None
    max_year = request.form.get('course_max_year') or None
    session["search_params"] = {
        "teacher_id": teacher_id,
        "min_year": min_year,
        "max_year": max_year,
    }
    global course_res
    global paper_res
    global pro_res
    try:
        course_query = db.session.query(Course, CourseTeach, Teacher).join(CourseTeach, Course.C_id == CourseTeach.course_id).join(Teacher, Teacher.T_id == CourseTeach.teacher_id)
        course_query = course_query.filter(Teacher.T_id ==teacher_id)
        if min_year:
            course_query = course_query.filter(CourseTeach.year >= int(min_year))
        if max_year:
            course_query = course_query.filter(CourseTeach.year <= int(max_year))
        course_res = course_query.distinct().all()

        paper_query = db.session.query(Paper, PaperPublish, Teacher).join(PaperPublish, Paper.P_id == PaperPublish.paper_id).join(Teacher, Teacher.T_id == PaperPublish.teacher_id)
        paper_query = paper_query.filter(Teacher.T_id == teacher_id)
        if min_year:
            paper_query = paper_query.filter(extract('year', Paper.P_year) >= int(min_year))
        if max_year:
            paper_query = paper_query.filter(extract('year', Paper.P_year) <= int(max_year))
        paper_res = paper_query.distinct().all()

        pro_query = db.session.query(Project, ProjectParticipate, Teacher).join(ProjectParticipate, Project.Pro_id == ProjectParticipate.project_id).join(Teacher, Teacher.T_id == ProjectParticipate.teacher_id)
        pro_query = pro_query.filter(Teacher.T_id==teacher_id)
        if min_year:
            pro_query = pro_query.filter(Project.Pro_start_year >= int(min_year))
        if max_year:
            pro_query = pro_query.filter(Project.Pro_end_year <= int(max_year))
        pro_res = pro_query.distinct().all()
    except:
        course_res=None
        pro_res=None
        paper_res=None

    return render_template('search.html',papers= paper_res, projects=pro_res, courses=course_res, project_type = project_trans_type, paper_type=paper_trans_type,paper_level=paper_trans_level,course_term=course_trans_type, course_type=course_trans_type)

@app.route('/download')
def download_pdf():
    params = session.get("search_params", {})

    teacher_id = params.get("teacher_id")
    min_year = params.get("min_year")
    max_year = params.get("max_year")

    query = db.session.query(Teacher).filter(Teacher.T_id== teacher_id)
    t_info = query.distinct().all()
    # res = session.get("res", {})
    # course = res.get("course")
    # paper = res.get("paper")
    # project = res.get("project")
    html = render_template(
        "pdf.html",
        papers = paper_res,
        courses= course_res,
        project = pro_res,
        project_type = project_trans_type, paper_type=paper_trans_type,
        paper_level=paper_trans_level,course_term=course_trans_type, 
        course_type=course_trans_type,
        t_info = t_info,
        gender=gender_trans,
        title = title_trans,
        min_year = min_year,
        max_year = max_year
                           )
    path_wkthmltopdf = "D:\\wkhtmltopdf\\bin\\wkhtmltopdf.exe"
    pdf_path = "teacher_info.pdf"
    config = pdfkit.configuration(wkhtmltopdf=path_wkthmltopdf)
    pdfkit.from_string(html, pdf_path, configuration=config)
    return send_file(pdf_path, as_attachment=True)

@app.route('/')
def home():
    return render_template('homePage.html')

@app.route('/paper/show', methods=['GET'])
def paper_show_html():
    return render_template('paper.html')

@app.route('/paper/add', methods=['GET'])
def paper_add_html():
    return render_template('add_paper.html')

@app.route('/paper/search', methods=['GET'])
def paper_search_html():

    return render_template('paper.html', papers=papers_global, author=author_map,type=type_map,level=level_map)


@app.route('/project/show', methods=['GET'])
def project_show_html():
    return render_template('project.html')

@app.route('/project/add', methods=['GET'])
def project_add_html():
    return render_template('add_project.html')

@app.route('/course/show', methods=['GET'])
def course_show_html():
    return render_template('course.html')

@app.route('/course/add', methods=['GET'])
def course_add_html():
    return render_template('add_course.html')

@app.route('/course/add_teach', methods=['GET'])
def course_add_teach_html():
    return render_template('add_teach.html')

@app.route('/id/show',methods=['GET'])
def id_show():
    return render_template('search.html')

@app.route('/id/search',methods=['GET'])
def id_show2():
    return render_template('search.html')

if __name__ == '__main__':
    app.run()