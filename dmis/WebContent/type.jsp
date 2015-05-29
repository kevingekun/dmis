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
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" type="text/css" href="css/matrix-style.css" />

<link rel="stylesheet" type="text/css" href="css/bg/yetou.css"/>
<link rel="stylesheet" type="text/css" href="css/dmis.css"/>
<!-- <link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.min.css" /> -->
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<!-- <link rel="stylesheet" type="text/css" href="css/matrix-media.css" /> -->
<!-- <link rel="stylesheet" type="text/css" href="css/uniform.css" /> -->
<!-- <link rel="stylesheet" type="text/css" href="css/select2.css" /> -->
<!-- <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.css" /> -->
<link rel="stylesheet" type="text/css" href="css/buttons/buttons.css" />
<link rel="stylesheet" type="text/css" href="css/forms/style.css" />

<script src="js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body id="table1">
	<input type="text" id="checkRadio" value="${state}" style='display:none'/>
	<div id="mask" class="mask" style="display: none;background-color: rgb(40, 95, 108);"></div>	
	<div class="widget-box">
          <div class="widget-title">
            <h5>类型管理</h5>
            <a class="btn btn-small gray" style="margin:5px 0 0 3px; " onClick="dele();">删除选中</a>
            <div class="widget-radio">
				<input id="addType" class="btn btn-small blue" type="button"
					value="新增类别" style="margin-bottom: 5px;">
				<input type="radio" name="state" id="all"  onClick="allType();"/>全部
				<input type="radio" name="state" id="one_level"   onClick="one_type();"/>一级类
				<input type="radio" name="state" id="two_level"  onClick="two_type();"/>二级类
				<input type="radio" name="state" id="three_level"   onClick="three_type();"/>三级类
			</div>
		   </div>
		   <div id="type_add" style="display: none;" align="center">
		   <div id="type_form_content" class="type_form_content" style="display:none;">
			<form id="test" action="" method="post" enctype="multipart/form-data">
				<fieldset>
					<legend>新增  类别</legend>
					<div class="form-row">
						<div class="field-label_type">
							<label for="field1">类别等级</label>:
						</div>
						<div class="field-widget">
							<select id="typeOne" name="typeOne" onchange="t1(this)" class="validate-selection">
			                    <option value="-1"> 一级分类  </option>
				                <s:iterator value="#request.firstType" >   <!--遍历后台firstType  -->
				                	<option value=<s:property value="id"/>><s:property value="name"/> </option>
				                </s:iterator>
			                </select>
			                <select id="typeTwo" name="typeTwo" onchange="t2(this)" class="validate-selection">
			                    <option value="-1"> 二级分类  </option>
			                </select>
						</div>
					</div>
					<div class="form-row">
						<div class="field-label_type">
							<label for="field1">类别名称</label>:
						</div>
						<div class="field-widget">
							<input name="typ" id="typ" class="required" placeholder="添加一级分类"
								type="text" onblur="checkType();"/>
							<div class="validation-advice" id="advice-required-field1"
								style="display: none;">required field.</div>
						</div>
					</div>
					
					<div class="form-row">
						<div class="field-widget-confirm_user">
							<input id="btn" type="button" class="submit" value="确定" /> 
							<input type="reset" class="reset" value="重置" />
							<input id="cancleFile" type="button" class="cancle" value="取消" /> 
						</div>
					</div>
				</fieldset>
			</form>
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
                  <td><s:property value="parent.id"/></td>
                  	<td><a class="btn btn-mini gray" href="Type/delete.action?id=<s:property value="id"/>&pageNo=<s:property value="#request.page.pageNo"/>&state=${state}">删除</a>
                  </td>                  
                </tr>
                </s:iterator>
              </tbody>
            </table>
            </s:form>
           
            <div id="upPageBar">
				<div class="pagination alternate"
					style="float: left; margin-top: 30px; margin-left: -15px">
					<ul>
						<s:if test="#request.page.showPrv != 0">
							<li id="firstPage" data-id="PAGE"><a
								href="Type/list?pageNo=1&state=${state}">首页</a></li>
							<li id="lastPage" data-id="PAGE"><a
								href="Type/list?pageNo=<s:property value="#request.page.pageNo -1"/>&state=${state}">上一页</a></li>
						</s:if>
						<s:else>
							<li class="disabled" id="firstPage" data-id="PAGE"><a
								href="javascript:void(0);">首页</a></li>
							<li class="disabled" id="lastPage" data-id="PAGE"><a
								href="javascript:void(0);">上一页</a></li>
						</s:else>
						<s:iterator value="#request.page.pageNum" id="key">
							<s:if test="#key != #request.page.pageNo">
								<li data-vl="1" data-id="PAGE" id="pageNo"><a
									href="Type/list?pageNo=<s:property value="key"/>&state=${state}"><s:property
											value="key" /></a></li>
							</s:if>
							<s:else>
								<li data-vl="1" data-id="PAGE" id="pageNo" class="active">
									<a href="javascript:void(0);"><s:property value="key" /></a>
								</li>
								<input type="hidden" id="dqPageNo"
									value="<s:property value="key"/>"></input>
							</s:else>
						</s:iterator>
						<s:if test="#request.page.showNext != 0">
							<li id="nextPage" data-id="PAGE"><a
								href="Type/list?pageNo=<s:property value="#request.page.pageNo +1"/>&state=${state}">下一页</a></li>
							<li id="endPage" data-id="PAGE"><a
								href="Type/list?pageNo=<s:property value="#request.page.totalPage"/>&state=${state}">尾页</a></li>
						</s:if>
						<s:else>
							<li class="disabled" id="nextPage" data-id="PAGE"><a
								href="javascript:void(0);">下一页</a></li>
							<li class="disabled" id="endPage" data-id="PAGE"><a
								href="javascript:void(0);">尾页</a></li>
						</s:else>
						<li class="disabled"><a href="javascript:void(0);">共<s:property
									value="#request.page.totalPage" />页
						</a></li>
					</ul>
				</div>
			</div>
          </div>
        </div>
