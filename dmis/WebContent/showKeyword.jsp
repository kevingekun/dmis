<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page
	import="com.zhuozhengsoft.pageoffice.*,java.net.URLEncoder.*,lab.dmis.model.Doc"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	
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
<!-- <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'> -->
</head>
<body>
	
	<!-- header -->
	<div id="header">
		<h1>
			<a href="dashboard.html" style="height: 50px;">Matrix Admin</a>
		</h1>
	</div>
	<!--close-Header-part-->

	<!--header-->
	<div id="user-nav" class="navbar navbar-inverse">
		<ul class="nav">
		<li class=""><a title="首页" href="/dmis/Doc/getRecentDoc"><i
					class="icon icon-home"></i> <span class="text"> 首页 </span></a></li>
			<li><a title="" href="/dmis/Page/getPagepersonalCenter"><i
					class="icon icon-user"></i> <span class="text"> 个人主页 </span></a></li>

			<li class="dropdown" id="menu-messages"><a href="#"
				data-toggle="dropdown" data-target="#menu-messages"
				class="dropdown-toggle"><i class="icon icon-envelope"></i> <span
					class="text"> 站内信 </span> <span class="label label-important">5</span>
					<b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li><a class="sAdd" title="" href="#"><i class="icon-plus"></i>
							新消息 </a></li>
					<!--   <li class="divider"></li>
        <li><a class="sInbox" title="" href="#"><i class="icon-envelope"></i> inbox</a></li>
        <li class="divider"></li>
        <li><a class="sOutbox" title="" href="#"><i class="icon-arrow-up"></i> outbox</a></li>
        <li class="divider"></li>
        <li><a class="sTrash" title="" href="#"><i class="icon-trash"></i> trash</a></li>-->
				</ul></li>
			
			<li class=""><a title="登出" href="/dmis/User/LoginOut"><i
					class="icon icon-share-alt"></i> <span class="text"> 登出 </span></a></li>
		</ul>
	</div>
<!--start-top-serch-->
<div id="search">
<s:form action="" name="form1">
  <input type="text" placeholder="Search here..." style="width:300px"  name="keyw" />
  <button type="button" class="tip-bottom" title="Search" onclick="form1.action='/dmis/Keyword/search';form1.submit();"><span style="color:#FFF" >词条检索</span></button>
  &nbsp;<button type="button" class="tip-bottom" title="Search" onclick="form1.action='/dmis/Doc/search';form1.submit();"><span style="color:#FFF" >文库检索</span></button>
  </s:form>
</div>
<!--close-top-serch-->

	<div id="content"
		style="margin-top: 37px; margin-left: 7%; margin-right: 7%;height:118%;">
		<div id="content-header" style="height: 36px;"></div>
		
		<div class="row-fluid" style="height:360px;">
			<div class="span3"
				style="float: right; position: relative; margin-right: 25px; width: 24%;">

				<!-- video -->
				<div class="widget-box">

					<div class="widget-content" style="height: 150px;">
				<a  
			 href=""
			 onClick="window.open('video.jsp')"> <img alt="点击播放" src="images/default.jpg" style="height:100%;width：100%;">
		</a> 	
            
		
              
						<div class="todo">
						
							<ul id="searchHistory">
								<li class="clearfix">
									<div class="txt" style="padding: 10px 0 10px 40%"></div>
								</li>
							</ul>
						</div>
					</div>
					<div class="widget-title">
						<h5 style="margin-left: 35%;">	<a  
			 href="" onClick="window.open('video.jsp')"> 相关视频</a></h5>
			<!--  <A ID="InstallButton" HREF="video/DES.exe">Install</A> -->
			 
					</div>
				</div>  

				<!--keyword  -->
				<div class="widget-box">
					<div class="widget-title">
						<h5>相关词条</h5>
					</div>
					<div class="widget-content" style="clear:both;overflow:hidden;">
						<div class="todo" style="clear:both;overflow:hidden;">


							<ul id="keywords">
								<s:if test="#request.keywordList.size()==0">
						暂无相关词条！
						</s:if>
						<s:if test="#request.keywordList.size()>0" >
						<s:iterator value="#request.keywordList"  id="keyword" status="status">
							<li id="<s:property value='#status.index' />"  style="display:block;"><image src="img/pdf.jpg" width="20px" height="20px" /><a
								href="Keyword/hrefsearch?keywordId=<s:property value="id"/>"><s:property value="keyword"/></a></li> 
						 
						</s:iterator>
						

							</ul>
							<a id = "keywordmore" href="javascript:void"  onClick="keywordmore()" >更多</a>
						</s:if>	
						</div>
					</div>
				</div>
				<!-- doc -->
				<div class="widget-box">
					<div class="widget-title">
						<h5>相关文献</h5>
					</div>
					<div class="widget-content" style="clear:both;overflow:hidden;">
						<div class="todo" style="clear:both;overflow:hidden;">


							<ul id="docs">
								 <s:if test="#request.keyword.keyworddocs.isEmpty()">
						暂无相关文献！
						</s:if>
						
						<s:iterator value="#request.keyword.keyworddocs" status="status" >
						
							<li ><image src="img/pdf.jpg" width="20px" height="20px" /><a
								href="Doc/hrefsearch?docId=<s:property value='doc.id'/>"><s:property value="doc.title"/></a></li>
					
						</s:iterator>
							</ul>
							<s:if test="#request.keyword.keyworddocs.size()>0">
							<a id="docmore" href="javascript:void"  onClick="docmore()" >更多</a>
							</s:if>
						</div>
					</div>
				</div>
			</div>
			<div class="widget-box span9" style="width: 70%;height:515px;">

				<div class="widget-title bg_ly">
					<h1 style="text-align: center;">
						<s:property value="#request.keyword.getKeyword()" />
					</h1>
				</div>
	<!-- <div class="row" style="margin-left: 20px;">	 -->
    <div class="span12"><a href="javascript:void(0)" onclick="javascript:history.back(-1);" style="color: gray" onmouseover="this.style.cssText='color:#FFA011;'" onmouseout="this.style.cssText='color:gray;'" >返回上一页</a>
       </div>
                 

			<%-- 	<div class="article-post"
					style="height: 350px; margin-left: 7%; margin-top: 5%;overflow:auto;">

                    <h3>
							<s:property value="#request.keyword.getContent()"/>
				     </h3>  --%>
					 <div class="article-post"
						style="height: 350px; margin-left: 7%; margin-top: 5%;overflow:auto;">

						 
						 <h3>
							<s:property value="#request.keyword.getContent()" escape="false"/>
						</h3> 
					 </div> 
			

				</div>
				
			</div>
		</div>
      
	</div>

	<!--Footer-part-->
	<div class="row-fluid">
		<div id="footer" class="span12">
			2014 &copy; 硬件安全实验室<a href="http://themedesigner.in/">Themedesigner.in</a>
		</div>
	</div>
	<!--end-Footer-part-->
	<script src=" js/jquery.min.js"></script>
	<script src=" js/contact.js"></script>
	
	<script src=" js/bootstrap.min.js"></script>
	
	
	
</body>
</html>
