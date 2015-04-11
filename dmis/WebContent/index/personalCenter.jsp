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
<title> Hardware Security Lab</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/matrix-style.css" />
<link rel="stylesheet" href="<%=basePath%>css/matrix-media.css" />
<link rel="stylesheet" href="<%=basePath%>css/knowledge.css" />
<link rel="stylesheet" href="<%=basePath%>css/uniform.css" />
<link rel="stylesheet" href="<%=basePath%>css/select2.css" />
<link href="<%=basePath%>font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='css/goolefont.css' rel='stylesheet' type='text/css'>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>

</head>

<body>
<div class="alertMask" style="display: none"></div>
<div id="alertPanel"></div>
<div id="mask" class="mask"></div>
<!--Header-part-->
<div id="header">
  <h1><a href="dashboard.html">Hardware Security Lab</a></h1>
</div>
<!--close-Header-part--> 
<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse">
  <ul class="nav">
  <li class=""><a title="首页" href="/knowledge/Doc/getRecentDoc"><i class="icon icon-home"></i> <span class="text"> 首页 </span></a></li>
    <li><a title="" href="/knowledge/Page/getPagepersonalCenter" ><i class="icon icon-user"></i>  <span class="text">  个人主页  </span></a>
    </li>
    <li class="dropdown" id="menu-messages"><a href="#" data-toggle="dropdown" data-target="#menu-messages" class="dropdown-toggle"><i class="icon icon-envelope"></i> <span class="text">  站内信  </span> <span class="label label-important">5</span> <b class="caret"></b></a>
      <ul class="dropdown-menu">
        <li><a class="sAdd" title="" href="#"><i class="icon-plus"></i>  新消息  </a></li>
     <!--   <li class="divider"></li>
        <li><a class="sInbox" title="" href="#"><i class="icon-envelope"></i> inbox</a></li>
        <li class="divider"></li>
        <li><a class="sOutbox" title="" href="#"><i class="icon-arrow-up"></i> outbox</a></li>
        <li class="divider"></li>
        <li><a class="sTrash" title="" href="#"><i class="icon-trash"></i> trash</a></li>-->
      </ul>
    </li>      
      <li class=""><a title="登出" href="/knowledge/User/LoginOut"><i class="icon icon-share-alt"></i> <span class="text"> 登出 </span></a></li>
  </ul>
</div>

<%-- <jsp:include page="top.jsp"/> --%>

<!--close-top-serch-->
<!--sidebar-menu-->
<div id="sidebar">

	<div id="photo" align="center" style="margin:10px;"><img src="<%=basePath%>images/photo.jpg" width="125" height="124"/>
    </div>
  <ul >
    <li data-val="person" class="sidebarPer">姓名：<s:property value="#session.LOGIN_USER.name"/></li>
    <li data-val="person" class="sidebarPer">电话：<s:property value="#session.LOGIN_USER.phone"/></li>
    <li data-val="person" class="sidebarPer">Q Q：<s:property value="#session.LOGIN_USER.qq"/></li>
   <li data-val="person" class="sidebarPer">身份：
	<s:if test="#session.LOGIN_USER.role == 0">
	管理员   </s:if>
	<s:if test="#session.LOGIN_USER.role == 2">
	专家</s:if>
	<s:if test="#session.LOGIN_USER.role == 3">
	普通用户
	</s:if>
	</li>
  	 <s:if test="#session.LOGIN_USER.role == 0">
  	 <li  data-val="person"  >
  	 	<a  href="/knowledge/Admin/getAdminIndex" target="_blank">进入管理中心>></a></li>
  	 </s:if>
  	 <s:else><li data-val="person" style="padding:10px 0 10px 0;">&nbsp;</li></s:else>
    <li  id="btnEdit" data-val="person"  ><a href="javascript:void(0)">信息完善</a></li>
    <li  id="passEdit" data-val="person" ><a href="javascript:void(0)">修改密码</a></li>
     <li  id="fileEdit2" data-val="person" ><a href="javascript:void(0)">上传文献</a></li>
    <%--  <s:if test="#session.LOGIN_USER.role == 1">
    	 <li data-val="person"><a href=" /knowledge/Page/getPagewelcome" >管理中心</a></li>
	</s:if> --%>
	 <li  id="fileEdit1" data-val="person" ><a href="javascript:void(0)">上传资料</a></li>
	 <s:if test="#session.LOGIN_USER.role == 0">
	 	<li  id="manage" data-val="person" ><a href="/knowledge/page/background/welcome.jsp">后台管理</a></li>
	 </s:if>
	</ul>
