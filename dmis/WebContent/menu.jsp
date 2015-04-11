<%@ page language="java" contentType="text/html; charset=UTF-8"
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
</head>
<body>
<div id="sidebar">
  <img id="img_admin" src="images/backgrounds/admin1.png	"/>
  <ul>
    <li class="fristChild"> 
		<a href="Doc/list?state=2" target="admin_menu">
			<i class="icon icon-signal"></i> 
			<img src="images/backgrounds/file.png"/>
			<span>文档管理</span>
		</a> 
	</li>
    <li> 
		<a href="Keyword/list?state=2" target="admin_menu">
			<i class="icon icon-inbox"></i> 
			<img src="images/backgrounds/word.png"/>
			<span>词条管理</span>
		</a> 
	</li>
    <li>
		<a href="User/list?state=1" target="admin_menu">
			<i class="icon icon-th"></i> 
			<img src="images/backgrounds/person.png"/>
			<span>人员管理</span>
		</a>
	</li>
    <li>
		<a href="Notice/list" target="admin_menu">
			<i class="icon icon-fullscreen"></i> 
			<img src="images/backgrounds/common.png"/>
			<span>公告管理</span>
		</a>
	</li>
	<li>
		<a href="Type/list?state=0" target="admin_menu">
			<i class="icon icon-fullscreen"></i> 
			<img src="images/backgrounds/self.png"/>
			<span>类型管理</span>
		</a>
	</li>
	<!-- <li>
		<a href="Comment/listByhaveHandled?haveHandled=0" target="admin_menu">
			<i class="icon icon-fullscreen"></i> 
			<img src="images/backgrounds/comment.png"/>
			<span>评论管理</span>
		</a>
	</li> -->
	<!-- <li>
		<a >href="Info/getInfo" target="admin_menu"
			<i class="icon icon-fullscreen"></i> 
			<img src="images/backgrounds/comment.png"/>
			<span>信息统计</span>
		</a>
	</li> -->

  </ul>
</div>
</body>
</html>
