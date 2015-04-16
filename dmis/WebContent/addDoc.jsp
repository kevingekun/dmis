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
<title>新增文档</title>


<!-- <script type="text/javascript" src="js/forms/prototype.js"></script>
<script type="text/javascript" src="js/forms/effects.js"></script>
<script type="text/javascript" src="js/forms/validation.js"></script> -->
<script type="text/javascript" src="js/jquery.min.js"></script>
<!-- <script type="text/javascript" src="js/forms/form.js"></script> -->

<link rel="stylesheet" type="text/css" href="css/forms/style.css" />
<link rel="stylesheet" type="text/css" href="css/matrix-style.css" />
<link rel="stylesheet" type="text/css" href="css/bg/yetou.css" />
</head>
<body id="adddoc">
	<div class="widget-box">
		<div class="widget-title">
			<h5>新增文档</h5>
		</div>
		<div class="form_content">
			<form id="test" action="Doc/uploadDocDoc" method="post"
				enctype="multipart/form-data">
				<fieldset>
					<legend>文档上传</legend>
					<div class="form-row">
						<div class="field-label">
							<label for="field1">文档标题</label>:
						</div>
						<div class="field-widget">
							<input name="doc.title" id="title" class="required" onblur="checkTitle()"/><!-- required validation-failed -->
							<div class="validation-advice" id="advice-required-field1" style="display:none;">required field.</div>
						</div>
					</div>

					<div class="form-row">
						<div class="field-label">
							<label for="field2">文档类别</label>:
						</div>
						<div class="field-widget">
							<select id="category" name="category" class="validate-selection">
								<option value="-1">其他</option>
								<option value="1">分类文档</option>
							</select> 
							<select id="language" name="doc.language" class="validate-selection"
								onchange="categoryCheck('language','level')"><!-- languageCheck(this) -->
								<option value="-1">选择语言</option>
								<option value="1">中文</option>
								<option value="0">英文</option>
							</select> 
							<select id="level" name="doc.level" class="validate-selection"
								onchange="categoryCheck('level','language')"><!-- levelCheck(this)  -->
								<option value="-1">选择级别</option>
								<option value="1">一类文档</option>
								<option value="2">二类文档</option>
								<option value="3">三类文档</option>
							</select>
							<div class="validation-advice" id="all-selection" 
									style="display:none;">Make a selection</div>
							<input id="languageid" type="hidden" value="0"/>
							<input id="levelid" type="hidden" value="0"/>
						</div>

						<div class="field-widget2" id="docType" style="display: none;">
							<input type="hidden" id="fIdDoc" value="-1" /> 
							<select id="typeOneDoc" name="doc.typeOne" class="validate-selection"
								onchange="selectOne(this,'typeTwoDoc','typeThreeDoc');typeCheck();"><!-- validate-selection validation-failed -->
								<option value="-1">一级分类</option>
							</select> 
							<input type="hidden" id="sIdDoc" value="-1" /> 
							<select id="typeTwoDoc" name="doc.typeTwo" class="validate-selection"
								onchange="selectTwo(this,'typeThreeDoc');typeCheck();">
								<option value="-1">二级分类</option>
							</select> 
							<input type="hidden" id="tIdDoc" value="-1" />
							<select id="typeThreeDoc" name="typeThree" class="validate-selection"
							onchange="typeCheck();">
								<option value="-1">三级分类</option>
							</select>
							<div class="validation-advice" id="advice-validate-selection2" 
									style="display:none;">Make a selection</div>
						</div>
					</div>

					<div class="form-row">
						<div class="field-label">
							<label for="field3">上传</label>:
						</div>
						<div class="field-widget">
							<input type="file" id="file" name="uploadFile" class="file-class" />
						</div>
					</div>
					<div class="form-row">
						<div class="field-widget-confirm">
							<input id="btn" type="button" class="submit" value="确定" onclick="checkTitle();typeCheck();categoryCheck('language','level');categoryCheck('level','language');isvalidatefile();"/> 
							<input class="reset" type="button" value="重置"
								onclick="valid.reset(); return false" />
						</div>
					</div>


				</fieldset>


			</form>
		</div>
	</div>
	<script type="text/javascript">
		 $("#category").change(function() {
			var category = $("#category option:selected").text().trim();
			if (category == "分类文档"){
				$.ajax({
					type : 'GET',
					dataType : 'json',
					url : '/dmis/Type/TypeAction/lista',
					success : function(jsonData) {
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
				$("#docType").removeAttr('style');
			}else{
				$("#docType").attr('style', 'display:none');
				var typeOne = document.getElementById("typeOneDoc");
				typeOne.length = 1;
			}
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
						url : '/dmis/Type/TypeAction/listaByParentId?parentid='
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
						url : '/dmis/Type/TypeAction/listaaByParentId?parentid='
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
				} else {
					$("#title")[0].className = "required";
					$("#advice-required-field1").attr("style","display:none;");
				}
			}
			 /* function languageCheck(lan){
				var language = lan.value;
				if(language=="-1"){
					$("#language")[0].className = "validate-selection validation-failed";
					$("#all-selection").removeAttr("style");
					$("#languageid")[0].value="1";
				}else{
					$("#language")[0].className = "validate-selection";
					$("#languageid")[0].value="0";
					if($("#levelid").val()=="0")
						$("#all-selection").attr("style","display:none;");
				}
			} */
			 function categoryCheck(obj1,obj2){
				 var val = $("#"+obj1)[0].value;
				 var id1 = $("#"+obj1)[0].id;
				 var id2 = $("#"+obj2)[0].id;
				 if(val=="-1"){
					 $("#"+id1)[0].className = "validate-selection validation-failed"
					 $("#all-selection").removeAttr("style");
					 $("#"+id1+"id")[0].value="1";
				 }else{
					 $("#"+id1)[0].className = "validate-selection";
					 $("#"+id1+"id")[0].value="0";
					 if($("#"+id2+"id").val()=="0"){
						$("#all-selection").attr("style","display:none;");
					 }
						 
					}
			 }
			/* function levelCheck(lev){
				var level = lev.value;
				if(level=="-1"){
					$("#level")[0].className = "validate-selection validation-failed";
					$("#all-selection").removeAttr("style");
					$("#levelid")[0].value="1";
				}else{
					$("#level")[0].className = "validate-selection";
					$("#levelid")[0].value="0";
					if($("#languageid").val()=="0"){
						$("#all-selection").attr("style","display:none;");
					}
				}
			} */
			function typeCheck(){
				var category = $("#category").val();
				if(category=="1"){
					var typeone = $("#typeOneDoc").val();
					var typetwo = $("#typeTwoDoc").val();
					var typethree = $("#typeThreeDoc").val();
					if(typeone=="-1"){
						$("#typeOneDoc")[0].className = "validate-selection validation-failed";
						$("#advice-validate-selection2").removeAttr("style");
					}else{
						$("#typeOneDoc")[0].className = "validate-selection";
						$("#advice-validate-selection2").attr("style","display:none;");
					}
					if(typetwo=="-1"){
						$("#typeTwoDoc")[0].className = "validate-selection validation-failed";
						$("#advice-validate-selection2").removeAttr("style");
					}else{
						$("#typeTwoDoc")[0].className = "validate-selection";
						$("#advice-validate-selection2").attr("style","display:none;");
					}
					if(typethree=="-1"){
						$("#typeThreeDoc")[0].className = "validate-selection validation-failed";
						$("#advice-validate-selection2").removeAttr("style");
					}else{
						$("#typeThreeDoc")[0].className = "validate-selection";
						$("#advice-validate-selection2").attr("style","display:none;");
					}
				}
				
			}
			function isvalidatefile() {
				var fileType = $("#file").val();
				var pos = fileType.lastIndexOf(".");
				var lastname = fileType.substring(pos, fileType.length);
				if (!(lastname.toLowerCase() == ".doc"
						|| lastname.toLowerCase() == ".pdf"
						|| lastname.toLowerCase() == ".docx"
						|| lastname.toLowerCase() == ".ppt" || lastname
						.toLowerCase() == ".xls")
						|| lastname.toLowerCase() == ".pptx"
						|| lastname.toLowerCase() == ".xlsx"
						|| lastname.toLowerCase() == ".zip") {
					alert("您上传的文件类型为" + lastname + "文件类型不符");
					$("#file")[0].className="file-class-failed";
					return false;
				} else {
					$("#file")[0].className="file-class";
					//alert("文件类型符合，可以上传");
				}
				return true;
			}
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