</div>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">

<!--infoEdit Start-->
<div id="infoEdit" style="display:none;" align="center">
  <div id="infoEditContent" style="display:none;" >
	<div class="infoHeader bg_lg" ><span id="title"  >资料修改</span></div><br>
      <form id="edituser" action=""> 
       <div class="row" id="editInfo" style="color:#FFF; font-size:14px;margin:10px 0 0 15px; ">
       	<div class="control-group">
                    <div class="controls">
                        <div class="main_input_box ">
                            <span class="add-on bg_lg" ><li class="icon-home"></li></span><input type="text" placeholder="请输入邮箱"  value="<s:property value='#session.LOGIN_USER.email'/>"name="email" id="email" onchange="checkemail()"/>
                        </div><br/>
                        <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-phone"></li></span><input type="text" placeholder="请输入电话"value="<s:property value='#session.LOGIN_USER.phone'/>" name="phone" id="phone" onchange=" checkphone()"/>
                        </div><br/>
                        <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-share"></li></span><input type="text" placeholder="请输入QQ号码"value="<s:property value='#session.LOGIN_USER.qq'/>"  name="qq" id="qq" onchange="checkqq()"/>
                        </div><br/>
                        <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-key"></li></span><input type="text" placeholder="请输入安全问题" name="question"value="<s:property value='#session.LOGIN_USER.question'/>" id="question" onchange="" />
                        </div><br/>
                        <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-share"></li></span><input type="text" placeholder="请输入答案" value="<s:property value='#session.LOGIN_USER.answer'/>"name="answer" id="answer" onchange=""/>
                        </div>
                    </div>
                </div>
        <input type="button" class="btn btn-success" style="margin:10px 0 0 0;" value="确定" id="edit"/>
        <input type="reset" class="btn" style="margin:10px 0 0 40px;" id="cancleInfo" value="取消"/><br><br>
        </div>
       </form> 
       
      </div>
   <div id="passEditContent" style="display:none;" >
   	<div class="infoHeader bg_lg"><span id="title">密码修改</span></div><br>
      <form  id="resetpassword" action="" > 
       <div class="row" id="editInfo" style="color:#FFF; font-size:14px;margin:60px 0 0 15px; ">
       	<div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-key"></li></span><input type="password" placeholder="请输入旧密码"  name="oldpassword" id="oldpassword" />
                        </div><br/>
                        <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-key"></li></span><input type="password" placeholder="请输入新密码"  name="newpassword" id="newpassword" onchange="passworda()"/>
                        </div><br/>
                        <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-key"></li></span><input type="password" placeholder="请重复新密码" name="newpassword" id="nwpassword" onchange="newpassworda()"/>
                        </div>
                    </div>
                </div>
      
        <input type="button" class="btn btn-success" style="margin:10px 0 0 0;" value="确定" id="com">
         <input type="reset" class="btn" style="margin:10px 0 0 40px;" id="canclePass" value="取消"/><br><br>
        </div>
         </form> 
       
      </div>

  <div id="fileEditContent2" style="display:none;">
      <div class="infoHeader bg_lg" >上传文献</div>
      <form id="uploadDocform"action="/knowledge/Doc/uploadDoc" method="post" enctype="multipart/form-data"> 
    
       <div class="row" id="filePageOne" style="color:#FFF; font-size:14px;margin:0 0 0 15px; ">
       	<div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-edit"></li></span><input type="text" placeholder="请输入文章标题" name="doc.title"/>
                        </div><br/>
                        <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-user"></li></span><input type="text" placeholder="请输入文章作者"name="doc.author" />
                        </div><br/>
                          <div class="main_input_box">
                       		<input type="hidden" id="fId" value="-1"/>
			                       		 <select id="typeOne" name="doc.typeOne" onchange="t1(this,'typeTwo')" style="width:100px;">
			                       		 	 <option value="-1"> 一级分类  </option>
			                             </select>
			                             <input type="hidden" id="sId" value="-1"/>
			                             <select id="typeTwo" name="doc.typeTwo" onchange="t2(this,'typeThree')" style="width:100px;">
			                             	<option value="-1"> 二级分类  </option>
			                             </select>
                          <input type="hidden" id="tId" value="-1"/><!--设置一个隐藏的input,用于存中间值-->
                             <select id="typeThree"name="typeThree"style="width:100px;" >
									<option value="-1">
                          			     三级分类
                       		 		</option>
							</select>

			                          
                              </div><br/>
                              <div class="main_input_box">
                             <select name="doc.category" style="width:150px;">
                             	<option> 选择类别 </option>
                                <option > 外文期刊 </option>
                                <option > OA论文 </option>
                                <option > 期刊论文 </option>
                                <option > 学位论文 </option>
                                <option > 会议论文 </option>
                             </select>
                             <select name="doc.language" style="width:150px;">
                             	<option> 选择语言 </option>
                                <option value="1"> 中文  </option>
                                <option value="0"> 英文  </option>
                             </select>
                        </div><br>
                        
                             <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-book"></li></span><input type="text" placeholder="请输入期刊（可选）" name="doc.journal"/>
                        </div>
                        
                    </div>
                    
                </div><br/>
               		 <input type="button" name="nextFilePage" id="nextFilePage" class="btn btn-success"  value="下一页"/>
       				<input type="reset" class="btn" id="cancleFile" style="margin:0 0 0 40px;" value="取消"/>	
        </div>
         <div class="row" id="filePageTwo" style="color:#FFF; font-size:14px;margin:0 0 0 15px; display:none">
       		<div class="control-group">
                    <div class="controls">
                    <div class="main_input_box">
                 <%--    
                     <textarea id=" brief " placeholder="请输入文章摘要 " name="doc.brief" cols="20" rows="2" class="ckeditor"></textarea>
                                       <script type="text/javascript"> 
                                               CKEDITOR.replace(' brief ');
                                       </script> --%>
                            <textarea  placeholder="请输入文章摘要 "  style="width:300px; height:100px;resize: none;" name="doc.brief"></textarea> 
                           
                         <!--  <input type="button" id="btn" onclick="checkKeyword(),checkContent(),check()" value="提交"/>
			              <input type="reset"/> -->
                        </div><br/>
                    	 <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-time"></li></span><input style="width:45%" type="date"onblur="checkpublishtime()" placeholder="请输入出版（发表）时间:年，卷（期）"name="doc.publishedTime" id="publishtimeType" />
									
                        </div><br/>
                         <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-file"></li></span><input type="text" id="txt" style="width:195px;">	<span class="add-on bg_ic" onclick="f.click()"><a style="color:#2E363F;" href="javascript:void(0);">浏览</a></span>
                
                       		<br><input type="file" id="f" onchange="txt.value=this.value;isvalidatefile('file','f')" name="uploadFile" class="files" onblur="checkType('file')" />
                       		<!--  <input type="button" class="btn btn-success" style="width:300px;margin:;" id="testbutton"value="检测文件类型" onclick="isvalidatefile('file','f')"/>  -->
                         <!--     <font color="red" id="kw"></font><input type="hidden" id="kt" value="false"> -->
                        </div>
                        <br/>
                
        			<input type="submit" class="btn btn-success"  value="确定"   >
        			<input type="button" class="btn" style="margin:0 0 0 40px;" id="lastFilePage" value="上一页"/>
        			<input type="reset" class="btn" id="cancleFile" style="margin:0 0 0 80px;" value="取消"/>	
                    </div>
             </div>
             
          </div> 
         </form> 
      </div>
      
  <div id="fileEditContent1" style="display:none;" >
	<div class="infoHeader bg_lg">上传文档</div><br>
         <form id="uploadDocDocupload"  action="/knowledge/Doc/uploadDocDoc" method="post" enctype="multipart/form-data">
          <div class="row" id="filePageDoc" style="color:#FFF; font-size:14px;margin:0 0 0 15px">
       		<div class="control-group">
                    <div class="controls">
                            <div class="main_input_box">
                            <span class="add-on bg_lg" ><li class="icon-edit"></li></span><input type="text" placeholder="请输入文档标题" name="doc.title"/>
                        </div><br/>
                    	 <div class="main_input_box">
                             <select name="category" style="width:150px;" id="Category">
                                <option > 其他 </option>
                                <option > 分类文档 </option>
                             </select>
                             <select name="doc.language" style="width:150px;">
                             	<option> 选择语言 </option>
                                <option value="1"> 中文  </option>
                                <option value="0"> 英文  </option>
                             </select>
                        </div><br>
                         <div class="main_input_box" id="docType" style="display: none" >
                       		<input type="hidden" id="fIdDoc" value="-1"/>
			                       		 <select id="typeOneDoc" name="doc.typeOne" onchange="t1(this,'typeTwoDoc')" style="width:100px;">
			                       		 	 <option value="-1"> 一级分类  </option>
			                             </select>
			                             <input type="hidden" id="sIdDoc" value="-1"/>
			                             <select id="typeTwoDoc" name="doc.typeTwo" onchange="t2(this,'typeThreeDoc')" style="width:100px;">
			                             	<option value="-1"> 二级分类  </option>
			                             </select>
                          <input type="hidden" id="tIdDoc" value="-1"/><!--设置一个隐藏的input,用于存中间值-->
                             <select id="typeThreeDoc"name="typeThree"style="width:100px;" >
									<option value="-1">
                          			     三级分类
                       		 		</option>
							</select>

                              </div><br/> 
                              <div class="main_input_box">
                              
                            <span class="add-on bg_lg" ><li class="icon-file"></li></span> <input type="text" id="txt" style="width:195px;">	
                            <span class="add-on bg_ic"<%--  onclick="f1.click() --%>><a onclick="f1.click()" style="color:#2E363F;" href="javascript:void(0);">浏览</a></span>

                
                       		<br><input type="file" id="f1" onchange="txt.value=this.value;isvalidatefile('file','f1')" name="uploadFile" class="files" onblur="checkType('file')" />
                       	<!--  <input type="button" class="btn btn-success" style="width:300px;margin:;" id="testbutton"value="检测文件类型" onclick="isvalidatefile('file','f')"/>   -->
                         <!--     <font color="red" id="kw"></font><input type="hidden" id="kt" value="false"> -->
                        </div>
                        <br/>
                
        			<input type="submit" class="btn btn-success"  value="确定"   >
        			<input type="reset" class="btn" id="cancleFile1" style="margin:0 0 0 80px;" value="取消"/>	
             </div>
              <center><span style="color:#FFF" id="passTips"></span></center>
          </div> 
          </div>
         </form>
       
      </div>
