$(document).ready(function()
{
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
		 function selectTwo(obj, TypeTh) {
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
});