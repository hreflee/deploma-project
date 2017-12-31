<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@page import="entity.*"%><%@page import="java.net.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application"/>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="英语,单词,突击,艾宾浩斯,记忆曲线">
    <title>自己背单词</title>
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
			document.getElementById("feedbackPane").style.display="none";
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
            document.getElementById("LogContainer").style.display="";
			document.getElementById("feedbackPane").style.display="";
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
		        document.getElementById("yes").disabled = false;
				document.getElementById("no").disabled = false;
				document.getElementById("delete").disabled = false;
				document.getElementById("tips").disabled = false;
	            if (SocketCreated && (ws.readyState == 0 || ws.readyState == 1)) {
	                lockOn("今天就到这里吧...");  
					 ws.send("teacher*" + document.getElementById("txtName").value + "*1001");
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
	                document.getElementById("ToggleConnection").innerHTML = "今天就到这里吧";
	                ws.onopen = WSonOpen;
	                ws.onmessage = WSonMessage;
	                ws.onclose = WSonClose;
	                ws.onerror = WSonError;
	            
	         }
        };


        function TipsClicked(){
			  ws.send("single*" + document.getElementById("txtName").value + "*2111");
			  document.getElementById("next").disabled  = true;
			  document.getElementById("delete").disabled  = true;			  
			  document.getElementById("next").style.color = "gray";
			  document.getElementById("delete").style.color = "gray";
			  document.getElementById("tips").style.color = "gray";
		}

		function YesClicked(){
			  ws.send("single*" + document.getElementById("txtName").value + "*1010");
			  document.getElementById("next").style.color = "gray"; 
		}
		
		function NoClicked(){
			  ws.send("single*" + document.getElementById("txtName").value + "*1111");
			  document.getElementById("next").disabled  = false;
			  document.getElementById("yes").disabled  = true;
			  document.getElementById("no").disabled  = true;
			  document.getElementById("delete").disabled  = true;	
			  document.getElementById("tips").disabled  = true;		  
			  document.getElementById("next").style.color = "red";
			  document.getElementById("yes").style.color = "gray"; 
			  document.getElementById("no").style.color = "gray"; 
			  document.getElementById("delete").style.color = "gray";
			  document.getElementById("tips").style.color = "gray";
		}
		
		function NextClicked(){
			  ws.send("single*" + document.getElementById("txtName").value + "*1000");
			  document.getElementById("next").disabled  = true;
			  document.getElementById("yes").disabled  = false;
			  document.getElementById("no").disabled  = false;
			  document.getElementById("delete").disabled  = false;
			  document.getElementById("tips").disabled  = false;
			  document.getElementById("next").style.color = "gray";
			  document.getElementById("yes").style.color = "black"; 
			  document.getElementById("no").style.color = "black"; 
			  document.getElementById("delete").style.color = "black";
			  document.getElementById("tips").style.color = "black";
		}
		
		function DeleteClicked(){
			  ws.send("single*" + document.getElementById("txtName").value + "*1101");
			  document.getElementById("next").disabled  = true;
			  document.getElementById("yes").disabled  = false;
			  document.getElementById("no").disabled  = false;
			  document.getElementById("next").style.color = "gray";
			  document.getElementById("yes").style.color = "black"; 
			  document.getElementById("no").style.color = "black"; 
			  document.getElementById("delete").style.color = "black";
			  document.getElementById("tips").style.color = "black";
		}

        function WSonOpen() {
            lockOff();
            Log("连接已经建立。正在取词，请稍候...", "OK");
            $("#SendDataContainer").show();
   			ws.send("single*" + document.getElementById("txtName").value + "*1110" + "*" +  document.getElementById("newWordNum").value + "*" + document.getElementById("remWordNum").value + "*" + <%=request.getParameter("catagloryID")%>);
        };

        function WSonMessage(event) {
            Log(event.data); 
        };

        function WSonClose() {
            lockOff();
            if (isUserloggedout)
                Log("【"+document.getElementById("txtName").value+"】结束背单词！");
            document.getElementById("ToggleConnection").innerHTML = "今天先到这里吧";
            document.getElementById("yes").disabled  = false;
            document.getElementById("no").disabled  = false;
            document.getElementById("next").disabled  = false;
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
       

%>
        $(document).ready(function () {
            $("#SendDataContainer").hide();
            var WebSocketsExist = true;
          

            if (WebSocketsExist) {
                Log("您的浏览器支持WebSocket!", "OK");
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
  <h3>
  当前用户：<%=username %><%= new String(request.getParameter("catagloryName").getBytes("ISO-8859-1"),"utf-8") %>
       <button id='back' type="button" onclick="javascript:window.location.href='main.jsp?update=true'" class="button gray">回退</button>
       <button id='logout' type="button" onclick="javascript:window.location.href='../logout.jsp'" class="button gray">注销 </button>
      </h3>
<p>
    <div id="skm_LockPane" class="LockOff"></div>
     
    <form id="remForm" name="remForm">
    <div id="selectPanel"  class='container1'>
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
        <div id='LogContainer' class='container1' ></div>
		<div id='feedbackPane' class='container2' >
		 	<button id='yes' type="button" onclick='YesClicked();' accesskey="y" disabled="disabled" class="button green">知道</button>
		  	<button id='no' type="button" onclick='NoClicked();' accesskey="n" disabled="disabled"  class="button blue">不知道</button>
		  	<button id='next' type="button" onclick='NextClicked();' accesskey="x" disabled="disabled"  class="button gray">下一个</button>
		  	<button id='delete' type="button" onclick='DeleteClicked();' accesskey="d" disabled="disabled" class="button yellow">不用背</button>
		  	<button id='tips' type="button" onclick='TipsClicked();' accesskey="d" disabled="disabled" class="button yellow">提示</button>
		</div>
    
    </form>
    <p align="left" class="tips">
            提示：如遇界面卡死或显示连接中断，请刷新当前页面，10秒后再试。
     </p>
</body>
</html>

