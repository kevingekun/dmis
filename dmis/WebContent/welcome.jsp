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

<frameset rows="12%,88%" border="0" bordercolor="#2E3740">
	<frame src="System/top" noresize="noresize" scrolling="no" />
	<frameset cols="16.8%,83.2%">
		<frame src="System/menu" noresize="noresize" scrolling="no" />
		<frame src="Doc/list?state=2" name="admin_menu" noresize="noresize "
			scrolling="auto"></frame>
	</frameset>
</frameset>
<noframes></noframes>
</html>
