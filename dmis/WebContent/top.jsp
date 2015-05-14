<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</head>
<body>
	<div id="all_top">
		<div id="img">
			<img src="images/menu/logo.png" />
		</div>
		<div id="menu_all">
			<div id="menu" style="z-index: 22;">
				<div id="topMenu">
					<ul>
						<li><a title="退出" href="#"
							onClick="if (confirm('确认要离开本系统?')){href='/dmis/User/LoginOut';target='_top';}else {href='System/top';target='_self';}">退出</a>
						</li>
						<li
							style="padding: 8px 15px 5px 15px; border-left: 1px #2e363f solid;">&nbsp;</li>
					</ul>
				</div>
				<div class="search_top">
					<form id="searchBox" name="labs-search" method="post" action="#">
						<input type="text" placeholder="Search here..." class="textfield"
							name="term" />
						<button title="search" type="button" id="submit">搜索</button>
					</form>
				</div>
			</div>
			<div id="show_top" style="z-index: 33;">
				<div
					style="color: #666; font-size: 12px; font-family: 'Open Sans', sans-serif; margin: 0 auto; padding: 7px 0 7px 15px;">后台管理</div>
			</div>
		</div>
	</div>
</body>
</html>