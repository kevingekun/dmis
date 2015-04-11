<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <title>Matrix Admin</title><meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
		<link rel="stylesheet" href="<%=basePath%>css/bootstrap-responsive.min.css" />
        <link rel="stylesheet" href="<%=basePath%>css/matrix-login.css" />
        <link rel="stylesheet" href="<%=basePath%>css/login.css" />
        <link href="<%=basePath%>font-awesome/css/font-awesome.css" rel="stylesheet" />
		<link href='css/goolefont.css' rel='stylesheet' type='text/css'>

    </head>
    <body>
	<div class="alertMask" style="display: none"></div>
	 <div id="alertPanel"></div>
	 <input value="<%=basePath%>" id="localHostPath" style="display: none"/>
    <div class="step"  align="center">
            	<div class="notSelectStepOne" id="one" >1</div><div class="notSelectStepTwo" id="two">2</div><div class="notSelectStepThree" id="three">3</div>
            </div>
        <div id="loginbox">        
            <form id="loginform" class="form-vertical" action="">  
				 <div class="control-group normal_text"> <h3><img src="<%=basePath%>img/logo1.png" alt="Logo" /></h3></div>
                <div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
                            <span class="add-on bg_lg"><i class="icon-user"></i></span><input type="text" name="user.name" placeholder="Username" />
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
                            <span class="add-on bg_ly"><i class="icon-lock"></i></span><input type="password" name="user.password" placeholder="Password" />
                        </div>
                    </div>
                </div>
                <div class="form-actions">
                    <%-- <span class="pull-left"><a href="javascript:void(0);" class="flip-link btn btn-info" id="to-recover">忘记密码？</a></span> --%>
                    <span class="pull-left"><a href="javascript:void(0);" class="flip-link btn btn-info" >忘记密码？</a></span>
                    <span class="pull-right"><a type="button" href="javascript:void(0);" id="loginCheck" class="btn btn-success" /> 登录</a></span>
                </div>
            </form>
            <form id="recoverform" action="#" class="form-vertical">
            <p/>
             <br><br>
				<p style="margin-left:40px;font-size:14px;color:#999">请填写需要找回密码的账号。</p>
                    <div class="controls" id="findpass">
                        <div class="main_input_box">
                            <span class="add-on bg_lg"><i class="icon-user"></i></span><input type="text" placeholder="Username" name="user.name" />
                        </div>
                    </div><br>
                <div class="control-group">
				<div class="controls" id="findpass">
					<div class="main_input_box">
						<span class="add-on bg_ly"><i class="icon-eye-open"></i></span><input type="text" placeholder="验证码"  style="width: 200px;" name="user.verfi" /> 
                        <img id="verfi" alt=""
							src="<%=basePath%>Verfi/getVerification" 
							style="width: 90px; height: 40px;" onclick="this.src='<%=basePath%>Verfi/getVerification?'+Math.random()">
					</div>
				</div>
			</div>
                <div class="form-actions">
                    <span class="pull-left"><a href="javascript:void(0);" class="flip-link btn btn-success" id="to-login">&laquo; 返回</a></span>
                    <span class="pull-right"><a class="btn btn-info" id="nextStepTwo"/>下一步</a></span>
                </div>
            </form>
            
            <form id="recoverformStepTwo" action="#" class="form-vertical">
            <p/>
				<p style="margin-left:40px;font-size:14px;color:#999">您正在找回密码的账号是：<span id="findName"></span></p>
                <p style="font-size:14px;color:#FFF;margin-left:40px;">请您回答以下问题</p>
                    <div class="controls" id="findpass">
                        <div class="main_input_box">
                            <span class="add-on bg_lg">问题:</span><input type="text" readonly name="user.question" id="question"/>
                        </div>
                    </div><br>
                <div class="control-group">
				<div class="controls" id="findpass">
					<div class="main_input_box">
						<input id="getAnswer" value="" style="display:none;"/>
						<span class="add-on bg_ly">答案:</span><input type="text" name="user.answer" id="answer"/> 
					</div>
				</div>
			</div>
                <div class="form-actions">
                    <span class="pull-left"><a href="#" class="flip-link btn btn-success" id="parentStepOne">上一步</a></span>
                    <span class="pull-right"><a class="btn btn-info" id="nextStepThree"/>下一步</a></span>
                </div>
            </form>
            
            <form id="recoverformStepThree" action="#" class="form-vertical">
            <p/>
            <br><br>
				<p style="margin-left:40px;font-size:14px;color:#999">请重置密码</p>
                    <div class="controls" id="findpass">
                        <div class="main_input_box">
                        	<input id="putName" name="user.name" style="display:none;">
                        	<input id="putAnswer" name="user.answer" style="display:none;">
                            <span class="add-on bg_lg" style="width:80px;">请输入新密码</span><input type="text" style="width:260px;" name="user.password" id="password"/>
                        </div>
                    </div><br>
                <div class="control-group">
				<div class="controls" id="findpass">
					<div class="main_input_box">
						<span class="add-on bg_ly" style="width:80px;">请确认新密码</span><input type="text" style="width:260px;"  name="user.newPassword" id="newPassword"/> 
					</div>
				</div>
			</div>
                <div class="form-actions">
                    <span class="pull-left"><a href="#" class="flip-link btn btn-success" id="parentStepTwo">上一步</a></span>
                    <span class="pull-right"><a class="btn btn-info" id="passwordReset"/>重置</a></span>
                </div>
            </form>
        </div>
       
        <script src="<%=basePath%>js/jquery.min.js"></script>  
        <script src="<%=basePath%>js/pagescript/login.js"></script> 
        <script src="<%=basePath%>js/pagescript/knowledge.alert.js"></script> 
    </body>

</html>
