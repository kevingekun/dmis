<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%@page
	import="com.zhuozhengsoft.pageoffice.*,java.net.URLEncoder.*,lab.dmis.model.Doc"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	/*pageoffice  */
	PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);
	poCtrl1.setServerPage("poserver.do"); //此行必须
	poCtrl1.setSaveFilePage("/knowledge/saveDocFile.jsp");//如要保存文件，此行必须
	String docPath = request.getAttribute("docPath").toString();
	if (docPath.endsWith(".doc")||docPath.endsWith(".docx")) { //判断后缀名
		String filePath = request.getSession().getServletContext()
				.getRealPath(docPath);
		System.out.println(filePath);
		/* poCtrl1.webOpen(new String(filePath.getBytes("ISO-8859-1"),"UTF-8"), OpenModeType.pptNormalEdit, "张三");

		poCtrl1.webOpen(filePath, OpenModeType.docNormalEdit, "张三");
 */

		poCtrl1.webOpen(filePath, OpenModeType.docNormalEdit, "张三");

		poCtrl1.setTagId("PageOfficeCtrl1"); //此行必须
		
	} else if (docPath.endsWith(".ppt")||docPath.endsWith(".pptx")) { //判断后缀名
		String filePath = request.getSession().getServletContext()
				.getRealPath(docPath);
		System.out.println(filePath);
		poCtrl1.webOpen(filePath, OpenModeType.pptNormalEdit, "张三");
		poCtrl1.setTagId("PageOfficeCtrl1"); //此行必须
		
	} else if (docPath.endsWith(".xls")||docPath.endsWith(".xlsx")) { //判断后缀名
		String filePath = request.getSession().getServletContext()
				.getRealPath(docPath);
		System.out.println(filePath);
		poCtrl1.webOpen(filePath, OpenModeType.xlsNormalEdit, "张三");
		poCtrl1.setTagId("PageOfficeCtrl1"); //此行必须
		
	}else {
		String filePath = request.getSession().getServletContext() //设置默认值
				.getRealPath("doc/JAVA.docx");
		System.out.println(filePath);
		poCtrl1.webOpen(filePath, OpenModeType.docNormalEdit, "张三");
		poCtrl1.setTagId("PageOfficeCtrl1"); //此行必须
	}
%>