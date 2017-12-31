
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>index Page</title>
<style type="text/css">
<!--
.STYLE1 {
	font-family: "宋体";
	font-weight: bold;
	color: #000066;
	font-size: xx-large;
}

-->
.button.gray {
	color: #8c96a0;
	text-shadow: 1px 1px 1px #fff;
	border: 1px solid #dce1e6;
	box-shadow: 0 1px 2px #fff inset, 0 -1px 0 #a8abae inset;
	font-family: "宋体 ";
	font-size: 14pt;
	font-weight: bold;
	background: -webkit-linear-gradient(top, #f2f3f7, #e4e8ec);
	background: -moz-linear-gradient(top, #f2f3f7, #e4e8ec);
	background: linear-gradient(top, #f2f3f7, #e4e8ec);
}
</style>
<script type="text/javascript">
    function detectBrowser()
	{
		var browser=navigator.appName;
		
		if (browser=="Microsoft Internet Explorer"){
		  alert("您使用的是IE浏览器。该HTML5应用需要请使用谷歌或狐火浏览器！");
		};
	}	
	
</script>
</head>
<body onload="detectBrowser()" bgcolor="#DFFFBF">

	
				<table border=0 width="95%">
				<tr>
						<td colspan="3">
						<button id='logout' type="button" onclick="javascript:window.location.href='index.jsp'" class="button gray">回退 </button>
						
						</td>
					</tr>
				   <tr>
				   <td colspan="3">
						&nbsp;&nbsp;&nbsp;&nbsp;该应用基于艾宾浩斯的遗忘曲线进行单词的突击记忆。最适合考前3-5个月突击记忆单词。
						<br> &nbsp;&nbsp;&nbsp
						遗忘曲线证明：第一天记得的单词，第二天及时复习还记得的话，一般第四天才 需要复习；第四天及时复习还记得的话，第七天才需要复习；第七天及时复习还记得的话，一般第十五天才 需要
						复习；第十五天及时复习还记得的话，三个月内不会忘！
						<br>
						&nbsp;&nbsp;&nbsp;&nbsp;基于这个规律，可通过在即将遗忘前及时复习，提高效率。但是，太早复习，浪费时间；晚于遗
						忘点，又得重新开始，也是浪费时间。目前基于艾宾浩斯的遗忘曲线的软件也有，但是尚无 双人背单词的模式。
						由于记单词是非常枯燥的事情，人又有惰性，自己背单词时，记得与否能否真正把关，每天应该复习的单词的数量能否保证，是很难说的。
						<br>
						&nbsp;&nbsp;&nbsp;&nbsp;开发者一家三口、两代人在准备出国留学的过程中，均使用17个纸盒子，两人配对，严格把关，
						基于遗忘曲线 记忆单词，效果明显。但由于使用纸盒子不甚方便，且哪个单词什么时间应该放到哪里 确实比较烦人，故将其做成应用，供大家使用。
						<br> &nbsp;&nbsp;&nbsp;
						该方法优点多多，但是有一点需牢记，如果不能坚持每天背一定量的单词（新词至少30个以上），三天打鱼， 两天晒网，在遗忘前未能及时复习，
						效果将差强人意，浪费时间。所以需要一定的毅力。 尤其是在中期，积累的一 天的单词量是较多的，可能要花2个小时或以上。
						没有努力就没有成功。 是成是败看坚持！祝大家考试取得好成绩！
						</td>
					</tr>
					
					
				</table>
			
</body>
</html>
