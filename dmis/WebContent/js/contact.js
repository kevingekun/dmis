$(document).ready(function(){ 
		
			var keywordUl = document.getElementById("keywords");
		
			var docUl = document.getElementById("docs");
			var keywordlist=keywordUl.getElementsByTagName("li");
			var doclist=docUl.getElementsByTagName("li");
		
			var i = 0;
		
			for (i = 0; i < keywordlist.length; i++)
			{	
				if(keywordlist[i].id>3){
					$("#" + keywordlist[i].id).css("display","none");
					 
				}
			}
			
			for (i = 0; i < doclist.length; i++)
			{	
				if(doc[i].id>3){
					$("#" + doc[i].id).css("display","none");
					 
				}
			}

	});
		
	function keywordslowup(){  //收起
		var keywordUl = document.getElementById("keywords");
		
		
		var keywordlist=keywordUl.getElementsByTagName("li");
		
		var i = 0;
	
		for (i = 0; i < keywordlist.length; i++)
		{	
			if(keywordlist[i].id>3){
				$("#" + keywordlist[i].id).css("display","none");
				 
			}
		}
		$("#keywordmore").text("更多");
		$("#keywordmore").attr("onclick","keywordmore()") ;
		}
		
	
	function docslowup(){  //收起
		var docUl = document.getElementById("docs");
		var doclist=docUl.getElementsByTagName("li");
		var i = 0;
	
		for (i = 0; i < doclist.length; i++)
		{	
			if(doclist[i].id>3){
				$("#" + keywordlist[i].id).css("display","none");
				 
			}
		}
		$("#docmore").text("更多");
		$("#docmore").attr("onclick","docmore()") ;
		}
	
		function keywordmore(){  //显示更多
			
			var keywordUl = document.getElementById("keywords");
			
			var docUl = document.getElementById("docs");
			var keywordlist=keywordUl.getElementsByTagName("li");
			var doclist=docUl.getElementsByTagName("li");
			var flag=$("#keywordmore").text();
			var i = 0;
			
			
				for (i = 0; i < keywordlist.length; i++)
				{	
					if(3<keywordlist[i].id<10){
						$("#" + keywordlist[i].id).css("display","block");
					}
				}
				$("#keywordmore").text("收起");
				$("#keywordmore").attr("onclick","keywordslowup()") ;

				
					
				
			}
			
		
		
	function docmore(){
			
			
			
			var docUl = document.getElementById("docs");
		
			var doclist=docUl.getElementsByTagName("li");
		
			var i = 0;
		
			for (i = 0; i < doclist.length; i++)
			{	
				if(3<doclist[i].id<10){
					$("#" + doclist[i].id).css("display","block");
				}
			}
			$("#docmore").text("收起");
			$("#docmore").attr("onclick","docslowup()") ;

			
		}