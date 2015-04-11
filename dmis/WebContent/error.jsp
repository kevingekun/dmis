<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath %>">
<html>
<link href="style.css" rel="stylesheet" type="text/css" />
<body style="background:#f9f9f9;">
违规操作！
</body>
</html>