</div>
                      
<!--infoEdit End-->
<div id="NoticeShow" style="display:none;" >
<div class="infoHeader bg_lg" align="center"><span id="title">公告内容</span></div><br>
       <div class="row" id="noticeContent" style="color:#FFF; font-size:14px;margin:10px 10px 0 10px; word-break:break-all ">
    	
       </div>
       <!-- <center input type="button" class="btn btn-success" style="margin-top:330px;" value="关闭" id="noticeClose"/></center> -->
        <center><a class="btn btn-success" style="margin-top:280px"; position:absolute; id="noticeClose">关闭</a></center> 
</div>
<!--breadcrumbs-->

<!--End-breadcrumbs--> 
<div class="loadimg" align="center" ><img src="<%=basePath%>images/loading.gif" /></div>
    <div class="row-fluid" style="margin-left:20px; width:97%;" >
        <div class="widget-box" >
          <div class="widget-title">
            <ul class="nav nav-tabs">
              <li class="active"><a data-toggle="tab" id="upload" href="#tab1">我的上传</a></li>
              <li><a data-toggle="tab" id="download" href="#tab2">我的下载</a></li>
              <li><a data-toggle="tab" id="favo" href="#tab3">我的收藏</a></li>
              <li><a data-toggle="tab" id="notice" href="#tab4">公告查询</a></li>
            </ul>
          </div>
          <div class="widget-content tab-content">
            <div id="tab1" class="tab-pane active">
               <div class="widget-box">
         <%--  <div class="widget-title"> <span class="icon">
            <input type="checkbox" id="title-checkbox-upload" name="title-checkbox" />
            </span>
            <a class="btn  btn-small" style="margin:3px 0 0 3px;" id="delUploadChecked" data-vl='Doc'>删除选中</a>
          </div> --%>
          <div class="widget-content nopadding">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
                  <th><i class="icon-resize-vertical"></i></th>
                  <th>序号</th>
                  <th>上传时间</th>
                  <th>标题</th>
                  <th>作者</th>
                  <th>文件类型</th>
                  <th>审核情况</th>
                  <th>操作</th>
                </tr>
              </thead>
              <input id="nowPageNo" value="" style="display:none"/>
               <input id="totalPageNo" value="" style="display:none"/>
              <tbody id="uploadR" >

              </tbody>
            </table>
          </div>
         <div id="upPageBar">
          
         </div>
        </div>
              
              </div>
            <div id="tab2" class="tab-pane">
            <div class="widget-box">
          <div class="widget-title"> <span class="icon">
            <input type="checkbox" id="title-checkbox-download" name="title-checkbox" />
            </span>
            <a class="btn  btn-small " style="margin:3px 0 0 3px; " id="delDownloadChecked" data-vl='DownloadRecoder'>删除选中</a>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered table-striped with-check" id="UPRECODER">
              <thead>
                <tr>
                  <th><i class="icon-resize-vertical"></i></th>
                  <th>序号</th>
                  <th>下载时间</th>
                  <th>标题</th>
                  <th>作者</th>
                  <th>文件类型</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody id="downloadR">
             
              </tbody>
            </table>
          </div>
         <div id="downPageBar">
         
          </div>

        </div>
            </div>
             
            <div id="tab3" class="tab-pane">
               <div class="widget-box">
          <div class="widget-title"> <span class="icon">
            <input type="checkbox" id="title-checkbox-myfavorite" name="title-checkbox" />
            </span>
            <a class="btn  btn-small " style="margin:3px 0 0 3px; " id="delFavoritesChecked" data-vl='Favorites'>删除选中</a>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered table-striped with-check" id="UPRECODER">
              <thead>
                <tr>
                  <th><i class="icon-resize-vertical"></i></th>
                  <th>序号</th>                  
                  <th>标题</th>
                  <th>作者</th>
                  <th>文件类型</th>
                  <th>操作</th>
                </tr> 
              </thead>
              <tbody id="myfavoritesR">
             
              </tbody>
            </table>
          </div>
          <div id="myfavoritesBar">
         
          </div> 

        </div> 
              </div>
             <div id="tab4" class="tab-pane">
             <div class="widget-box">
          <div class="widget-title"> <span class="icon">
          <i class="icon-time"></i>
            </span>
            <h5>历史公告信息</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
                  <th><i class="icon-resize-vertical"></i></th>
                  <th>序号</th>
                  <th>时间</th>
                  <th>标题</th>                                   
                </tr>
              </thead>
              <tbody  id="noticeR">
                
              </tbody>
            </table>
            <div id="noticeBar" >
            </div>
          </div>
        
        </div>
        </div> </div> </div>                             
