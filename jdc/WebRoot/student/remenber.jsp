<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="entity.*"%><%@page import="java.net.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application" />
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>双人背单词</title>
<link href="../CSS/all.css" rel="stylesheet" type="text/css" />
<script src="../jquery-min.js" type="text/javascript"></script>
<script type="text/javascript">
      var ws;
      var SocketCreated = false;
      var isUserloggedout = false;
      var ToggleButtonClicked = 0;
      
      var DispClose = true;  
      
      window.onload = function(){ 
			document.getElementById("LogContainer").style.display="none";
	  }
  
      function CloseEvent() {  
        if (DispClose) {              
            return "是否停止背单词?";  
        }  
      }
      
       window.onbeforeunload = CloseEvent;   
      
      function lockOn(str) 
      { 
         var lock = document.getElementById('skm_LockPane'); 
         if (lock) 
            lock.className = 'LockOn'; 
         lock.innerHTML = str; 
      } 

      function lockOff()
      {
         var lock = document.getElementById('skm_LockPane'); 
         lock.className = 'LockOff'; 
      }

      function ToggleConnectionClicked() {
        document.getElementById("LogContainer").style.display="";
		document.getElementById("selectPanel").style.display="none";
        ToggleButtonClicked++;
            if(ToggleButtonClicked == 2){
                //ws.send("teacher*" + document.getElementById("txtName").value + "*1001");
	            SocketCreated = false;
	            isUserloggedout = true;
	            ws.close();
                window.open("../logout.jsp","_self");
            }
            var regu=/^[0-9]*[1-9][0-9]*$/;
            var reg= new RegExp(regu);
            if(document.getElementById("newWordNum").value.length ==0 || document.getElementById("remWordNum").value.length ==0)
            {
                alert("请同时输入取新词数和背出单词数。");    
				return; 
            }
            if(!reg.test(document.getElementById("newWordNum").value) || !reg.test(document.getElementById("remWordNum").value)){
				alert("请同时输入大于0的取新词数和背出单词数。");    
				return; 			      
            }
            if (SocketCreated && (ws.readyState == 0 || ws.readyState == 1)) {
                lockOn("今天就到这里吧...");  
				ws.send("student*" + document.getElementById("txtName").value + "*1001");
                SocketCreated = false;
                isUserloggedout = true;
                ws.close();
            } else {
                lockOn("webSocket新技术，初始连接需要5-10秒...。10秒后无反应，请刷新页面。");  
                Log("准备连接到服务器 ...");
                try {
                    if ("WebSocket" in window) {
                    	ws = new WebSocket("ws://" + document.getElementById("Connection").value);
                    }
                    else if("MozWebSocket" in window) {
                    	ws = new MozWebSocket("ws://" + document.getElementById("Connection").value);
                    }
                    
                    SocketCreated = true;
                    isUserloggedout = false;
                } catch (ex) {
                    Log(ex, "ERROR");
                    return;
                }               
                ws.onopen = WSonOpen;
                ws.onmessage = WSonMessage;
                ws.onclose = WSonClose;
                ws.onerror = WSonError;
            }
        };
       

        function WSonOpen() {
        	document.getElementById("ToggleConnection").disabled  = true;
            lockOff();
            Log("连接已经建立。等待帮背人点击开始，请稍候..", "OK");
            $("#SendDataContainer").show();
            ws.send("student*" + document.getElementById("txtName").value + "*1110*" + <%=request.getParameter("catagloryID")%> + "*" +  document.getElementById("newWordNum").value + "*" + document.getElementById("remWordNum").value);
   		    
        };

        function WSonMessage(event) {
            Log(event.data);            
        };

        function WSonClose() {
        document.getElementById("ToggleConnection").disabled  = false;
            lockOff();
            if (isUserloggedout){
                Log("【"+document.getElementById("txtName").value+"】结束背单词");
                
            }
            document.getElementById("ToggleConnection").innerHTML = "重新开始";
            $("#SendDataContainer").hide();			
        };

        function WSonError() {
            lockOff();
            Log("远程连接中断。", "ERROR");
        };    


        function Log(Text, MessageType) {
            if (MessageType == "OK") Text = "<span style='color: green;'>" + Text + "</span>";
            if (MessageType == "ERROR") Text = "<span style='color: red;'>" + Text + "</span>";
            document.getElementById("LogContainer").innerHTML = Text + "<br />";
            var LogContainer = document.getElementById("LogContainer");
            LogContainer.scrollTop = LogContainer.scrollHeight;
        };
<%
		 InetAddress addr = InetAddress.getLocalHost();
        String  hostName = addr.getHostName();
        String ip="";
        if (hostName.length() > 0) {
            try{
	            InetAddress[] addrs = InetAddress.getAllByName(hostName);
	            if (addrs.length > 0) {
	            	ip = addrs[0].getHostAddress();
	            }
            }
            catch (Exception ex) {
        	}
        }
		
%>

        $(document).ready(function () {
            $("#SendDataContainer").hide();
            var WebSocketsExist = true;
          

            if (WebSocketsExist) {
                Log("您的浏览器支持WebSocket. 您可以开始背单词!", "OK");
                document.getElementById("Connection").value = "<%=ip%>:8080/englishWord";
            } else {
                Log("您的浏览器不支持WebSocket。请选择Chrome或Firefox。", "ERROR");
                document.getElementById("ToggleConnection").disabled = true;
            }    
            
            $("#DataToSend").keypress(function(evt)
            {
            		if (evt.keyCode == 13)
            		{
            				$("#SendData").click();
            				evt.preventDefault();
            		}
            })        
        });

    </script>
</head>
<body bgcolor="#DFFFBF">

	<%
    String username = (String) session.getAttribute("user");
 %>
	<p>
	<h3><%= new String(request.getParameter("catagloryName").getBytes("ISO-8859-1"),"utf-8") %>

		<%=username %>的帮背人是：<%=userMgr.getTeacherName(username) %>
		<button id='back' type="button"
			onclick="javascript:window.location.href='../student/main.jsp?update=true'"
			class="button gray">回退</button>
		<button id='logout' type="button"
			onclick="javascript:window.location.href='../logout.jsp'"
			class="button gray">注销</button>
	</h3>

	</p><div id="skm_LockPane" class="LockOff"></div>

	<p>
	

	<form id="studentForm" runat="server">
		<div id="selectPanel" class='container1'>
			<p align="center">
				<input type="hidden" id="Connection" size="35" /> <input
					type="hidden" id="txtName"
					value="<%=(String) session.getAttribute("user") %>" size="5" />
				取新词数： <input type="text" id="newWordNum" value="10" size="3"
					maxlength="2" class="inputFrame" /> 背出单词数： <input type="text"
					id="remWordNum" value="10" size="3" maxlength="2"
					class="inputFrame" />
			
			<span class="tips">注： 背出单词数是指从积累的不记得单词中需背出的单词数。</span>
			
				<button id='ToggleConnection' type="button"
					onclick='ToggleConnectionClicked();' class="button green">开始背单词</button>
			</p>
			</div>
			<div id='LogContainer' class='container1'
			></div>
			
	</form>
	<p align="left" class="tips">提示：如遇界面卡死或显示连接中断，请刷新当前页面，10秒后再试。</p>
</body>
</html>

