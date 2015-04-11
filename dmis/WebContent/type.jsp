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
<link href="css/bg/yetou.css" rel="stylesheet" type="text/css" />
<link href="css/dmis.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/matrix-style.css" />
<link rel="stylesheet" href="css/matrix-media.css" />
<link rel="stylesheet" href="css/uniform.css" />
<link rel="stylesheet" href="css/select2.css" />
<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href="css/matrix-style.css" rel="stylesheet" type="text/css" />

<script src="js/jquery.min.js" type="text/javascript"></script>
</head>
<body id="table1">
<input type="text" id="checkRadio" value="${state}" style='display:none'/>
<div class="mask" style="display:none"></div>
<div class="widget-box">
          <div class="widget-title">
            <h5>类型管理</h5>
            <a class="btn  btn-small " style="margin:5px 0 0 3px; " onClick="dele();">删除选中</a>
            <div class="widget-radio">

				<input id="addType" class="btn btn-small" type="button"
					value="新增类别" style="margin-bottom: 5px;">
				<input type="radio" name="state" id="all"  onClick="allType();"/>全部
				<input type="radio" name="state" id="one_level"   onClick="one_type();"/>一级类
				<input type="radio" name="state" id="two_level"  onClick="two_type();"/>二级类
				<input type="radio" name="state" id="three_level"   onClick="three_type();"/>三级类
			</div>
		   </div>
		   <div id="infoEdit" style="display: none" align="center">
			<div id="passEditContent" style="display: none;">
				<div class="infoHeader bg_lg">
					<span id="title">类别添加</span>
				</div>
				<br>
				<div style="height: 200px">
					<form id="type" name="type" method="post" action="">
						<div class="row" id="editInfo"
							style="color: #FFF; font-size: 14px; margin: 60px 0 0 15px;">
							<div class="control-group" style="height: 100px">
								<div class="controls" style="height: 150px">
									<div class="main_input_box">
										<div style="width:250px;margin-left:88px;padding-bottom:20px">
										<input type="hidden" id="fId" value="-1"/>
			                       		 <select id="typeOne" name="typeOne" onchange="t1(this)" style="width:120px;">
			                       		 	 <option value="-1"> 一级分类  </option>
				                       		 <s:iterator value="#request.firstType" >   <!--遍历后台firstType  -->
				                                <option value=<s:property value="id"/>><s:property value="name"/> </option>
				                             </s:iterator>
			                             </select>
			                             <input type="hidden" id="sId" value="-1"/><!--设置一个隐藏的input,用于存中间值-->
			                             <select id="typeTwo" name="typeTwo" onchange="t2(this)" style="width:120px;">
			                             	<option value="-1"> 二级分类  </option>
			                             </select>
			                             <script type="text/javascript">
			                             function t1(obj){
			                            	 var parentid = obj.value;    //获取所选类别的id
			                            	 if(parentid!=-1){			//如果id==-1，说明没选任何类别
			                            		 document.getElementById("fId").value=parentid;		//在隐藏的input中存id
			                            		 document.getElementById("typ").placeholder="添加二级分类";
				                            	 var typeTwo = document.getElementById("typeTwo");
				                            	 typeTwo.length = 1;		//分类二下拉菜单置空
				                            	 $.ajax({
				                            		 type:'GET',
				                            		 dataType:'json',
				                            		 url:'Type/listaByParentId?parentid='+parentid,
				                            		 success:function(jsonData){
				                            			 var data = eval(jsonData);
				                            			  $.each(data,function(i,n){
				                            				  document.getElementById("typeTwo").options.add(new Option(data[i].name,data[i].id));
				                            			 }); 
				                            		 },
				                            		 error:function(){
				                            			 alert("err");
				                            		 } 
				                            	 });
				                            	 }else{
				                            		 document.getElementById("fId").value="-1";
				                            		 document.getElementById("typ").placeholder="添加一级分类";
				                            		 var typeTwo = document.getElementById("typeTwo");
					                            	 typeTwo.length = 1;
				                            	 }
			                             }
			                             function t2(obj){
			                            	 var id = obj.value;
			                            	 if(id!=-1){
			                            		 document.getElementById("sId").value=id;
			                            		 document.getElementById("typ").placeholder="添加三级分类";
			                            	 }else{
			                            		 document.getElementById("sId").value="-1";
			                            	 }
			                            	
			                             } 
			                             </script>
			                             </div>
                              		</div>
									<div style="height: 50px; float: left">
										<div class="main_input_box"
											style="float: left; margin-left: 90px; margin-top: 0px; height: 31px">
											<span class="add-on bg_lg" style="float:left"><li class="icon-key"></li></span>
											<input id="typ" name="typ" type="text"
												placeholder="添加一级分类" onblur="checkType()"/> 
												<font color="red" id="umsg"></font>
												<input type="hidden" id="typecheck" value="false">
										</div>
										<div style="font-size: 8px; float: left; margin-left: 90px">
											<a style="color: #28b779; margin-left: 55px">默认为一级分类!</a>
										</div>
									</div>
									<br />
									
								</div>
							</div>
							<div style="height: 30px;">
								<div style="width: 160px; margin-left: -70px">
									<input type="button" class="btn btn-success" style="margin: 0px 0 0 0;"
										id="btn" value="确定" onclick="checkType(),check()"/> 
									<input type="reset" id="close" class="btn" style="margin: 0px 0 0 40px;"value="取消"/><br>
									<br>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		
		      
		      
		 
          <div class="widget-content ">
           <s:form name="form2" id="form2" method="post">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
                  <th style="width:20px;"><input type="checkbox" id="selAll" style="margin-bottom:4px" onclick="selectAll();"/><input type="hidden" id="checkselect" value="false" /></th>
                  <th style="width:30px;">编号</th>
                  <th style="width:280px;">类型名</th>
                  <th style="width:200px;">类型级别</th>
                  <th style="width:100px;">父类型编号</th>
                  <th style="width:150px;">操作</th>

                </tr>
              </thead>
              <tbody>
              
               <s:iterator value="#request.page.pageList" >
                <tr>
                  <td><input type="checkbox" style="margin-left:8px" name="checkAll" id="checkAll" value="<s:property value="id"/>"  onClick="setSelectAll();" /></td>
                  <td><s:property value="id"/></td>
                  <td><s:property value="name"/></td>
                  <td><s:property value="level"/></td>
                  <td><s:property value="parentId"/></td>
                  	<td><a class="btn btn-mini" href="Type/delete.action?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>">删除</a>
                  </td>                  
                </tr>
                </s:iterator>
              </tbody>
            </table>
            </s:form>
           
            <div id="upPageBar">
            <div class="pagination alternate" style="float:left;margin-top:30px;margin-left:-15px">
				              <ul>
				              	<s:if test="#request.page.showPrv != 0">
					              	<li class id="firstPage" data-id="PAGE"><a href="Type/list?pageNo=1&state=${state}">首页</a></li>
					                <li class id="lastPage" data-id="PAGE"><a href="Type/list?pageNo=<s:property value="#request.page.pageNo -1"/>&state=${state}">上一页</a></li>
					            </s:if>
					            <s:else>
					            	<li class="disabled" id="firstPage" data-id="PAGE"><a href="javascript:void(0);">首页</a></li>
					                <li class="disabled" id="lastPage" data-id="PAGE"><a href="javascript:void(0);">上一页</a></li>
					            </s:else>
					            	<s:iterator value="#request.page.pageNum" id="key">
						            	<s:if test="#key != #request.page.pageNo">
						            		<li data-vl="1" data-id="PAGE" id="pageNo"><a href="Type/list?pageNo=<s:property value="key"/>&state=${state}"><s:property value="key"/></a></li>	
						            	</s:if>
						            	<s:else>
						            		<li data-vl="1" data-id="PAGE" id="pageNo" class="active"> <a href="javascript:void(0);"><s:property value="key"/></a> </li>
						            		<input type="hidden" id="dqPageNo" value="<s:property value="key"/>"></input>
						            	</s:else>
					           		</s:iterator>
				                <s:if test="#request.page.showNext != 0">
				               		<li class id="nextPage" data-id="PAGE"><a href="Type/list?pageNo=<s:property value="#request.page.pageNo +1"/>&state=${state}" >下一页</a></li>
				               		<li class id="endPage" data-id="PAGE"><a href="Type/list?pageNo=<s:property value="#request.page.totalPage"/>&state=${state}">尾页</a></li>
				                </s:if>
				                <s:else>
				                	<li class="disabled" id="nextPage" data-id="PAGE"><a href="javascript:void(0);">下一页</a></li>
					                <li class="disabled" id="endPage" data-id="PAGE"><a href="javascript:void(0);">尾页</a></li>
				                </s:else>
				                <li class="disabled"><a href="javascript:void(0);">共<s:property value="#request.page.totalPage"/>页</a></li>
				              </ul>
				       </div>
				  </div>
          </div>
        </div>