<%-- <input type="hide"id="pword"value="<s:property value='#session.LOGIN_USER.password'/>" --%>
<!--end-main-container-part-->

<!--Footer-part-->

<div class="row-fluid">
  <div id="footer" class="span12"> 2013 &copy; 硬件安全研究所
  </div>
</div>


<!--end-Footer-part-->

 <script src="<%=basePath%>js/jquery.min.js"></script> 
 <script src="<%=basePath%>js/pagescript/knowledge.alert.js"></script> 
<script src="<%=basePath%>js/bootstrap.min.js"></script> 
<script src="<%=basePath%>js/jquery.uniform.js"></script> 
<script src="<%=basePath%>js/select2.min.js"></script> 
<script src="<%=basePath%>js/jquery.dataTables.min.js"></script> 
<script src="<%=basePath%>js/knowledge.tables.js"></script> 
<script src="<%=basePath%>js/pagescript/personal.center.js"></script> 
<script src="<%=basePath%>js/jquery.tablesorter.min.js"></script>  
<script src="<%=basePath%>js/pagescript/search.js"></script> 

 
<script type="text/javascript">
	
$("#UPRECODER").tablesorter();
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
   
 $("#com").click(function(){
		var passwordData = $("#resetpassword").serialize();
		var url = "/knowledge/User/UserAction/resetpassword "; 
		
		/* if($("#oldpassword").val() == pw)
		{
			if($("#oldpassword").val().length < 6)
				alertTip("密码长度小于6位，请重新输入。");
			else */
		     if($("#newpassword").val()==$("#nwpassword").val())
		      {$.post(url,passwordData,function(umsg)
				   {
					if(umsg == "true")
					  {
						//alertTip("密码重置成功，正在自动跳转至登录页面。。。");	
						location.href='/knowledge/User/respassword';
					   }
					else
						alertTip("密码错误，重置密码失败。");
					});
				
						
						
			
		
	       
			
  }
		   else
	             alertTip("两次输入不相同。");
  
  }
 );
  
  /* function old()
  {
	  var pw=$("#pword").val();
		if($("#oldpassword").val() != pw)
		{
			
				alertTip("密码错误，请重新输入。");
		}
		
  } */
  function passworda()
  {
	  
		if($("#newpassword").val().length <6)
		{
			
				alertTip("密码长度小于6位，请重新输入");
		}
		
  }
  function newpassworda()	
{
	    var nwpassword=$("#nwpassword").val();
	    if(nwpassword.length<6)
	    	alertTip("密码长度小于6位，请重新输入。");
	    
}
 
  
  
    $("#edit").click(function(){
         	 var userInfal=$("#edituser").serialize();
         	var url="/knowledge/User/UserAction/updateUser"; 
         	$.post(url,userInfal,function(msg){
         		if(msg=="true")
         			{

         			  location.href='/knowledge/User/UserAction/getAllInfo';

         			}
         		else
         			alertTip("安全问题或安全答案错误，信息修改失败");
         		});
 } ); 
    
     function checkemail()
    {
    	var reg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/; 
    	if(reg.test($("#email").val()))
    		{alertTip("Your email address is correct");
    		return true;
    		
    		}
    	else
    		alertTip("Please try again");
    	return false;
    } 
   
     function checkphone()
    {
    	var reg=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
    	if(reg.test($("#phone").val()))
    		{
    		alertTip("手机号码有效");
    		}
    	else
    		alertTip("无效的手机号请重新输入");
    	return false;
    }
   
     function checkqq()
    {
    	var reg=/^[0-9]{1,20}$/;
    	if(reg.test($("#qq").val()))
    		{
    		alertTip("qq号码有效");
    		}
    	else
    		alertTip("qq号无效，请重新输入");
    	return false;
    	
    }
