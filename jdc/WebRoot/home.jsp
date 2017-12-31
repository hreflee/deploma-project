
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

	<table width="100%" height="500" border="0">
		<tr height="30">
			<td height="80" colspan="3" align="center" valign="top"><img
				src="images/title.jpg" alt="云词" width="100%"
				height="70"></td>
		</tr>
		<tr height="200">
			<td width="150" align="left" valign="top">

				<table width="95%" height="90%" border="0">
					<form id="login" name="login" method="post"
						onsubmit="return isValid(login)"
						action="http://120.24.92.35/servlet/Login">
						<tr height="20">
							<td width="40" align="left">
								<p align="left"
									style="font-family:宋体;color:black;font-size:16px;">用户名：
							</td>
							<td width="40" align="left"><input type="text"
								name="username" size=8 style="background-color:#fffacd" /></td>
						</tr>
						<tr height="20">
							<td width="40" align="left">
								<p align="left"
									style="font-family:宋体;color:black;font-size:16px;">
									密&nbsp;&nbsp;码：
							</td>
							<td width="40" align="left"><input type="password"
								name="password" size=8 style="background-color:#fffacd" /></td>
						</tr>
						<tr height="20">
							<td colspan=2 align="center"
								style="font-family:宋体;color:black;font-size:20px;"><input
								type="submit" name="Submit" value="登录" class="button gray" /></td>
						</tr>
					</form>
					<tr height="20">
						<td colspan=2 align="center">
							<button id='register'
								onclick="javascript:window.location.href='register.jsp'"
								class="button gray">注册</button>
						</td>
					</tr>
					<tr height="20">
						<td colspan=2>
							<p align="center">
								<%
									if (request.getParameter("loged") == null) {
										out.println("<!-----");
									}
								%>
							
							<form id="logout" action="logout">
								<input type=button name="logoutButton" onclick="logout()"
									value="注销上次登录" class="button gray" />
							</form> <%
 	if (request.getParameter("loged") == null) {
 		out.println("----->");
 	}
 %>
							</p>
						</td>
					</tr>
					<tr height="20">
						<td colspan=2>
							<p align="center">
								<font color="red"> <%
 	if (request.getParameter("error") != null) {
 		out.println(request.getParameter("error"));
 	}
 %>
								</font>
							</p>
						</td>
					</tr>
					<tr height="30">
						<td colspan=2>
							<p align="left" style="font-family:宋体;color:blue;font-size:15px;">
								温馨提示： 如尚无账号， 请点击注册进行 账号注册。 账号注册后马上可以使用。</p>
						</td>
					</tr>
				</table>
			</td>
			<td colspan="2" align="left" valign="top">
				<table border=0 width="95%">
					<tr>
						<td width="150px" align="center"><img
							src="images/ffdouble.png" alt="面对面双人背" width="150"
							height="180"></td>
						<td width="150px" align="center"><img
							src="images/remotedouble.png" alt="远程双人背"
							width="150px" height="180"></td>
						<td width="150px" align="center"><img
							src="images/self.png" alt="自己背" width="150px"
							height="180"></td>
					</tr>
					<tr>
						<td colspan="3">
							&nbsp;&nbsp;&nbsp;&nbsp;该应用独创双人背单词模式，记忆效果惊人！最适合考前3-5个月突击记忆单词。该软件是开发者一家三口两代人在准备出国留学的过程中的珍贵经验总结。<a href="introduction.jsp" target="_blank">（详细介绍）</a>
							<br> &nbsp;&nbsp;&nbsp;&nbsp;三种背单词方式的对比见下表。
						</td>
					</tr>
					<tr>

					</tr>
					<tr>
						<table width="90%" border="1" bordercolor="#996600" height="35%">

							<tr valign="top">
								<td width="33%">单词本记单词 <br> <br> 优点：方便携带，随时可记。 <br>
									缺点：熟词反复记忆，浪费时间。
								</td>
								<td width="33%">其他软件记单词 <br> <br> 优点：遗忘曲线，科学记忆。 <br>
									缺点：把关不严，很难坚持。
								</td>
								<td width="33%">本软件记单词 <br> <br>
									优点：遗忘曲线，科学记忆，有人监督，杜绝偷懒。 <br> 缺点：专人陪背，网络支持。
								</td>
							</tr>
						</table>

					</tr>

				</table>
			</td>
		</tr>
		
		<tr height="20" align="center">
			<td colspan="2" align="center"></td>

		</tr>
	</table>
	<p align="center">
	Copyright@2014. Developed By Jiang Bian. All Rights Reserved.
	</p>
</body>
</html>
