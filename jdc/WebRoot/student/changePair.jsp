<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="entity.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>修改帮背人</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
 <link href="../CSS/all.css" rel="stylesheet" type="text/css" />
<script src="../jquery-min.js" type="text/javascript"></script>

<script type="text/javascript">
	var xmlHttp;
	window.onload = function() {
		checkPair();
	};
</script>
</head>

<body bgcolor="#DFFFBF">
	<h3>修改帮背人</h3>
	<button id='logout' type="button"
		onclick="javascript:window.location.href='../student/main.jsp'"
		class="button gray">返回</button>
	<form id="changePairForm" name="changePairForm" method="post"
		onsubmit="return isChangePairFormValid(changePairForm)"
		action="../student/servlet/ChangePair">
		<table>
			<tr>
				<%
				    String studentname = (String) session.getAttribute("user");				    
				    String pairname = userMgr.getTeacherName(studentname);
				    out.println("当前帮背人：" + pairname + "<br>");
					if (request.getParameter("error") != null) {
						out.println(request.getParameter("error"));
					}
				%>
			</tr>
			<tr align="left">
				<td align="left"  width="120px">新帮背人名：</td>
				<td><input  type="text"
					id="pairname" name="pairname" class="inputFrame"></td>
			</tr>
			<tr>
				<td align="left" width="120px">新帮背人密码：</td>
				<td><input  type="password"
					id="password" name="password" class="inputFrame">
				</td>
				<td align="left" width="120px">确认新帮背人密码：</td>
				<td><input  type="password"
					id="password2" name="password2" class="inputFrame">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="checkUser"></div>
				</td>
			</tr>

			<tr>
				<td colspan="2" align="center"><input type="submit" value="提交"></td>
			</tr>
		</table>
	</form>

</body>
</html>
