<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="entity.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>修改密码</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
 <link href="../CSS/all.css" rel="stylesheet" type="text/css" />
<script src="../jquery-min.js" type="text/javascript"></script>

<script type="text/javascript">
	function isValid(form) {
		var msg = "\错误提示：\n\n";
		oldPassword = form.oldPassword.value;
		password = form.password.value;
		password2 = form.password2.value;
		
		if (oldPassword.length == 0)//判定老密码是否为空
		{
			msg += "您的原密码为空，请填写！\n";
			form.oldPassword.focus();
			alert(msg);
			return false;
		}
		if (password.length == 0)//判定密码是否为空
		{
			msg += "您的新密码为空，请填写！\n";
			form.password.focus();
			alert(msg);
			return false;
		}

		if (password2.length == 0)//判定密码是否为空
		{
			msg += "您再次输入密码为空，请填写！\n";
			form.password2.focus();
			alert(msg);
			return false;
		}

		if (password != password2)//判定密码是否为空
		{
			msg += "两次密码不同，请填写！\n";
			form.password.value = "";
			form.password2.value = "";
			form.password.focus();
			alert(msg);
			return false;
		}

		return true;
	}
</script>
</head>

<body bgcolor="#DFFFBF">
	<h3>修改密码</h3>
	<button id='back' type="button" onclick="javascript:window.location.href='../teacher/main.jsp'" class="button gray">返回 </button>
	<form id="registerForm" name="registerForm" method="post"
		onsubmit="return isValid(registerForm)" action="../servlet/ChangePassword">
		<table>
			<tr>
				<td>原始密码：</td>
				<td><input type="password"
					id="oldPassword" name="oldPassword" size=8 class="inputFrame"></td>
				<td colspan="2">
					<%
						if (request.getParameter("msg") != null) {
							out.println(request.getParameter("msg"));
						}
					%>

				</td>
			</tr>
			<tr>
				<td>新 密 码：</td>
				<td><input  type="password"
					id="password" name="password" size=8 class="inputFrame"></td>
				<td>确认新密码：</td>
				<td><input type="password"
					id="password2" name="password2" size=8 class="inputFrame"></td>
			</tr>

			<hr>

			<tr>
				<td colspan="2" align="center"><input type="submit" value="提交"></td>
				<td><input  type="hidden"
					id="userType" name="userType" value="1">
					</td>
			</tr>
		</table>
	</form>
</body>
</html>
