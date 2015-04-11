// JavaScript Document
$(function(){
		
	// TypeTwoStart
	 	var step;
	 	var url = "/dmis/Type/getType";
	 	$.post(url,function(result){
		 	var list = eval(result);
		 	getType("menu","",0);
		$("li[data-val='menu']").live('mouseover',function(){
			flag=false;
			var Y = $("#"+this.id).offset().top-77;
			step = this.id;
			$("#hidemenu").removeAttr('style');
			$("#hidemenu").attr('style','margin-top:'+Y+'px');
			$("li[data-val='menu']").removeClass();
			$("li[data-val='menuTwo']").removeClass();
			$("#"+step).addClass('active');
			$("#hidemenuTwo").hide();
			getType("menuTwo","hidemenu",$("li#"+step+">input").val());
		});
		
			$("div").mouseout(function(){
				var ID = $(this).attr("class");
				if(ID != 'sidebar' && ID != 'hidemenu' && ID != 'hidemenuTwo' && ID != 'sidebarTwo' ){
					$("#hidemenu").removeAttr('style');
					$("#hidemenuTwo").removeAttr('style');
					$("li[data-val='menu']").removeClass();
				}
				});
			// TypeTwoEnd
			
			// TypeThreeStart
			$("li[data-val='menuTwo']").live('mouseover',function(){
				var Y = $("#"+this.id).offset().top-77;
				step = this.id;
				$("#hidemenuTwo").removeAttr('style');
				$("#hidemenuTwo").attr('style','margin-top:'+Y+'px');
				$("li[data-val='menuTwo']").removeClass();
				$("#"+step).addClass('active');
				getType("menuThree","hidemenuTwo",$("li#"+step+">input").val());
			});
			
			// TypeThreeEnd
			
			//getTypeStart
	
			function getType(menuId,hidemenuId,typeId){
				var html = "";
				var href = "";
				for(var i=0;i<list.length;i++){
					href = "javascript:void(0)";
					if(list[i].level == 3) href = "/dmis/Doc/getDocByType?pageNo=1&typeId="+list[i].id+"&typeName="+list[i].name+"";
					if(typeId == list[i].parentId)
					html += "<li id="+list[i].id+" data-val='"+menuId+"'><a href='"+href+"'> <span>"+list[i].name+" </span></a>" +
							"<input style='display:none' value='"+list[i].id+"'></li>";

					$("ul#"+menuId).empty().append(html);
				}
				$("#"+hidemenuId).show();
			}
	 	});
	});