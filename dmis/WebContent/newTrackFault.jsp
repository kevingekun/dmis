<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html >
<html>
	<head>

		<title>故障统计</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<title>故障统计</title>
		<link href="../css/reset.css" rel="stylesheet" type="text/css" />
		<link href="../css/style.css"rel="stylesheet" type="text/css" />
		<link href="../css/skin.css" rel="stylesheet" type="text/css" />
		<script src="../js/jquery-1.4.min.js" type="text/javascript"> </script>
		<script language="javascript" src="../js/public.js"></script>
		<script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js"></script>

<script language="javascript">
	//var flag1=false;
	//$(function(){//整个界面装载完之后再处理function
	//$("#city").change(function(){
	
	//var city=$(this).val();
	
	//$.post(//Ajax操作，向业务层发送数据
	//"<%=basePath%>mitor/showRadarState.action
	//",请求地址
	//{"cityId":city},//发送的数据(json格式)
	//function(data){//回调函数,data是返回的结果(json格式)
	//flag1=true;
	//},
	//"json"//前后台数据通信的约定格式
	//);
	//location.reload();
	//});
	//});

	$(function(){
		//省变化
		$("#province").change(function(){
			var province=document.getElementById("province").value;
			//alert("12");
			$.post(
				"<%=basePath%>track/linkAreaPro.action",
				{"areaunitidprovince":province},
				function(data){
					var json = '{"areaunit":'+data.jsonareaunitpro+'}';
					var obj = eval ("(" + json + ")");
					//alert(obj.equipclass[0].equipmentclassname);//测试
		
					//上一级change 下一级清空
					var selObj_city = document.getElementById("city");
					var option_f_city = selObj_city.options[0];
					selObj_city.options.length = 0;
					selObj_city.options.add(option_f_city);//置为第0个？
					
					var selObj_county = document.getElementById("county");
					var option_f_county = selObj_county.options[0];
					selObj_county.options.length = 0;
					selObj_county.options.add(option_f_county);
					
		
					if(obj.areaunit.length!=0){
						for(var i = 0 ; i<obj.areaunit.length ; i++){
							$("<option value='"+obj.areaunit[i].areaunitid+"'>"+obj.areaunit[i].areaunitname+"</option>").appendTo("#city");
						}  
					}
				},
				"json"
			);
		});
		
		//市变化
		$("#city").change(function(){
			var city=document.getElementById("city").value;
			//alert("123");
			$.post(
				"<%=basePath%>track/linkAreaCity.action",
				{"areaunitidcity":city},
				function(data){
					var json = '{"areaunit":'+data.jsonareaunitcity+'}';
					var obj = eval ("(" + json + ")");
					//alert(obj.equipclass[0].equipmentclassname);//测试
		
					//上一级change 下一级清空
					var selObj_county = document.getElementById("county");
					var option_f_county = selObj_county.options[0];
					selObj_county.options.length = 0;
					selObj_county.options.add(option_f_county);
					
					
					if(obj.areaunit.length!=0){
						for(var i = 0 ; i<obj.areaunit.length ; i++){
							$("<option value='"+obj.areaunit[i].areaunitid+"'>"+obj.areaunit[i].areaunitname+"</option>").appendTo("#county");
						}  
					}
				},
				"json"
			);
		});
		
		//县变化
		$("#county").change(function(){
			var county=document.getElementById("county").value;
			$.post(
				"<%=basePath%>track/linkAreaCounty.action",
				{"areaunitidcounty":county},
				function(data){
					var json = '{"areaunit":'+data.jsonequipclass2+'}';
					var obj = eval ("(" + json + ")");
					
				},
				"json"
			);
		});
	});