/*      $("#uploadcom").click(function()
    	{
    	 var Infal=$("#uploadDocform").serialize();
      	var url="/knowledge/Doc/DocAction/uploadDoc"; 
      	$.post(url,Infal,function(msg){
      		if(msg=="true")
      			{

      			  location.href='/knowledge/User/UserAction/getAllInfo';

      			}
      		else
      			alertTip("上传失败");
      		});
    	
    	 
    	
    	
    	}); */
    	function checkpublishtime()
    	{  
    		var reg=/^(1|2)\d{3}\,[1-9]{1}\d{1,2}\([1-9]{1}\d{1,2}\)$/;
    		
    		if(reg.test($("publishtimeType")).val)
    			{
    			 alert("出版时间格式符合");
    			
    			}
    		else 
    			alert("出版时间格式不符，请重新输入");
    			return false;
    	
    	}
    	
     $("#fileEdit1").click(function(){
			$("#infoEdit").removeAttr("style");
			$("#mask").slideDown("fast");
		  $("#fileEditContent1").removeAttr('style');
		  $.ajax({
	 		 type:'GET',
	 		 dataType:'json',
	 		 url:'/knowledge/Type/TypeAction/lista',
	 		 success:function(jsonData){
	 			//document.getElementById("typeOne").options.add(new Option("asd",11));
	 			  var data = eval(jsonData);
	 			  $.each(data,function(i,n){
	 				  document.getElementById("typeOne").options.add(new Option(data[i].name,data[i].id));
	 				  document.getElementById("typeOneDoc").options.add(new Option(data[i].name,data[i].id));
	 			 });
	 		 },
	 		 error:function(){
	 			 alert("err");
	 		 } 
		  });
	  });
