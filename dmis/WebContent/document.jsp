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
<script src="js/jquery.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/matrix-style.css" />
<link rel="stylesheet" type="text/css" href="css/bg/yetou.css" />
<link rel="stylesheet" type="text/css" href="css/dmis.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/buttons/buttons.css" />
<link rel="stylesheet" type="text/css" href="css/forms/style.css" />
</head>
<body id="table1">
	<input type="text" id="checkRadio" value="${state}"
		style='display: none' />
	<div id="mask" class="mask" style="display: none;background-color: rgb(40, 95, 108);"></div>
	<div class="widget-box">
		<div class="widget-title">
			<h5>文档管理</h5>
			<a class="btn btn-small gray" style="margin: 5px 0 0 3px;"onClick="dele();">删除选中</a> 
			<a class="btn btn-small green" style="margin: 5px 0 0 3px;" onClick="pass();">通过选中</a>
			<div class="widget-radio">
			
				<input id="fileEdit1" class="btn btn-small blue" type="button" value="新增文档" style="margin-bottom: 5px"> 
				<input id="fileEdit2" class="btn btn-small orange" type="button" value="新增文献" style="margin-bottom: 5px">
				<input type="radio" name="state" id="all" onClick="allPass();" />全部 
				<input type="radio" name="state" id="isPass" onClick="isPass();" />已录入 
				<input type="radio" name="state" id="noPass" onClick="noPass();" />待审核
			</div>
		</div>
		<!-- 绑定开始 -->
		<div id="keyword_doc" style="display: none;" align="center">
		<div id="keyword_doc_form_content" class="keyword_doc_form_content" style="display:none;">
			<form id="test_keyword_doc">
				<fieldset>
					<legend>关联词条</legend>
					<div class="form-row">
						<div class="field-label_keyword_doc">
							<label for="field1">词条名称：</label>:
						</div>
						<div class="field-widget">
							<input name="keyword" id="keyword" class="required"
								type="text" onblur="checkKeyword();"/>
							<div class="validation-advice" id="advice-required-field2"
								style="display: none;">required field.</div>
						</div>
					</div>

					<div class="form-row">
						<div class="field-widget-confirm_keyword_doc">
							<input id="btn_keyword_doc" type="button" class="submit" value="确定" /> 
							<input id="cancleFile_keyword_doc" type="button" class="cancle_keyword_doc" value="取消" /> 
						</div>
					</div>
				</fieldset>
			</form>
		</div>
		</div>
		<!-- 绑定结束 -->
		<div class="widget-content ">
			<s:form name="form2" id="form2" method="post">
				<table class="table table-bordered table-striped with-check">
					<thead>
						<tr>
							<th style="width: 20px;"><input type="checkbox"
								style="margin-bottom: 4px" id="selAll" onclick="selectAll();" /><input
								type="hidden" id="checkselect" value="false"></th>
							<th style="width: 20px;">编号</th>
							<th style="width: 100px;">文档名</th>
							<th style="width: 100px;">类型</th>
							<th style="width: 100px;">上传人</th>
							<th style="width: 100px;">上传时间</th>
							<th style="width: 70px;">是否通过</th>
							<th style="width: 130px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="#request.page.pageList">
							<tr>
								<td><input type="checkbox" style="margin-left: 12px"
									name="checkAll" id="checkAll" value="<s:property value="id"/>"
									onClick="setSelectAll();" /></td>
								<td><s:property value="id" /></td>
								<td class="link_href"><a href="Doc/reading?id=<s:property value="id"/>" 
								   target="_blank" style="text-decoration: none;"><s:property
											value="title" /></a></td>
								<td><s:property value="format" /></td>
								<td><s:property value="author" /></td>
								<td><s:date name="uploadTime" format="yyyy-MM-dd HH:mm" /></td>
								<s:if test="isPass">
									<td>通过</td>
								</s:if>
								<s:else>
									<td>未通过</td>
								</s:else>
								<td><a class="btn btn-mini gray" id="updateDoc"
								      href="Doc/delete?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>&state=${state}">
								                     删除</a> 
								    <input name="<s:property value="id"/>" value="关联词条" type="button" class="btn btn-mini blue" onclick="bindKeywordClick(<s:property value="id"/>)"/>
								<s:if test="!isPass">
									<a class="btn btn-mini green"
									  href="Doc/passDoc.action?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>&state=${state}">
									         通过</a>
							    </s:if> 
							    <s:else>
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
								href="Doc/list?pageNo=1&state=${state}">首页</a></li>
							<li id="lastPage" data-id="PAGE"><a
								href="Doc/list?pageNo=<s:property value="#request.page.pageNo -1"/>&state=${state}">上一页</a></li>
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
									href="Doc/list?pageNo=<s:property value="key"/>&state=${state}"><s:property
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
								href="Doc/list?pageNo=<s:property value="#request.page.pageNo +1"/>&state=${state}">下一页</a></li>
							<li id="endPage" data-id="PAGE"><a
								href="Doc/list?pageNo=<s:property value="#request.page.totalPage"/>&state=${state}">尾页</a></li>
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
		var docId;
		var keywordId;
		var value_keyword=false;
		function bindKeywordClick(did){
			docId = did;
			$("#mask").slideDown("fast");
			$("#keyword_doc").fadeIn("slow");
			$("#keyword_doc_form_content").fadeIn("slow");
		}
		$("#cancleFile_keyword_doc").click(function(){
			cancleFile_keyword_doc();
		});
		function cancleFile_keyword_doc(){
			$("#keyword_doc").fadeOut("slow");
			$("#keyword_doc_form_content").fadeOut("slow");
			$("#mask").slideUp("fast");
		}
		function checkKeyword(){
			var keyword = $("#keyword").val();
			if(!keyword){
				$("#keyword")[0].className = "required validation-failed";
				$("#advice-required-field2")[0].innerHTML="不为空！";
				$("#advice-required-field2").removeAttr("style");
				return false;
			}else{
				var keyword = encodeURI(encodeURI(keyword));
				$.ajax({
					type:'GET',
					async : false,
					url:"Keyword/checkKeywordByName?k="+keyword,
					success:function(result){
						if(result == "noKeyword"){
							$("#keyword")[0].className = "required validation-failed";
							$("#advice-required-field2")[0].innerHTML="不存在！";
							$("#advice-required-field2").removeAttr("style");
							value_keyword = false;
						}else{
							$("#keyword")[0].className = "required";
							$("#advice-required-field2").attr("style","display:none;");
							keywordId = result;
							value_keyword = true;
						}
					},
					error:function(){
						alert("errooor");
						value_keyword = false;
					}
				});
				return value_keyword;
			}
		}
		$("#btn_keyword_doc").click(function(){
			if(checkKeyword()){
				$.ajax({
					type:"post",
					async : false,
					url:"Keyword/bindDoc?keywordid="+keywordId+"&docid="+docId,
					success:function(result){
						if(result=="success"){
							alert("绑定成功！");
							cancleFile_keyword_doc();
						}if(result=="repeat"){
							alert("重复绑定！");
						}
					},
					error:function(){
						alert("出错啦，抢修中。。。。");
					}
				});
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
		function allPass() {
			location.href = "Doc/list?state=2";
		}
		function isPass() {
			location.href = "Doc/list?state=1";
		}
		function noPass() {
			location.href = "Doc/list?state=0";
		}

		function dele() {
			var state = $("#checkRadio").val();
			var checkselect = $("#checkselect").val();
			if (checkselect == "true") {
				var pageNo = $("#dqPageNo").val();
				form2.action = "Doc/delete?pageNo=" + pageNo+"&state="+state;
				document.getElementById("form2").submit();
			} else {
				alert("请选中所需删除数据！");
			}
		}
		function pass() {
			var state = $("#checkRadio").val();
			var checkselect = $("#checkselect").val();
			if (checkselect == "true") {
				var pageNo = $("#dqPageNo").val();
				form2.action = "Doc/passCheck?pageNo=" + pageNo+"&state="+state;
				document.getElementById("form2").submit();
			} else {
				alert("请选中所需要通过的数据！");
			}
		}
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
				$("#checkselect")[0].value="true";
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

		$("#fileEdit1").click(
			function(){
				location.href="Doc/addDoc";
			}		
		);
		$("#fileEdit2").click(
			function(){
				location.href="Doc/addLiteratrue";
			}		
		);
	</script>
</body>
</html>