<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath %>">
<html lang="en">
<head>
<title>addkeyword</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" type="text/css" href="css/goolefont.css" />
<script type="text/javascript" src="js/ckeditor/ckeditor.js"></script>
<script src="js/jquery.min.js"></script> 
</head>
<body style="background:#efefef;">
    <div class="widget-box">
	<form action="Keyword/addKeyword.action" method="post">

			 <br>
		  	&nbsp;&nbsp;&nbsp;&nbsp;词条名
		  	<input type="text" id="key" name="keyword.keyword" style="width:150px;" onblur="checkKeyword()">
		  	<font color="red" id="kw"></font><input type="hidden" id="kt" value="false">
		  	<br>
      
      <div class="widget-content">
        <div class="control-group">
          
             <div class="controls">
             <!--  <textarea name="keyword.content" id="con" class="textarea_editor span12" rows="6" placeholder="Enter text ..." onblur="checkContnet()"></textarea>
=======
		<div class="keyword_name" style="float:left;">
			<div style="position:relative;float:left;">词条名</div>
		  	<div style="position:relative;float:left;top:-7px;"><input type="text" id="key" name="keyword.keyword" style="width:150px;" onblur="checkKeyword()"></div>
		  	<font style="float:left;" color="red" id="kw"></font><input type="hidden" id="kt" value="false">
		</div>
		<br><br>
		 	<div>
		 	

              <input type="hidden" id="ct" value="false">

            </div>
			<input type="button" id="btn" onclick="checkKeyword(),checkContent(),check()" value="提交"/>
			<input type="reset"/>   -->
			<textarea id=" con " name="keyword.content" cols="20" rows="2" class="ckeditor"onblur="checkContnet()"></textarea>
      <script type="text/javascript"> 
      CKEDITOR.replace(' keyword.content ');
      </script>
          <input type="submit" id="btn" onclick="checkKeyword(),checkContent(),check()" value="提交"/>
			<input type="reset"/>
          </form>
       </div>
<script type="text/javascript">
	$('.textarea_editor').wysihtml5();
	function checkKeyword(){
		var keyword = $("#key").val();
		keyword2 = keyword.replace(/\s+/g,"");
		if(keyword.length==0){
			document.getElementById("kw").color="red";
			document.getElementById("kw").innerHTML="不能为空！";
			$("#kt").val("false");
		}else{
			if(keyword.length>keyword2.length){
				document.getElementById("kw").color="red";
				document.getElementById("kw").innerHTML="不能有空格！";
				$("#kt").val("false");
			}else{
				document.getElementById("kw").color="green";
				document.getElementById("kw").innerHTML="可用！";
				$("#kt").val("true");
			}
		}
		
	}
	function checkContent(){
		var str = $("#con").val();
		content=str.replace(/^\s+|\s+$/g,'');
		if(content.length==0){
			$("#ct").val("false");
		}else{
			$("#ct").val("true");
		}
	}
	function check(){
		var str1 = $("#kt").val();
		var str2 = $("#ct").val();
		if(str1=="false" || str2=="false"){
			document.getElementById("btn").type="button";
		}else{
			document.getElementById("btn").type="submit";
		}
	}
	
CKEDITOR.replace(' activity ');
</script>
</body>
</html>
