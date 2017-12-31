<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@page import="entity.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>注册用户</title>      
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="英语,单词,突击,艾宾浩斯,记忆曲线">
	<link href="CSS/all.css" rel="stylesheet" type="text/css" />
   <script src="jquery-min.js" type="text/javascript"></script>
    <script src="englishword.js" type="text/javascript"></script>
    <script type="text/javascript">    
     var xmlHttp; 
     window.onload = function(){ 
			registerCheckUser();
		}
    </script>
  </head>
  
  <body bgcolor="#DFFFBF">
  <h1>注册用户</h1>  
  <button id='logout' type="button" onclick="javascript:window.location.href='index.jsp'" class="button gray">回退 </button>
  <hr/>
  <form id="registerForm" name="registerForm" method="post" onsubmit="return isRegisterFormValid(registerForm)" action="servlet/Register"  >
  <table>
  <tr>
   <%
						     if(request.getParameter("error")!= null){
						     	out.println(new String(request.getParameter("error").getBytes("ISO-8859-1"),"utf-8"));
						     }
						      
  %>
  </tr>
  <tr align="left">
 <td align="left" width="80px"  class="inputLabel">学生名：</td>
 <td align="left" width="80px"><input class="inputFrame" type="text" id="studentName" name="studentName" ></td>
 <td align="left" width="80px" class="inputLabel">帮 背 人：</td>
 <td align="left" width="50px"><input class="inputFrame" type="text" id="pairname" name="pairname" ></td>
 </tr>
 <tr align="left">
 <td align="left" width="80px" class="inputLabel">密&nbsp;&nbsp;码：</td>
 <td align="left" width="50px"><input class="inputFrame" type="password" id="password" name="password" > 
 </td>
 <td align="left" width="80px" class="input.label">确认密码：</td>
 <td><input class="inputFrame" type="password" id="password2" name="password2"> 
 </td>
 </tr>
 <tr>
 <td colspan="4" class="alert">
	 <div id="checkUser"> 
	 </div>
 </td>
 </tr>
 <tr height="5px">
 <td colspan="4">
 请设定当前要背诵的词汇（登陆后可修改）：
 </td>
 </tr>
 <%
    java.util.HashMap<String,Cataglory> cataList = new java.util.HashMap<String,Cataglory>();
	cataList = userMgr.getCatagloryList();
	java.util.Iterator iterator = cataList.keySet().iterator();

	while(iterator.hasNext()){
		Cataglory usercata = (Cataglory) cataList.get(iterator.next());
	
   %>
 <tr><td align="center"><input type="radio" id="catagloryID1" name="catagloryID" value="<%=usercata.getCatagloryID()%>"></td>
     <td align="center" colspan="3"><%=usercata.getCatagloryName()%></td>
 </tr>
<% 
 }

%>
 <tr><td colspan="4" align="center"><input class="button gray" type="submit" value="提交" ></td>	</tr>
  </table>
			
</form>
	<p class="tips">
	提示：可使用中文名字注册。初始密码两人相同，待登录后可各自修改。
	<br>帮背人如暂无合适对象，可随意填写，学生用户登录后可修改帮背人。
	</p>
	</body>
</html>
