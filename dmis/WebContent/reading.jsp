<%@page import="org.objectweb.asm.tree.TryCatchBlockNode"%>
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
<s:if test="#request.type != 'pdf'">
	<jsp:include page="office.jsp"></jsp:include>
</s:if>
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
<link rel="stylesheet" href=" css/dmis.css" />
<link href=" font-awesome/css/font-awesome.css" rel="stylesheet" />
</head>
<body>
<%try{ %>
	<input id="DOCPATH" value="<s:property value="#request.docPath"/>" type="hidden" />
	<input id="TYPE" value="<s:property value="#request.type"/>" type="hidden" />

	<s:if test="#request.type == 'pdf'">
		<!-- start pdf -->
		<div id="showpdf" style="height: 100%;">
			<div class="widget-content" id="pdf" style="width: 100%; height: 100%;"></div>
		</div>
	</s:if>
	<!-- end pdf -->

	<!-- start pageoffice -->
	<s:else>
		<div id="showoffice" style="height: 100%;">
			<div style="width: 100%; height: 100%;">
				<po:PageOfficeCtrl id="PageOfficeCtrl1"></po:PageOfficeCtrl>
			</div>
		</div>
	</s:else>
<%}catch (Exception e){ %>
	<jsp:include page="readingError.jsp"></jsp:include>
<% } %>
	<!-- end pageoffice -->
	<!--end-Footer-part-->
	<script src=" js/jquery.min.js"></script>
	<script src=" js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/pdfobject.js" charset="utf-8"></script>
	<script type="text/javascript" charset="utf-8">
		var type = $('#TYPE').val().trim();
		var path = $('#DOCPATH').val().trim();
		if (type == "pdf") {
			var success = new PDFObject({
				url : path
			}).embed("pdf");
		}
	</script>
</body>
</html>
