// JavaScript Document
$(function(){
	

	//用户信息操作Start
	$("#btnEdit,#passEdit").click(function(){
		$("#infoEdit").removeAttr("style");
		$("#mask").slideDown("fast");
		if(this.id == 'btnEdit')
		{
			$("#infoEditContent").removeAttr('style');
		}
		else if(this.id == 'passEdit')
		{
			$("#passEditContent").removeAttr('style');
		}
	/*	else
		{
			$.ajax({
       		 type:'GET',
       		 dataType:'json',
       		 url:'/dmis/Type/lista',
       		 success:function(jsonData){
       			document.getElementById("typeOne").options.add(new Option("asd",11));
       			 var data = eval(jsonData);
       			  $.each(data,function(i,n){
       				  document.getElementById("typeOne").options.add(new Option(data[i].name,data[i].id));
       			 }); 
       		 },
       		 error:function(){
       			 alert("err");
       		 } 
       	 });
			$("#fileEditContent").removeAttr('style');
		}*/
		});
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

	
	//post方法异步获取列表
function getListPanel(url,No,pageBar,listContent,listHTML){	
	url = url +"?pageNo="+ No; 
	$.post(url, function(result){

		delLoad("loadimg");
		Clear('#'+listContent);
		var objs=eval(result); //解析json对象  
        var obj = objs[0];   
        var list = obj.pageList;
        switch(listHTML){
        	case 'uploadHTML':
        		$("#"+listContent).append(getUpListContent(list));
        		break;
        	case 'downloadHTML':
        		$("#"+listContent).append(getDownListContent(list));
        		break;
        	case 'favoHTML':
        		$("#"+listContent).append(getFavoListContent(list));
        		break;
        	case 'noticeHTML':
        		$("#"+listContent).append(getNoticeListContent(list));
        		break;
        }
		getPage(obj,pageBar);
		}); 
	}
	//获取上传记录HTML
	function getUpListContent(list){
		var upListContent="";
		for(var i=0;i<list.length;i++){
			if(list[i].isPass) list[i].isPass = PASS; else list[i].isPass = noPASS;
			upListContent += "<tr>" +
					"<td><input type='checkbox' id='title-checkbox-upload' value='"+list[i].id+"' /></td>" +
					"<td width='5%'>"+list[i].id+"</td>" +
					"<td width='13%'>"+ list[i].uploadTime+"</td>" +
					"<td><a href='/dmis/Doc/hrefsearch?docId="+list[i].id+"'>"+list[i].title+"</a></td>" +
					"<td width='10%'> "+list[i].author+"</td>" +
					"<td width='10%'>"+list[i].format+"</td>" +
					"<td width='10%'>"+list[i].isPass+"</td>" +
					"<td width='10%'><a title='删除' class='btn btn-mini'>删除</a></td></tr>";

		}
		return upListContent;
	}
	//获取下载记录HTML
	function getDownListContent(list){
		var downListContent="";
		for(var i=0;i<list.length;i++){
			downListContent += "<tr>" +
					"<td ><input type='checkbox' id='title-checkbox-download' value='"+list[i].id+"'/></td>" +
					"<td width='5%'>"+list[i].id+"</td>" +
					"<td width='13%'>"+ list[i].downloadTime+"</td>" +
					"<td><a href='/dmis/Doc/hrefsearch?docId="+list[i].id+"'>"+list[i].doc.title+"</a></td>" +
					"<td width='10%'> "+list[i].doc.author+"</td>" +
					"<td width='10%'>"+list[i].doc.format+"</td>" +
					"<td width='10%'><a id='delete' data-vl='removedown' href='javascript:void(0)' title='删除' class='btn btn-mini'>删除</a></td></tr>";

		}
		return downListContent;
	}
	//获取收藏记录html
	function getFavoListContent(list){
		var favoListContent="";
		for(var i=0;i<list.length;i++){
			favoListContent += "<tr>" +
					"<td><input type='checkbox' id='title-checkbox-myfavorite' value='"+list[i].id+"'/></td>" +
					"<td width='5%'>"+list[i].id+"</td>" +									
					"<td><a href='/dmis/Doc/hrefsearch?docId="+list[i].id+"'>"+list[i].doc.title+"</a></td>" +
					"<td width='10%'> "+list[i].doc.author+"</td>" +
					"<td width='10%'>"+list[i].doc.format+"</td>" +
					"<td width='10%'><a id='delete' data-vl='removefavo' href='javascript:void(0)' title='删除' class='btn btn-mini'>删除</a></td></tr>";


		}
		return favoListContent;
	}
	
	//获取公告查询html
	function getNoticeListContent(list){
		var noticeListContent="";
		for(var i=0;i<list.length;i++){
			noticeListContent += "<tr>" +
					"<td></td>" +
					"<td width='5%'>"+list[i].id+"</td>" +
					"<td width='13%'>"+ list[i].time+"</td>" +
					"<td><a id='content1' href='javascript:void(0)'>"+list[i].title+"</a></td>"+
					"<td style='display:none' id='contentNotices' class='content'>"+ list[i].content+"</td>";

		}
		return noticeListContent;
	}
	//异步加载翻页
	function getPage(obj,pageBar){
		var endCla 		="";
		var firstCla 	="";
		var nextCla     ="";
		var lastCla     ="";

		if(obj.pageNo == 1 || obj.pageNum.length == 1 || obj.pageNum.length == 0){
			firstCla = "disabled";
			lastCla	 = "disabled";
		}
		if(obj.pageNo == obj.pageNum[obj.pageNum.length - 1] || obj.pageNum.length == 0){
			endCla = "disabled";
			nextCla	 = "disabled";
		}
			
		var pageHTML = "<div class='pagination alternate' style='float:left'>"+
		" <ul ><li class='"+firstCla+"' id='firstPage' data-id='PAGE'><a href='javascript:void(0)' >首页</a></li>"+
			  "<li class='"+lastCla+"' id='lastPage' data-id='PAGE'><a href='javascript:void(0)'>上一页</a></li>"+
			  "<li class='disabled' ><a href='javascript:void(0)'>共"+ obj.totalPage +"页</a></li>";
		for(var i=1;i<=obj.pageNum.length;i++){
			pageHTML += "<li  data-vl ="+obj.pageNum[i-1]+" data-id='PAGE' id='pageNo'><a href='javascript:void(0)'>"+obj.pageNum[i-1]+"</a></li>";
		}
		pageHTML = pageHTML +"<li  class='"+nextCla+"' id='nextPage' data-id='PAGE'><a href='javascript:void(0)'>下一页</a></li>"+
		"<li class='"+endCla+"' id='endPage' data-id='PAGE'><a href='javascript:void(0)'>尾页</a></li></ul></div>";
		
		Clear("#"+pageBar);
		$("#totalPageNo").val(obj.totalPage);
		$("#nowPageNo").val(obj.pageNo);
		$("#"+pageBar).append(pageHTML);
		$("li[data-vl]").removeClass('active');
		$("li[data-vl ="+obj.pageNo+"]").attr('class','active');
		
	}

	// 实现点击无刷新翻页
	$("li[data-id='PAGE']").live('click',function(){
			var enable =  $(this).attr('class');
			var pageId = this.id;
			var num =  $(this).attr('data-vl');
			var upTotalPageNo = $("#totalPageNo").val();
			var nowPageNo = $("#nowPageNo").val();
			if(enable == 'disabled' || enable == 'active')
				return false;
			else{
				$("div.loadimg").removeAttr('style');
				switch(pageId){
					case 'firstPage':
						getListPanel(URL,1,pageBar,listContent,listHTML);
						break;
					case 'lastPage':
						getListPanel(URL,nowPageNo-1,pageBar,listContent,listHTML);
						break;
					case 'pageNo':
						 getListPanel(URL,num,pageBar,listContent,listHTML);
						break;
					case 'nextPage':
						getListPanel(URL,nowPageNo*1+1*1,pageBar,listContent,listHTML);
						break;
					case 'endPage':
						getListPanel(URL,upTotalPageNo,pageBar,listContent,listHTML);
						break;
				}
			}
				
		});	
	
	// 清空div
	function Clear(div){
		$(div).empty();
	}
	//隐藏加载图片
	function delLoad(div){
		$("div."+div).attr('style','display:none');
	}
	
	//重置密码验证
//	var url="/dmis/User/UserAction/updateUser";
	
	
	/**
	 * 删除单条记录
	 */
	$("#delete").live('click',function(){
		var data_vl = $(this).attr('data-vl');	
		var id = $(this).parent().parent().find('td input').val();
		
		switch (data_vl) {
		
		case "removedown":					
		var url= "/dmis/DownloadRecoder/delete?id="+id+"";
		alertTip(alertConfirm("确定删除","javascript:void(0)"));
		
		$('#confir').live('click',function(){	
		
		$.post(url, function(result){
			if(result == "success"){ 
				$("tbody input").each(function(index){
					$(this).parents('tr').remove();
		    		alertClose();
		    	});			}
			else
				alert("删除错误,请重新尝试");
		});
		});
		break;
		case "removefavo":
			var url= "/dmis/Favorites/delete?id="+id+"";
			alertTip(alertConfirm("确定删除","javascript:void(0)"));
			
			$('#confir').live('click',function(){	
			
			$.post(url, function(result){
				//alert(result); 
				if(result == "success"){ 
					$("tbody input").each(function(index){
						$(this).parents('tr').remove();
			    		alertClose();
			    	});			}
				else
					alert("删除错误,请重新尝试");
			});
			});
			break;
		}
		
	}) ;
	
	/**
	 * 删除选中
	 */
	
	$('#delDownloadChecked,#delFavoritesChecked').click(function(){
		var ids = "";
		$("tbody input:checked").each(function(index){
    		if(index == 0) ids += this.value;
    		else ids += ","+this.value;
    	});
		var namespace = $(this).attr('data-vl');
		URL = "/dmis/"+namespace+"/removeChecked?ids="+ids+"";
		if(ids == "")
			alertTip('请选择');
		else{
		alertTip(alertConfirm("确定删除选中？","javascript:void(0)"));
		
		$('#confir').live('click',function(){
			$.post(URL,function(result){
				
				if(result == 'success')
					$("tbody input:checked").each(function(index){
			    		$(this).parent().parent().remove();
			    		alertClose();
			    	});
				else alertTip("删除错误,请重新尝试");
			});
		});
		}
	});

});

/**
 * 公告内容
 */
$('#content1').live('click',function(){
	var content = $(this).parent().parent().find('td.content').text().trim();
	$('#NoticeShow').removeAttr('style');
	$('#noticeContent').text(content);
});
$('#noticeClose').live('click',function(){
	$('#NoticeShow').attr('style','display:none');
});