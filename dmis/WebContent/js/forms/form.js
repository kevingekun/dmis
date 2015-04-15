//传文档是否分类
$('#Category').change(function() {
	var category = $("#Category option:selected").text().trim();
	if (category == "分类文档")
		$('#docType').removeAttr('style');
	else
		$('#docType').attr('style', 'display:none');
});