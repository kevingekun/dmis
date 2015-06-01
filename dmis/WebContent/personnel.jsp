<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<html>
<head>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" type="text/css" href="css/matrix-style.css" />
<link rel="stylesheet" type="text/css" href="css/bg/yetou.css"/>
<link rel="stylesheet" type="text/css" href="css/dmis.css"/>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/buttons/buttons.css" />
<link rel="stylesheet" type="text/css" href="css/forms/style.css" />
</head>
<body id="table1">
<input type="text" id="checkRadio" value="${state}" style='display:none'/>
	<div id="mask" class="mask" style="display: none;background-color: rgb(40, 95, 108);"></div>
	<div class="widget-box">
		<div class="widget-title">
			<h5>人员管理</h5>
			<a class="btn btn-small gray" style="margin: 5px 0 0 3px;" onClick="dele();">删除选中</a>
			<div class="widget-radio">
				<input id="addUser" class="btn btn-small blue" type="button"
					value="新增人员" style="margin-bottom: 5px">
					<input type="radio" name="state" id="all" onClick="allUser();"/>全部
					<input type="radio" name="state" id="isForbidden" onClick="isForbidden();"/>已禁用
			</div>
		</div>
		<div id="user_add" style="display: none;" align="center">
		<div id="user_form_content" class="user_form_content" style="display:none;">
			<form id="test" action="User/add" method="post" enctype="multipart/form-data">
				<fieldset>
					<legend>添加 用户</legend>
					<div class="form-row">
						<div class="field-label_user">
							<label for="field1">用户名</label>:
						</div>
						<div class="field-widget">
							<input name="userVo.name" id="username" class="required"
								type="text" placeholder="必须为字母数字下划线" onblur="checkUsername();"/>
							<div class="validation-advice" id="advice-required-field1"
								style="display: none;">required field.</div>
						</div>
					</div>
					<div class="form-row">
						<div class="field-label_user">
							<label for="field1">密码</label>:
						</div>
						<div class="field-widget">
							<input name="userVo.password" id="password" class="required"
								type="password" placeholder="6到12位密码" onblur="checkPassword();"/>
							<div class="validation-advice" id="advice-required-field2"
								style="display: none; width:72px;">required field.</div>
						</div>
					</div>
					<div class="form-row">
						<div class="field-label_user">
							<label for="field1">确认密码</label>:
						</div>
						<div class="field-widget">
							<input name="userVo.newPassword" id="vpassword" class="required"
								type="password" placeholder="再次输入密码" onblur="verifyPass()"/>
							<div class="validation-advice" id="advice-required-field3"
								style="display: none; width:72px;">required field.</div>
						</div>
					</div>
					<div class="form-row">
						<div class="field-widget-confirm_user">
							<input id="btn" type="button" class="submit" value="确定" /> 
							<input type="reset" class="reset" value="重置" />
							<input id="cancleFile" type="button" class="cancle" value="取消" /> 
						</div>
					</div>
				</fieldset>
			</form>
		</div>
		</div>
		
		<div class="widget-content ">
		<s:form name="form2" id="form2" method="post">
			<table class="table table-bordered table-striped with-check">
				<thead>
					<tr>
						<th style="width: 20px"><input type="checkbox" id="selAll"
							style="margin-bottom: 4px" onclick="selectAll();" />
							<input type="hidden" id="checkselect" value="false">
						</th>
						<th style="width: 30px">ID</th>
						<th style="width: 60px">用户名</th>
						<th style="width: 60px">级别</th>
						<th style="width: 150px">手机</th>
						<th style="width: 150px">邮箱</th>
						<th style="width: 100px">QQ</th>
						<th style="width: 100px">用户状态</th>
						<th style="width: 180px">操作</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="#request.page.pageList">
						<tr id="<s:property value="id"/>" class="formcolor">
							<td><input type="checkbox" style="margin-left: 6px"
								name="checkAll" id="checkAll" value="<s:property value="id"/>"
								onClick="setSelectAll();" /></td>
							<td><s:property value="id" /></td>
							<td><s:property value="name" /></td>
							<td id="role<s:property value="id" />">
								<s:property value="role"/></td>
							<td><s:property value="phone" /></td>
							<td><s:property value="email" /></td>
							<td><s:property value="qq" /></td>
							<s:if test="isForbidden">
								<td>禁用</td>
							</s:if>
							<s:else>
								<td>未禁用</td>
							</s:else>
							<td>
								<a class="btn btn-mini gray" href="User/delete?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>&state=${state}">删除</a>
								<s:if test="isForbidden">
									<a class="btn btn-mini green" href="User/forbidden?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>&state=${state}">启用</a>
								</s:if> <s:else>
									<a class="btn btn-mini orange" href="User/forbidden?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>&state=${state}">禁用</a>
								</s:else>
								<input type="hidden" value="<s:property value="id"/>" />		
								<s:if test="role!=0">
									<select id="select<s:property value="id"/>" onchange="t(this)" style="height:20px;width:75px;font-size:12px;padding:0 0;margin-bottom:0.9">															
										<option value="1">一级用户</option>
										<option value="2">二级用户</option>
										<option value="3">三级用户</option>
									</select>
								</s:if>					
								<script type="text/javascript">
									var id = "select"+"<s:property value="id"/>";
									var role = "<s:property value="role"/>" - 1; //0->一级；1->二级；2->三级
									var td = "#role"+"<s:property value="id"/>";
									var x=document.getElementById(id);
									x.selectedIndex = role;//设置初始等级	
									function t(obj){
										var id2 = obj.id.substring(6);	
										var roleid = "role" + id2;
										$.ajax({
											url:'User/changRole?id='+id2+'&role='+obj.value,
											type:'post',
											success:function(data){
												if(data == "true"){
													alert("修改成功！");
													document.getElementById(roleid).innerHTML = obj.value;
												}
											},
											error:function(){
												alert("修改失败");
												var x=document.getElementById(id);
												x.selectedIndex = role;//恢复初始值
											}
										});								
									}
								</script>
							</td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
			</s:form>
			<div id="upPageBar">
				<div class="pagination alternate"
					style="float: left; margin-top: 30px; margin-left: -15px">
					<ul>
						<s:if test="#request.page.showPrv != 0">
							<li id="firstPage" data-id="PAGE"><a
								href="User/list?pageNo=1&state=${state}">首页</a></li>
							<li id="lastPage" data-id="PAGE"><a
								href="User/list?pageNo=<s:property value="#request.page.pageNo -1"/>&state=${state}">上一页</a></li>
						</s:if>
						<s:else>
							<li class="disabled" id="firstPage" data-id="PAGE"><a
								href="javascript:void(0);">首页</a></li>
							<li class="disabled" id="lastPage" data-id="PAGE"><a
								href="javascript:void(0);">上一页</a></li>
						</s:else>
						<s:iterator value="#request.page.pageNum" id="key">
							<s:if test="#key != #request.page.pageNo">
								<li data-vl="1" data-id="PAGE" id="pageNo"><a
									href="User/list?pageNo=<s:property value="key"/>&state=${state}"><s:property
											value="key" /></a></li>
							</s:if>
							<s:else>
								<li data-vl="1" data-id="PAGE" id="pageNo" class="active">
									<a href="javascript:void(0);"><s:property value="key" /></a>
								</li>
								<input type="hidden" id="dqPageNo" value="<s:property value="key"/>"></input>
							</s:else>
						</s:iterator>
						<s:if test="#request.page.showNext != 0">
							<li id="nextPage" data-id="PAGE"><a
								href="User/list?pageNo=<s:property value="#request.page.pageNo +1"/>&state=${state}">下一页</a></li>
							<li id="endPage" data-id="PAGE"><a
								href="User/list?pageNo=<s:property value="#request.page.totalPage"/>&state=${state}">尾页</a></li>
						</s:if>
						<s:else>
							<li class="disabled" id="nextPage" data-id="PAGE"><a
								href="javascript:void(0);">下一页</a></li>
							<li class="disabled" id="endPage" data-id="PAGE"><a
								href="javascript:void(0);">尾页</a></li>
						</s:else>
						<li class="disabled"><a href="javascript:void(0);">共<s:property
									value="#request.page.totalPage" />页
						</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$(function(){
		var state = $('#checkRadio').val();
		if(state == 1)
			$('#all').attr("checked","checked");
		if(state == 2)
			$('#isForbidden').attr("checked","checked");
	});
	$("#addUser").click(function() {
		$("#mask").slideDown("fast",slidedown);
	});
	function slidedown(){
		$("#user_add").fadeIn("slow");
		$("#user_form_content").fadeIn("slow");
	}
	function slideup(){
		$("#user_add").fadeOut("slow");
		$("#user_form_content").fadeOut("slow");
	}
	$("#cancleFile").click(function(){
		slideup();
		$("#mask").slideUp("fast");
	});
	function dele(){
		var state = $("#checkRadio").val();
		var cs = $("#checkselect").val();
		if(cs=="true"){
			var pageNo = $("#dqPageNo").val();
			form2.action="User/delete?pageNo="+pageNo+"&state="+state;
			document.getElementById("form2").submit();
		}else{
			alert("请选中所需删除数据！");
		}
	}
	function allUser(){
		location.href="User/list?state=1";
	}
	function isForbidden(){
		location.href="User/list?state=2";
	}
	var selAll = document.getElementById("selAll");
	function selectAll() {
		var obj = document.getElementsByName("checkAll");
		if (document.getElementById("selAll").checked == false) {
			for (var i = 0; i < obj.length; i++) {
				obj[i].checked = false;
			}
			document.getElementById("checkselect").value="false";
		} else {
			for (var i = 0; i < obj.length; i++) {
				obj[i].checked = true;
			}
			document.getElementById("checkselect").value="true";
		}
	}	
	//当选中所有的时候，全选按钮会勾上 
	function setSelectAll() {
		var obj = document.getElementsByName("checkAll");
		var count = obj.length;
		var selectCount = 0;

		for (var i = 0; i < count; i++) {
			if (obj[i].checked == true) {
				selectCount++;
			}
		}
		if(selectCount>0){
			document.getElementById("checkselect").value="true";
		}else{
			document.getElementById("checkselect").value="false";
		}
		if (count == selectCount) {
			document.all.selAll.checked = true;
		} else {
			document.all.selAll.checked = false;
		}
	}
	//反选按钮 
	function inverse() {
		var checkboxs = document.getElementsByName("checkAll");
		for (var i = 0; i < checkboxs.length; i++) {
			var e = checkboxs[i];
			e.checked = !e.checked;
			setSelectAll();
		}
	}
	function checkUsername() {
		var username = $("#username").val();
		var regex = /^[0-9A-Za-z_]{3,15}$/;
		if (regex.exec(username) == null) {
			$("#username")[0].className = "required validation-failed";
			$("#advice-required-field1")[0].innerHTML="格式有误！";
			$("#advice-required-field1").removeAttr("style");
			return false;
		} else {
			$.ajax({
				type : "GET",
				url : "User/checkUserName?username=" + username,
				success : function(msg) {
					if (msg == "false") {
						$("#username")[0].className = "required validation-failed";
						$("#advice-required-field1")[0].innerHTML="已被使用！";
						$("#advice-required-field1").removeAttr("style");
						return false;
					} else {
						$("#username")[0].className = "required";
						$("#advice-required-field1").attr("style","display:none;");
						return true;
					}
				},
				error : function(msg) {
				}
			});
			return true;
		}
	}
	function checkPassword(){
		var password = $("#password").val();
		if(password.length < 6 || password.length > 12){
			$("#password")[0].className = "required validation-failed";
			$("#advice-required-field2")[0].innerHTML="6-12位密码！";
			$("#advice-required-field2").removeAttr("style");
			$("#advice-required-field2").attr("style","width:72px;");
			return false;
		}else{
			$("#password")[0].className = "required";
			$("#advice-required-field2").attr("style","display:none;");
			return true;
		}
	}
	function verifyPass() {
		var pass1, pass2;
		pass1 = $("#password").val();
		pass2 = $("#vpassword").val();
		if (pass2.length == 0) {
			$("#vpassword")[0].className = "required validation-failed";
			$("#advice-required-field3")[0].innerHTML="确认密码！";
			$("#advice-required-field3").removeAttr("style");
			return false;
		} else {
			if (pass1 != pass2) {
				$("#vpassword")[0].className = "required validation-failed";
				$("#advice-required-field3")[0].innerHTML="密码不一致！";
				$("#advice-required-field3").removeAttr("style");
				$("#advice-required-field3").attr("style","width:72px;");
				return false;
			} else {
				$("#vpassword")[0].className = "required";
				$("#advice-required-field3").attr("style","display:none;");
				return true;
			}
		}
	}
	$("#btn").click(function(){
		if(checkUsername() && checkPassword() && verifyPass()){
			$("#test").submit();
		}
	});	
	</script>
</body>
</html>