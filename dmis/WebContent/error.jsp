<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath %>">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/bg/yetou.css" />
</head>
<body style="background:#f9f9f9;">
<div style="margin-left: 30px;margin-top:30px">
	<a style="color: orange; font-size: 16px;"><s:property value="errors.error[0]"/></a>
	<s:debug></s:debug>
</div>
</body>
</html>