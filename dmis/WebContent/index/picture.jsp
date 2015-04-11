<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="en">
<base href="<%=basePath %>">
<head>
<title>查询</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/picture.css" />
<link href=" font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link
	href='css/goolefont.css'
	rel='stylesheet' type='text/css'>
</head>
<body>

	<!--Header-part-->
	<div id="header">
		<h1>
			<a href="#">Matrix Admin</a>
		</h1>


	</div>
	<div id="header1">
		<ul id="topMenu">
			<li class="firstChild"><a href="#">首页</a></li>
			<li><a href="#">个人中心</a></li>
			<li><a href="#">查询</a></li>
		</ul>
	</div>
	<div style="margin-left: 40%">
		<input type="text"
			style="width: 200px; border-radius: 10px; background-color: white;"
			placeholder="Search here..." /> &nbsp;
		<button type="submit" style="background-color: #28b779; border: 0px;"
			class="tip-bottom" title="Search">
			<i class="icon-search icon-white"
				style="opacity: 0.8; color: #fff; background-color: #28b779;"></i>词条查询
		</button>
		&nbsp;
		<button type="submit" style="background-color: #28b779; border: 0px;"
			class="tip-bottom" title="Search">
			<i class="icon-search icon-white"
				style="opacity: 0.8; color: #fff; background-color: #28b779;"></i>文库查询
		</button>
	</div>
	<!--close-Header-part-->

	<!--top-Header-menu-->

	<div id="user-nav" class="navbar navbar-inverse">
		<ul class="nav">

			<li class=""><a title="" href="#"><i class="icon icon-user"></i>
					<span class="text">张三</span></a></li>
			<li class=""><a title="" href="#"><i class="icon icon-cog"></i>
					<span class="text">个人中心</span></a></li>
			<li style="border-right: 0px"><a title="" href="login.html"><i
					class="icon icon-share-alt"></i> <span class="text">退出</span></a></li>
		</ul>
	</div>

	<!--start-top-serch-->


	<div class="row-fluid" style="margin-left: 200px;">
		<div class="span12">
			<div class="widget-box">

				<div class="widget-content">
					<ul class="thumbnails">

						<img src="img/gallery/imgbox5.jpg" width="790"
		height="440" name="img">
					</br>
						<INPUT TYPE="button" style="margin-left: 300px" value="上一张"
							onClick='playS();'>
						<INPUT TYPE="button" value="下一张" onClick='playImg();'>


					</ul>

				</div>
			</div>
		</div>
	</div>

	<div id="footer" class="span12">	2013 &copy; 2014 &copy; 硬件安全研究所</div>
</body>
<script language="JavaScript">

function ImgArray(len)
{
	this.length=len;
	 }
	ImgName=new ImgArray(7);
	ImgName[0]="img/gallery/imgbox3.jpg";
	ImgName[1]="img/gallery/imgbox4.jpg";
	ImgName[2]="img/gallery/imgbox5.jpg";
	ImgName[3]="img/gallery/imgbox1.jpg";
	ImgName[4]="img/gallery/imgbox2.jpg";
	ImgName[5]="img/gallery/imgbox3.jpg";
	ImgName[6]="img/gallery/imgbox5.jpg";
	    
	var t=0;
	function playImg()
{
	if (t==6)
{t=0;}
 else
{t++;}
	    
	   

	 img.src=ImgName[t];
	
	}

	function playS()

	   {    
	    if (t==0)
	
	    {t=6;}

	  else

	    {t--;}
	  
	
 img.src=ImgName[t];

}
</script>

</html>