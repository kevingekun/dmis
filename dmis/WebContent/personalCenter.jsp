<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath %>">
<!DOCTYPE html>
<html lang="en">
<head>
<title>Matrix Admin</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/bg/bootstrap.min.css" />
<link rel="stylesheet" href="css/bg/matrix-style.css" />
<link rel="stylesheet" href="css/bg/yetou.css" />
</head>
<body>
 <div id="content">
  <div id="content-header">
   <div class="container-fluid">
    
    <h1>个人中心</h1>
	<hr></hr>
  </div>
  
   <div class="widget-box">
          <div class="widget-title">
            <ul class="nav nav-tabs">
              <li class="active"><a data-toggle="tab" href="#tab1">已上传文档</a></li>
              <li><a data-toggle="tab" href="#tab2">已下载文档</a></li>
              <li><a data-toggle="tab" href="#tab3">我的收藏</a></li>
			  <li><a data-toggle="tab" href="#tab4">信息编辑</a></li>
            </ul>
          </div>
          <div class="widget-content tab-content">
            <div id="tab1" class="tab-pane active">
			
         
    
<div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>已上传文档总数：xx份</h5>
            </div>
          <div class="widget-content ">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
                  <th><input type="checkbox" id="title-table-checkbox" name="title-table-checkbox" /></th>
                  <th>标题</th>
                  <th>作者</th>
                  <th>文件类型</th>
                  <th>上传人</th>
				  <th>下载时间</th>
				  <th>删除</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><input type="checkbox" /></td>
                  <td>AES算法经典</td>
                  <td>Rudolf Usselmann</td>
                  <td>pdf</td>
                  <td class="center"> xxx</td>
				  <td class="center"> xxx</td>
				  <td class="center"> xxx</td>
                </tr>
                <tr>
                  <td><input type="checkbox" /></td>
                  <td>Trident</td>
                  <td>Internet
                    Explorer 5.0</td>
                  <td>Win 95+</td>
                  <td class="center">5</td>
				  <td class="center"> xxx</td>
				  <td class="center"> xxx</td>
                </tr>
                <tr>
                  <td><input type="checkbox" /></td>
                  <td>Trident</td>
                  <td>Internet
                    Explorer 4.0</td>
                  <td>Win 95+</td>
                  <td class="center"> 4</td>
				  <td class="center"> xxx</td>
				  <td class="center"> xxx</td>
                </tr>
                <tr>
                  <td><input type="checkbox" /></td>
                  <td>Trident</td>
                  <td>Internet
                    Explorer 5.0</td>
                  <td>Win 95+</td>
                  <td class="center">5</td>
				  <td class="center"> xxx</td>
				  <td class="center"> xxx</td>
                </tr>
                <tr>
                  <td><input type="checkbox" /></td>
                  <td>Trident</td>
                  <td>Internet
                    Explorer 5.5</td>
                  <td>Win 95+</td>
                  <td class="center">5.5</td>
				  <td class="center"> xxx</td>
				  <td class="center"> xxx</td>
                </tr>
                <tr>
                  <td><input type="checkbox" /></td>
                  <td>Trident</td>
                  <td>Internet
                    Explorer 6</td>
                  <td>Win 98+</td>
                  <td class="center">6</td>
				  <td class="center"> xxx</td>
				  <td class="center"> xxx</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
            <div id="tab2" class="tab-pane"> 
             <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>已下载文档总数：xx份</h5>
            </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th></th>
                  <th>标题</th>
                  <th>作者</th>
                  <th>文件类型</th>
				  <th>上传人</th>
				  <th>下载时间</th>
				  <th>删除</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>1</td>
                  <td>AES算法经典</td>
                  <td>Rudolf Usselmann</td>
                  <td>pdf</td>
                  <td class="center"> xxx</td>
				  <td class="center"> xxx</td>
				  <td class="center"> xxx</td>
                </tr>
                <tr>
                  <td>2</td>
                  <td>john</td>
                  <td>deo</td>
                  <td>@john</td>
				  <td></td>
				  <td></td>
				  <td></td>
				 
                </tr>
                <tr>
                  <td>3</td>
                  <td >collspan text</td>
                  <td>@twitter</td>
				  <td></td>
				  <td></td>
				  <td></td>
				  <td></td>
				  
                </tr>
              </tbody>
            </table>
          </div>
        </div>
            <div id="tab3" class="tab-pane">
                <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>已收藏文档总数：xx份</h5>
            </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th></th>
                  <th>标题</th>
                  <th>作者</th>
                  <th>文件类型</th>
				  <th>上传人</th>
				  <th>下载时间</th>
				  <th>删除</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>1</td>
                  <td>AES算法经典</td>
                  <td>Rudolf Usselmann</td>
                  <td>pdf</td>
                  <td class="center"> xxx</td>
				  <td class="center"> xxx</td>
				  <td class="center"> xxx</td>
                </tr>
                <tr>
                  <td>2</td>
                  <td>john</td>
                  <td>deo</td>
                  <td>@john</td>
				  <td></td>
				  <td></td>
				  <td></td>
				 
                </tr>
                <tr>
                  <td>3</td>
                  <td >collspan text</td>
                  <td>@twitter</td>
				  <td></td>
				  <td></td>
				  <td></td>
				  <td></td>
				  
                </tr>
              </tbody>
            </table>
          </div>
        </div>
			    <div id="tab4" class="tab-pane">
<form>
<center>
 <p>姓名:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input  type="text" name="username"></p>
 <p>性别:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<select name="sex">
<option value="male">男</option>
<option value="female">女</option>
</select></p>
 <p>联系方式:<input  type="text" name="Tel"></p>           
 <p>&nbsp&nbspQQ:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input  type="text" name="Tel"></p>  			  
 <p>家乡:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<select name="sex"></select></p>
 <p><input type="submit"  value="提交"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  <input type="reset" value="重置"/></p>		  
			  </div>
          </div>
        </div>
		</div>
		</div>
		</div>

<script src="js/jquery.min.js"></script> 
 
<script src="js/bootstrap.min.js"></script> 
 
</body>
</html>
