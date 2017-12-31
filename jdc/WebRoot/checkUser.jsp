<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="entity.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application"/>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=gb2312">
    <title>学生登录与否</title> 
 <script src="jquery-min.js" type="text/javascript"></script>

</head>
<body>
<% 
   String pairname = request.getParameter("pairname");
   pairname = java.net.URLDecoder.decode(pairname , "UTF-8"); 
   String studentname = request.getParameter("studentName");
    studentname = java.net.URLDecoder.decode(studentname , "UTF-8"); 
   int result = -1;
   if(pairname != null && studentname!= null){
   		if(pairname.length() ==0 || studentname.length() ==0){
   			result = 5;
   		}
   		 else{
   	    	result = userMgr.checkUser(studentname, pairname);
   		}
   }
   
   String msg = "";
   //1 - no student and no pair; 2 - no student but has pair; 3- has student but no pair;4 - has student and has pair
   switch(result){
      case 1:
      	msg= "<font color=\"green\">学生名和帮背人名字都可以使用</font>";
      	break;
      case 2:
      	msg= "学生名可以使用。帮背人名字冲突!";
      	break;
      case 3:
      	msg= "学生名冲突，帮背人名字可以使用!";
      	break;
      case 4:
      	msg="学生名和帮背人名字都有冲突!";
      	break;
      case 5:
      	msg="请同时填写学生名和帮背人名字。帮背人名字可由学生登陆后修改!";
      	break;
   }
   out.print(msg);

%>
</body>
</html>

