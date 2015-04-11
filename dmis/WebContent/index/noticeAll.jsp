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
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/matrix-style.css" />
<link rel="stylesheet" href="<%=basePath%>css/matrix-media.css" />
<link rel="stylesheet" href="<%=basePath%>css/knowledge.css" />
<link href="<%=basePath%>font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="<%=basePath%>css/jquery.gritter.css" />
<link href='css/goolefont.css' rel='stylesheet' type='text/css'>
</head>
<body>

<jsp:include page="top.jsp"/>
<!--close-top-serch-->
<!--sidebar-menu-->
<div id="sidebar" class="sidebar">
  <ul id="menu">
    
  </ul>
</div>

<!--hideSecondMenuStart-->
    <div id="hidemenuTwo" class="hidemenuTwo">
    <div id="sidebar" class="sidebar" >
 		 <ul style="background:#2E363F" id="menuThree">
    		
		</ul>
  	 </div></div>
	<div id="hidemenu" class="hidemenu">
   		<div id="sidebar" class="sidebar" >
 		 <ul style="background:#2E363F" id="menuTwo">
    		
		</ul>
  	 </div>
	</div>
<!--hideSecondMenuEnd-->


<!--sidebar-menu-->

<!--main-container-part-->
<div id="content" >

<!--End-breadcrumbs-->
	
<!--Chart-box-->    
    <div class="row-fluid">
    <div class="span3" style="float:right;position:relative;margin-right:20px;">
        </div>
      <div class="span8" style="margin-left:20px;width:70%">
      	<div class="widget-box">
          <div class="widget-title">
            <h5>公告</h5>
          </div>
          <div class="widget-content">
            <div class="todo">
               <ul>
                <s:iterator value="#request.page.pageList">
                <li class="clearfix">
                  <div class="txt"> 标题：<s:property value="title"/><br/> 内容：<s:property value="content"/> 
                  <br/> 时间：<s:date  name="time" format="yyyy-MM-dd HH:mm"/>
                  </div>
                </li>
               </s:iterator>
         
             <input id="type" value="${typeId }" style="display:none" />
         <%--  <input id="searchRecoder" value="${search }"  style="display:none"/> --%>
          <input id="typeName" value="${typeName }"  style="display:none"/>
		 <div class="pagination alternate" style=" float: left">
			 <ul>
            	<s:if test="#request.page.showPrv != 0">
					              	<li ><a href="<%=basePath %>Notice/<s:property value="actionName"/>?pageNo=1&typeId=${typeId}${uri}">首页</a></li>
					                <li ><a href="<%=basePath %>Notice/<s:property value="actionName"/>?pageNo=<s:property value="#request.page.pageNo -1"/>&typeId=${typeId}${uri}">上一页</a></li>
					            </s:if>
					            <s:else>
					            	<li class="disabled"><a href="javascript:void(0);">首页</a></li>
					                <li class="disabled"><a href="javascript:void(0);">上一页</a></li>
					            </s:else>
					            	<li class="disabled"><a href="javascript:void(0);">共<s:property value="#request.page.totalPage"/>页</a></li>
					            <s:iterator value="#request.page.pageNum" id="key">
					            	<s:if test="#key != #request.page.pageNo">
					            		<li><a href="<%=basePath %>Notice/<s:property value="actionName"/>?pageNo=<s:property value="key"/>&typeId=${typeId}${uri}"><s:property value="key"/></a></li>
					            	</s:if>
					            	<s:else>
					            		<li class="active"> <a href="javascript:void(0);"><s:property value="key"/></a> </li>
					            	</s:else>
					            </s:iterator>
				                
				                <s:if test="#request.page.showNext != 0">
				               		<li><a href="<%=basePath %>Notice/<s:property value="actionName"/>?pageNo=<s:property value="#request.page.pageNo +1"/>&typeId=${typeId}${uri}" >下一页</a></li>
				               		<li><a href="<%=basePath %>Notice/<s:property value="actionName"/>?pageNo=<s:property value="#request.page.totalPage"/>&typeId=${typeId}${uri}">尾页</a></li>
				                </s:if>
				                <s:else>
				                	<li class="disabled"><a href="javascript:void(0);">下一页</a></li>
					                <li class="disabled"><a href="javascript:void(0);">尾页</a></li>
				                </s:else>
              </ul>
            </div>
          </div>
        </div>
        
        
      </div>
     </div>

    </div>
  </div>
</div>

<!--end-main-container-part-->

<!--Footer-part-->

<div class="row-fluid">
  <div id="footer" class="span12"> 2013 &copy; Matrix Admin. Brought to you by <a href="http://themedesigner.in/">Themedesigner.in</a> </div>
</div>

<!--end-Footer-part-->

<script src="<%=basePath%>js/jquery.min.js"></script> 
<script src="<%=basePath%>js/pagescript/slide.menu.js"></script> 
<script src="<%=basePath%>js/bootstrap.min.js"></script> 
<script src="<%=basePath%>js/pagescript/search.js"></script> 
<script src="<%=basePath%>js/pagescript/knowledge.alert.js"></script> 
<script type="text/javascript">
  // This function is called from the pop-up menus to transfer to
  // a different page. Ignore if the value returned is a null string:
  function goPage (newURL) {

      // if url is empty, skip the menu dividers and reset the menu selection to default
      if (newURL != "") {
      
          // if url is "-", it is this page -- reset the menu:
          if (newURL == "-" ) {
              resetMenu();            
          } 
          // else, send page to designated URL            
          else {  
            document.location.href = newURL;
          }
      }
  }

// resets the menu selection upon entry to this page:
function resetMenu() {
   document.gomenu.selector.selectedIndex = 2;
}
</script>
</body>
</html>
