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

<link rel="stylesheet" type="text/css" href="css/matrix-style.css" />
<link rel="stylesheet" type="text/css" href="css/bg/yetou.css" />
<link rel="stylesheet" type="text/css" href="css/dmis.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/buttons/buttons.css" />
<link rel="stylesheet" type="text/css" href="css/forms/style.css" />

</head>
<body id="table1">
	<div id="mask" class="mask" style="display: none;background-color: rgb(40, 95, 108);"></div>
	<input type="text" id="checkRadio" value="${state}"
		style='display: none' />
	<div class="mask" style="display: none"></div>
	<div class="widget-box">
		<div class="widget-title">
			<h5>评论管理(根据用户评论管理文献)</h5>
			<div class="widget-radio">
				<input type="radio" name="state" id="listByhaveHandled0"
					onClick="listByhaveHandled0();" />待审核 
				<input type="radio" name="state" id="listByhaveHandled1"
					onClick="listByhaveHandled1();" />已同意 
				<input type="radio" name="state" id="listByhaveHandled2"
					onClick="listByhaveHandled2();" />已拒绝
			</div>
		</div>
		<div id="comment_check" style="display: none;" align="center">
		<div id="commentcheck_form_content" class="comment_form_content" style="display:none;">
			<form>
				<fieldset>
					<legend>查看  评论</legend>
					<div class="form-row">
						<div class="field-label_comment">
							<label for="field1">文章标题</label>:
						</div>
						<div class="field-widget">
							<input id="docTitle" class="required" type="text"/>
						</div>
					</div>
					<div class="form-row_comment">
						<div class="field-label_comment">
							<label for="field1">评论内容</label>:
						</div>
						<div class="controls">
						<textarea id="comment_textarea" cols="20" rows="2"></textarea>
					</div>
					</div>
					<div class="form-row">
						<div class="field-widget-confirm_comment" style="margin-left: 167px;">
							<input id="cancle" type="button" class="reset" value="关闭" />
						</div>
					</div>
				</fieldset>
			</form>
		</div>
		</div>
		<div class="widget-content nopadding">
			<s:form name="form2" id="form2" method="post">
				<table class="table table-bordered table-striped with-check">
					<thead>
						<tr>
							<th style="width: 30px;">编号</th>
							<th style="width: 130px;">评论的文章</th>
							<th style="width: 300px;">评论内容</th>
							<th style="width: 80px;">发表评论的用户</th>
							<th style="width: 80px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="#request.page.pageList">
							<tr id='<s:property value="id" />'>
								<td><s:property value="id" /></td>
								<td><a href='Doc/reading?id=<s:property value="doc.id" />'>
										<s:property value="doc.title" /></a></td>
								<td style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
									<a style="cursor:hand;text-decoration:none;" onclick="commentCheck(<s:property value="id"/>)">
									<s:property value="content" /></a></td>
								<td><s:property value="user.name" /></td>
								<td><s:if test="%{haveHandled != 1 && haveHandled != 3}">
										<a class="btn btn-mini green" onclick="process(<s:property value="id"/>,1)">同意</a>
									</s:if>
									<s:if test="%{haveHandled == 0 || haveHandled == 1}">
										<a class="btn btn-mini gray" onclick="process(<s:property value="id"/>,2)">拒绝</a>
									</s:if></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:form>
			<div id="upPageBar">
				<div class="pagination alternate"
					style="float: left; margin-top: 20px;">
					<ul>
						<s:if test="#request.page.showPrv != 0">
							<li id="firstPage" data-id="PAGE"><a
								href="Comment/listByhaveHandled?pageNo=1&haveHandled=${state}">首页</a></li>
							<li id="lastPage" data-id="PAGE"><a
								href="Comment/listByhaveHandled?pageNo=<s:property value="#request.page.pageNo -1"/>&haveHandled=${state}">上一页</a></li>
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
									href="Comment/listByhaveHandled?pageNo=<s:property value="key"/>&haveHandled=${state}"><s:property
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
								href="Comment/listByhaveHandled?pageNo=<s:property value="#request.page.pageNo +1"/>&haveHandled=${state}">下一页</a></li>
							<li id="endPage" data-id="PAGE"><a
								href="Comment/listByhaveHandled?pageNo=<s:property value="#request.page.totalPage"/>&haveHandled=${state}">尾页</a></li>
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
	<script src="js/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function() {
			var state = $('#checkRadio').val();
			if (state == 0) {
				$('#listByhaveHandled0').attr("checked", "checked");
			} else if (state == 1) {
				$('#listByhaveHandled1').attr("checked", "checked");
			} else if (state == 2) {
				$('#listByhaveHandled2').attr("checked", "checked");
			}
		});
		function commentCheck(id){
			$.ajax({
				type:'GET',
				url:"Comment/checkComment?id="+id,
				success:function(jsonData){
					var data = eval(jsonData);
	      			$("#docTitle")[0].value=data[0].doc.title;
	      			$("#comment_textarea")[0].value=data[0].content;
	      			
	      			$("#mask").slideDown("fast");
	    			$("#comment_check").fadeIn("slow");
	    			$("#commentcheck_form_content").fadeIn("slow");
				},
				error:function(){
					alert("查询失败！");
				}
			});
			
		}
		$("#cancle").click(function(){
			$("#comment_check").fadeOut("slow");
			$("#commentcheck_form_content").fadeOut("slow");
			$("#mask").slideUp("fast");
		});
		function listByhaveHandled0() {
			location.href = "Comment/listByhaveHandled?haveHandled=0";
		}
		function listByhaveHandled1() {
			location.href = "Comment/listByhaveHandled?haveHandled=1";
		}
		function listByhaveHandled2() {
			location.href = "Comment/listByhaveHandled?haveHandled=2";
		}
		
		//同意或拒绝处理
		function process(commentId,haveHandled){
			$.get("Comment/alterHaveHandled?haveHandled=" + haveHandled +"&commentId="+commentId, function(data){
				if(data=="success"){
					$("tr").remove("#" + commentId);
				}else{
					alert("失败");
				}
			});
		}
	</script>

</body>
</html>