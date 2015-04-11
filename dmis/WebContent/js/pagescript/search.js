/**
 * 
 */

$(function(){
	
	var typeId = $("#type").val();
	if(typeof(typeId) == "undefined")
		typeId = "";	
	var typeName = $("#typeName").val();
	if(typeof(typeName) == "undefined")
		typeName = "";
	var basePath = $("#basePath").val();
	var year = "";
	var category = "";
	var language = "";
	var searchText = "";
	
	$("#advancedTwiceSearch").click(function(){
		
		 year = $("#year").val();
		 category = $("#category").val();
		 language = $("#language").val();
		 searchText = $("#searchRecoder").val();
		
		if(year == "年份")
			year = "";
		if(category == "类别")
			category = "";
		if(language == "语言")
			language = "";
	
		loadDocBysearch(typeId,year,category,language,searchText,typeName);
		
	});
	
	$("#advancedAllSearch").click(function(){
		
		 year = $("#year").val();
		 category = $("#category").val();
		 language = $("#language").val();
		
		if(year == "年份")
			year = "";
		if(category == "类别")
			category = "";
		if(language == "语言")
			language = "";
	
		loadDocBysearch("",year,category,language,searchText,typeName);
		
	});
	
	$("div#condition > a").click(function(){
		var id = this.id;
		 year = $("#yearClear").text().trim();
		 category = $("#categoryClear").text().trim();
		 language = $("#languageClear").text().trim();
		 typeName = $("#typeNameClear").text().trim();
		 searchText = $("#searchClear").text().trim();
		
		if(year == "近一年")
			year = "1";
		if(year == "近二年")
			year = "2";
		if(year == "近三年")
			year = "3";
		
		if(language == "中文")
			language = "1";
		if(language == "英文")
			language = "2";
		
		switch(id){
			case "yearClear":
				$("#"+id).text();
				year="";
				break;
			case "categoryClear":
				$("#"+id).text();
				category="";
				break;
			case "languageClear":
				$("#"+id).text();
				language="";
				break;
			case "typeNameClear":
				$("#"+id).text();
				typeName="";
				typeId = "";
				break;
			case "searchClear":
				$("#"+id).text();
				searchText="";
				break;
		}
	
		loadDocBysearch(typeId,year,category,language,searchText,typeName);
		
	});

	$("#searchAllDoc").click(function(){
		 searchText = $("#searchText").val();
		 $('#searchAllDoc > span').text("搜索中...");
		 if(searchText != "")
			$.post("/dmis/SearchHistory/saveSearchHistory?keyword="+searchText+"",function(){
				loadDocBysearch(typeId,"","","",searchText,typeName);
			});
		 else
			 loadDocBysearch(typeId,"","","",searchText,typeName);
	});

	/**
	 * 高级搜索
	 */
	function loadDocBysearch(typeId,year,category,language,searchText,typeName){
		var url = "/dmis/Doc/getAdvancedSearch?pageNo=1&typeId="+typeId+"&year="+year+"&category="+category+"&language="+language+"&keyword="+searchText+"&typeName="+typeName+"";
		location.href=url;
		
	}
	/**
	 * 搜索关键字高亮
	 */
	var reg = eval("/"+$("#searchRecoder").val()+"/gi");
	document.getElementById("collapseG2").innerHTML = document.getElementById("collapseG2").innerHTML.replace(reg,"<span class='bg_ly'>"+$("#searchRecoder").val()+"</span>");

	
	/**
	 * 加载搜索历史
	 */
	searchHistory();
function searchHistory(){
	$.post("/dmis/SearchHistory/loadSearchHistory",function(result){
		if(result == "field")
			$("ul#searchHistory").html("<h5 style='color:red'>什么都没留下...</h5>");
		else{
			var objs = eval(result);
			$("ul#searchHistory").empty();
			for(var i = 0;i<objs.length;i++){
				$("ul#searchHistory").append("<li class='clearfix' id='hoverSearchHistory'>"+
                 "<div class='txt' ><a href='"+keywordURL(typeId,objs[i].name,typeName)+"'> "+objs[i].name+" </a></div> " +
                 "<div class='pull-right'  style='display:none;'> <a href='javascript:void(0)' class='DELETE' id='"+objs[i].id+"' title='删除' style='font-size:14px;font-weight:bold;'> × </a> </div></li>");
			}
		}
	});
	}

	/**
	 * 删除搜索历史
	 */
	$('li[id=hoverSearchHistory]').live('mouseover',function(){
		$(this).find('div.pull-right').removeAttr('style');
	});
	
	$('li[id=hoverSearchHistory]').live('mouseout',function(){
		$(this).find('div.pull-right').attr('style','display:none');
	});

	$('.DELETE').live('click',function(){
		var delUrl = "/dmis/SearchHistory/deleteSearchHistory?searchHistoryId="+this.id;
		$.post(delUrl,function(result){
				$(this).parent().parent().remove();
				searchHistory();
		});
	});
	/**
	 * 加载热门词汇
	 */
	$.post("/dmis/SearchHistory/loadHotKeyword",function(result){

			var objs = eval(result);
			$("ul#hotword").empty();
			for(var i = 0;i<objs.length;i++){
				$("ul#hotword").append("<li class='clearfix'>"+
                 "<div class='txt'><a href='"+keywordURL(typeId,objs[i].name,typeName)+"'> "+objs[i].name+"</a> </div> </li>");
			}
	});
	/**
	 * 返回关键字URL
	 */
	function keywordURL(typeId,searchText,typeName){
		var url = "/dmis/Doc/getAdvancedSearch?pageNo=1&typeId="+typeId+"&year=&category=&language=&keyword="+searchText+"&typeName="+typeName+"";
		return url;	
	}
});