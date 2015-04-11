<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!-- <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'> -->
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
   		<div id="sidebar" class="sidebar">
 		 <ul style="background:#2E363F" id="menuTwo">
    		
		</ul>
  	 </div>
	</div>
<!--hideSecondMenuEnd-->

<div id="content">
  <!--start-top-serch-->
   
       <!--close-top-serch--> 
   <div class="row-fluid">
    <div class="span3" style="float:right;position:relative;margin-right:20px;">
        <div class="widget-box">
          <div class="widget-title">
            <h5>搜索历史</h5>
          </div>
          <div class="widget-content">
            <div class="todo">
             <ul id="searchHistory">
                <li class="clearfix">
                  <div class="txt" style="padding:10px 0 10px 40%"> <img src='<%=basePath %>images/loading.gif' width='50px' height='50px'/> </div>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <div class="widget-box">
          <div class="widget-title">
            <h5>热门词汇</h5>
          </div>
          <div class="widget-content">
            <div class="todo">
             <ul id="hotword">
                <li class="clearfix">
                   <div class="txt" style="padding:10px 0 10px 40%"> <img src='<%=basePath %>images/loading.gif' width='50px' height='50px'/> </div>
                </li>
              </ul>
            </div>
          </div>
        </div> 
        </div>
        <div class="widget-box span9" style="width:70%">
          <div class="widget-title bg_ly" >           
            <div id="loadFilter" class="main_input_box">
           		<span class="add-on" style="font-weight:bolder;">按年份搜索:</span>	<select id="year" style="width:12%; margin-top:3px;">
           		 	 <option >年份</option>
                     <option value="1"> 近一年</option>
                     <option value="2"> 近两年</option>
                     <option value="3"> 近三年  </option>
                 </select>
                 <span class="add-on" style="font-weight:bolder">按类别搜索:</span>	<select id="category" style="width:15%; margin-top:3px;">
                	 <option >类别</option>
                     <option > 外文期刊 </option>
                     <option > OA论文 </option>
                     <option > 期刊论文 </option>
                     <option > 学位论文 </option>
                     <option > 会议论文 </option>
                     <option > 分类文档 </option>
                     <option > 其他 </option>
                  </select>
                  <span class="add-on" style="font-weight:bolder">按语言搜索:</span>	<select id="language" style="width:10%; margin-top:3px;">
                     <option >语言</option>
                     <option value="1"> 中文  </option>
                     <option value="2"> 英文  </option>
                  </select>
                  <button  style="margin-bottom: 5px; width:11%" id="advancedTwiceSearch" class="btn btn-success">二次搜索</button>
                  <button style="margin-bottom: 5px; width:15%" id="advancedAllSearch" class="btn btn-success">搜索全部文档</button>
              </div>
          </div>

           <div class="main_input_box">
             <div style="display: inline" id="condition"><h6>&nbsp;&nbsp;当前搜索条件：</h6>&nbsp;
	             <a href="javascript:void(0)" style="color:#FFF;" class="bg_ly" title="点击清除" id="typeNameClear">
					<s:if test = "#request.typeName==null">
						全部文档</s:if>
					<s:elseif test = "#request.typeName==''">
						全部文档</s:elseif>
					<s:else>
						${typeName }</s:else>
					</a> &nbsp;
	             <a href="javascript:void(0)" style="color:#FFF;" class="bg_ly" title="点击清除" id="searchClear"> ${search }</a>
	             <a href="javascript:void(0)" style="color:#FFF;" class="bg_ly" title="点击清除" id="yearClear">
	             <s:if test = "#request.year==1">  近一年</s:if> 
	             <s:if test = "#request.year==2">  近二年</s:if>
	             <s:if test = "#request.year==3">  近三年</s:if>
	             </a> &nbsp;
	             <a href="javascript:void(0)" style="color:#FFF;" class="bg_ly" title="点击清除" id="categoryClear"> ${category }</a>
	             <a href="javascript:void(0)" style="color:#FFF;" class="bg_ly" title="点击清除" id="languageClear">
	             <s:if test = "#request.language==1">  中文</s:if> 
	             <s:if test = "#request.language==2">  英文</s:if>
	            	 </a>
             </div>
             <hr class="hr"/>
             </div>

          <div class="widget-content nopadding collapse in" id="collapseG2">
            <ul class="recent-posts">
            <s:iterator value="#request.page.pageList">
              <li>
                <div class="user-thumb"> <img width="30" height="30" alt="<s:property value="format"/>" src="<%=basePath %>img/demo/<s:property value="format"/>.png"> </div>
                <div class="article-post"> 
                <a href="/knowledge/Doc/hrefsearch?docId=<s:property value='id' /> " style="color:#004BBB;"onmouseover="this.style.cssText='color:#FFA011;'" onmouseout="this.style.cssText='color:#004BBB;'"><s:property value="title"/></a> 
                <p><span class="user-info" style="color:#0A8F3F;"> 作者: <s:property value="author"/></span></p>
				  <p style="color:#0A8F3F;">[<s:property value="category"/>] <s:property value="type.name"/> <s:property value="journal"/> <s:property value="publishedTime"/> 
				  下载次数：<s:property value="downloadTimes"/></p>
				  <p >摘    要：
				  <s:if test="brief.length()>200">
				  	<s:property value="brief.substring(0,200)" escape="false"/>...
				  </s:if>
				  <s:else>
				  	<s:property value="brief" escape="false"/>
				  </s:else>
				  	</p>
				  <p style="color:#0A8F3F;">关键字：<s:property value="CCC"/>......</p>
				  <p><a href="/knowledge/Download/downloadDoc?downPath=doc/<s:property value="getFilename()"/>" style="color: gray" onmouseover="this.style.cssText='color:#FFA011;'" onmouseout="this.style.cssText='color:gray;'"> 下载全文 </a> 
				  - <a href="/knowledge/Doc/hrefsearch?docId=<s:property value='id' />" style="color: gray" onmouseover="this.style.cssText='color:#FFA011;'" onmouseout="this.style.cssText='color:gray;'"> 查看全文 </a></p>
                </div>
                </li>
   			</s:iterator>
				 
            </ul>
          </div>
          <input id="type" value="${typeId }" style="display:none" />
          <input id="searchRecoder" value="${search }"  style="display:none"/>
          <input id="typeName" value="${typeName }"  style="display:none"/>
		 <div class="pagination alternate" style=" float: left">
			 <ul>
            	<s:if test="#request.page.showPrv != 0">
					              	<li ><a href="<%=basePath %>Doc/<s:property value="actionName"/>?pageNo=1&typeId=${typeId}${uri}">首页</a></li>
					                <li ><a href="<%=basePath %>Doc/<s:property value="actionName"/>?pageNo=<s:property value="#request.page.pageNo -1"/>&typeId=${typeId}${uri}">上一页</a></li>
					            </s:if>
					            <s:else>
					            	<li class="disabled"><a href="javascript:void(0);">首页</a></li>
					                <li class="disabled"><a href="javascript:void(0);">上一页</a></li>
					            </s:else>
					            	<li class="disabled"><a href="javascript:void(0);">共<s:property value="#request.page.totalPage"/>页</a></li>
					            <s:iterator value="#request.page.pageNum" id="key">
					            	<s:if test="#key != #request.page.pageNo">
					            		<li><a href="<%=basePath %>Doc/<s:property value="actionName"/>?pageNo=<s:property value="key"/>&typeId=${typeId}${uri}"><s:property value="key"/></a></li>
					            	</s:if>
					            	<s:else>
					            		<li class="active"> <a href="javascript:void(0);"><s:property value="key"/></a> </li>
					            	</s:else>
					            </s:iterator>
				                
				                <s:if test="#request.page.showNext != 0">
				               		<li><a href="<%=basePath %>Doc/<s:property value="actionName"/>?pageNo=<s:property value="#request.page.pageNo +1"/>&typeId=${typeId}${uri}" >下一页</a></li>
				               		<li><a href="<%=basePath %>Doc/<s:property value="actionName"/>?pageNo=<s:property value="#request.page.totalPage"/>&typeId=${typeId}${uri}">尾页</a></li>
				                </s:if>
				                <s:else>
				                	<li class="disabled"><a href="javascript:void(0);">下一页</a></li>
					                <li class="disabled"><a href="javascript:void(0);">尾页</a></li>
				                </s:else>
              </ul>
          </div>
		</div>
       </div>
       
    </div></div>
       </div></div>
        
</div>

<!--Footer-part-->
<div class="row-fluid">
  <div id="footer" class="span12"> 2014 &copy; 欢迎来到知识的海洋<a href="http://themedesigner.in/">Themedesigner.in</a> </div>
</div>
<!--end-Footer-part--> 
<script src="<%=basePath%>js/jquery.min.js"></script> 
<script src="<%=basePath%>js/bootstrap.min.js"></script> 
<script src="<%=basePath%>js/pagescript/slide.menu.js"></script> 
<script src="<%=basePath%>js/pagescript/search.js"></script> 
<script src="<%=basePath%>js/pagescript/knowledge.alert.js"></script> 
<script>
</script>
</body>
</html>
