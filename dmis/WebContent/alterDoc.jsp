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
<link href="css/bg/yetou.css" rel="stylesheet" type="text/css" />
<link href="css/dmis.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/matrix-style.css" />
<link rel="stylesheet" href="css/matrix-media.css" />
<link rel="stylesheet" href="css/uniform.css" />
<link rel="stylesheet" href="css/select2.css" />
<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href="css/matrix-style.css" rel="stylesheet" type="text/css" />

</head>
<body id="table1">
	<input type="text" id="checkRadio" value="${state}"
		style='display: none' />
	<div class="mask" style="display: none"></div>
	<div class="widget-box">
		<div class="widget-title">
			<h5>评论管理(根据用户评论管理文献)</h5>
			<div class="widget-radio">

				<input type="radio" name="state" id="listByhaveHandled3"
					onClick="listByhaveHandled3();" />已重传 <input type="radio"
					name="state" id="listByhaveHandled0"
					onClick="listByhaveHandled0();" />待审核 <input type="radio"
					name="state" id="listByhaveHandled1"
					onClick="listByhaveHandled1();" />已同意 <input type="radio"
					name="state" id="listByhaveHandled2"
					onClick="listByhaveHandled2();" />已拒绝
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
							<th style="width: 50px;">申请修改次数</th>
							<th style="width: 80px;">操作</th>

						</tr>
					</thead>
					<tbody>

						<s:iterator value="#request.page.pageList">
							<tr id='<s:property value="id" />'>
								<td><s:property value="id" /></td>
								<td><a
									href='Doc/hrefsearch?docId=<s:property value="doc.id" />'><s:property
											value="doc.title" /></a></td>
								<td><s:property value="content" /></td>
								<td><s:property value="numOfApplications" /></td>
								<td><s:if test="%{haveHandled != 1 && haveHandled != 3}">
										<button type="button" class="btn btn-mini"
											onclick="process(<s:property value="id"/>,1)">同意</button>
									</s:if> <s:if test="%{haveHandled == 1}">
										<a href="#myModal" role="button" class="btn btn-mini"
											data-toggle="modal" onclick='javascript:$("#curVersion").html(<s:property value="doc.version" />);$("#docId").val(<s:property value="doc.id" />);$("#commentId").val(<s:property value="id" />)'>重传</a>
									</s:if> <s:if test="%{haveHandled == 0 || haveHandled == 1}">
										<button type="button" class="btn btn-mini"
											onclick="process(<s:property value="id"/>,2)">拒绝</button>
									</s:if></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:form>


			<!-- Modal -->
			<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h3 id="myModalLabel">文件重传</h3>
				</div>
				<div class="modal-body">
					<form id="uploadDocDocupload" action="Doc/reUploadDoc" method="post"
						enctype="multipart/form-data">
						<input id="docId" name="doc.id" class="hidden"/>
						<input id="commentId" name="commentId" class="hidden"/>
						<div class="row">
							<div class="span2">当前版本：</div>
							<div id="curVersion" class="span2"></div>
						</div><br />
						<div class="row">
							<div class="span2">更新后版本：</div>
							<div class="span2">
								<input type="text" name="doc.version">
							</div>
						</div><br />
						<div class="row">
							<div class="span2">语言：</div>
							<div class="span2">
								<select name="doc.language">
									<option value="1">中文</option>
									<option value="0">英文</option>
								</select>
							</div>
						</div><br/>
						<div class="row">
							<div class="span2">文件：</div>
							<div class="span4">
								<input name="uploadFile" type="file" />
							</div>
						</div><br/>
						<div class="row">
							<div class="span4"></div>
							<div class="btn-group span1">
								<input type="reset" class="btn btn-primary" value="重置" />
								<input type="submit" class="btn btn-success" value="上传" />
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
				</div>
			</div>
			<!--/ Modal -->

			<div id="upPageBar">
				<div class="pagination alternate"
					style="float: left; margin-top: 30px; margin-left: -15px">
					<ul>
						<s:if test="#request.page.showPrv != 0">
							<li class id="firstPage" data-id="PAGE"><a
								href="Comment/listByhaveHandled?pageNo=1&haveHandled=${state}">首页</a></li>
							<li class id="lastPage" data-id="PAGE"><a
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
							<li class id="nextPage" data-id="PAGE"><a
								href="Comment/listByhaveHandled?pageNo=<s:property value="#request.page.pageNo +1"/>&haveHandled=${state}">下一页</a></li>
							<li class id="endPage" data-id="PAGE"><a
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
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function() {
			var state = $('#checkRadio').val();
			if (state == 0) {
				$('#listByhaveHandled0').attr("checked", "checked");
			} else if (state == 1) {
				$('#listByhaveHandled1').attr("checked", "checked");
			} else if (state == 2) {
				$('#listByhaveHandled2').attr("checked", "checked");
			} else {
				$('#listByhaveHandled3').attr("checked", "checked");
			}
		});

		function listByhaveHandled3() {
			location.href = "Comment/listByhaveHandled?haveHandled=3";
		}
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
				if(data.tip=="success"){
					$("tr").remove("#" + commentId);
				}else{
					alert("失败");
				}
			});
		}
	</script>

</body>
</html>