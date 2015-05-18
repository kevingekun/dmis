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
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/ckeditor/ckeditor.js"></script>

<link rel="stylesheet" type="text/css" href="css/bg/yetou.css" />
<link rel="stylesheet" type="text/css" href="css/dmis.css"/>
<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/matrix-media.css" />
<link rel="stylesheet" type="text/css" href="css/uniform.css" />
<link rel="stylesheet" type="text/css" href="css/select2.css" />
<link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="css/matrix-style.css" />
<link rel="stylesheet" type="text/css" href="css/buttons/buttons.css" />
<link rel="stylesheet" type="text/css" href="css/forms/style.css" />

<script src="js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body id="table1">
	<div id="mask" class="mask" style="display: none;background-color: rgb(40, 95, 108);"></div>
	<div class="widget-box">
		<div class="widget-title">
			<h5>公告管理</h5>
			<a class="btn btn-small gray" style="margin: 5px 0 0 3px;" onClick="dele();">删除选中</a>
			<div class="widget-radio">
				<input id="addNotice" class="btn btn-small blue" type="button" value="新增公告" style="margin-bottom: 5px">
			</div>
		</div>
		<div id="notice_add" style="display: none;" align="center">
		<div id="notice_form_content" class="notice_form_content" style="display:none;">
			<form id="test" action="Notice/add" method="post"
				enctype="multipart/form-data">
				<fieldset>
					<legend>新增  公告</legend>
					<div class="form-row">
						<div class="field-label_notice">
							<label for="field1">标题</label>:
						</div>
						<div class="field-widget">
							<input name="notice.title" id="notice" class="required"
								type="text" onblur="checkTitle();"/>
							<div class="validation-advice" id="advice-required-field1"
								style="display: none;">required field.</div>
						</div>
					</div>

					<div class="form-row_notice">
						<div class="controls">
						<textarea id="con" name="notice.content" cols="20" rows="2"
							class="ckeditor" onblur="checkContent()"></textarea>
						<script type="text/javascript">
							var ckeditor=CKEDITOR.replace('con', {
								uiColor: '#becffb'
							});
						</script>
					</div>
					</div>
					<div class="form-row">
						<div class="field-widget-confirm_notice">
							<input id="btn" type="button" class="submit" value="确定" /> 
							<input type="reset" class="reset" value="重置" />
							<input id="cancleFile" type="button" class="cancle" value="取消" /> 
						</div>
					</div>
				</fieldset>
			</form>
		</div>
		</div>
		<div id="notice_check" style="display: none;" align="center">
		<div id="noticecheck_form_content" class="notice_form_content" style="display:none;">
			<form>
				<fieldset>
					<legend>查看  公告</legend>
					<div class="form-row">
						<div class="field-label_notice">
							<label for="field1">标题</label>:
						</div>
						<div class="field-widget">
							<input id="notice2" class="required"
								type="text"/>
						</div>
					</div>

					<div class="form-row_notice">
						<div class="controls">
						<textarea id="con2" cols="20" rows="2" class="ckeditor" ></textarea>
						<script type="text/javascript">
							var ckeditor2=CKEDITOR.replace('con2', {
								uiColor: '#becffb'
							});
						</script>
					</div>
					</div>
					<div class="form-row">
						<div class="field-widget-confirm_notice" style="margin-left: 630px;">
							<input id="cancleFile2" type="button" class="reset" value="关闭" />
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
							<li id="firstPage" data-id="PAGE"><a
								href="Notice/list?pageNo=1">首页</a></li>
							<li id="lastPage" data-id="PAGE"><a
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
							<li id="nextPage" data-id="PAGE"><a
								href="Notice/list?pageNo=<s:property value="#request.page.pageNo +1"/>">下一页</a></li>
							<li id="endPage" data-id="PAGE"><a
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
		$("#addNotice").click(function() {
			$("#mask").slideDown("fast",slidedown);
		});
		function slidedown(){
			$("#notice_add").fadeIn("slow");
			$("#notice_form_content").fadeIn("slow");
		}
		function slideup(){
			$("#notice_add").fadeOut("slow");
			$("#notice_form_content").fadeOut("slow");
		}
		$("#cancleFile").click(function(){
			slideup();
			$("#mask").slideUp("fast");
		});
		$("#cancleFile2").click(function(){
			$("#notice_check").fadeOut("slow");
			$("#noticecheck_form_content").fadeOut("slow");
			$("#mask").slideUp("fast");
		});
		//删除选中
		function dele() {
			var checkselect = $("#checkselect").val();
			if(checkselect=="true"){
				var pageNo = $("#dqPageNo").val();
				form2.action = "Notice/delete?pageNo=" + pageNo;
				document.getElementById("form2").submit();
			}else{
				alert("请选中所需删除数据！");
			};
		}
		function noticeCheck(id){
			$.ajax({
				type:'GET',
				url:"Notice/checkNotice?id="+id,
				success:function(jsonData){
					var data = eval(jsonData);
	      			$("#notice2")[0].value=data[0].title;
	      			ckeditor2.setData(data[0].content);//编辑器内容填充
				},
				error:function(){
					alert("errooor");
				}
			});
			$("#mask").slideDown("fast");
			$("#notice_check").fadeIn("slow");
			$("#noticecheck_form_content").fadeIn("slow");
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
			};
		}
		//当选中所有的时候，全选按钮会勾上 
		function setSelectAll() {
			var obj = document.getElementsByName("checkAll");
			var count = obj.length;
			var selectCount = 0;

			for (var i = 0; i < count; i++) {
				if (obj[i].checked == true) {
					selectCount++;
				};
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
			};
		}
		//反选按钮 
		function inverse() {
			var checkboxs = document.getElementsByName("checkAll");
			for (var i = 0; i < checkboxs.length; i++) {
				var e = checkboxs[i];
				e.checked = !e.checked;
				setSelectAll();
			};
		}
		//检查标题是否符合要求  
		function checkTitle() {
			var notice = $("#notice").val();
			notice = notice.replace(/\s+/g, "");
			if (notice.length == 0) {
				$("#notice")[0].className = "required validation-failed";
				$("#advice-required-field1")[0].innerHTML="不为空！";
				$("#advice-required-field1").removeAttr("style");
				return false;
			} else {
				$("#notice")[0].className = "required";
				$("#advice-required-field1").attr("style","display:none;");
				return true;
			};
		}
		//检查正文
		function checkContent() {
			var str=ckeditor.document.getBody().getText();
			content = str.replace(/^\s+|\s+$/g, '');
			if (content.length == 0) {
				alert("请添公告正文！");
				return false;
			}
			return true;
		}
		$("#btn").click(function(){
			if(checkTitle()&&checkContent()){
				$("#test").submit();
			}
		});
	</script>
</body>
</html>



