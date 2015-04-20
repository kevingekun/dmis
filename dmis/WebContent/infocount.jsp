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
<link rel="stylesheet" type="text/css" href="css/bg/yetou.css"/>
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/matrix-style.css" />
<link rel="stylesheet" type="text/css" href="css/buttons/buttons.css" />
<link rel="stylesheet" href="css/chart/chart.css" />

<script src="js/jquery.min.js" type="text/javascript"></script>
</head>
<body id="table1">
<div class="widget-box">
	<div class="widget-title">
       <h5>信息统计</h5>
       <a class="btn btn-small green" style="margin:5px 0 0 3px; " onclick="docCategory()">文档文献</a>
       <a class="btn btn-small green" style="margin:5px 0 0 3px; " onclick="docLevel()">文档等级</a>
       <a class="btn btn-small green" style="margin:5px 0 0 3px; " onclick="docDownload_thisYear()">下载量</a>
	</div>
	<div>
		<div class="widget-content" style="float: left;">
        	<div id="docChart" class="content"></div>
    		<div id="yearChange" class="count_left" style="display:none;">
    			<a id="yearChangeId"class="btn btn-small green" style="margin:5px 0 0 3px; " onclick="docLevel()">下载量</a>
    		</div>
    	</div>
	</div>
</div>
<script src="js/echarts/build/dist/echarts-all.js"></script>
<script src="js/echarts/chart.js"></script>
</body>
</html>