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
<script type="text/javascript" src="js/forms/prototype.js"></script>
<script type="text/javascript" src="js/forms/effects.js"></script>
<script type="text/javascript" src="js/forms/validation.js"></script>
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
							<input name="doc.title" id="field1" class="required"
								title="Enter your title" />
						</div>
					</div>

					<div class="form-row">
						<div class="field-label">
							<label for="field2">文档类别</label>:
						</div>
						<div class="field-widget">
							<select id="Category" name="category" class="validate-selection">
								<option>其他</option>
								<option>分类文档</option>
							</select> <select name="doc.language" class="validate-selection">
								<option>选择语言</option>
								<option value="1">中文</option>
								<option value="0">英文</option>
							</select> <select name="doc.level" class="validate-selection">
								<option>选择级别</option>
								<option value="1">一类文档</option>
								<option value="2">二类文档</option>
								<option value="3">三类文档</option>
							</select>
						</div>

						<div class="field-widget2" id="docType" style="display: none;">
							<input type="hidden" id="fIdDoc" value="-1" /> <select
								id="typeOneDoc" name="doc.typeOne" class="validate-selection"
								onchange="t1(this,'typeTwoDoc','typeThreeDoc')" title="Choose your department">
								<option value="-1">一级分类</option>
							</select> <input type="hidden" id="sIdDoc" value="-1" /> <select
								id="typeTwoDoc" name="doc.typeTwo" class="validate-selection"
								onchange="t2(this,'typeThreeDoc')"
								title="Choose your department">
								<option value="-1">二级分类</option>
							</select> <input type="hidden" id="tIdDoc" value="-1" /> <select
								id="typeThreeDoc" name="typeThree" class="validate-selection"
								title="Choose your department">
								<option value="-1">三级分类</option>
							</select>
						</div>
					</div>

					<div class="form-row">
						<div class="field-label">
							<label for="field3">上传</label>:
						</div>
						<div class="field-widget">
							<!-- <input type="text" id="txt" style="width: 203px;"> -->
							<!-- <span class="add-on bg_ic" onclick="$('#f').click()">
							<a style="color: #2E363F;" href="javascript:void(0);">浏览</a>
						</span> <br> -->
							<input type="file" id="f" onchange="txt.value=this.value"
								name="uploadFile" class="files" onblur="checkType('file')" />
						</div>
					</div>
					<div class="form-row">
						<div class="field-widget-confirm">
							<input type="submit" class="submit" value="确定" /> <input
								class="reset" type="button" value="重置"
								onclick="valid.reset(); return false" />
						</div>
					</div>


				</fieldset>


			</form>
		</div>
	</div>
	<script type="text/javascript">
		 $("#Category").change(function() {
			var category = $("#Category option:selected").text().trim();
			if (category == "分类文档"){
				$.ajax({
					type : 'GET',
					dataType : 'json',
					url : '/dmis/Type/TypeAction/lista',
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
				$("#docType").removeAttr('style');
			}else{
				$("#docType").attr('style', 'display:none');
			}
		});
		 function t1(obj, TypeTw, TypeTh) {
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
							/* if(data == ""){
							 $('#'+TypeTw).empty();
							 typeTwo.options.add(new Option("没有分类","1"));
							 $('option').click();
							}
							else */
							$.each(data, function(i, n) {
								typeTwo.options.add(new Option(data[i].name,
										data[i].id));
								//document.getElementById("typeTwoDoc").options.add(new Option(data[i].name,data[i].id));
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
		 function t2(obj, TypeTh) {
				var parentwoid = obj.value;
				if (parentwoid != -1) {
					document.getElementById("sIdDoc").value = parentwoid;//在隐藏的input中存id
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
		 
		function formCallback(result, form) {
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
		} ] ]);
	</script>
</body>
</html>