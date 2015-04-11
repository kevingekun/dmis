<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Matrix Admin</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

</head>
<body>

<!--Header-part-->
<div id="header">
  <h1><a href="javascript:void(0)">知识管理系统--主页</a></h1>
</div>
<!--close-Header-part--> 


<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse">
  <ul class="nav">
 
  <li class=""><a title="首页" href="/knowledge/Doc/getRecentDoc"><i class="icon icon-home"></i> <span class="text"> 首页 </span></a></li>
  <li ><a title="" href="/knowledge/Page/getPagepersonalCenter" ><i class="icon icon-user"></i>  <span class="text">  个人主页  </span></a>
    </li>
     <s:if test="#session.LOGIN_USER.role == 0">
  	<li class=""><a title="进入后台管理" href="/knowledge/Admin/getAdminIndex"><i class="icon icon-user"></i> <span class="text"> 管理中心  </span></a></li>
  </s:if>

    <li class="dropdown" id="menu-messages"><a href="#" data-toggle="dropdown" data-target="#menu-messages" class="dropdown-toggle"><i class="icon icon-envelope"></i> <span class="text"> 站内信 </span> <span class="label label-important">5</span> <b class="caret"></b></a>
      <ul class="dropdown-menu">
        <li><a class="sAdd" title="" href="#"><i class="icon-plus"></i> 新消息</a></li>
       <!-- <li class="divider"></li>
        <li><a class="sInbox" title="" href="#"><i class="icon-envelope"></i> inbox</a></li>
        <li class="divider"></li>
        <li><a class="sOutbox" title="" href="#"><i class="icon-arrow-up"></i> outbox</a></li>
        <li class="divider"></li>
        <li><a class="sTrash" title="" href="#"><i class="icon-trash"></i> trash</a></li>-->
      </ul>
    </li>
     <%--  <li class=""><a title="主页" href="/knowledge/Page/getPageindex"><i class="icon icon-home"></i> <span class="text"> 主页 </span></a></li> --%>
    <li class=""><a title="登出" href="/knowledge/User/LoginOut"><i class="icon icon-share-alt"></i> <span class="text"> 退出 </span></a></li>
  </ul>
</div>
<!--close-top-Header-menu-->
<!--start-top-serch-->
<div id="search">
<s:form name="form1">
  <input type="text" placeholder="搜索..." style="width:300px" name="keyw" id="searchText" value="${keywords}" />
  <button type="button" class="tip-bottom" title="搜索"  onclick="form1.action='/knowledge/Keyword/search';form1.submit();"><span style="color:#FFF" >词条检索</span></button>
  &nbsp;<button type="button" class="tip-bottom" title="Search" id="searchAllDoc"><span style="color:#FFF" >文库检索</span></button>
</s:form>

</div>
<!--breadcrumbs-->
  <!-- <div id="content-header">
    <div id="breadcrumb"> <a href="javascript:void(0)" title="知识管理系统" class="tip-bottom"><i class="icon-book"></i> 知识管理系统 </a></div>
  </div> -->
<!--End-breadcrumbs-->

</body>

</html>