$("#fileEdit2").click(function(){
$("#infoEdit").removeAttr("style");
$("#filePageOne").removeAttr('style');
$("#mask").slideDown("fast");
$("#fileEditContent2").removeAttr('style');
$.ajax({
	 type:'GET',
	 dataType:'json',
	 url:'/knowledge/Type/TypeAction/lista',
	 success:function(jsonData){
		//document.getElementById("typeOne").options.add(new Option("asd",11));
		  var data = eval(jsonData);
		  $.each(data,function(i,n){
			  document.getElementById("typeOne").options.add(new Option(data[i].name,data[i].id));
			  document.getElementById("typeOneDoc").options.add(new Option(data[i].name,data[i].id));
		 });
	 },
	 error:function(){
		 alert("err");
	 } 
});
});

$("#nextFilePage").click(function(){
	$("#filePageOne").slideUp('slow',function(){
		$("#filePageTwo").slideDown('slow');
		});
	});
function isvalidatefile(obj,fileId){
	  
	  var fileType=$("#"+fileId).val();
	  var pos=fileType.lastIndexOf(".");
	  var lastname=fileType.substring(pos,fileType.length);
	  if(!(lastname.toLowerCase()==".doc"||lastname.toLowerCase()==".pdf"||lastname.toLowerCase()==".docx"||lastname.toLowerCase()==".ppt"||lastname.toLowerCase()==".xls")
			||lastname.toLowerCase()==".pptx" ||lastname.toLowerCase()==".xlsx" ||lastname.toLowerCase()==".zip")
		{
		  alertTip("您上传的文件类型为"+lastname+"文件类型不符");
		  return false;
		}
	  else{ 
		  alertTip("文件类型符合，可以上传");
	  }
	    return true;
	  }

