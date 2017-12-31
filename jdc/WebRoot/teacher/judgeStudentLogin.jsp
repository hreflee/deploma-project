<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="entity.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application"/>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=gb2312">
    <title>学生登录与否</title> 
 <script src="../jquery-min.js" type="text/javascript"></script>

</head>
<body>
<% 
   String teachername = (String) session.getAttribute("user");
   String studentname = userMgr.getStudentName(teachername);
   int result = userMgr.judgeStudentLogin(teachername);
   if(result == 1){
   		out.print(" <font color=\"green\" >" + studentname + "已准备好，请点击\"我来帮你背单词\"开始背!</font>");
   }
   else
   {
   		out.print("<font color=\"red\" >" + studentname + " 尚未准备好，请勿点击\"我来帮你背单词!\"</font>");
   }

%>
</body>
</html>

