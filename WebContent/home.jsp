<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=38c94f403689a40910baa6aa7e797c7d"></script>
	<title>냉장고 관리</title>
	<link rel="stylesheet" href="/style.css"/>	
</head>
<body>
	<div id="divPage">
		<div id="divTop">
			<h1>[냉장고 관리 사이트]</h1>
			<a href="/home"><img src="http://placehold.it/960x180" width=960/></a>
		</div>
		<div id="divCenter">
			<div id="divMenu">
				<jsp:include page="/menu.jsp"/>
			</div>
			<div id="divContent">
				<jsp:include page="${pageName}"/>
			</div>
		</div>
		<div id="divBottom">
			<h4>...</h4>
		</div>
	</div>
</body>
</html>