</script>
	</head>

	<body>
	<table class="navposition" cellpadding="0" cellspacing="0">
			<tr>
				<td class="titleBg leftwidth">
					<div class="titleLeft">
						&nbsp;
					</div>
				</td>
				<td class="titleBg title">
					<span>当前位置：</span><span>设备追踪&nbsp;&gt;&gt;&nbsp;故障统计</span>
				</td>
				<td class="titleBg rightwidth">
					<div class="titleRight">
						&nbsp;
					</div>
				</td>
			</tr>
		</table>
		
		<div class="detail">
			<form action="<%=basePath%>track/AreaFiltSearchStation.action" method="post">			
				<table class="toolbar" cellpadding="0%" cellspacing="0%" >
					<tr>
						<td width="10" class="text">
							省：
						</td>
						<td  class="value width50" align="left" width="15">
							<select name="province" id="province">
								<option value="-1">
									请选择.....
								</option><!-- 迭代输出省份 -->
								<c:forEach items="${provinceunitlist}" var="provinceunit">
									<option name="province" value="${provinceunit.areaunitid}">${provinceunit.areaunitname}</option>
								</c:forEach>
							</select>
						</td>
						<td width="10" class="text">
							市：
						</td>
						<td  class="value width60" width="15">
							<select name="city" id="city">
								<option value="-1">
                          			  请选择.....
                       		 </option>
							</select>
						</td>
						
						<td  width="10" class="text">
							县：
						</td>
						<td width="60" class="value width60" width="15">
							<select name="county" id="county">
									<option value="-1">
                          			  请选择.....
                       		 		</option>
							</select>
						</td>
					</tr>
					<tr>
						<td   width="10" class="text">
						台站名：
					</td>
					<td class="value width150">
						<input name="stationname" type="text" id="stationname" />
					</td>
					<td  class="text" align=“left” >开始时间：</td>
					<td  class="text ">
						<input name="begintime" id="begintime"  value="${begintime}" type="text" class="Wdate"  onclick="WdatePicker()"  size="20"/>
					</td>
					<td  class="text" align=“left” >结束时间：</td>
					<td  class="text">
						<input name="endtime" id="endtime"  value="${endtime}" type="text" class="Wdate"  onclick="WdatePicker()"  size="20"/>
					</td>
						<td width="60" class="operate">
							<input type="submit" value="查询" " />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<%--<div class="detail">
			<table class="toolbar" cellpadding="0" cellspacing="0" align="center">
				<tr>
					<td class="text">
						台站名：
					</td>
					<td class="value width150">
						<input name="stationname" type="text" id="stationname" />
					</td>
					<!--  
					<td class="text">
						设备类别码：
					</td>
					<td class="value width150">
						<input name="userid" type="text" id="userName" />
					</td>
					-->
					<td class="operate">
						<input type="button" value="查询" onclick="find()" class="seach_bot" />
					</td>
					
				
				</tr>
				
			</table>
		</div>


		--%>
		<div class="detail">

			<table class="gridview" cellspacing="1" rules="all" border="1" id="GVUser">
                <thead>
				<tr class="head">

					<th scope="col" width="10%">
						序号
					</th>
					<th scope="col" width="20%">
						台站名
					</th>				
					<th scope="col" width="20%">
						地区
					</th>
					<th scope="col" width="20%">
						总维修次数
					</th>
					<th scope="col" width="20%">
						总维修花费
					</th>
					<th scope="col" width="10%">
						查看设备
					</th>
				</tr>
	</thead>
		
		
	<tbody>
				<c:if test="${!empty trackstationslist}">
					<c:forEach items="${trackstationslist}" var="trackstation" varStatus="index">
						<tr  >
							<td align="center">
								${index.index+1 }
							</td>
							<td align="center">
								${trackstation.stationname }
							</td>
							<td align="center">
								${trackstation.area}
							</td>
							<td align="center">
								${trackstation.stationtotalmaintenancetimes}
							</td>
							<td align="center">
								${trackstation.stationtotalmaintenancefee}
							</td>
							<td align="center" class="detail">
								<a href="trackFaultDetailPage.action?stationnumber=${trackstation.stationnumber}" >查看设备</a>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			<!-- 在列表数据为空的时候，要显示的提示信息 -->
			<c:if test="${empty trackstationslist}">
				<tr>
					<td colspan="7" align="center" bgcolor="#EFF3F7" class="TableBody1"
						onmouseover="this.bgColor = '#DEE7FF';"
onmouseout="this.bgColor = '#EFF3F7';"
>
						没有找到相应的数据
					</td>
				</tr>
			</c:if>
				
				
		</tbody>		
				
			</table>
		</div>
		
		
		
	<div align="center">	
	
		   <!-- 首页 -->
        <s:form  action="faultTrackStationSearch.action" theme="simple"  >
        <s:url id="url_first" value="faultTrackStationSearch.action">
            <s:param name="curpage" value="1"></s:param>
        </s:url>
        <!-- 上一页 -->
        <s:url id="url_pre" value="faultTrackStationSearch.action">
            <s:param name="curpage" value="curpage-1"></s:param>
        </s:url>
        <!-- 下一页 -->
        <s:url id="url_next" value="faultTrackStationSearch.action">
            <s:param name="curpage" value="curpage+1"></s:param>
        </s:url>
        <!-- 末页 -->
        <s:url id="url_last" value="faultTrackStationSearch.action">
            <s:param name="curpage" value="stationtotalPages"></s:param>
        </s:url>
        <!-- 如果不是首页则提供首页的链接,如果是首页则不提供链接,以下类似 -->
        <s:if test="curpage != 1">
            【<s:a href="%{url_first}">首页</s:a>】     
        </s:if>
        <s:else>
            【首页】
        </s:else>
        <s:if test="curpage>1">
            【<s:a href="%{url_pre}">上一页</s:a>】
        </s:if>
        <s:else>
            【上一页】
        </s:else>
      
 	
      	&nbsp;<s:textfield size="1"  name="curpage" label="跳转页面" theme="simple"></s:textfield>
      <s:submit value="GO" theme="simple" ></s:submit>
     
        <s:if test=" stationtotalPages > curpage ">
            【<s:a href="%{url_next}">下一页</s:a>】
        </s:if>
        <s:else>
           【下一页】
        </s:else>
        <s:if test="stationtotalPages != curpage">
            【<s:a href="%{url_last}">末页</s:a>】
        </s:if>
        <s:else>
           【末页】
        </s:else>
        
      共${stationcount}条记录 /共${stationtotalPages}页
  
	 </s:form>
		</div>	
		
	</body>
</html>