function t1(obj,TypeTw){
var parentid = obj.value;//获取所选的一级类别的id
if(parentid!=-1){//如果id==-1，说明没选任何类别
	 document.getElementById("fId").value=parentid;//在隐藏的input中存id
	 document.getElementById("fIdDoc").value=parentid;
	 var typeTwo = document.getElementById(TypeTw);
	 	typeTwo.length = 1;//分类二下拉菜单置一
	 $.ajax({
		 type:'GET',
		 dataType:'json',
		 url:'/knowledge/Type/TypeAction/listaByParentId?parentid='+parentid,//parentid=父类的id
		 success:function(jsonData){
			 var data = eval(jsonData);
			 /* if(data == ""){
  			 $('#'+TypeTw).empty();
				 typeTwo.options.add(new Option("没有分类","1"));
				 $('option').click();
			 }
			 else */
			  $.each(data,function(i,n){
				 typeTwo.options.add(new Option(data[i].name,data[i].id));
				 //document.getElementById("typeTwoDoc").options.add(new Option(data[i].name,data[i].id));
			 }); 
		 },
		 error:function(){
			 alert("error");
		 } 
	 });
	 }else{
		 var typeTwo = document.getElementById(TypeTw);
  	 typeTwo.length = 1;
	 }
}
function t2(obj,TypeTh){
var parentwoid = obj.value;
if(parentwoid!=-1){
	 document.getElementById("sId").value=parentwoid;//在隐藏的input中存id
	 document.getElementById("sIdDoc").value=parentwoid;
	 var typeThree=document.getElementById(TypeTh);
	 typeThree.length=1;
	 $.ajax({
		 type:'GET',
		 dataType:'json',
		 url:'/knowledge/Type/TypeAction/listaaByParentId?parentid='+parentwoid,
				 success:function(jsonData){
					 var data=eval(jsonData);
					 $.each(data,function(i,n)
							 {
						typeThree.options.add(new Option(data[i].name));
							 });
				 },
				 error:function(){
					 alert("error");
				 }
		
	 });
}
else{
	 var typeTwo = document.getElementById(TypeTw);
	 typeTwo.length = 1;
}
}
$("#nextFilePage").click(function(){
	$("#filePageOne").slideUp('slow',function(){
		$("#filePageTwo").slideDown('slow');
		});
	});
$("#lastFilePage").click(function(){
	$("#filePageTwo").slideUp('slow',function(){
		$("#filePageOne").slideDown('slow');
		});
	});
//上传文档是否分类
$('#Category').change(function(){
	var category = $("#Category option:selected").text().trim();
	if(category == "分类文档")
		$('#docType').removeAttr('style');
	else $('#docType').attr('style','display:none');
});

$("#cancleInfo,#canclePass,#cancleFile").click(function(){
	$("#mask").slideUp("slow");
	$("#infoEdit").attr('style','display:none');
	$(this).parent().parent().parent().attr('style','display:none');
	$("#fileEditContent2").attr('style','display:none');
	});
$("#cancleFile1").click(function(){
	$("#mask").slideUp("slow");
	$("#infoEdit").attr('style','display:none');
	$("#fileEditContent1").attr('style','display:none');
});
   
</script>
</body>
</html>
