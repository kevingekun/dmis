

/**
 * 使用方法：在调用页面的body标签下面添加
 * <div class="alertMask" style="display: none"></div>
 *	 <div id="alertPanel"></div>
 *
 *	调用alert提示框方法：alertTip(message);
 *	调用confirm提示框方法： alertTip(alertConfirm(message,confirHref));
 *
 * 否则不能正常使用
 * @author Joki
 * @returns alert
 * 
 */

		/**
		 * 重写alert()弹出框
		 */
	
	function alertTip(message){
		
		var $div1 = $('<div />').addClass('closeButton btn btn-danger btn-small')
								.attr('id','closeAlert').html("×");					
		var $div2 = $('<div />').addClass('alertContent').html(message);
		var $div = $('<div />').addClass('alert bg_lg').attr('id','alertBox')
								.append($div1,$div2);
							
		$("#alertPanel").html($div);
		$(".alertMask").removeAttr('style');
		$("#closeAlert").live('click',function(){
			alertClose();
		});
	}
	
	function alertClose(){
		$("#alertBox").remove();
		$(".alertMask").attr('style','display:none');
	}
	
	/**
	 * 重写confirm()弹出框
	 */
	function alertConfirm(message,confirHref){
		
		var $btn_confirm = $('<a />').addClass('btn btn-success btn-mini')
									 .attr('href',confirHref)
									 .attr('id','confir').text('确定');
		
		var $btn_cancle = $('<a />').addClass('btn btn-mini')
									.attr('id','closeAlert')
									.attr('style','margin-left:40px').text('取消');
		
		var $confirDiv = $('<div />').append(message,'<br/><br/>',$btn_confirm,$btn_cancle);

		return $confirDiv;
	}