<script type="text/javascript">
$(function() {
	$("#addType").click(function() {
		$("#infoEdit").removeAttr("style");
		/* $(".mask").slideDown("slow"); */
		if (this.id == 'addType') {
			$("#passEditContent").removeAttr('style');
		}
	});
	$("#close").click(function() {
		/* $(".mask").slideUp("slow"); */
		$("#infoEdit").attr('style', 'display:none');
		
	});
});
$(function(){
	var state = $('#checkRadio').val();
	if(state == 0)
		$('#all').attr("checked","checked");
	if(state == 1)
		$('#one_level').attr("checked","checked");
	if(state == 2)
		$('#two_level').attr("checked","checked");
	if(state == 3)
		$('#three_level').attr("checked","checked");
});
function change(radio_oj,aValue){    //传入一个对象
   for(var i=0;i<radio_oj.length;i++) //循环
   {
   if(radio_oj[i].value==aValue) //比较值
     {
radio_oj[i].checked=true; //修改选中状态
   break; //停止循环
   }
}
}

function dele(){
	var checkselect = $("#checkselect").val();
	if(checkselect == "true"){
		var pageNo = $("#dqPageNo").val();
		form2.action="Type/delete_check?pageNo="+pageNo;
		document.getElementById("form2").submit();
	}else{
		alert("请选中需要删除的数据！");
	}
}
function allType(){
	location.href="Type/list?state=0";
}
function one_type(){
	location.href="Type/list?state=1";
}
function two_type(){
	location.href="Type/list?state=2";
}
function three_type(){
	location.href="Type/list?state=3";
}
/*  $(function(){
		$("#addWord").click(function(){
			
			if(this.id == 'addWord')
			{
			$("#infoEdit").removeAttr("style");
			$(".mask").slideDown("slow");
				$("#addWordContent").removeAttr('style');
			}
			});
		$("#close").click(function(){
		$(".mask").slideUp("slow");
		$("#infoEdit").attr('style','display:none');
		var typeTwo = document.getElementById("typeTwo");
   	 	typeTwo.length = 1;		//分类二下拉菜单置空
	})
	}) */
