<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="entity.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>选择背单词模式</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script src="../jquery-min.js" type="text/javascript"></script>

</head>

<body bgcolor="#DFFFBF">
	<button id='logout' type="button"
		onclick="javascript:window.location.href='../student/main.jsp'"
		class="button gray">回退</button>
		<table width="90%">
			<tr height=50px>
				<%
				    String studentname = (String) session.getAttribute("user");
				    String cataID = request.getParameter("cataID");	
				    String cataName = request.getParameter("cataName");		
				%>
			</tr>
			
			<tr>
				<th align="center" width="180px"><a href="../student/remenber.jsp?catagloryID=<%=cataID%>&catagloryName=<%=cataName%>">
				<img src="../images/ffdouble.png" alt="面对面双人背" width="200"
							height="220"></a>
				</th>
				<th align="center" width="180px"><a href="../student/remenber.jsp?catagloryID=<%=cataID%>&catagloryName=<%=cataName%>">
				<img src="../images/remotedouble.png" alt="远程双人背" width="200"
							height="220"></a>
				</th>
				<th align="center" width="180px"><a href="../student/remSingle.jsp?catagloryID=<%=cataID%>&catagloryName=<%=cataName %>">
				<img src="../images/self.png" alt="自己背" width="200px"
							height="220"></a>
				</th>
			</tr>
		
		</table>
	</form>

</body>
</html>
