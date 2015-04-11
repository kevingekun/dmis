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
	
<!--Chart-box-->    
    <div class="row-fluid">
    <div class="span3" style="float:right;position:relative;margin-right:20px;">
        <div class="widget-box">
          <div class="widget-title">
            <h5>最新公告</h5>
          </div>
          <div class="widget-content" style="height: 632px; overflow: auto;">
            <div class="todo" style="overflow: auto;">
             <ul>
             <s:iterator value="#request.recentNotice.pageList">
                <li class="clearfix">
                  <div class="txt"> 标题：<s:property value="title"/><br/> 内容：<s:property value="content"/> 
                  <br/> 时间：<s:date  name="time" format="yyyy-MM-dd HH:mm"/>
                  </div>
                </li>
               </s:iterator>
               <div class="pull-right"> <a href="/knowledge/Notice/listAll"><span >更多>></span></a></div><br/>
              </ul>
            </div>
          </div>
    </div></div>
      <div class="span8" style="margin-left:20px;width:70%">
      	<div class="widget-box">
          <div class="widget-title">
            <h5>最近上传</h5>
          </div>
          <div class="widget-content">
            <div class="todo">
               <ul>
               <s:iterator value="#request.recentDoc.pageList">
                <li class="clearfix">

                
                  <div class="txt"><img width="30" height="30" title="<s:property value="format"/>" src="<%=basePath %>img/demo/<s:property value="format"/>.png"> <a href="/knowledge/Doc/hrefsearch?docId=<s:property value='id' />" target="_blank"><s:property value="title"/></a> </div>

                  <div class="pull-right"> <a href="/knowledge/Download/downloadDoc?downPath=doc/<s:property value="getFilename()"/>" style="color: gray" onmouseover="this.style.cssText='color:#FFA011;'" onmouseout="this.style.cssText='color:gray;'"> 下载  </a> 
				   <a href="/knowledge/Doc/hrefsearch?docId=<s:property value='id' />" style="color: gray" onmouseover="this.style.cssText='color:#FFA011;'" onmouseout="this.style.cssText='color:gray;'"> 查看  </a></div>
                </li>
                </s:iterator>
               <div class="pull-right"> <a href="/knowledge/Doc/getAllDoc"><span >更多>></span></a></div><br/>
              </ul>
            </div>
          </div>
        </div>
        
        <div class="widget-box">
          <div class="widget-title">
            <h5>行业动态</h5>
          </div>
          <div class="widget-content">
            <div class="todo">
               <ul>
                <li class="clearfix">
                  <div class="txt"> COSADE会议 </div>
                   <div class="pull-right"> <a href="http://cosade.org/"><span >详情点击>></span></a></div>
                </li>
                <li class="clearfix">
                  <div class="txt">CHES会议 </div>
                  <div class="pull-right"> <a href="http://www.ches.org/"><span >详情点击>></span></a></div>
                </li>
                <li class="clearfix">
                  <div class="txt"> FDTC会议 </div>
                  <div class="pull-right"> <a href="https://www.fdtc.edu/"><span >详情点击>></span></a></div>
                </li>
                <li class="clearfix">
                  <div class="txt"> 国际密码研究协会 </div>
                  <div class="pull-right"> <a href="http://www.iacr.org/"><span >详情点击>></span></a></div>
                </li>
                <li class="clearfix">
                  <div class="txt"> 美密会 </div>
                  <div class="pull-right"> <a href="http://www.crypto.gr/"><span >详情点击>></span></a></div>
                </li>
                 <li class="clearfix">
                  <div class="txt"> 欧密会2014</div>
                  <div class="pull-right"> <a href="http://ec14.compute.dtu.dk/"><span >详情点击>></span></a></div>
                </li>
                 <li class="clearfix">
                  <div class="txt"> 亚密会2014 </div>
                  <div class="pull-right"> <a href="http://des.cse.nsysu.edu.tw/asiacrypt2014/"><span >详情点击>></span></a></div>
                </li>
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
  <div id="footer" class="span12"> 2014 &copy; 硬件安全研究所 </div>
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


	/* $("#searchDoc").click(function(){
		 searchText = $("#searchText").val();
		 $('#searchDoc > span').text("搜索中...");
		 if(searchText != "")
			$.post("/knowledge/SearchHistory/saveSearchHistory?keyword="+searchText+"",function(){
				/* loadDocBysearch(typeId,"","","",searchText,typeName); */
		/* 		 location.href='/knowledge/Doc/DocAction/search';
			});
		 else
			 loadDocBysearch(typeId,"","","",searchText,typeName);
	}); */
 
// resets the menu selection upon entry to this page:
function resetMenu() {
   document.gomenu.selector.selectedIndex = 2;
}
</script>
</body>
</html>
