
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="英语,单词,突击,艾宾浩斯,记忆曲线">
<title>index Page</title>
<link href="CSS/all.css" rel="stylesheet" type="text/css" />

<script src="englishword.js" type="text/javascript"></script>
<script type="text/javascript">

    var rightBrowser = false;
	
</script>
</head>
<body onload="detectBrowser()" bgcolor="#DFFFBF">
	<table width="90%" height="50px" border="0" align="center">
		<tr>
			<td align="left">
				<button id='logout' type="button"
					onclick="javascript:window.location.href='home.jsp'"
					class="button gray">首页</button>
			</td>
		</tr>
	</table>
	<table width="250px" height="150px" border="0" align="center">

		<form id="login" name="login" method="post"
			onsubmit="return isLoginFormValid(login)"
			action="/jdc/servlet/Login">
			<tr height="20">
				<td width="40" class="inputLabel" align="right">
					用户名：					
				</td>
				<td width="40" align="left"><input class="inputFrame" type="text" name="username"
					size=8 /></td>
			</tr>
			<tr height="20">
				<td width="40" class="inputLabel" align="right">
						密&nbsp;&nbsp;码：
				</td>
				<td width="40" align="left"><input class="inputFrame" type="password"
					name="password" size=8 /></td>
			</tr>
			<tr height="10px">
			<tr height="20">
				<td align="right"><input
					type="submit" name="Submit" value="登录" class="button gray" /></td>
					<td  align="center">
					</form>
				<button id='register'
					onclick="javascript:window.location.href='register.jsp'"
					class="button gray">注册</button>
			</td>
			</tr>
		
		
		</tr>
		<tr height="20">
			
		</tr>

		<tr height="20">
			<td colspan=2>
				<p align="center">
					<font color="red"> <%
 	if (request.getParameter("error") != null) {
 		out.println(new String(request.getParameter("error").getBytes("ISO-8859-1"),"utf-8"));
 	}
 %>
					</font>
				</p>
			</td>
		</tr>
		<tr height="30">
			<td colspan=2>
				<p align="right" class="tips">
					提示： 简单注册后即可使用。</p>
			</td>
		</tr>
	</table>

	<p align="center">Copyright@2014. Developed By Jiang Bian. All
		Rights Reserved.</p>
</body>
</html>
