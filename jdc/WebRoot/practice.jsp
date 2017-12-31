<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="entity.*"%><%@page import="java.net.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application" />
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="英语,单词,突击,艾宾浩斯,记忆曲线">
<title>自己背单词</title>
<link href="CSS/all.css" rel="stylesheet" type="text/css" />
<script src="jquery-min.js" type="text/javascript"></script>

<%
 	String studentname = "边江";
	String cataID = "1";	
	String cataName = "SAT词汇";	
	String boxID = "-3";	
	
 %>

<script type="text/javascript">
      var ws;
      var SocketCreated = false;
      var isUserloggedout = false;
      var ToggleButtonClicked = 0;
      
      
      var DispClose = true;  
      
      window.onload = function(){ 
      	ToggleConnectionClicked();
	  }
  
       function CloseEvent() {  
        if (DispClose) {              
            return "是否停止背单词?";  
        }  
       }  
       window.onbeforeunload = CloseEvent;  
      
				
      function lockOn(str) //Toggle按钮（开始背单词、结束背单词）被点击
      { 
         var lock = document.getElementById('skm_LockPane'); 
         if (lock) 
            lock.className = 'LockOn'; 
         lock.innerHTML = str; //Div显示指定的内容
      } 

      function lockOff()//关闭Web Socket
      {
         var lock = document.getElementById('skm_LockPane'); 
         lock.className = 'LockOff'; 
      }

      function ToggleConnectionClicked() {
	            if (SocketCreated && (ws.readyState == 0 || ws.readyState == 1)) {
	                lockOn("今天就到这里吧...");  
					 ws.send("practice*" +  "end");
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


        function PreviouseClicked(){
			  ws.send("practice*" + "previouse*" + "<%=studentname%>");
		}
		
		function NextClicked(){
			  ws.send("practice*" + "next*" + "<%=studentname%>");
		}

        function WSonOpen() {
            lockOff();
            Log("连接已经建立。正在取词，请稍候...", "OK");
            $("#SendDataContainer").show();
   			ws.send("practice*" + "<%=studentname%>" + "*" + "<%=cataID%>" + "*" + "<%=cataName%>" + "*" + "<%=boxID%>");
        };

        function WSonMessage(event) {
            Log(event.data); 
        };

        function WSonClose() {
            lockOff();
            if (isUserloggedout)
                Log("结束预习！");        
            $("#SendDataContainer").hide();
        };

        function WSonError() {
            lockOff();
            Log("远程连接中断。", "ERROR");
        };    


        function Log(Text, MessageType) {
            if (MessageType == "OK") {
				Text = "<span style='color: green;'>" + Text + "</span>";
			}
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
        //ip="jidanci.eicp.net";

%>
        $(document).ready(function () {
            $("#SendDataContainer").hide();
            var WebSocketsExist = true;
          

            if (WebSocketsExist) {
                Log("您的浏览器支持WebSocket!", "OK");
                document.getElementById("Connection").value = "<%=ip%>:8080/englishWord";
            } else {
                Log("您的浏览器不支持WebSocket。请选择Chrome或Firefox。", "ERROR");
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
	
	<h3>
		当前用户：<%=studentname %>
		预习<%=(String)request.getParameter("cataName") %>
		<button id='back' type="button"  
		onclick="javascript:window.location.href='student/main.jsp'"
			class="button gray">先预习到这儿</button>
		<button id='logout' type="button"
			onclick="javascript:window.location.href='logout.jsp'"
			class="button gray">注销</button>
	</h3>
	
	<form>
	<input type="hidden" id="Connection" size="40" /> 
	<div id="skm_LockPane" class="LockOff"></div>
	<div id='LogContainer' class='container1' align="left"></div>
	<div id='feedbackPane' class='container2' align="center">
		<button id='previouse' type="button" onclick='PreviouseClicked();' accesskey="y"
			 class="button green"> <---   </button>
                &nbsp;&nbsp;&nbsp;&nbsp;
		<button id='next' type="button" onclick='NextClicked();' accesskey="n"
			 class="button blue" > --->  </button>
	</div>

	</form>
	<p align="left" class="tips">提示：如遇界面卡死或显示连接中断，请刷新当前页面，10秒后再试。</p>
</body>
</html>

