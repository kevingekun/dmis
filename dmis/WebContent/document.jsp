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
<link rel="stylesheet" type="text/css" href="css/bg/yetou.css" />
<link rel="stylesheet" type="text/css" href="css/dmis.css" />
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
</head>
<body id="table1">
	<input type="text" id="checkRadio" value="${state}"
		style='display: none' />
	<div class="mask" id="mask" style="display: none"></div>
	<div class="widget-box">
		<div class="widget-title">
			<h5>文档管理</h5>
			<a class="btn btn-small gray" style="margin: 5px 0 0 3px;"onClick="dele();">删除选中</a> 
			<a class="btn btn-small green" style="margin: 5px 0 0 3px;" onClick="pass();">通过选中</a>
			<div class="widget-radio">
			
				<input id="fileEdit1" class="btn btn-small blue" type="button" value="新增文档" style="margin-bottom: 5px"> 
				<input id="fileEdit11" class="btn btn-small orange" type="button" value="新增文献" style="margin-bottom: 5px">
				<input id="fileEdit2" class="btn btn-small orange" type="button" value="弹框文献" style="margin-bottom: 5px">
				<!-- <input id="fileEdit3" class="btn btn-small blue" type="button" value="弹框文档" style="margin-bottom: 5px"> --> 
				<input type="radio" name="state" id="all" onClick="allPass();" />全部 
				<input type="radio" name="state" id="isPass" onClick="isPass();" />已录入 
				<input type="radio" name="state" id="noPass" onClick="noPass();" />待审核
			</div>
		</div>
		<!-- 文件上传表单开始 -->
		<div id="infoEdit" style="display: none;" align="center">
			<div id="fileEditContent1" style="display: none;">
				<div class="infoHeader bg_lg">上传文档</div>
				<br>
				<form id="uploadDocDocupload" action="Doc/uploadDocDoc"
					method="post" enctype="multipart/form-data">
					<div class="row" id="filePageDoc"
						style="color: #FFF; font-size: 14px; margin: 0 0 0 15px">
						<div class="control-group">
							<div class="controls">
								<div class="main_input_box">
									<span class="add-on bg_lg"><li class="icon-edit"></li></span>
									<input type="text" placeholder="请输入文档标题" name="doc.title" />
								</div>
								<br />
								<div class="main_input_box">
									<select name="category" style="width: 100px;" id="Category">
										<option>其他</option>
										<option>分类文档</option>
									</select> <select name="doc.language" style="width: 100px;">
										<option>选择语言</option>
										<option value="1">中文</option>
										<option value="0">英文</option>
									</select> <select name="doc.level" style="width: 100px;">
										<option>选择级别</option>
										<option value="1">一类文档</option>
										<option value="2">二类文档</option>
										<option value="3">三类文档</option>
									</select>
								</div>
								<br>
								<div class="main_input_box" id="docType" style="display: none">
									<input type="hidden" id="fIdDoc" value="-1" /> 
									<select id="typeOneDoc" name="doc.typeOne"
										onchange="t1(this,'typeTwoDoc')" style="width: 100px;">
										<option value="-1">一级分类</option>
									</select> 
									<input type="hidden" id="sIdDoc" value="-1" /> 
									<select id="typeTwoDoc" name="doc.typeTwo"
										onchange="t2(this,'typeThreeDoc')" style="width: 100px;">
										<option value="-1">二级分类</option>
									</select> 
									<input type="hidden" id="tIdDoc" value="-1" />
									<!--设置一个隐藏的input,用于存中间值-->
									<select id="typeThreeDoc" name="typeThree"
										style="width: 100px;">
										<option value="-1">三级分类</option>
									</select>


								</div>
								<br />
								<div class="main_input_box">
									<span class="add-on bg_lg"><li class="icon-file"></li></span>
									<input type="text" id="txt" style="width: 203px;"> 
									<span class="add-on bg_ic" onclick="$('#f').click()">
										<a style="color: #2E363F;" href="javascript:void(0);">浏览</a></span> <br>
									<input type="file" id="f" onchange="txt.value=this.value"
										name="uploadFile" class="files" onblur="checkType('file')" />
									<input type="button" class="btn btn-success"
										style="width: 314px; margin:;" id="testbutton" value="检测文件类型"
										onclick="isvalidatefile('file','f')" />
									<!--     <font color="red" id="kw"></font><input type="hidden" id="kt" value="false"> -->
								</div>
								<br /> <input type="submit" class="btn btn-success" value="确定">
								<input type="reset" class="btn" id="cancleFile1"
									style="margin: 0 0 0 80px;" value="取消" />
							</div>
							<center>
								<span style="color: #FFF" id="passTips"></span>
							</center>
						</div>
					</div>
				</form>

			</div>
			<div id="fileEditContent2" style="display: none;">
				<div class="infoHeader bg_bg" style="background: #28b779;">上传文献</div>
				<form id="uploadDocform" action="Doc/uploadDoc" method="post"
					enctype="multipart/form-data">

					<div class="row" id="filePageOne"
						style="color: #FFF; font-size: 14px; margin: 0 0 0 15px;">
						<div class="control-group">
							<div class="controls">
								<div class="main_input_box">
									<span class="add-on bg_lg"><li class="icon-edit"></li></span><input
										type="text" placeholder="请输入文章标题" name="doc.title" />
								</div>
								<br />
								<div class="main_input_box">
									<span class="add-on bg_lg"><li class="icon-user"></li></span><input
										type="text" placeholder="请输入文章作者" name="doc.author" />
								</div>
								<br />
								<div class="main_input_box">
									<input type="hidden" id="fId" value="-1" /> <select
										id="typeOne" name="doc.typeOne" onchange="t1(this,'typeTwo')"
										style="width: 100px;">
										<option value="-1">一级分类</option>
									</select> <input type="hidden" id="sId" value="-1" /> <select
										id="typeTwo" name="doc.typeTwo"
										onchange="t2(this,'typeThree')" style="width: 100px;">
										<option value="-1">二级分类</option>
									</select> <input type="hidden" id="tId" value="-1" />
									<!--设置一个隐藏的input,用于存中间值-->
									<select id="typeThree" name="typeThree" style="width: 100px;">
										<option value="-1">三级分类</option>
									</select>


								</div>
								<br />
								<div class="main_input_box">
									<select name="doc.category" style="width: 100px;">
										<option>选择类别</option>
										<option>外文期刊</option>
										<option>OA论文</option>
										<option>期刊论文</option>
										<option>学位论文</option>
										<option>会议论文</option>
									</select> <select name="doc.language" style="width: 100px;">
										<option>选择语言</option>
										<option value="1">中文</option>
										<option value="0">英文</option>
									</select> <select name="doc.level" style="width: 100px;">
										<option>选择级别</option>
										<option value="1">一类文献</option>
										<option value="2">二类文献</option>
										<option value="3">三类文献</option>
									</select>
								</div>
								<br>

								<div class="main_input_box">
									<span class="add-on bg_lg"><li class="icon-book"></li></span><input
										type="text" placeholder="请输入期刊（可选）" name="doc.journal" />
								</div>

							</div>

						</div>
						<br /> <input type="button" name="nextFilePage" id="nextFilePage"
							class="btn btn-success" value="下一页" /> <input type="reset"
							class="btn" id="cancleFile" style="margin: 0 0 0 40px;"
							value="取消" />
					</div>
					<div class="row" id="filePageTwo"
						style="color: #FFF; font-size: 14px; margin: 0 0 0 15px; display: none">
						<div class="control-group">
							<div class="controls">
								<div class="main_input_box">
									<textarea placeholder="请输入文章摘要 "
										style="width: 300px; height: 100px; resize: none;"
										name="doc.brief"></textarea>
								</div>
								<br />
								<div class="main_input_box">
									<span class="add-on bg_lg"><li class="icon-time"></li></span><input
										style="width: 46.3%" type="date" placeholder="请输入出版（发表）时间"
										name="publishedTime" />
								</div>
								<br />
								<div class="main_input_box">
									<span class="add-on bg_lg"><li class="icon-file"></li></span>
									<input type="text" id="txt" style="width: 190px;"> 
									<span class="add-on bg_ic" onclick="$('#f').click()">
									  <a style="color: #2E363F;" href="javascript:void(0);">浏览</a></span> <br>
									<input type="file" id="f" onchange="txt.value=this.value"
										name="uploadFile" class="files" onblur="checkType('file')" />
									<input type="button" class="btn btn-success"
										style="width: 300px; margin:;" id="testbutton" value="检测文件类型"
										onclick="isvalidatefile('file','f')" />
									<!--     <font color="red" id="kw"></font><input type="hidden" id="kt" value="false"> -->
								</div>
								<br /> <input type="submit" class="btn btn-success" value="确定">
								<input type="button" class="btn" style="margin: 0 0 0 40px;"
									id="lastFilePage" value="上一页" /> <input type="reset"
									class="btn" id="cancleFile" style="margin: 0 0 0 80px;"
									value="取消" />
							</div>
						</div>
						<center>
							<span style="color: #FFF" id="passTips">提示信息</span>
						</center>
					</div>
				</form>
			</div>
		</div>
		<!-- 文件上传表单结束 -->
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
							<th style="width: 100px;">是否通过</th>
							<th style="width: 100px;">操作</th>
						</tr>
					</thead>
					<tbody>

						<s:iterator value="#request.page.pageList">
							<tr>
								<td><input type="checkbox" style="margin-left: 12px"
									name="checkAll" id="checkAll" value="<s:property value="id"/>"
									onClick="setSelectAll();" /></td>
								<td><s:property value="id" /></td>
								<%--  <td class="link_href"><a href="Doc/hrefsearch?docId=<s:property value="id"/>" target="_blank"><s:property value="title" /></a></td> --%>
								<td class="link_href"><a
									href="Doc/reading?id=<s:property value="id"/>" 
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
							<li class id="firstPage" data-id="PAGE"><a
								href="Doc/list?pageNo=1&state=${state}">首页</a></li>
							<li class id="lastPage" data-id="PAGE"><a
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
							<li class id="nextPage" data-id="PAGE"><a
								href="Doc/list?pageNo=<s:property value="#request.page.pageNo +1"/>&state=${state}">下一页</a></li>
							<li class id="endPage" data-id="PAGE"><a
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
			var checkselect = $("#checkselect").val();
			if (checkselect == "true") {
				var pageNo = $("#dqPageNo").val();
				form2.action = "Doc/deleteCheck?pageNo=" + pageNo;
				document.getElementById("form2").submit();
			} else {
				alert("请选中所需删除数据！");
			}

		}
		function pass() {
			var checkselect = $("#checkselect").val();
			if (checkselect == "true") {
				var pageNo = $("#dqPageNo").val();
				form2.action = "Doc/passCheck?pageNo=" + pageNo;
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
		//加载文档类型
		$("#fileEdit1").click(
			function(){
				location.href="addDoc.jsp";
			}		
		);
		$("#fileEdit11").click(
			function(){
				location.href="addLiteratrue.jsp";
			}		
		);
		 $("#fileEdit3").click(
				function() {
					$("#infoEdit").removeAttr("style");
					/* $("#mask").slideDown("fast"); */
					$("#fileEditContent1").removeAttr('style');
					$.ajax({
						type : 'GET',
						dataType : 'json',
						url : '/dmis/Type/TypeAction/lista',
						success : function(jsonData) {
							//document.getElementById("typeOne").options.add(new Option("asd",11));
							var data = eval(jsonData);
							$.each(data, function(i, n) {
								document.getElementById("typeOne").options
										.add(new Option(data[i].name,
												data[i].id));
								document.getElementById("typeOneDoc").options
										.add(new Option(data[i].name,
												data[i].id));
							});
						},
						error : function() {
							alert("err");
						}
					});
				});
		$("#fileEdit2").click(
				function() {
					$("#infoEdit").removeAttr("style");
					$("#filePageOne").removeAttr('style');
					/* $("#mask").slideDown("fast"); */
					$("#fileEditContent2").removeAttr('style');
					$.ajax({
						type : 'GET',
						dataType : 'json',
						url : '/dmis/Type/TypeAction/lista',
						success : function(jsonData) {
							//document.getElementById("typeOne").options.add(new Option("asd",11));
							var data = eval(jsonData);
							$.each(data, function(i, n) {
								document.getElementById("typeOne").options
										.add(new Option(data[i].name,
												data[i].id));
								document.getElementById("typeOneDoc").options
										.add(new Option(data[i].name,
												data[i].id));
							});
						},
						error : function() {
							alert("err");
						}
					});
				});

		$("#nextFilePage").click(function() {
			$("#filePageOne").slideUp('slow', function() {
				$("#filePageTwo").slideDown('slow');
			});
		});
		function isvalidatefile(obj, fileId) {

			var fileType = $("#" + fileId).val();
			var pos = fileType.lastIndexOf(".");
			var lastname = fileType.substring(pos, fileType.length);
			if (!(lastname.toLowerCase() == ".doc"
					|| lastname.toLowerCase() == ".pdf"
					|| lastname.toLowerCase() == ".docx"
					|| lastname.toLowerCase() == ".ppt" || lastname
					.toLowerCase() == ".xls")
					|| lastname.toLowerCase() == ".pptx"
					|| lastname.toLowerCase() == ".xlsx"
					|| lastname.toLowerCase() == ".zip") {
				alert("您上传的文件类型为" + lastname + "文件类型不符");
				return false;
			} else {
				alert("文件类型符合，可以上传");
			}
			return true;
		}

		function t1(obj, TypeTw) {
			var parentid = obj.value;//获取所选的一级类别的id
			if (parentid != -1) {//如果id==-1，说明没选任何类别
				document.getElementById("fId").value = parentid;//在隐藏的input中存id
				document.getElementById("fIdDoc").value = parentid;
				var typeTwo = document.getElementById(TypeTw);
				typeTwo.length = 1;//分类二下拉菜单置一
				$.ajax({
					type : 'GET',
					dataType : 'json',
					url : '/dmis/Type/TypeAction/listaByParentId?parentid='
							+ parentid,//parentid=父类的id
					success : function(jsonData) {
						var data = eval(jsonData);
						/* if(data == ""){
						 $('#'+TypeTw).empty();
						 typeTwo.options.add(new Option("没有分类","1"));
						 $('option').click();
						}
						else */
						$.each(data, function(i, n) {
							typeTwo.options.add(new Option(data[i].name,
									data[i].id));
							//document.getElementById("typeTwoDoc").options.add(new Option(data[i].name,data[i].id));
						});
					},
					error : function() {
						alert("error");
					}
				});
			} else {
				var typeTwo = document.getElementById(TypeTw);
				typeTwo.length = 1;
			}
		}
		function t2(obj, TypeTh) {
			var parentwoid = obj.value;
			if (parentwoid != -1) {
				document.getElementById("sId").value = parentwoid;//在隐藏的input中存id
				document.getElementById("sIdDoc").value = parentwoid;
				var typeThree = document.getElementById(TypeTh);
				typeThree.length = 1;
				$.ajax({
					type : 'GET',
					dataType : 'json',
					url : '/dmis/Type/TypeAction/listaaByParentId?parentid='
							+ parentwoid,
					success : function(jsonData) {
						var data = eval(jsonData);
						$.each(data, function(i, n) {
							typeThree.options.add(new Option(data[i].name));
						});
					},
					error : function() {
						alert("error");
					}

				});
			} else {
				var typeTwo = document.getElementById(TypeTw);
				typeTwo.length = 1;
			}
		}
		$("#nextFilePage").click(function() {
			$("#filePageOne").slideUp('slow', function() {
				$("#filePageTwo").slideDown('slow');
			});
		});
		$("#lastFilePage").click(function() {
			$("#filePageTwo").slideUp('slow', function() {
				$("#filePageOne").slideDown('slow');
			});
		});
		//上传文档是否分类
		$('#Category').change(function() {
			var category = $("#Category option:selected").text().trim();
			if (category == "分类文档")
				$('#docType').removeAttr('style');
			else
				$('#docType').attr('style', 'display:none');
		});

		$("#cancleInfo,#canclePass,#cancleFile").click(function() {
			$("#mask").slideUp("slow");
			$("#infoEdit").attr('style', 'display:none');
			$(this).parent().parent().parent().attr('style', 'display:none');
			$("#fileEditContent2").attr('style', 'display:none');
		});
		$("#cancleFile1").click(function() {
			$("#mask").slideUp("slow");
			$("#infoEdit").attr('style', 'display:none');
			$("#fileEditContent1").attr('style', 'display:none');
		});
	</script>

</body>
</html>