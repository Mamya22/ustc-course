<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录处理</title>
</head>
<body>
<%--登录处理 --%>
<%
request.setCharacterEncoding("UTF-8");
String name=request.getParameter("username");
String password=request.getParameter("password"); 
String password2=request.getParameter("password");
%>
    <% if("maxiaoya".equals(name) && "123456".equals(password) && (password==password2) )
	{
	%>
       <jsp:forward page="index.html"></jsp:forward>
    <%
	}
	else
	{
	%>
       <jsp:forward page="login.jsp"></jsp:forward>
	<%
	}
	%>

</body>
</html>
