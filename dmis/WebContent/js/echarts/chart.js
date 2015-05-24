var count_cat = new Array();
var count_lev = new Array();
var count_dld = new Array();
$.ajax({
	type:'get',
	dataType:'json',
	url:'Doc/categoryCount',
	success:function(jsonData){
		count_cat = jsonData;
	},
	error:function(){
		alert("count_cat error");
	}
});
$("#btn1").click(function(){
	$.ajax({
		type:'get',
		dataType:'json',
		url:'Doc/categoryCount',
		success:function(jsonData){
			count_cat = jsonData;
		},
		error:function(){
			alert("暂无数据...");
		}
	});
	setTimeout(docCategory, 200);
});
$("#btn2").click(function(){
	$.ajax({
		type:'get',
		dataType:'json',
		url:'Doc/levelCount',
		success:function(jsonData){
			count_lev = jsonData;
		},
		error:function(){
			alert("暂无数据...");
		}
	});
	setTimeout(docLevel, 200);
});
$("#btn3").click(function(){
	$.ajax({
		type:'get',
		dataType:'json',
		url:'Doc/downloadCount',
		success:function(jsonData){
			count_dld = jsonData;
		},
		error:function(){
			alert("暂无数据...");
		}
	});
	setTimeout(docDownload, 500);
});

function docDownload(num){
	var n = num;
	if(n==null){
		n=4;
	}
	var dldChart = echarts.init(document.getElementById('docChart'));
	option = {
		    title : {
		        text: '文档下载量统计',
		        subtext: 'professional statistical'
		    },
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['']//2015年
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType: {show: true, type: ['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'value',
		            boundaryGap : [0, 0.01]
		        }
		    ],
		    yAxis : [
		        {
		            type : 'category',
		            data : ['巴西','印尼','美国','印度','中国','世界人口(万)']
		        }
		    ],
		    series : [
		        {
		            name:'',//2015年
		            type:'bar',
		            data:[18203, 23489, 29034, 104970, 131744, 630230]
		        }
		    ]
		};
	option.yAxis[0].data=count_dld[0+(n-4)*2];
	option.series[0].data = count_dld[1+(n-4)*2];
	option.legend.data[0] = count_dld[n];
	option.series[0].name = count_dld[n];
	dldChart.setOption(option);
	if(n==4){
		$("#yearChangeId").click(function(){
			docDownload(5);
		});
		$("#yearChangeId")[0].innerHTML=count_dld[5]+"排行";
	}else{
		$("#yearChangeId").click(function(){
			docDownload(4);
		});
		$("#yearChangeId")[0].innerHTML=count_dld[4]+"排行";
	}
	$("#yearChange").removeAttr("style");
}
function docLevel(){
	
	$("#yearChange").attr("style","display:none;");
	var levChart = echarts.init(document.getElementById('docChart'));
	option = {
		    title : {
		        text: '文档等级统计',
		        subtext: 'professional statistical',
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient : 'vertical',
		        x : 'left',
		        data:['一类文档','二类文档','三类文档']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType : {
		                show: true, 
		                type: ['pie', 'funnel'],
		                option: {
		                    funnel: {
		                        x: '25%',
		                        width: '50%',
		                        funnelAlign: 'left',
		                        max: 1548
		                    }
		                }
		            },
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    series : [
		        {
		            name:'By DMIS',
		            type:'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[
		                {value:0, name:'一类文档'},
		                {value:0, name:'二类文档'},
		                {value:0, name:'三类文档'}
		            ]
		        }
		    ]
		};
	option.series[0].data[0].value=count_lev[0];
	option.series[0].data[1].value=count_lev[1];
	option.series[0].data[2].value=count_lev[2];
	levChart.setOption(option);
}

function docCategory(){
	
	$("#yearChange").attr("style","display:none;");
	var catChart = echarts.init(document.getElementById('docChart'));
	var option = {
			tooltip : {
				show : true
			},
			legend : {
				data : [ '文档类型统计' ]
			},
			xAxis : [ {
				type : 'category',
				data : [ "doc", "docx", "pdf", "ppt", "pptx", "xls", "xlsx" ]
			} ],
			yAxis : [ {
				type : 'value'
			} ],
			series : [ {
				"name" : "文档类型统计",
				"type" : "bar",
				"data" : count_cat
			} ]
		};
	option.series[0].data = count_cat;
	catChart.setOption(option);
}
setTimeout(docCategory, 500);//页面首次加载时显示‘文档类型统计’，延时处理