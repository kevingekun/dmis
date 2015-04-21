
$(document).ready(function(){
	var hostPath = $("#localHostPath").val();

	var speed = 1000;
	var step=1;
	$("#recoverform").animate({left:'450px'},speed);
	$("#recoverformStepTwo").animate({left:'450px'},speed);
	$("#recoverformStepThree").animate({left:'450px'},speed);
	
	$('#to-recover').click(function(){
		$("#loginform").animate({left:'-450px'},speed,function(){$("#loginform").hide();
			comeBack("recoverform");
			getStepOut(step);
			$("div.step").slideDown("slow");
		});
	});
	$('#to-login').click(function(){
		
		$("#recoverform").animate({left:'450px'},speed,function(){$("#recoverform").hide();
			comeBack("loginform");
		});
			$("div.step").slideUp("slow");
			step=1;
	});
	$('#nextStepTwo').click(function(){
		var url = "/dmis/System/NameAndVerfiCheck";
		var data = $("#recoverform").serialize();
		alertTip("<img src='"+hostPath+"images/loading.gif' width='50px' height='50px'>");
		$.post(url,data,function(result){
			if(result == "0")
				alertTip("验证码错误！");
			else if(result == "1")
				alertTip("用户名不存在！");
			else{
				var objs = eval(result);
				var obj = objs[0];
				$("#findName").text(obj.name);
				$("input#putName").val(obj.name);
				$("input#question").val(obj.question);
				$("input#getAnswer").val(obj.answer);
				$("input#putAnswer").val(obj.answer);
				alertClose();
				$("#recoverform").animate({left:'-450px'},speed,function(){$("#recoverform").hide();
				comeBack("recoverformStepTwo");
				step=2;
				getStepOut(step);
			});
			}
		});
		
	});
	$('#nextStepThree').click(function(){
		var getAnswer = $("input#getAnswer").val();
		var answer = $("input#answer").val();
		if(getAnswer != answer)
			alertTip("答案错误！");
		else
		$("#recoverformStepTwo").animate({left:'-450px'},speed,function(){$("#recoverformStepTwo").hide();
			comeBack("recoverformStepThree");
			step=3;
			getStepOut(step);
		});
		
	});
	$('#parentStepOne').click(function(){
		$("#recoverformStepTwo").animate({left:'450px'},speed,function(){$("#recoverformStepTwo").hide();
			comeBack("recoverform");
			step=1;
			getStepOut(step);
		});
		
	});
	$('#parentStepTwo').click(function(){
		$("#recoverformStepThree").animate({left:'450px'},speed,function(){$("#recoverformStepThree").hide();
			comeBack("recoverformStepTwo");
			step=2;
			getStepOut(step);
		});
		
	});
	
	
	$('#passwordReset').click(function(){
		alertTip("<img src='"+hostPath+"images/loading.gif' width='50px' height='50px'>");
		var passwordData = $("#recoverformStepThree").serialize();
		var url = "/dmis/System/PasswordUpdate";
		if($("#password").val() == $("#newPassword").val())
			if($("#password").val().length < 6)
				alertTip("密码长度小于6位，请重新输入。");
			else
				$.post(url,passwordData,function(result){
					if(result == "success"){
						alertTip("密码重置成功，正在自动跳转至登录页面。。。");	
						setTimeout("location = location",2000);
						
					}
					else
						alertTip("密码重置失败，请重新尝试。。。");	
				});
		else
			alertTip("两次输入不相等，请重新输入。");
	});
    
    if($.browser.msie == true && $.browser.version.slice(0,3) < 10) {
        $('input[placeholder]').each(function(){ 
       
        var input = $(this);       
       
        $(input).val(input.attr('placeholder'));
               
        $(input).focus(function(){
             if (input.val() == input.attr('placeholder')) {
                 input.val('');
             }
        });
       
        $(input).blur(function(){
            if (input.val() == '' || input.val() == input.attr('placeholder')) {
                input.val(input.attr('placeholder'));
            }
        });
    });

        
        
    }
	// 密码找回
	function comeBack(form){
			$("#"+form).show();
			$("#"+form).animate({left:'0px'},speed);
	}
	
	function getStepOut(step){
	switch(step){
		case 1: 
			$("div.step>div").attr("style","opacity:0.4; filter: alpha(opacity=40);");
			$("div#one").removeAttr("style");
			break;
		case 2: 
			$("div.step>div").attr("style","opacity:0.4; filter: alpha(opacity=40);");
			$("div#two").removeAttr("style");
			break;
		case 3: 
			$("div.step>div").attr("style","opacity:0.4; filter: alpha(opacity=40);");
			$("div#three").removeAttr("style");
			break;
		}
	}
	
	//回车登陆
	$("body").keydown(function(event) {

		if (event.keyCode == 13) {
		$("#loginCheck").click();
		}
		});
	
	//用户登录处理	
	$("#loginCheck").click(function(){
		var user = $("#loginform").serialize();
		$.ajax({
			type:"POST",
			url:"/dmis/System/LoginCheck",
			data:user,
			success:function(result){
				if(result == "admin"){
					location.href='/dmis/Admin/getAdminIndex';
				}else 
					alertTip("用户名或密码错误，请重新登录！");
			}
		});
	});
});


	
	