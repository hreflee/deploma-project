<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@page import="entity.*"%><%@page import="java.net.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>index Page</title>
        <style type="text/css">
<!--
.STYLE1 {
	font-family: "宋体";
	font-weight: bold;
	color: #000066;
	font-size: xx-large;
}
-->
        </style>
</head>
<%
    String username = (String) request.getParameter("username");
    String password = (String) request.getParameter("password");
    if(username != null){
    	userMgr.logout(username);
        
    }
    else{
        username = (String) session.getAttribute("user");
        if(username != null){
    		userMgr.logout(username);
    	}
    }
	if(session != null){
		session.setAttribute("priv", null);
		session.setAttribute("user", null);
	}
%>
<jsp:forward page="index.jsp"/>
    <body>
    </body>
</html>
