## 1 需求分析

## 总体设计
### 系统模块设计
页面文件
│      add_course.html  用于添加课程
│      add_paper.html   用于添加论文
│      add_project.html 用于增加项目
│      add_teach.html   用于增加教师-课程
│      course.html      用于course搜索，修改，删除等
│      homePage.html    首页
│      paper.html       用于paper搜索，修改，删除等
│      pdf.html         用于生成pdf
│      project.html     用于project搜索，修改，删除等
│      search.html      用于进行根据教师id的综合查询

后端操作
│  app.py   
│  db.py    初始化后端数据库
│  model.py 定义数据库


// 给出本系统的模块结构图（建议Visio画图），包括各级子模块，以及模块之间的接口关系。定义每个模块的基本功能。模块名称在整个报告中保持一致。