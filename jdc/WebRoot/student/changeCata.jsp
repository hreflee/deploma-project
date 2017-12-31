<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@page import="entity.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>切换词汇</title>      
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="英语,单词,突击,艾宾浩斯,记忆曲线">
	<link href="../CSS/all.css" rel="stylesheet" type="text/css" />
   <script src="../jquery-min.js" type="text/javascript"></script>
    <script src="../englishword.js" type="text/javascript"></script>
   
  </head>
  
  <body bgcolor="#DFFFBF">
  <h1>切换词汇</h1>  
  <button id='logout' type="button" onclick="javascript:window.location.href='../student/main.jsp'" class="button gray">回退 </button>
  <hr/>
  <form id="registerForm" name="registerForm" method="post" onsubmit="return isRegisterFormValid(registerForm)" action="../servlet/ChangeCata"  >
  <table>
 
 <tr height="5px">
 <td colspan="4">
 当前选定的词汇是：<%= new String(request.getParameter("cataName").getBytes("ISO-8859-1"),"utf-8") %>。

 </td>
 </tr>
  </tr>
 <tr height="5px">
 </tr>
 </tr>
 <tr height="5px">
 <td colspan="4">
 请重新选择要背诵的词汇：
  </td>
 </tr>
  <tr height="5px">
 </tr>
 <%
    java.util.HashMap<String,Cataglory> cataList = new java.util.HashMap<String,Cataglory>();
	cataList = userMgr.getCatagloryList();
	java.util.Iterator iterator = cataList.keySet().iterator();
    String cataName = (String) request.getParameter("cataName");
	while(iterator.hasNext()){
		Cataglory usercata = (Cataglory) cataList.get(iterator.next());
		if(!usercata.getCatagloryName().equals(cataName)){
	
   %>
 <tr><td align="center"><input type="radio" id="catagloryID1" name="catagloryID" value="<%=usercata.getCatagloryID()%>"></td>
     <td align="center" colspan="3"><%=usercata.getCatagloryName()%></td>
 </tr>
 <tr height="5px">
 </tr>
<% 
		}
 	}

%>
 <tr><td colspan="4" align="center"><input class="button gray" type="submit" value="提交" ></td>	</tr>
  </table>
			
</form>
	</body>
</html>
