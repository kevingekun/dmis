<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<html>
<head>
<title>新增文献</title>
<script type="text/javascript" src="js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/forms/style.css" />
<link rel="stylesheet" type="text/css" href="css/matrix-style.css" />
<link rel="stylesheet" type="text/css" href="css/bg/yetou.css" />
</head>
<body id="adddoc">
	<div class="widget-box">
		<div class="widget-title">
			<h5>新增文献</h5>
		</div>
		<div class="form_content">
			<form id="test" action="Doc/uploadDoc" method="post"
				enctype="multipart/form-data">
				<fieldset>
					<legend>文献上传</legend>
					<div class="form-row">
						<div class="field-label">
							<label for="field1">文献标题</label>:
						</div>
						<div class="field-widget">
							<input name="doc.title" id="title" class="required"
								onblur="checkTitle()" />
							<div class="validation-advice" id="advice-required-field1"
								style="display: none;">输入标题!</div>
						</div>
					</div>

					<div class="form-row">
						<div class="field-label">
							<label for="field2">文献作者</label>:
						</div>
						<div class="field-widget">
							<input name="doc.author" id="author" class="required"
								title="Enter your name" />
						</div>
					</div>

					<div class="form-row">
						<div class="field-label">
							<label for="field2">文献类别</label>:
						</div>
						<div class="field-widget">
							<select id="category" name="doc.category" class="validate-selection">
								<option>选择类别</option>
								<option>外文期刊</option>
								<option>OA论文</option>
								<option>期刊论文</option>
								<option>学位论文</option>
								<option>会议论文</option>
							</select> <select id="language" name="doc.language"
								class="validate-selection" onchange="categoryCheck('language','level')">
								<!-- languageCheck(this) -->
								<option value="-1">选择语言</option>
								<option value="1">中文</option>
								<option value="0">英文</option>
							</select> <select id="level" name="doc.level" class="validate-selection"
								onchange="categoryCheck('level','language')">
								<!-- levelCheck(this)  -->
								<option value="-1">选择级别</option>
								<option value="1">一类文献</option>
								<option value="2">二类文献</option>
								<option value="3">三类文献</option>
							</select>
							<div class="validation-advice" id="all-selection"
								style="display: none;">Make a selection</div>
							<input id="languageid" type="hidden" value="0" /> <input
								id="levelid" type="hidden" value="0" />
						</div>

						<div class="field-widget2" id="docType">
							<input type="hidden" id="fIdDoc" value="-1" /> <select
								id="typeOneDoc" name="typeOne" class="validate-selection"
								onchange="selectOne(this,'typeTwoDoc','typeThreeDoc');typeCheck();">
								<!-- validate-selection validation-failed -->
								<option value="-1">一级分类</option>
							</select> <input type="hidden" id="sIdDoc" value="-1" /> <select
								id="typeTwoDoc" name="typeTwo" class="validate-selection"
								onchange="selectTwo(this,'typeThreeDoc');typeCheck();">
								<option value="-1">二级分类</option>
							</select> <input type="hidden" id="tIdDoc" value="-1" /> <select
								id="typeThreeDoc" name="doc.typeName" class="validate-selection"
								onchange="typeCheck();">
								<option value="-1">三级分类</option>
							</select>
							<div class="validation-advice" id="advice-validate-selection2"
								style="display: none;">Make a selection</div>
						</div>
					</div>

					<div class="form-row">
						<div class="field-label">
							<label for="field2">期刊</label>:
						</div>
						<div class="field-widget">
							<input name="doc.journal" id="journal" class="required"
								title="Enter your name" />
						</div>
					</div>
				</fieldset>
				<fieldset>
					<legend>NEXT PAGE</legend>

					<div class="form-row">
						<div class="field-label">
							<label for="field12">文章摘要</label>:
						</div>
						<div class="field-widget">
							<textarea name="doc.brief" class="optional"></textarea>
						</div>
					</div>

					<div class="form-row">
						<div class="field-label">
							<label for="field5">时间</label>:
						</div>
						<div class="field-widget">
							<input name="doc.publishedTime" id="time" type="date"
								class="required validate-email" title="Enter your name" />
						</div>
					</div>

					<div class="form-row">
						<div class="field-label">
							<label for="field3">上传</label>:
						</div>
						<div class="field-widget">
							<input type="file" id="file" name="uploadFile" class="file-class" />
							<div class="validation-advice" id="file-required"
								style="display: none;">type error.</div>
						</div>
					</div>
					<div class="form-row">
						<div class="field-widget-confirm">
							<input id="btn" type="button" class="submit" value="确定" /> <input
								class="reset" type="reset" value="重置" />
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			type : 'GET',
			dataType : 'json',
			url : 'Type/listByParentId',
			success : function(jsonData) {
				//document.getElementById("typeOne").options.add(new Option("asd",11));
				var data = eval(jsonData);
				$.each(data, function(i, n) {
					document.getElementById("typeOneDoc").options
							.add(new Option(data[i].name,
									data[i].id));
				});
			},
			error : function() {
				alert("err");
			}
		});
	});
	function selectOne(obj, TypeTw, TypeTh) {
		var parentid = obj.value;//获取所选的一级类别的id
		if (parentid != -1) {//如果id==-1，说明没选任何类别
			document.getElementById("fIdDoc").value = parentid;//在隐藏的input中存id
			var typeTwo = document.getElementById(TypeTw);
			var typeThree = document.getElementById(TypeTh);
			typeTwo.length = 1;//分类二下拉菜单置一
			typeThree.length = 1;//分类三下拉菜单置一 
			$.ajax({
				type : 'GET',
				dataType : 'json',
				url : 'Type/listByParentId?parentid='
						+ parentid,//parentid=父类的id
				success : function(jsonData) {
					var data = eval(jsonData);
					 if(data == ""){
					 $('#'+TypeTw).empty();
					 typeTwo.options.add(new Option("没有分类","1"));
					 $('option').click();
					}
					else
					$.each(data, function(i, n) {
						typeTwo.options.add(new Option(data[i].name,
								data[i].id));
					});
				},
				error : function() {
					alert("error");
				}
			});
		} else {
			var typeTwo = document.getElementById(TypeTw);
			var typeThree = document.getElementById(TypeTh);
			typeTwo.length = 1;
			typeThree.length = 1;
		}
	}
 	function selectTwo(obj, TypeTh) {
		var parentwoid = obj.value;
		if (parentwoid != -1) {
			document.getElementById("sIdDoc").value = parentwoid;
			var typeThree = document.getElementById(TypeTh);
			typeThree.length = 1;
			$.ajax({
				type : 'GET',
				dataType : 'json',
				url : 'Type/listByParentId?parentid='
						+ parentwoid,
				success : function(jsonData) {
					var data = eval(jsonData);
					$.each(data, function(i, n) {
						typeThree.options.add(new Option(data[i].name));
					});
				},
				error : function() {
					alert("error");
				}
			});
		} else {
			var typeTwo = document.getElementById(TypeTw);
			typeTwo.length = 1;
		}
	}
 	function checkTitle(){
		var str = $("#title").val();
		title = str.replace(/^\s+|\s+$/g, '');
		if (title.length == 0) {
			$("#title")[0].className = "required validation-failed";
			$("#advice-required-field1").removeAttr("style");
			return false;
		} else {
			$("#title")[0].className = "required";
			$("#advice-required-field1").attr("style","display:none;");
			return true;
		}
	}
 	function categoryCheck(obj1,obj2){
		 var val = $("#"+obj1)[0].value;
		 var id1 = $("#"+obj1)[0].id;
		 var id2 = $("#"+obj2)[0].id;
		 if(val=="-1"){
			 $("#"+id1)[0].className = "validate-selection validation-failed"
			 $("#all-selection").removeAttr("style");
			 $("#"+id1+"id")[0].value="1";
			 return false;
		 }else{
			 $("#"+id1)[0].className = "validate-selection";
			 $("#"+id1+"id")[0].value="0";
			 if($("#"+id2+"id").val()=="0"){
				$("#all-selection").attr("style","display:none;");
			 }
			 return true;
		 }
	 }
 	function typeCheck(){
		var tpo = $("#typeOneDoc").val();
		if(tpo!="-1"){
			var typeone = $("#typeOneDoc").val();
			var typetwo = $("#typeTwoDoc").val();
			var typethree = $("#typeThreeDoc").val();
			var one = false;
			var two = false;
			var three = false;
			if(typeone=="-1"){
				$("#typeOneDoc")[0].className = "validate-selection validation-failed";
				$("#advice-validate-selection2").removeAttr("style");
				one = false;
			}else{
				$("#typeOneDoc")[0].className = "validate-selection";
				$("#advice-validate-selection2").attr("style","display:none;");
				one = true;
			}
			if(typetwo=="-1"){
				$("#typeTwoDoc")[0].className = "validate-selection validation-failed";
				$("#advice-validate-selection2").removeAttr("style");
				two = false;
			}else{
				$("#typeTwoDoc")[0].className = "validate-selection";
				$("#advice-validate-selection2").attr("style","display:none;");
				two = true;
			}
			if(typethree=="-1"){
				$("#typeThreeDoc")[0].className = "validate-selection validation-failed";
				$("#advice-validate-selection2").removeAttr("style");
				three = false;
			}else{
				$("#typeThreeDoc")[0].className = "validate-selection";
				$("#advice-validate-selection2").attr("style","display:none;");
				three = true;
			}
			if(one&&two&&three)
				return true;
			else
				return false;
		}else{
			$("#typeOneDoc")[0].className = "validate-selection validation-failed";
			$("#advice-validate-selection2").removeAttr("style");
			$("#typeTwoDoc")[0].className = "validate-selection validation-failed";
			$("#advice-validate-selection2").removeAttr("style");
			$("#typeThreeDoc")[0].className = "validate-selection validation-failed";
			$("#advice-validate-selection2").removeAttr("style");
			return false;
		}
		return true;
		
	}
 	function isvalidatefile() {
		var fileType = $("#file").val();
		var pos = fileType.lastIndexOf(".");
		var lastname = fileType.substring(pos, fileType.length);
		var type = lastname.toLowerCase();
		if (!(type == ".doc" || type == ".pdf" || type == ".docx"
				|| type == ".ppt" || type == ".xls" || type == ".pptx"
				|| type == ".xlsx" || type == ".zip")) {
			//alert("您上传的文件类型为" + lastname + "文件类型不符");
			$("#file")[0].className="file-class-failed";
			$("#file-required").removeAttr("style");
			return false;
		} else {
			$("#file")[0].className="file-class";
			$("#file-required").attr("style","display:none;");
			//alert("文件类型符合，可以上传");
		}
		return true;
	}
 	$("#btn").click(function(){
		if(checkTitle()&&categoryCheck('language','level')&&
				categoryCheck('level','language')&&typeCheck()
				&&isvalidatefile()){
			$("#test").submit();
		}
	});
		/* function formCallback(result, form) {
			window.status = "valiation callback for form '" + form.id
					+ "': result = " + result;
		}

		var valid = new Validation('test', {
			immediate : true,
			onFormValidate : formCallback
		});
		Validation.addAllThese([ [ 'validate-password', '> 6 characters', {
			minLength : 7,
			notOneOf : [ 'password', 'PASSWORD', '1234567', '0123456' ],
			notEqualToField : 'field1'
		} ], [ 'validate-password-confirm', 'please try again.', {
			equalToField : 'field8'
		} ] ]); */
	</script>
</body>
</html>