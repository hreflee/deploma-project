<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="entity.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Cache-control" content="no-cache">
<title>盒子详细信息</title>
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
<%
	String studentname = (String) session.getAttribute("user");
	String cataID = (String) request.getParameter("cataID");	
	String cataName = (String) request.getParameter("cataName");	
	java.util.LinkedHashMap<String,Box> usercataList = new java.util.LinkedHashMap<String,Box>();
	usercataList = userMgr.getUserWordDetailInfo(studentname, cataID, cataName);
	java.util.Iterator iterator = usercataList.keySet().iterator();
    int i = 1;
    int red = 255;
    int green = 255;
    int blue = 100;
	while(iterator.hasNext()){
	    String boxID = (String) iterator.next();	    
		Box box = (Box) usercataList.get(boxID);
		if(box.getBoxNum() >= -1){
		        red = 176;
    			green = 224;
    			blue = 230;
		}
		try{
			if(box.getBoxWordNum() != 0){	
%>				  
				var canvasName = "canvas" + <%=i%>;
				var contextName = "context" + <%=i%>;
			    var canvasName = document.getElementById(canvasName);
				
				canvasName.width = "270";
				canvasName.height = "40";
			
				if (!canvasName.getContext) {
						console
								.log("Canvas not supported. Please install a HTML5 compatible browser.");
						return;
				}
				var contextName = canvasName.getContext('2d');
				contextName.strokeStyle = "gray";
				contextName.fillStyle = "RGBA(<%=red%>,<%=green%>,<%=blue%>, 0.5)";
				contextName.roundRect(5, 5, 250, 30, 5, true);		
					
				
				contextName.font = "22px 微软雅黑";
				contextName.fillStyle = "RGBA(0,0,0, 0.5)";
				<%
				    String boxName = (box.getBoxNum()-1) + "号盒子有";
				    if(box.getBoxNum() == -4){
				        boxName = "词库中有";
				    }
				     if(box.getBoxNum() == -3){
				        boxName = "背不出的有";
				    }
				     if(box.getBoxNum() == -1){
				        boxName = "上次未背完的有";
				    }
				%>
				contextName.fillText("<%=boxName%>" + "<%=box.getBoxWordNum()%>" + "个词",30, 25);
					
					
				canvasName.addEventListener('click', function(e){  
					p = getEventPosition(e);
					if(!contextName.isPointInPath(p.x, p.y)){
					<%
					   if((box.getBoxNum() == -4) || (box.getBoxNum() == -3)){
					%>
						window.open("../student/practice.jsp?cataID=<%=box.getCatagloryID()%>&cataName=<%=new String(request.getParameter("cataName").getBytes("ISO-8859-1"),"utf-8")%>&boxID=<%=box.getBoxNum()%>","_self");
					<%
					}
					%>
					}
				}, false); 
<%
	    	}
	    	i++;
	    }catch(Exception e){
	    
    	}    	
	}
%>
};


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
		当前词汇：<%= new String(request.getParameter("cataName").getBytes("ISO-8859-1"),"utf-8") %>
		<br>
		<button id='logout' type="button"
			onclick="javascript:window.location.href='../student/main.jsp'"
			class="button gray">回退</button>
		<button id='logout' type="button"
			onclick="javascript:window.location.href='../logout.jsp'"
			class="button gray">注销</button>
		<p class="tips" align="center">
		
		如上次未背完，先背上次未背完的；
		<br>否则，每天只需背诵1,2,5,7,15,45,105,195号盒子的单词。
		<br>
		时间稍有宽裕建议学习一下背不出的盒子中的单词；
		<br>有更多时间还可预习一下词库中的生词。
		
	</p>
<%
	iterator = usercataList.keySet().iterator();
    i = 1;
    boolean hr = true;
	while(iterator.hasNext()){
	    String boxID = (String) iterator.next();
	    Box box = (Box) usercataList.get(boxID);
	    if(box.getBoxNum() >= -1  && hr){
	    	out.println("<hr width=\"250px\" align=\"center\">");
	    	hr = false;
	    }	
	%>
	<div id="box_plot" align="center" >
		<canvas id="canvas<%=i%>"></canvas>
	</div>
	<br>
	
	<%
	i++;
	}
	 %>
	
</body>
<html>