var selAll = document.getElementById("selAll"); 
function selectAll() 
{ 
  var obj = document.getElementsByName("checkAll"); 
  if(document.getElementById("selAll").checked == false) 
  { 
  for(var i=0; i<obj.length; i++) 
  { 
    obj[i].checked=false; 
  } 
  }else 
  { 
  for(var i=0; i<obj.length; i++) 
  {	  
    obj[i].checked=true; 
  }	
  } 
  
} 

//当选中所有的时候，全选按钮会勾上 
function setSelectAll() 
{ 
var obj=document.getElementsByName("checkAll"); 
var count = obj.length; 
var selectCount = 0; 

for(var i = 0; i < count; i++) 
{ 
	if(obj[i].checked == true){ 
		selectCount++;	
	} 
} 
	if(selectCount>0){
		document.getElementById("checkselect").value="true";
	}else{
		document.getElementById("checkselect").value="false";
	}
	if(count == selectCount) {	
		document.all.selAll.checked = true; 
	}else{ 
		document.all.selAll.checked = false; 
	} 
} 
//反选按钮 
function inverse() { 
var checkboxs=document.getElementsByName("checkAll"); 
for (var i=0;i<checkboxs.length;i++) { 
  var e=checkboxs[i]; 
  e.checked=!e.checked; 
  setSelectAll(); 
} 
} 
function checkType(){
	var typ = $("#typ").val();
	var regex = /^[\u4E00-\u9FA5A-Za-z0-9_]+$/;
	 if(regex.test(typ)==false){
		document.getElementById("umsg").color="red";
		document.getElementById("umsg").innerHTML="输入有误!";
		document.getElementById("typecheck").value="false";
	}else{
		document.getElementById("umsg").color="green";
		document.getElementById("umsg").innerHTML="可用";
		document.getElementById("typecheck").value="true";
	}
}
function check(){
	var tp = $("#typecheck").val();		
    var fid = $("#fId").val();			//获取id为fId域的value
	var sid = $("#sId").val();
	var typeName = $("#typ").val();
	typeName = encodeURI(typeName);		//js处理中文问题
	typeName = encodeURI(typeName);
	if(sid!=-1){
		document.type.action="Type/add?sid="+sid+"&typeName="+typeName+"";
	}else if(fid!=-1){
		document.type.action="Type/add?fid="+fid+"&typeName="+typeName+"";
	}else{
		document.type.action="Type/add?typeName="+typeName;
	}
	if(tp=="false"){
		document.getElementById("btn").type="button";
	}else{
		document.getElementById("btn").type="submit";
	}
}
</script>

</body>
</html>