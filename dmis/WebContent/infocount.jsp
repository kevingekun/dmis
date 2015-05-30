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
<link rel="stylesheet" type="text/css" href="css/dmis.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/buttons/buttons.css" />
<link rel="stylesheet" href="css/chart/chart.css" />
<script src="js/jquery.min.js" type="text/javascript"></script>
</head>
<body id="table1">
<div class="widget-box">
	<div class="widget-title">
       <h5>信息统计</h5>
       <a id="btn1" class="btn btn-small green" style="margin:5px 0 0 3px;">文档文献</a>
       <a id="btn2" class="btn btn-small green" style="margin:5px 0 0 3px;"> 文档等级</a>
       <a id="btn3" class="btn btn-small green" style="margin:5px 0 0 3px;">下载量</a>
	</div>
	<div id="isEmpty" class="widget-content" style="float: left;">
        <div id="docChart" class="content"></div>
    	<div id="yearChange" class="count_left" style="display:none;">
    		<a id="yearChangeId" class="btn btn-small green" style="margin:5px 0 0 3px;">下载量</a>
    	</div>
    </div>
</div>
</body>
<script src="js/echarts/build/dist/echarts-all.js"></script>
<script src="js/echarts/chart.js"></script>
</html>