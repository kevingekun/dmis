<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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

<link rel="stylesheet" type="text/css" href="css/bg/yetou.css" />
<link rel="stylesheet" type="text/css" href="css/dmis.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/matrix-media.css" />
<link rel="stylesheet" type="text/css" href="css/uniform.css" />
<link rel="stylesheet" type="text/css" href="css/select2.css" />
<link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="css/buttons/buttons.css" />
<link rel="stylesheet" type="text/css" href="css/forms/style.css" />
</head>
<body id="table1">
	<input type="text" id="checkRadio" value="${state}"
		style="display: none" />
	<div id="mask" class="mask" style="display: none;background-color: rgb(40, 95, 108);"></div>
	<div class="widget-box">
		<div class="widget-title">
			<h5>词条管理</h5>
			<a class="btn btn-small gray" style="margin: 5px 0 0 3px;"
				onClick="dele();">删除选中</a> <a class="btn btn-small green"
				style="margin: 5px 0 0 3px;" onClick="pass();">通过选中</a>
			<div class="widget-radio">
				<input id="addkeyword" class="btn btn-small blue" type="button"
					value="新增词条" style="margin-bottom: 5px">
				<input type="radio" name="state" id="all" onClick="allPass();" />全部 
				<input type="radio" name="state" id="isPass" onClick="isPass();" />已录入 
				<input type="radio" name="state" id="noPass" onClick="noPass();" />待审核
			</div>
		</div>
		
		<div id="keyword_add" style="display: none;" align="center">
		<div id="keyword_form_content" class="keyword_form_content" style="display:none;">
			<form id="test" action="Keyword/addKeyword.action" method="post"
				enctype="multipart/form-data">
				<fieldset>
					<legend>添加  词条</legend>
					<div class="form-row">
						<div class="field-label_keyword">
							<label for="field1">词条名</label>:
						</div>
						<div class="field-widget">
							<input name="keyword.keyword" id="keyword" class="required"
								type="text" onblur="checkKeyword();"/>
							<div class="validation-advice" id="advice-required-field1"
								style="display: none;">required field.</div>
						</div>
					</div>

					<div class="form-row_keyword">
						<div class="controls">
						<textarea id="con" name="keyword.content" cols="20" rows="2"
							class="ckeditor" onblur="checkContent()"></textarea>
						<script type="text/javascript">
							//CKEDITOR.replace("keyword.content");
							var ckeditor=CKEDITOR.replace('con', {
								uiColor: '#82f5c8'
							});
						</script>
					</div>
					</div>
					<div class="form-row">
						<div class="field-widget-confirm_keyword">
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
							<th style="width: 20px;"><input type="checkbox" id="selAll"
								style="margin-bottom: 4px" onclick="selectAll();" /><input
								type="hidden" id="checkselect" value="false"></th>
							<th style="width: 30px;">编号</th>
							<th style="width: 280px;">知识名</th>
							<th style="width: 200px;">提交时间</th>
							<th style="width: 100px;">是否通过</th>
							<th style="width: 150px;">操作</th>
						</tr>
					</thead>
					<tbody>

						<s:iterator value="#request.page.pageList">
							<tr>
								<td><input type="checkbox" style="margin-left: 8px"
									name="checkAll" id="checkAll" value="<s:property value="id"/>"
									onClick="setSelectAll();" /></td>
								<td><s:property value="id" /></td>
								<td class="link_href"><a
									href="Keyword/hrefsearch?keywordId=<s:property value="id"/>"
									target="_blank" style="text-decoration: none;"><s:property
											value="keyword" /></a></td>
								<td><s:date name="commitTime" format="yyyy-MM-dd HH:mm" /></td>
								<s:if test="isPass">
									<td>通过</td>
								</s:if>
								<s:else>
									<td>未通过</td>
								</s:else>
								<td><a class="btn btn-mini gray"
									href="Keyword/delete?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>">删除</a>
									<s:if test="!isPass">
										<a class="btn btn-mini green"
											href="Keyword/passKeyword?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>&state=${state}">通过</a>
									</s:if> <s:else>
									</s:else></td>
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
								href="Keyword/list?pageNo=1&state=${state}">首页</a></li>
							<li id="lastPage" data-id="PAGE"><a
								href="Keyword/list?pageNo=<s:property value="#request.page.pageNo -1"/>&state=${state}">上一页</a></li>
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
									href="Keyword/list?pageNo=<s:property value="key"/>&state=${state}"><s:property
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
								href="Keyword/list?pageNo=<s:property value="#request.page.pageNo +1"/>&state=${state}">下一页</a></li>
							<li id="endPage" data-id="PAGE"><a
								href="Keyword/list?pageNo=<s:property value="#request.page.totalPage"/>&state=${state}">尾页</a></li>
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
		$("#addkeyword").click(function() {
			$("#mask").slideDown("fast",slidedown);
		});
		function slidedown(){
			$("#keyword_add").fadeIn("slow");
			$("#keyword_form_content").fadeIn("slow");
		}
		function slideup(){
			$("#keyword_add").fadeOut("slow");
			$("#keyword_form_content").fadeOut("slow");
		}
		$("#cancleFile").click(function(){
			slideup();
			$("#mask").slideUp("fast");
		});
		function checkKeyword() {
			var keyword = $("#keyword").val();
			keyword2 = keyword.replace(/\s+/g, "");
			if (keyword.length == 0) {
				$("#keyword")[0].className = "required validation-failed";
				$("#advice-required-field1")[0].innerHTML="不为空！";
				$("#advice-required-field1").removeAttr("style");
				return false;
			} else {
				if (keyword.length > keyword2.length) {
					$("#keyword")[0].className = "required validation-failed";
					$("#advice-required-field1")[0].innerHTML="有空格！";
					$("#advice-required-field1").removeAttr("style");
					return false;
				} else {
					$("#keyword")[0].className = "required";
					$("#advice-required-field1").attr("style","display:none;");
					return true;
				}
			}
		}
		function checkContent() {
			var str=ckeditor.document.getBody().getText();
			content = str.replace(/^\s+|\s+$/g, '');
			if (content.length == 0) {
				alert("请添加词条内容！");
				return false;
			}
			return true;
		}
		$("#btn").click(function(){
			if(checkKeyword()&&checkContent()){
				$("#test").submit();
			}
		});
		$(function() {
			var state = $('#checkRadio').val();
			if (state == 2)
				$('#all').attr("checked", "checked");
			if (state == 1)
				$('#isPass').attr("checked", "checked");
			if (state == 0)
				$('#noPass').attr("checked", "checked");
		});
		function change(radio_oj, aValue) { //传入一个对象
			for (var i = 0; i < radio_oj.length; i++) //循环
			{
				if (radio_oj[i].value == aValue) //比较值
				{
					radio_oj[i].checked = true; //修改选中状态
					break; //停止循环
				}
			}
		}

		function dele() {
			var checkselect = $("#checkselect").val();
			if (checkselect == "true") {
				var pageNo = $("#dqPageNo").val();
				form2.action = "Keyword/deleteCheck?pageNo=" + pageNo;
				document.getElementById("form2").submit();
			} else {
				alert("请选中需要删除的数据！");
			}
		}
		function pass() {
			var checkselect = $("#checkselect").val();
			if (checkselect == "true") {
				var pageNo = $("#dqPageNo").val();
				form2.action = "Keyword/passCheck?pageNo=" + pageNo;
				document.getElementById("form2").submit();
			} else {
				alert("请选中需要通过的数据!");
			}
		}
		function allPass() {
			location.href = "Keyword/list?state=2";
		}
		function isPass() {
			location.href = "Keyword/list?state=1";
		}
		function noPass() {
			location.href = "Keyword/list?state=0";
		}
		$(function() {
			$("#addWord").click(function() {

				if (this.id == 'addWord') {
					$("#infoEdit").removeAttr("style");
					$(".mask").slideDown("slow");
					$("#addWordContent").removeAttr('style');
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
			} else {
				for (var i = 0; i < obj.length; i++) {
					obj[i].checked = true;
				}
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
			if (selectCount > 0) {
				document.getElementById("checkselect").value = "true";
			} else {
				document.getElementById("checkselect").value = "false";
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
	</script>

</body>
</html>