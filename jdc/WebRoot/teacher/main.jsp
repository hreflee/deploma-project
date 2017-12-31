<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@page import="entity.*"%><%@page import="java.net.*"%>
<jsp:useBean id="userMgr" class="entity.UserMgr" scope="application"/>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=gb2312">
    <title>我来帮你背单词</title>
  <link href="../CSS/all.css" rel="stylesheet" type="text/css" />

   <script src="../jquery-min.js" type="text/javascript"></script>
   
    <script type="text/javascript">
      var ws;
      var SocketCreated = false;
      var isUserloggedout = false;
      
      var ToggleButtonClicked = 0;
      
      var DispClose = true;  
  
      function CloseEvent() {  
        if (DispClose) {              
            return "是否停止背单词?";  
        }  
      }
       window.onbeforeunload = CloseEvent;   
      
      var xmlHttp; 
      function judgeStudentLogin(){
	     var url = "judgeStudentLogin.jsp";
	     xmlHttp=new XMLHttpRequest(); 	
	     xmlHttp.onreadystatechange = judgeStudentLoginCallBack;
	     xmlHttp.open("GET",url,true);
	     xmlHttp.setRequestHeader("If-Modified-Since","0"); 
	     xmlHttp.send(null);
	    setTimeout("judgeStudentLogin();",3000);  
	   }
	   function judgeStudentLoginCallBack(){
	    
	      if (xmlHttp.readyState == 4) {
	          if (xmlHttp.status == 0 || xmlHttp.status == 200) {
	              document.getElementById("studentLogin").innerHTML=xmlHttp.responseText;
	         }
     		}
		}
		window.onload = function(){ 
   			judgeStudentLogin(); 
		};
				
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
      		ToggleButtonClicked++;
            if(ToggleButtonClicked == 2){
                //ws.send("teacher*" + document.getElementById("txtName").value + "*1001");
	            SocketCreated = false;
	            isUserloggedout = true;
	            ws.close();
                window.open("main.jsp","_self");
            }
            else{
		        document.getElementById("yes").disabled = false;
				document.getElementById("no").disabled = false;
				document.getElementById("delete").disabled = false;
	            if (SocketCreated && (ws.readyState == 0 || ws.readyState == 1)) {
	                lockOn("今天就到这里吧...");  
					 ws.send("teacher*" + document.getElementById("txtName").value + "*1001");
	                SocketCreated = false;
	                isUserloggedout = true;
	                ws.close();
	            } else {
	                lockOn("我们开始啰...");  
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
	                document.getElementById("ToggleConnection").innerHTML = "今天先背到这里";
	                ws.onopen = WSonOpen;
	                ws.onmessage = WSonMessage;
	                ws.onclose = WSonClose;
	                ws.onerror = WSonError;
	            }
            }
        };

		function YesClicked(){
			  ws.send("teacher*" + document.getElementById("txtName").value + "*1010");
			  document.getElementById("next").style.color = "gray"; 
		}
		
		function NoClicked(){
			  ws.send("teacher*" + document.getElementById("txtName").value + "*1111");
			  document.getElementById("next").disabled  = false;
			  document.getElementById("yes").disabled  = true;
			  document.getElementById("no").disabled  = true;
			  document.getElementById("delete").disabled  = true;			  
			  document.getElementById("next").style.color = "red";
			  document.getElementById("yes").style.color = "gray"; 
			  document.getElementById("no").style.color = "gray"; 
			  document.getElementById("delete").style.color = "gray";
		}
		
		function NextClicked(){
			  ws.send("teacher*" + document.getElementById("txtName").value + "*1000");
			  document.getElementById("next").disabled  = true;
			  document.getElementById("yes").disabled  = false;
			  document.getElementById("no").disabled  = false;
			  document.getElementById("delete").disabled  = false;
			  document.getElementById("next").style.color = "gray";
			  document.getElementById("yes").style.color = "black"; 
			  document.getElementById("no").style.color = "black"; 
			  document.getElementById("delete").style.color = "black";
		}
		
		function DeleteClicked(){
			  ws.send("teacher*" + document.getElementById("txtName").value + "*1101");
			  document.getElementById("next").disabled  = true;
			  document.getElementById("yes").disabled  = false;
			  document.getElementById("no").disabled  = false;
			  document.getElementById("next").style.color = "gray";
			  document.getElementById("yes").style.color = "black"; 
			  document.getElementById("no").style.color = "black"; 
			  document.getElementById("delete").style.color = "black";
		}

        function WSonOpen() {
            lockOff();
            Log("连接已经建立。正在取词，请稍候...", "OK");
            $("#SendDataContainer").show();
   			ws.send("teacher*" + document.getElementById("txtName").value + "*1110" );
        };

        function WSonMessage(event) {
            Log(event.data); 
        };

        function WSonClose() {
            lockOff();
            if (isUserloggedout)
                Log("【"+document.getElementById("txtName").value+"】结束背单词！");
            document.getElementById("ToggleConnection").innerHTML = "重新开始";
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
 <p><span class="STYLE5">当前用户：<%=username %> </span>
 <button id='logout' type="button" onclick="javascript:window.location.href='../logout.jsp'" class="button gray">注销 </button>
 <button id='logout' type="button" onclick="javascript:window.location.href='../teacher/changePassword.jsp'" class="button gray">修改密码 </button>
 </p>
<p>
    <div id="skm_LockPane" class="LockOff"></div>
    <form id="form1" runat="server">
        <div id="studentLogin"> 
    	</div>
        <input type="hidden" id="Connection" size="40" style="background-color:#fffacd"/> 
        <input type="hidden" id="txtName" value="<%=username %>"size="5" style="background-color:#fffacd"/>
		
        <button id='ToggleConnection' type="button" onclick='ToggleConnectionClicked();'  class="button green" >我来帮你背单词</button>
        
        
        <br />
        <br />
        <div id='LogContainer' class='container1'></div>
		<div id='feedbackPane' class='container2'>
		 	<button id='yes' type="button" onclick='YesClicked();' accesskey="y" disabled="disabled" class="button green">知道</button>
		  	<button id='no' type="button" onclick='NoClicked();' accesskey="n" disabled="disabled"  class="button blue">不知道</button>
		  	<button id='next' type="button" onclick='NextClicked();' accesskey="x" disabled="disabled"  class="button gray">下一个</button>
		  	<button id='delete' type="button" onclick='DeleteClicked();' accesskey="d" disabled="disabled" class="button yellow">不用背</button>
		</div>
		
        <br />
      
    </form>
     注：1、如遇界面卡死或显示连接中断，请刷新页面，10秒后再试。
</body>
</html>

