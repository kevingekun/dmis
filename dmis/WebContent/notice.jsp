<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/bg/yetou.css" />
<link rel="stylesheet" type="text/css" href="css/dmis.css"/>
<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/matrix-style.css" />
<link rel="stylesheet" type="text/css" href="css/matrix-media.css" />
<link rel="stylesheet" type="text/css" href="css/uniform.css" />
<link rel="stylesheet" type="text/css" href="css/select2.css" />
<link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="css/matrix-style.css" />
<link rel="stylesheet" type="text/css" href="css/buttons/buttons.css" />

<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body id="table1">
	<div class="mask" style="display: none"></div>
	<div class="widget-box">
		<div class="widget-title">
			<h5>公告管理</h5>
			<a class="btn btn-small gray" style="margin: 5px 0 0 3px;" onClick="dele();">删除选中</a>
			<div class="widget-radio">
				<input id="addNotice" class="btn btn-small blue" type="button" value="新增公告" style="margin-bottom: 5px">
			</div>
		</div>
		<div id="infoEdit" style="display: none" align="center">
			<div id="addNoticeContent" style="display: none;">
				<div class="infoHeader bg_lg">
					<span id="title">新增公告</span>
				</div>
				<form method="post" action="Notice/add">
					<div class="row" id="editInfo"
						style="color: #FFF; font-size: 14px; margin: 40px 0 0 15px;">
						<div class="control-group" style="float: left">
							<div class="controls">
								<div style="float: left; width: 480px">
									<a style="float: left; color: #28b779">标题：</a>
								</div>
								<div class="main_input_box" style="float: left">
									<input type="text" id="tit" name="notice.title"
										placeholder="标题" onblur="checkTitle()" /> <input type="hidden"
										id="ti" value="false" /> <font color="red" id="tcheck"></font>
								</div>
								<div style="float: left; width: 480px">
									<a style="float: left; color: #28b779">正文：</a>
								</div>
								<div class="main_input_box" style="width: 550px; height: 200px">
									<textarea name="notice.content" id="con" rows="3" cols="4"
										style="width: 500px; height: 200px; float: left; margin-left: 0px"
										placeholder="正文" onblur="checkContent()"></textarea>
									<input type="hidden" id="co" value="false" /> <font color="red"
										id="ccheck"
										style="writing-mode: lr-tb; float: left; width: 15px; margin-top: 40px"></font>
								</div>
							</div>
						</div>
						<input type="button" class="btn btn-success"
							style="margin: 10px 0 0 0" id="btn" value="确定"
							onclick="check(),checkTitle(),checkContent()" /> <input
							type="reset" class="btn " style="margin: 10px 0 0 40px;"
							id="close" value="取消" /><br>
					</div>
				</form>
			</div>
		</div>
		<div id="infoCheck" style="display: none" align="center">
			<div id="noticeCheck" style="display: none;">
				<div class="infoHeader bg_lg">
					<span id="title">查看公告</span>
				</div>
				<form>
					<div class="row" id="editInfo"
						style="color: #FFF; font-size: 14px; margin: 40px 0 0 15px;">
						<div class="control-group" style="float: left">
							<div class="controls">
								<div style="float: left; width: 480px">
									<a style="float: left; color: #28b779">标题：</a>
								</div>
								<div class="main_input_box" style="float: left">
									<input type="text" id="tit2" disabled="disabled" name=""/>
								</div>
								<div style="float: left; width: 480px">
									<a style="float: left; color: #28b779">正文：</a>
								</div>
								<div class="main_input_box" style="width: 550px; height: 200px">
									<textarea disabled="disabled" id="con2" rows="3" cols="4"
										name="" style="width: 500px; height: 200px; float: left; margin-left: 0px"></textarea>
								</div>
							</div>
						</div> 
						<input type="reset" class="btn" id="closeCheck" value="关闭" /><br>
					</div>
				</form>
			</div>
		</div>
		<div class="widget-content ">
			<s:form name="form2" id="form2" method="post">
				<table class="table table-bordered table-striped with-check">
					<thead>
						<tr>
							<th style="width: 8px"><input type="checkbox" id="selAll"
								value="" class="checkbox" onClick="selectAll()"
								style="margin-bottom: 4px" />
								<input type="hidden" id="checkselect" value="false">
							</th>
							<th style="width: 20px">ID</th>
							<th style="width: 100px">标题</th>
							<th style="width: 300px">内容</th>
							<th style="width: 70px">发布日期</th>
							<th style="width: 50px">操作</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="#request.page.pageList">
							<tr id="<s:property value="id"/>">
								<td><input type="checkbox" style="margin-left: 7px"
									name="checkAll" id="checkAll" value="<s:property value="id"/>"
									onclick="setSelectAll();" /></td>
								<td><s:property value="id" /></td>
								<td style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap;" class="link_href">
									<a style="cursor:hand;text-decoration:none;" onclick="noticeCheck(<s:property value="id"/>)"><s:property value="title" /></a>
								</td>
								<td style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap;"><s:property value="content" /></td>
								<td><s:date name="time" format="yyyy-MM-dd hh:mm" /></td>
								<td><a class="btn btn-mini gray" href="Notice/delete2?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>">删除</a></td>
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
								href="Notice/list?pageNo=1">首页</a></li>
							<li class id="lastPage" data-id="PAGE"><a
								href="Notice/list?pageNo=<s:property value="#request.page.pageNo -1"/>">上一页</a></li>
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
									href="Notice/list?pageNo=<s:property value="key"/>"><s:property
											value="key" /></a></li>
							</s:if>
							<s:else>
								<li data-vl="1" data-id="PAGE" id="pageNo" class="active">
									<a href="javascript:void(0);"><s:property value="key" /></a>
								</li>
								<input type="hidden" id="dqPageNo"
									value="<s:property value="key"/>"></input>
							</s:else>
						</s:iterator>
						<s:if test="#request.page.showNext != 0">
							<li class id="nextPage" data-id="PAGE"><a
								href="Notice/list?pageNo=<s:property value="#request.page.pageNo +1"/>">下一页</a></li>
							<li class id="endPage" data-id="PAGE"><a
								href="Notice/list?pageNo=<s:property value="#request.page.totalPage"/>">尾页</a></li>
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
		//删除选中
		function dele() {
			var checkselect = $("#checkselect").val();
			if(checkselect=="true"){
				var pageNo = $("#dqPageNo").val();
				form2.action = "Notice/delete?pageNo=" + pageNo;
				document.getElementById("form2").submit();
			}else{
				alert("请选中所需删除数据！");
			}
			
		}
		$(function() {
			$("#addNotice").click(function() {
				$("#infoEdit").removeAttr("style");
				/* $(".mask").slideDown("slow"); */
				if (this.id == 'addNotice') {
					$("#addNoticeContent").removeAttr('style');
				}
			});
			$("#close").click(function() {
				$(".mask").slideUp("slow");
				$("#infoEdit").attr('style', 'display:none');
			});
			$("#closeCheck").click(function() {
				$(".mask").slideUp("slow");
				$("#infoCheck").attr('style', 'display:none');
			});
		});
		function noticeCheck(id){
			$.ajax({
				type:'GET',
				url:"Notice/checkNotice?id="+id,
				success:function(jsonData){
					var data = eval(jsonData);
	      			document.getElementById("tit2").value=data[0].title;
	      			document.getElementById("con2").value=data[0].content;

				},
				error:function(){
					alert("errooor");
				}
			});
			$("#infoCheck").removeAttr("style");
			$(".mask").slideDown("slow");
			$("#noticeCheck").removeAttr('style');
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
		//检查标题是否符合要求  
		function checkTitle() {
			var str = $("#tit").val();
			title = str.replace(/^\s+|\s+$/g, '');
			if (title.length == 0) {
				document.getElementById("tcheck").color = "red";
				document.getElementById("tcheck").innerHTML = "标题不能为空！";
				$("#ti").val("false");
			} else {
				document.getElementById("tcheck").color = "green";
				document.getElementById("tcheck").innerHTML = "标题可用！";
				$("#ti").val("true");
			}
		}
		//检查正文
		function checkContent() {
			var str = $("#con").val();
			content = str.replace(/^\s+|\s+$/g, '');
			if (content.length == 0) {
				document.getElementById("ccheck").color = "red";
				document.getElementById("ccheck").innerHTML = "请输入正文";
				$("#co").val("false");
			} else {
				document.getElementById("ccheck").color = "green";
				document.getElementById("ccheck").innerHTML = "请继续";
				$("#co").val("true");
			}
		}
		//总检
		function check() {
			var ti = $("#ti").val();
			var co = $("#co").val();
			if (ti == "false" || co == "false") {
				document.getElementById("btn").type = "button";
			} else {
				document.getElementById("btn").type = "submit";
			}
		}
	</script>
</body>
</html>



