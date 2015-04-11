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
<link rel="stylesheet" type="text/css" href="css/bg/yetou.css"/>
<link rel="stylesheet" type="text/css" href="css/dmis.css"/>
<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/matrix-style.css" />
<link rel="stylesheet" href="css/matrix-media.css" />
<link rel="stylesheet" href="css/uniform.css" />
<link rel="stylesheet" href="css/select2.css" />
<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href="css/matrix-style.css" rel="stylesheet" type="text/css" />

<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body id="table1">
<input type="text" id="checkRadio" value="${state}" style='display:none'/>
	<div class="mask" style="display: none"></div>
	<div class="widget-box">
		<div class="widget-title">
			<h5>人员管理</h5>
			<a class="btn btn-small " style="margin: 5px 0 0 3px;" onClick="dele();">删除选中</a>
			<div class="widget-radio">
				<input id="addUser" class="btn btn-small" type="button"
					value="新增人员" style="margin-bottom: 5px">
					<input type="radio" name="state" id="all"   onClick="allUser();"/>全部
					<input type="radio" name="state" id="isForbidden"  onClick="isForbidden();"/>已禁用
			</div>
		</div>
		<div id="infoEdit" style="display: none" align="center">
			<div id="passEditContent" style="display: none;">
				<div class="infoHeader bg_lg">
					<span id="title">用户添加</span>
				</div>
				<br>
				<div style="height: 200px">
					<form id="user" name="user" method="post" action="User/add">
						<div class="row" id="editInfo"
							style="color: #FFF; font-size: 14px; margin: 60px 0 0 15px;">
							<div class="control-group" style="height: 100px">
								<div class="controls" style="height: 150px">
									<div style="height: 50px; float: left">
										<div class="main_input_box"
											style="float: left; margin-left: 90px; margin-top: 0px; height: 30px">
											<span class="add-on bg_lg"><li class="icon-user"></li></span>
											<input id="username" name="user.name" type="text"
												placeholder="用户名" onblur="checkUsername()" /> 
												<font color="red" id="umsg"></font>
												<input type="hidden" id="usercheck" value="false">
										</div>
										<div style="font-size: 8px; float: left; margin-left: 90px">
											<a style="color: #28b779; margin-left: 55px">用户名必须为字母数字下划线!</a>
										</div>
									</div>
									<br />
									<div class="main_input_box"
										style="float: left; margin-left: 90px">
										<span class="add-on bg_lg"><li class="icon-key"></li></span>
										<input id="pass" name="user.password" type="password"
											placeholder="密码" />
									</div>
									<br />
									<div class="main_input_box"
										style="float: left; margin-left: 90px">
										<span class="add-on bg_lg"><li class="icon-key"></li></span>
										<input id="vfpass" type="password" placeholder="确认密码" onblur="verifyPass()"/> 
										<font color="red" id="vpass"></font>
										<input id="passcheck" type="hidden" value="false">
									</div>
								</div>
							</div>
							<div style="height: 30px; margin-top: 20px">
								<div style="width: 160px; margin-left: -70px">
									<input type="button" class="btn btn-success" style="margin: 0px 0 0 0;"
										id="btn" value="确定" onclick="check(),checkUsername(),verifyPass()"/> 
									<input type="reset" id="close" class="btn" style="margin: 0px 0 0 40px;"value="取消"  /><br>
									<br>
								</div>
							</div>
						</div>
					</form>
				</div>
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
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="#request.page.pageList">
						<tr id="<s:property value="id"/>">
							<td><input type="checkbox" style="margin-left: 6px"
								name="checkAll" id="checkAll" value="<s:property value="id"/>"
								onClick="setSelectAll();" /></td>
							<td><s:property value="id" /></td>
							<td><s:property value="name" /></td>
							<td id="role<s:property value="id" />"><s:property value="role" /></td>
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
								<a class="btn btn-mini" href="User/delete2?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>">删除</a>
								<s:if test="isForbidden">
									<a class="btn btn-mini" href="User/forbidden?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>">启用</a>
								</s:if> <s:else>
									<a class="btn btn-mini" href="User/forbidden?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>">禁用</a>
								</s:else>
								<input type="hidden" value="<s:property value="id"/>" />							
								<select id="select<s:property value="id"/>" onchange="t(this)" style="height:20px;width:75px;font-size:12px;padding:0 0;margin-bottom:0.9">															
									<option value="1">一级用户</option>
									<option value="2">二级用户</option>
									<option value="3">三级用户</option>
								</select>								
								<script type="text/javascript">
									var id = "select"+"<s:property value="id"/>";
									var role = "<s:property value="role"/>" - 1;
									var td = "#role"+"<s:property value="id"/>";
									var x=document.getElementById(id);
									x.selectedIndex = role;																						
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
												var x=document.getElementById(id)
												x.selectedIndex = role;			
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
							<li class id="firstPage" data-id="PAGE"><a
								href="User/list?pageNo=1&state=${state}">首页</a></li>
							<li class id="lastPage" data-id="PAGE"><a
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
							<li class id="nextPage" data-id="PAGE"><a
								href="User/list?pageNo=<s:property value="#request.page.pageNo +1"/>&state=${state}">下一页</a></li>
							<li class id="endPage" data-id="PAGE"><a
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
	function dele(){
		var cs = $("#checkselect").val();
		if(cs=="true"){
			var pageNo = $("#dqPageNo").val();
			form2.action="User/delete?pageNo="+pageNo;
			document.getElementById("form2").submit();
		}else{
			alert("请选中所需删除数据！");
		}
		
	}
	
	$(function(){
		var state = $('#checkRadio').val();
		if(state == 1)
			$('#all').attr("checked","checked");
		if(state == 2)
			$('#isForbidden').attr("checked","checked");
	});
	function allUser(){
		location.href="User/list?state=1";
	}
	function isForbidden(){
		location.href="User/list?state=2";
	}
		$(function() {
			$("#addUser").click(function() {
				$("#infoEdit").removeAttr("style");
				/* $(".mask").slideDown("slow"); */
				if (this.id == 'addUser') {
					$("#passEditContent").removeAttr('style');
				}
			});
			$("#close").click(function() {
				$(".mask").slideUp("slow");
				$("#infoEdit").attr('style', 'display:none');
			});
		});
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
				document.getElementById("umsg").color = "red";
				document.getElementById("umsg").innerHTML = "用户名不合法！";
				$("#usercheck").val("false");
			} else {
				$
						.ajax({
							type : "GET",
							url : "User/checkUserName?username=" + username,
							success : function(msg) {
								if (msg == "false") {
									document.getElementById("umsg").color = "red";
									document.getElementById("umsg").innerHTML = "该用户名已被使用";
									$("#usercheck").val("false");
								} else {
									document.getElementById("umsg").color = "green";
									document.getElementById("umsg").innerHTML = "恭喜!用户名可用";
									$("#usercheck").val("true");
								}
							},
							error : function(msg) {
							
							}
						});
			}
		}
		function verifyPass() {
			var pass1, pass2;
			pass1 = $("#pass").val();
			pass2 = $("#vfpass").val();
			if (pass1.length == 0 || pass2.length == 0) {
				document.getElementById("vpass").color = "red";
				document.getElementById("vpass").innerHTML = "密码不能为空！";
				$("#passcheck").val("false");
			} else {
				if (pass1 != pass2) {
					document.getElementById("vpass").color = "red";
					document.getElementById("vpass").innerHTML = "两次密码不一致！";
					$("#passcheck").val("false");
				} else {
					document.getElementById("vpass").color = "green";
					document.getElementById("vpass").innerHTML = "密码一致！";
					$("#passcheck").val("true");
				}
			}

		}
		function check() {
			var usercheck = $("#usercheck").val();
			var passcheck = $("#passcheck").val();
			if(usercheck=="false" || passcheck=="false"){
				document.getElementById("btn").type = "button";
			}else{
				document.getElementById("btn").type = "submit";
			}
		}
	</script>
</body>
</html>