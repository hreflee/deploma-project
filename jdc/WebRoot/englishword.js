function detectBrowser() {
		var Sys={};
		var ua=navigator.userAgent.toLowerCase();
		var s;
		(s=ua.match(/msie ([\d.]+)/))?Sys.ie=s[1]:
		(s=ua.match(/firefox\/([\d.]+)/))?Sys.firefox=s[1]:
		(s=ua.match(/chrome\/([\d.]+)/))?Sys.chrome=s[1]:
		(s=ua.match(/opera.([\d.]+)/))?Sys.opera=s[1]:
		(s=ua.match(/version\/([\d.]+).*safari/))?Sys.safari=s[1]:0;
		
		if(Sys.ie){//Js判断为IE浏览器
		   var temp=navigator.appVersion.split("MSIE");  
   		   var version=parseFloat(temp[1]);  
		   if(version > 9){
		        rightBrowser = true;
		   }
		}
		
		if(Sys.firefox){//Js判断为火狐(firefox)浏览器
			rightBrowser = true;
		}
		if(Sys.chrome){//Js判断为谷歌chrome浏览器
			rightBrowser = true;
		}
		if(Sys.safari){//Js判断为苹果safari浏览器
			rightBrowser = true;
		}

		if (rightBrowser==false) {
			alert("请您使用使用谷歌、狐火或IE10及以上版本浏览器！");
		};
	}
	
	function isBrowser(){
		var Sys={};
		var ua=navigator.userAgent.toLowerCase();
		var s;
		(s=ua.match(/msie ([\d.]+)/))?Sys.ie=s[1]:
		(s=ua.match(/firefox\/([\d.]+)/))?Sys.firefox=s[1]:
		(s=ua.match(/chrome\/([\d.]+)/))?Sys.chrome=s[1]:
		(s=ua.match(/opera.([\d.]+)/))?Sys.opera=s[1]:
		(s=ua.match(/version\/([\d.]+).*safari/))?Sys.safari=s[1]:0;
		if(Sys.ie){//Js判断为IE浏览器
			alert('http://www.phpernote.com'+Sys.ie);
			if(Sys.ie=='9.0'){//Js判断为IE 9
			}else if(Sys.ie=='8.0'){//Js判断为IE 8
			}else{
			}
		}
		if(Sys.firefox){//Js判断为火狐(firefox)浏览器
			alert('http://www.phpernote.com'+Sys.firefox);
		}
		if(Sys.chrome){//Js判断为谷歌chrome浏览器
			alert('http://www.phpernote.com'+Sys.chrome);
		}
		if(Sys.opera){//Js判断为opera浏览器
			alert('http://www.phpernote.com'+Sys.opera);
		}
		if(Sys.safari){//Js判断为苹果safari浏览器
			alert('http://www.phpernote.com'+Sys.safari);
		}
	}

	function isLoginFormValid(form) {
		var msg = "\错误提示：\n\n";
		password = form.password.value;
		username = form.username.value;

		if (password.length == 0)//判定密码是否为空
		{
			msg += "您的密码为空，请填写！\n";
			form.password.focus();
			alert(msg);
			return false;
		}

		if (username.length == 0)//判定密码是否为空
		{
			msg += "您的用户名为空，请填写！\n";
			form.username.focus();
			alert(msg);
			return false;
		}
		return true;
	}
	
	 function isSetNumFormValid(){
         var regu=/^[0-9]*[1-9][0-9]*$/;
         var reg= new RegExp(regu);
         if(document.getElementById("newWordNum").value.length ==0 || document.getElementById("remWordNum").value.length ==0)
         {
             	alert("请同时输入取新词数和背出单词数。");    
				return false; 
         }
         if(!reg.test(document.getElementById("newWordNum").value) || !reg.test(document.getElementById("remWordNum").value)){
				alert("请同时输入大于0的取新词数和背出单词数。");    
				return false; 			      
         }
         return true;
      }
        
	
	 function registerCheckUser(){
	     var url = "checkUser.jsp?studentName=" + document.getElementById("studentName").value
	     + "&pairname=" + document.getElementById("pairname").value;
	     url=encodeURI(url);
	     xmlHttp=new XMLHttpRequest(); 	
	     xmlHttp.onreadystatechange = judgeStudentLoginCallBack;
	     xmlHttp.open("GET",url,true);
	     xmlHttp.setRequestHeader("If-Modified-Since","0"); 
	     xmlHttp.send(null);
	     setTimeout("registerCheckUser();",5000);  
	   }
	   function judgeStudentLoginCallBack(){
	    
	      if (xmlHttp.readyState == 4) {
	          if (xmlHttp.status == 0 || xmlHttp.status == 200) {
	              document.getElementById("checkUser").innerHTML=xmlHttp.responseText;
	         }
     		}
		}
		
    function isRegisterFormValid(form)
    {
       var msg="\错误提示：\n\n";
        studentName=form.studentName.value;
        password=form.password.value;
        password2=form.password2.value;
       var objs=document.getElementsByName("catagloryID");
       var isSel=false;//判断是否有选中项，默认为无
       pairname=form.pairname.value;
       for(var i=0;i<objs.length;i++)
		{
 		 if(objs[i].checked==true)
   			{
   			 isSel=true;
   			 break;
   			}
		}
     
       if(password.length<6)//判定密码是否<6
       {
       		msg+="密码不能少于6位，请填写！\n";
       		form.password.focus();
       		alert(msg);
       		return false;
       }
       
        if(password2.length<6)//判定密码是否<6
       {
       		msg+="密码不能少于6位，请填写！\n";
       		form.password2.focus();
       		alert(msg);
       		return false;
       }
       
       
        if(password != password2)//判定两次密码是否相同
       {
       		msg+="两次密码不同，请填写！\n";
       		form.password.value="";
       		form.password2.value="";
       		form.password.focus();
       		alert(msg);
       		return false;
       }
       
         if(studentName.length<2)//判定用户是否>=2
       {
       		msg+="用户名不能少于2位，请填写！\n";
       		form.studentName.focus();
       		alert(msg);
       		return false;
       }
       
        if(pairname.length<2)//判定用户是否>=2
       {
             msg+="帮背人不能少于2位，请填写！\n";
       		alert(msg);
       		form.pairname.focus();
       		return false;
       }
       
        if(studentName==pairname)
       {
             msg+="学生名和帮背人不能相同，请修改！\n";
       		alert(msg);
       		form.pairname.focus();
       		return false;
       }
       
       if(!isSel)//判定词汇等级
       {
            msg+="您的词汇级别型为空，请选择！\n";
       		alert(msg);
       		return false;
       }
       return true;
    }
    function pair()
    {
    
      var obj=document.getElementById("usertype"); 
      
      //var idx=obj.selectedIndex;
       var usertype=obj.options[obj.selectedIndex].text;
      
      if(usertype=="管理员")
      {
         document.getElementsByName("userpair").disabled=true; 
          //alert("wrong"+usertype);
      }
    }
    
    function checkPair() {
		var url = "checkPair.jsp?pairname="
				+ document.getElementById("pairname").value;
		xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = judgeStudentLoginCallBack;
		xmlHttp.open("GET", url, true);
		xmlHttp.setRequestHeader("If-Modified-Since", "0");
		xmlHttp.send(null);
		setTimeout("checkPair();", 5000);
	}
	
	
	function isChangePairFormValid(form) {
		var msg = "\错误提示：\n\n";
		password = form.password.value;
		password2 = form.password2.value;
		pairname = form.pairname.value;

		if (password.length < 6)//判定密码是否为空
		{
			msg += "密码不能少于6位，请填写！\n";
			form.password.focus();
			alert(msg);
			return false;
		}

		if (pairname.length < 2) {
			msg += "帮背人用户民不能少于2位，请输入！\n";
			alert(msg);
			form.pairname.focus();
			return false;
		}

		if (password != password2)//判定密码是否为空
		{
			msg += "两次密码不同，请填写！\n";
			form.password.value = "";
			form.password2.value = "";
			form.password.focus();
			alert(msg);
			return false;
		}
		return true;
	}