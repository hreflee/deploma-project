<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="entity.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Cache-control" content="no-cache">
<title>学生背单词</title>
<link href="../CSS/all.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

	var canvasIndex = 1;
	window.onload = function() {
		createPic();
	};
	
	
	  function getEventPosition(ev){  
      var x, y;  
      if (ev.layerX || ev.layerX == 0) {  
        x = ev.layerX;  
        y = ev.layerY;  
      } else if (ev.offsetX || ev.offsetX == 0) { // Opera  
        x = ev.offsetX;  
        y = ev.offsetY;  
      }  
      return {x: x, y: y};  
    }      function getEventPosition(ev){  
      var x, y;  
      if (ev.layerX || ev.layerX == 0) {  
        x = ev.layerX;  
        y = ev.layerY;  
      } else if (ev.offsetX || ev.offsetX == 0) { // Opera  
        x = ev.offsetX;  
        y = ev.offsetY;  
      }  
      return {x: x, y: y};  
    }  

	//创建图形 
	function createPic() {		
		
<%String username = (String) session.getAttribute("user");
	java.util.HashMap<String,Cataglory> usercataList = new java.util.HashMap<String,Cataglory>();
	usercataList = userMgr.getUserCurrentCataglory(username);
	java.util.Iterator iterator = usercataList.keySet().iterator();
    int i = 1;
	while(iterator.hasNext()){
	    
		Cataglory usercata = (Cataglory) usercataList.get(iterator.next());%>
		var canvasName = "canvas" + <%=i%>;
		var contextName = "context" + <%=i%>;
	        var canvasName = document.getElementById(canvasName);
			
			canvasName.width = "460";
			canvasName.height = "40";
	
			if (!canvasName.getContext) {
				console
						.log("Canvas not supported. Please install a HTML5 compatible browser.");
				return;
			}
			var contextName = canvasName.getContext('2d');
			contextName.strokeStyle = "gray";
			contextName.fillStyle = "RGBA(255,255,100, 0.5)";
			contextName.roundRect(5, 5, 450, 30, 5, true);		
			
			contextName.translate(0,0);
			contextName.beginPath();
			
			var rate = Math.round(<%=usercata.getRemenberNum()*450/usercata.getTotalNum()%>);
			if(rate > 5){
			    contextName.strokeStyle = "green";
			    contextName.fillStyle = "RGBA(10,255,100, 0.5)";
				contextName.roundRect(5, 5, rate, 30, 5, true);
			}
			else{
			    contextName.strokeStyle = "red";
			    contextName.fillStyle = "RGBA(255,0,0, 0.5)";
				contextName.roundRect(5, 5, 6, 30, 5, true);
			}			
			contextName.font = "22px 微软雅黑";
			contextName.fillStyle = "RGBA(0,0,0, 0.5)";
			contextName.fillText("<%=usercata.getCatagloryName()%>  <%=usercata.getRemenberNum()%>\/" + "<%=usercata.getTotalNum()%>",70, 25);
			
			
			canvasName.addEventListener('click', function(e){  
				p = getEventPosition(e);
				if(!contextName.isPointInPath(p.x, p.y)){
					window.open("../student/detail.jsp?cataID=<%=usercata.getCatagloryID()%>&cataName=<%=usercata.getCatagloryName()%>","_self");
				}
			}, false); 
<%
    i++;
	}
%>
	}

	CanvasRenderingContext2D.prototype.roundRect = function(x, y, width,
			height, radius, fill, stroke) {
		if (typeof stroke == "undefined") {
			stroke = true;
		}
		if (typeof radius === "undefined") {
			radius = 5;
		}
		this.beginPath();
		this.moveTo(x + radius, y);
		this.lineTo(x + width - radius, y);
		this.quadraticCurveTo(x + width, y, x + width, y + radius);
		this.lineTo(x + width, y + height - radius);
		this.quadraticCurveTo(x + width, y + height, x + width - radius, y
				+ height);
		this.lineTo(x + radius, y + height);
		this.quadraticCurveTo(x, y + height, x, y + height - radius);
		this.lineTo(x, y + radius);
		this.quadraticCurveTo(x, y, x + radius, y);
		this.closePath();
		if (stroke) {
			this.stroke();
		}
		if (fill) {
			this.fill();
		}
	};
</script>
</head>
<body bgcolor="#DFFFBF">

	<p align="center">
		当前用户：<%=username%>
		<br>
		<button id='logout' type="button"
			onclick="javascript:window.location.href='../logout.jsp'"
			class="button gray">注销</button>
		<button id='password' type="button"
			onclick="javascript:window.location.href='../student/changePassword.jsp'"
			class="button gray">修改密码</button>
		<button id='pair' type="button"
			onclick="javascript:window.location.href='../student/changePair.jsp'"
			class="button gray">修改帮背人</button>
		<br>
		<p class="tips" align="center">
		提示：背出词数小于5%，进度显示为红色；否则为绿色。
		</p>
	</p>
<%
	iterator = usercataList.keySet().iterator();
    i = 1;
	while(iterator.hasNext()){
	    
		Cataglory usercata = (Cataglory) usercataList.get(iterator.next());
	%>
	<div id="box_plot" align="center" valign="top">
		<canvas id="canvas<%=i%>"></canvas>
		<p valign="top">
		<button id='logout' type="button"
			onclick="javascript:window.location.href='../student/changeCata.jsp?cataName=<%=usercata.getCatagloryName()%>'"
			class="button gray">切换词汇</button>
	     </p>
	</div>
	<br>
	<table width="450px" height="150px" align="center">
	<tr>
				<td align="center" width="200px"><a href="../student/remenber.jsp?catagloryID=<%=usercata.getCatagloryID()%>&catagloryName=<%=usercata.getCatagloryName()%>">
				<img src="../images/ffdouble.png" alt="面对面双人背" width="200px"
							height="200px"></a>				
				</td>
				<td align="center" width="200px"><a href="../student/remenber.jsp?catagloryID=<%=usercata.getCatagloryID()%>&catagloryName=<%=usercata.getCatagloryName()%>">
				<img src="../images/remotedouble.png" alt="面对面双人背" width="200px"
							height="200px"></a>				
				</td>
				<td align="center" width="200px"><a href="../student/remSingle.jsp?catagloryID=<%=usercata.getCatagloryID()%>&catagloryName=<%=usercata.getCatagloryName()%>">
				<img src="../images/self.png" alt="自己背" width="200px"
							height="200px"></a>
				</td>
			</tr>
	</table>   
	<%
	i++;
	}
	 %>
	<br>
	<br>
	
</body>
<html>