<script type="text/javascript">
	var fid = -1;//全局变量用来存一级类id
	var sid = -1;//全局变量用来存二级类id
	var check_type = false;
	$("#addType").click(function() {
		$("#mask").slideDown("fast", slidedown);
	});
	function slidedown() {
		$("#type_add").fadeIn("slow");
		$("#type_form_content").fadeIn("slow");
	}
	function slideup() {
		$("#type_add").fadeOut("slow");
		$("#type_form_content").fadeOut("slow");
	}
	$("#cancleFile").click(function() {
		slideup();
		$("#mask").slideUp("fast");
	});

	function t1(obj) {
		var parentid = obj.value; //获取所选类别的id
		if (parentid != -1) { //如果id==-1，说明没选任何类别
			fid = parentid;
			$("#typ")[0].placeholder = "添加二级分类";
			var typeTwo = document.getElementById("typeTwo");
			typeTwo.length = 1; //分类二下拉菜单置空
			$.ajax({
				type : 'GET',
				dataType : 'json',
				url : 'Type/listByParentId?parentid=' + parentid,
				success : function(jsonData) {
					var data = eval(jsonData);
					$.each(data, function(i, n) {
						document.getElementById("typeTwo").options
								.add(new Option(data[i].name, data[i].id));
					});
				},
				error : function() {
					alert("err");
				}
			});
		} else {
			fid = -1;
			$("#typ")[0].placeholder = "添加一级分类";
			var typeTwo = document.getElementById("typeTwo");
			typeTwo.length = 1;
		}
	}
	function t2(obj) {
		var id = obj.value;
		if (id != -1) {
			sid = id;
			$("#typ")[0].placeholder = "添加三级分类";
		} else {
			sid = -1;
		}
	}
	$(function() {
		var state = $('#checkRadio').val();
		if (state == 0)
			$('#all').attr("checked", "checked");
		if (state == 1)
			$('#one_level').attr("checked", "checked");
		if (state == 2)
			$('#two_level').attr("checked", "checked");
		if (state == 3)
			$('#three_level').attr("checked", "checked");
	});
	function change(radio_oj, aValue) { //传入一个对象
		for (var i = 0; i < radio_oj.length; i++) {
			if (radio_oj[i].value == aValue) { //比较值
				radio_oj[i].checked = true; //修改选中状态
				break; //停止循环
			}
		}
	}
	//批量删除
	function dele() {
		var state = $("#checkRadio").val();
		var checkselect = $("#checkselect").val();
		if (checkselect == "true") {
			var pageNo = $("#dqPageNo").val();
			form2.action = "Type/delete?pageNo=" + pageNo+"&state="+state;
			document.getElementById("form2").submit();
		} else {
			alert("请选中需要删除的数据！");
		}
	}
	function allType() {
		location.href = "Type/list?state=0";
	}
	function one_type() {
		location.href = "Type/list?state=1";
	}
	function two_type() {
		location.href = "Type/list?state=2";
	}
	function three_type() {
		location.href = "Type/list?state=3";
	}
	var selAll = document.getElementById("selAll");
	function selectAll() {
		var obj = document.getElementsByName("checkAll");
		if (document.getElementById("selAll").checked == false) {
			for (var i = 0; i < obj.length; i++) {
				obj[i].checked = false;
			}
		} else {
			for (var i = 0; i < obj.length; i++) {
				obj[i].checked = true;
			}
			$("#checkselect")[0].value="true";
		}
	}
	//当选中所有的时候，全选按钮会勾上 
	function setSelectAll() {
		var obj = document.getElementsByName("checkAll");
		var count = obj.length;
		var selectCount = 0;

		for (var i = 0; i < count; i++) {
			if (obj[i].checked == true) {
				selectCount++;
			}
		}
		if (selectCount > 0) {
			document.getElementById("checkselect").value = "true";
		} else {
			document.getElementById("checkselect").value = "false";
		}
		if (count == selectCount) {
			document.all.selAll.checked = true;
		} else {
			document.all.selAll.checked = false;
		}
	}
	//反选按钮 
	function inverse() {
		var checkboxs = document.getElementsByName("checkAll");
		for (var i = 0; i < checkboxs.length; i++) {
			var e = checkboxs[i];
			e.checked = !e.checked;
			setSelectAll();
		}
	}
	function checkType() {
		var typ = $("#typ").val();
		var regex = /^[\u4E00-\u9FA5A-Za-z0-9_]+$/;
		if (regex.test(typ) == false) {
			$("#typ")[0].className = "required validation-failed";
			$("#advice-required-field1")[0].innerHTML = "错误！";
			$("#advice-required-field1").removeAttr("style");
			return false;
		} else {
			typ = encodeURI(encodeURI(typ));
			$.ajax({
				type:'get',
				async : false,
				url:"Type/findByName?typeName="+typ,
				success:function(data){
					if(data=="true"){
						$("#typ")[0].className = "required";
						$("#advice-required-field1").attr("style", "display:none;");
						check_type = true;
					}else if(data=="false"){
						$("#typ")[0].className = "required validation-failed";
						$("#advice-required-field1")[0].innerHTML = "重复！";
						$("#advice-required-field1").removeAttr("style");
						check_type = false;
					}
				},
				error:function(){
					alert("sorry....");
					check_type = false;
				}
			});
			return check_type;
		}
	}
	function check() {
		var tp = $("#typecheck").val();
		var typeName = $("#typ").val();
		typeName = encodeURI(typeName); //js处理中文问题
		typeName = encodeURI(typeName);
		if (sid != -1) {
			document.type.action = "Type/add?sid=" + sid + "&typeName="
					+ typeName + "";
		} else if (fid != -1) {
			document.type.action = "Type/add?fid=" + fid + "&typeName="
					+ typeName + "";
		} else {
			document.type.action = "Type/add?typeName=" + typeName;
		}
		if (tp == "false") {
			document.getElementById("btn").type = "button";
		} else {
			document.getElementById("btn").type = "submit";
		}
	}
	
	$("#btn").click(function() {
		if (checkType()) {
			var typeName = $("#typ").val();
			typeName = encodeURI(typeName); //js处理中文问题
			typeName = encodeURI(typeName);
			if (sid != -1) {
				$("#test")[0].action = "Type/add?sid=" + sid
						+ "&typeName=" + typeName + "";
			} else if (fid != -1) {
				$("#test")[0].action = "Type/add?fid=" + fid
						+ "&typeName=" + typeName + "";
			} else {
				$("#test")[0].action = "Type/add?typeName=" + typeName;
			}
			$("#test").submit();
		}			
	});	
</script>

</body>
</html>