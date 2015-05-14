<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>DMIS System</title>
<link rel="stylesheet" href="css/login/screen.css" type="text/css"
	media="screen" title="default" />
<!--  jquery core -->
<script src="js/login/jquery-1.4.1.min.js" type="text/javascript"></script>

<!-- Custom jquery scripts -->
<script src="js/login/custom_jquery.js" type="text/javascript"></script>

<!-- MUST BE THE LAST SCRIPT IN <HEAD></HEAD></HEAD> png fix -->
<script src="js/login/jquery.pngFix.pack.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(document).pngFix();
	});
</script>
</head>
<body id="login-bg"> 
 
<!-- Start: login-holder -->
<div id="login-holder">

	<!-- start logo -->
	<div id="logo-login">
		<a href="index.html"><img src="images/login/logo1.png" width="156" height="40" alt="" /></a>
	</div>
	<!-- end logo -->
	
	<div class="clear"></div>
	
	<!--  start loginbox ................................................................................. -->
	<div id="loginbox">
	
	<!--  start login-inner -->
	<form id="loginform" class="form-vertical"> 
	<div id="login-inner">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<th>Username:</th>
			<td><input type="text" class="login-inp" name="user.name" placeholder="username"/></td>
		</tr>
		<tr>
			<th>Password:</th>
			<td><input type="password" name="user.password" placeholder="password" class="login-inp" /></td>
		</tr>
		<!-- <tr>
			<th></th>
			<td valign="top"><input type="checkbox" class="checkbox-size" id="login-check" /><label for="login-check">Remember me</label></td>
		</tr> -->
		<tr>
			<th></th>
			<td><input type="button" class="submit-login" id="loginCheck"/></td>
		</tr>
		</table>
	</div>
	</form>
 	<!--  end login-inner -->
	<div class="clear"></div>
	<a href="" class="forgot-pwd">忘记密码?</a>
 </div>
 <!--  end loginbox -->
 
	<!--  start forgotbox ................................................................................... -->
	<div id="forgotbox">
		<div id="forgotbox-text">请输入您的用户名及邮箱，我们会将新密码发到您的邮箱中.</div>
		<!--  start forgot-inner -->
		<form id="forgotform">
		<div id="forgot-inner">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<th>User Name:</th>
			<td><input type="text" name="user.name" placeholder="username" class="login-inp" /></td>
		</tr>
		<tr>
			<th>Email address:</th>
			<td><input type="text" name="user.email" placeholder="email" class="login-inp" /></td>
		</tr>
		<tr>
			<th> </th>
			<td><input type="button" class="submit-login" id="forgotCheck"/></td>
		</tr>
		</table>
		</div>
		</form>
		<!--  end forgot-inner -->
		<div class="clear"></div>
		<a href="" class="back-login">返回登录页面</a>
	</div>
	<!--  end forgotbox -->

</div>
 <script type="text/javascript">
document.onkeydown = function(event_e){    
   if(window.event)    
    event_e = window.event;    
    var int_keycode = event_e.charCode||event_e.keyCode;    
    if(int_keycode ==13){   
    	submit();
    }  
}; 
$("#loginCheck").click(function(){
	submit();
});
	 
function submit(){
	var user = $("#loginform").serialize();
	$.ajax({
		type:"POST",
		url:"/dmis/System/LoginCheck",
		data:user,
		success:function(result){
			if(result == "admin"){
				location.href='/dmis/Admin/getAdminIndex';
			}else 
				alert("用户名或密码错误，请重新登录！");
		}
});
};
$("#forgotCheck").click(function(){
	var user = $("#forgotform").serialize();
	$.ajax({
		type:"POST",
		url:"/dmis/System/UpdatePasswordBySendMail",
		data:user,
		success:function(result){
			if(result == "success"){
				alert("请查看您的邮箱！");
				location.href='/dmis';
			}else 
				alert("用户名或邮箱错误，请重新输入！");
		}
	});
});
</script>
</body>


</html>
