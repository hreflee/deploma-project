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
   String newPairname = request.getParameter("pairname");
   String studentname = (String) session.getAttribute("user");
   int result = -1;
   if(newPairname != null && studentname != null){
   		if(newPairname.length() ==0 || studentname.length() ==0){
   			result = 5;
   		}
   		 else{
   	    	result = userMgr.checkPair(studentname, newPairname);
   		}
   }
  
   String msg = "";
   //1 - no student and no pair; 2 - no student but has pair; 3- has student but no pair;4 - has student and has pair
   switch(result){
      case 1:
      	msg="帮背人名字都可以使用!";
      	break;
      case 2:
      	msg="帮背人名字冲突!";
      	break;
      case 3:
      	msg="帮背人名字可以使用!";
      	break;
      case 4:
      	msg="帮背人名字有冲突!";
      	break;
      case 5:
      	msg="请填写帮背人名字!";
      	break;
   }
   out.print(msg);

%>
</body>
</html>

