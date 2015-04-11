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


		<!-- start pdf -->
		<div id="showpdf" style="height:100%;">

			<div class="widget-content" 
				style="width: 100%; height:100%; ">
				<a  
				 href="<%=basePath %>video/aes.swf"
			 	style="display:block;width:100%;height:100%"  
			 	id="player"> 
				</a> 	
				</div>
		</div>
		<!-- end pdf -->
		

	
	<script src=" js/jquery.min.js"></script>
	<script src=" js/bootstrap.min.js"></script>
	
<script type="text/javascript" src="js/flowplayer-3.2.13.min.js"></script>
	
	<script>
			flowplayer("player", "video/aes.swf");
		</script>
	


		

</body>
</html>
