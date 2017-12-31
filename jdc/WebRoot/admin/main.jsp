<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=gb2312">
    <title>记忆曲线背单词</title>
 <style type="text/css">
    div { 
		word-wrap:break-word;
	}
     .container
     {
         font-family: "Courier New";
		 font-size:large;
         width: 600px;
         height: 350px;
         overflow: auto;
         border: 1px solid black;
     }	

     .LockOff {
         display: none; 
         visibility: hidden; 
      } 

      .LockOn { 
         display: block; 
         visibility: visible; 
         position:absolute; 
         z-index: 1; 
         top: 0px; 
         left: 0px; 
         width: 100%; 
         height: 100%; 
         background-color: #ccc; 
         text-align: center; 
         padding-top: 20%; 
         filter: alpha(opacity=75); 
         opacity: 0.75; 
      } 
	   
   </style> 

    <script src="jquery-min.js" type="text/javascript"></script>
    <script type="text/javascript">
      var ws;
      var SocketCreated = false;
      var isUserloggedout = false;;
				
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
                SocketCreated = false;
                isUserloggedout = true;
                ws.close();
            } else {
                lockOn("我们开始啰...");  
				
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
                document.getElementById("ToggleConnection").innerHTML = "搞定！";
                ws.onopen = WSonOpen;
                ws.onmessage = WSonMessage;
                ws.onclose = WSonClose;
                ws.onerror = WSonError;
            }
        };

		
        function WSonOpen() {
            lockOff();
            $("#SendDataContainer").show();
   			ws.send("admin*" + document.getElementById("txtName").value + "*" + document.getElementById("txtPassword").value + "*" + document.getElementById("txtNewUserName").value + "*" + document.getElementById("txtNewUserPassword").value);
        };

        function WSonMessage(event) {
        };

        function WSonClose() {
            lockOff();
            $("#SendDataContainer").hide();
        };

        function WSonError() {
            lockOff();
        };    



        $(document).ready(function () {
            $("#SendDataContainer").hide();
            var WebSocketsExist = true;
          

            if (WebSocketsExist) {
                Log("您的浏览器支持WebSocket!", "OK");
                document.getElementById("Connection").value = "172.168.1.102:4141/englishWord";
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
<body>
    <div id="skm_LockPane" class="LockOff"></div>
    <form id="form1" runat="server">
        <h1>管理界面</h1>
        <br />
        <div >使用有效的用户名、密码登陆可新增用户        </div>
		<br>
        服务器地址: <input type="text" id="Connection" size="40" /> 
		<br>
        用户名： <input type="text" id="txtName" value="" size="5"/> 
		密码： <input type="text" id="txtPassword" value=""size="5"/>
		<br>
		新增用户名： <input type="text" id="txtNewUserName" value="" size="5"/> 
		新增用户密码： <input type="text" id="txtNewUserPassword" value="123456" size="5"/> 
		<br>
        <button id='ToggleConnection' type="button" onclick='ToggleConnectionClicked();'>新增用户</button>
        
    </form>
</body>
</html>

