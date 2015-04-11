<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%@page
	import="com.zhuozhengsoft.pageoffice.*,java.net.URLEncoder.*,lab.dmis.model.Doc"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	/*pageoffice doc的路径和类型  */

	String docPath = ((Doc) request.getAttribute("doc")).getDocPath();

	String type = ((Doc) request.getAttribute("doc")).getFormat();
%>
<!DOCTYPE html>
<html lang="en">
<base href="<%=basePath%>">
<head>
<title>Matrix Admin</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href=" css/bootstrap.min.css" />
<link rel="stylesheet" href=" css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href=" css/matrix-style.css" />
<link rel="stylesheet" href=" css/matrix-media.css" />
<link rel="stylesheet" href=" css/knowledge.css" />
<link href=" font-awesome/css/font-awesome.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript">
	
	
	function showVersion(){
	
		$("#version").fadeToggle();
	}
</script>
<!-- <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'> -->
</head>
<body>
	<!-- header -->
	<jsp:include page="top.jsp" />

	<div id="content"
		style="margin-top: 47px; margin-left: 7%; margin-right: 7%;">
		<div id="content-header" style="height: 36px;"></div>

		<div class="row-fluid">
			<div class="span3"
				style="float: right; position: relative; margin-right: 20px; width: 20%;">

				<!--keyword  -->
				<div class="widget-box">
					<div class="widget-title">
						<h5>相关词条</h5>
					</div>
					<div class="widget-content" style="clear: both; overflow: hidden;">
						<div class="todo" style="clear: both; overflow: hidden;">


							<ul id="keywords">
								<s:if test="#request.keywordList.size()==0">
						暂无相关词条！
						</s:if>
								<s:if test="#request.keywordList.size()>0">
									<s:iterator value="#request.keywordList" id="keyword"
										status="status">
										<li id="<s:property value='#status.index' />"
											style="display: block;"><image src="img/pdf.jpg"
												width="20px" height="20px" /><a
											href="Keyword/hrefsearch?keywordId=<s:property value="id"/>"><s:property
													value="keyword" /></a></li>

									</s:iterator>
							</ul>
							<a id="keywordmore" href="javascript:void"
								onClick="keywordmore()">更多</a>
							</s:if>
						</div>
					</div>
				</div>
				<!-- doc -->
				<div class="widget-box">
					<div class="widget-title">
						<h5>相关文献</h5>
					</div>
					<div class="widget-content" style="clear: both; overflow: hidden;">
						<div class="todo" style="clear: both; overflow: hidden;">


							<ul id="docs">
								<s:if test="#request.keyword.keyworddocs.isEmpty()">
						暂无相关文献！
						</s:if>

								<s:iterator value="#request.keyword.keyworddocs" status="status">

									<li><image src="img/pdf.jpg" width="20px" height="20px" /><a
										href="Doc/hrefsearch?docId=<s:property value='doc.id'/>"><s:property
												value="doc.title" /></a></li>

								</s:iterator>
							</ul>
							<s:if test="#request.keyword.keyworddocs.size()>0">
								<a id="docmore" href="javascript:void" onClick="docmore()">更多</a>
							</s:if>
						</div>
					</div>
				</div>
			</div>
			<div class="widget-box span9" style="width: 75%;">
				<div class="widget-title"
					style="font-size: 20px; font-weight: bold; text-align: center; line-height: 36px;">
					<s:property value="#request.doc.getTitle()" />
				</div>
				<div class="widget-content" style="height: auto;">
					<input type="hidden" id="getDocId"
						value="<s:property value="#request.doc.id"/>" />
					<div class="row" style="margin-left: 20px;">
						<div class="span2">
							<span class="h5">作 者: </span>
						</div>
						<div class="span10">
							<small><s:property value="#request.doc.getAuthor()" /></small>
						</div>
					</div>
					<div class="row" style="margin-left: 20px;">
						<div class="span2">
							<span class="h5">摘 要:</span>
						</div>
						<div class="span10">
							<small><s:if test="#request.doc.getBrief()==null"> 暂无摘要！ </s:if>
								<s:else>
									<s:property value="#request.doc.getBrief()" escape="false" />
								</s:else></small>
						</div>
					</div>
					<div class="row" style="margin-left: 20px;">
						<div class="span2">
							<span class="h5">Journal:</span>
						</div>
						<div class="span9">
							<small><s:property value="#request.doc.getJournal()" /></small>
						</div>
					</div>
					<div class="row" style="margin-left: 20px;">
						<div class="span2">
							<span class="h5">刊名:</span>
						</div>
						<div class="span9">
							<small><s:property value="#request.doc.getCategory()" /></small>
						</div>
					</div>
					<div class="row" style="margin-left: 20px;">
						<div class="span2">
							<span class="h5">年，卷（期）: </span>
						</div>
						<div class="span9">
							<small><s:property
									value="#request.doc.getPublishedTime()" /></small>
						</div>
					</div>
					<div class="row" style="margin-left: 20px;">
						<div class="span2">
							<span class="h5">关键词: </span>
						</div>
						<div class="span9">
							<small><s:property value="" /></small>
						</div>
					</div>
					<div class="row" style="margin-left: 24px;">
						<div class="span12">
							<a href="javascript:void(0)"
								onclick="javascript:history.back(-1);" style="color: gray"
								onmouseover="this.style.cssText='color:#FFA011;'"
								onmouseout="this.style.cssText='color:gray;'">返回上一页</a> - <a
								href="/knowledge/Download/downloadDoc?downPath=doc/<s:property value="#request.doc.getFilename()"/>"
								style="color: gray"
								onmouseover="this.style.cssText='color:#FFA011;'"
								onmouseout="this.style.cssText='color:gray;'"> 下载全文 </a> - <a
								style="color: gray"
								onmouseover="this.style.cssText='color:#FFA011;'"
								onmouseout="this.style.cssText='color:gray;'" target="_blank"
								href='/knowledge/Doc/reading?id=<s:property value="#request.doc.getId()" />&type=<s:property value="#request.doc.format"/>'">
								查看全文 </a> - <a href="javascript:void(0)" onclick="showVersion()"
								id="displayversionHistory" style="color: gray"
								onmouseover="this.style.cssText='color:#FFA011;'"
								onmouseout="this.style.cssText='color:gray;'">查看历史版本(<s:property
									value="#request.docByVersionList.size()-1" />)
							</a> - <a href="javascript:void(0)" id="addFavo" style="color: gray"
								onclick="addFavo();"
								onmouseover="this.style.cssText='color:#FFA011;'"
								onmouseout="this.style.cssText='color:gray;'">收藏</a> - <a
								href="javascript:void(0)"
								id="addCommont" style="color: gray"
								onmouseover="this.style.cssText='color:#FFA011;'"
								onmouseout="this.style.cssText='color:gray;'">评论(<s:property
									value="#request.doc.comments.size()" />)>>
							</a>
						</div>
					</div>

				</div>

			</div>
			
			<!-- comment -->

			<div id="commentList" class="widget-box span9"
				style="width: 75%;">
				<s:form action="/Comment/add" style="margin-top:10px;">
					<textarea
						style="width: 92%; height: 20px; margin-left: 3%; resize: none"
						placeholder="说点什么" name="content" id="commont"></textarea>

					<input type="submit" style="margin-left: 90%;" value="发表"
						class="btn btn-success" />
				</s:form>
				<div class="widget-content" style="height: auto;">
					<div style="margin-top: 10px;">
						<ul style="list-style-type: none; margin-bottom: 10px">
							<s:if test="#request.doc.comments.isEmpty()">
								<font style="text-align: center;">暂无评论！</font>
							</s:if>

							<s:iterator status="doc" value="#request.doc.comments">

								<li style="margin-top: 5px"><font
									style="font-weight: bold; font-size: 16px;"><s:property
											value="user.name" />：</font> <s:date name="time"
										format="yyyy-MM-dd HH:mm" />
									<button
										onclick='application(<s:property value="id" />, <s:property value="haveHandled" />)'
										class="btn btn-mini" type="button" style="float: right;">
										建议修改(<span id='<s:property value="id" />'><s:property
												value="numOfApplications" /></span>)
									</button> <span id="processStatus" style="float: right; margin-right: 50px;"> <s:if
											test="numOfApplications > 0">处理状态:
											<s:if test="%{haveHandled == 0}">等待处理中</s:if>
											<s:elseif test="%{haveHandled == 1}">已经修改</s:elseif>
											<s:else>拒绝修改</s:else>
										</s:if>
								</span></li>
								<span style="margin-left: 6%"><s:property value="content" /></span>
								<br />

							</s:iterator>

						</ul>
					</div>

				</div>
			</div>
			<!-- 历史版本 -->

			<div id="version" class="widget-box span9" style="display:none">
				<div class="widget-title">
					<h5>历史版本</h5>
				</div>
				<div class="widget-content">
					<div class="todo">
						<ul>
							<s:iterator value="#request.docByVersionList">
								<li class='clearfix <s:if test="%{id == #request.doc.id}">hidden</s:if>'>
									<div class="txt">
										<s:if test="%{language == 0}">
											<p style="font-color:red">英文原件</p>
										</s:if>
										<img width="30" height="30"
											title="<s:property value="format"/>"
											src="<%=basePath%>img/demo/<s:property value="format"/>.png">
										<a
											href="/knowledge/Doc/hrefsearch?docId=<s:property value='id' />"
											target="_blank"><s:property value="title" /></a>
									</div>

									<div class="pull-right">
										<div>版本：<s:property value="version"/></div>
										<div>上传时间：<s:date name="uploadTime" format="yyyy-MM-dd HH:mm:ss"/></div>
										<a
											href="/knowledge/Download/downloadDoc?downPath=doc/<s:property value="getFilename()"/>"
											style="color: gray"
											onmouseover="this.style.cssText='color:#FFA011;'"
											onmouseout="this.style.cssText='color:gray;'"> 下载 </a> <a
											href="/knowledge/Doc/hrefsearch?docId=<s:property value='id' />"
											style="color: gray"
											onmouseover="this.style.cssText='color:#FFA011;'"
											onmouseout="this.style.cssText='color:gray;'"> 查看 </a>
									</div>
								</li>
							</s:iterator>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--Footer-part-->
	<div class="row-fluid">
		<div id="footer" class="span12">
			2014 &copy; 欢迎来到知识的海洋<a href="http://themedesigner.in/">Themedesigner.in</a>
		</div>
	</div>
	<!--end-Footer-part-->
	<script src=" js/jquery.min.js"></script>
	<script src=" js/contact.js"></script>

	<script src=" js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/pdfobject.js"></script>
	<script src="<%=basePath%>js/pagescript/search.js"></script>
	<script src="<%=basePath%>js/pagescript/knowledge.alert.js"></script>
	<script type="text/javascript" charset="utf-8">
	function application(id, haveHandled){
		if(haveHandled == 1){
			alert("管理员已经修改,不能再申请！")
		}else{
			$.get("/knowledge/Comment/application?commentId="+ id, function(data){
				if(data.tip=="success"){
					$("#processStatus").html("处理状态:等待处理中");
					var num= parseInt($("#" + id).html());
					$("#" + id).html(num + 1);
					alert("申请成功!");
				}else if(data.tip=="haveApplied"){
					alert("你已经申请过了！");
				}else{
					alert("申请失败！");
				}
			});
		}
		
	}

	function addFavo(){
		var FavoURL = "";
		if($('#addFavo').text().trim() == "收藏")
			FavoURL = "/knowledge/Favorites/addFavorites?id="+$('#getDocId').val()+"";
				//$('#addFavo').text("取消收藏");
		else
			FavoURL = "/knowledge/Favorites/removeFavorites?id="+$('#getDocId').val()+"";
				//$('#addFavo').text("收藏");
		$.post(FavoURL,function(result){
				if(result == 1)
					$('#addFavo').text("取消收藏");
				else if(result == 0)
					$('#addFavo').text("收藏");
				else alert("服务器异常");
			});
		}
	//判断文章是否被收藏
	$.post("/knowledge/Favorites/docIsAdd?id="+$('#getDocId').val()+"",function(result){
				if(result == 1)
					$('#addFavo').text("取消收藏");
				else 
					$('#addFavo').text("收藏");
			
			});
	$("#addCommont").click(function(){
			$("#commont").focus();
		});

	</script>

</body>
</html>
