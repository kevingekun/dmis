﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath %>">
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/bg/matrix-style.css" />
<script type="text/javascript" src="js/menu/jquery.js"></script>
<script type="text/javascript" src="js/menu/sliding_effect.js"></script>
</head>
<body>
<div id="sidebar">
  <img id="img_admin" src="images/menu/admin.png	"/>
  <ul id="sliding-navigation">
    <li class="sliding-element"> 
		<a href="Doc/list?state=2" target="admin_menu">
			<i class="icon icon-signal"></i> 
			<img src="images/menu/file.png"/>
			<span>文档管理</span>
		</a> 
	</li>
    <li class="sliding-element"> 
		<a href="Keyword/list?state=2" target="admin_menu">
			<i class="icon icon-inbox"></i> 
			<img src="images/menu/word.png"/>
			<span>词条管理</span>
		</a> 
	</li>
    <li class="sliding-element">
		<a href="User/list?state=1" target="admin_menu">
			<i class="icon icon-th"></i> 
			<img src="images/menu/person.png"/>
			<span>人员管理</span>
		</a>
	</li>
    <li class="sliding-element">
		<a href="Notice/list" target="admin_menu">
			<i class="icon icon-fullscreen"></i> 
			<img src="images/menu/common.png"/>
			<span>公告管理</span>
		</a>
	</li>
	<li class="sliding-element">
		<a href="Type/list?state=0" target="admin_menu">
			<i class="icon icon-fullscreen"></i> 
			<img src="images/menu/self.png"/>
			<span>类型管理</span>
		</a>
	</li>
	<li class="sliding-element">
		<a href="Comment/listByhaveHandled?haveHandled=0" target="admin_menu">
			<i class="icon icon-fullscreen"></i> 
			<img src="images/menu/comment.png"/>
			<span>评论管理</span>
		</a>
	</li>
	<li class="sliding-element">
		<a href="Info/getInfo" target="admin_menu">
			<i class="icon icon-fullscreen"></i> 
			<img src="images/menu/info.png"/>
			<span>信息统计</span>
		</a>
	</li>
  </ul>
</div>
</body>
</html>
