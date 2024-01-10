<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function(){
	let loginUserLevel = "${login_user_level}"
	if(loginUserLevel == 2){
		$("#write_btn_wrap").html("<button id='write_btn'><a href='notices/write'>글쓰기</a></button>")
	}
});
</script>
<body>
<h1>이벤트</h1>
<div id="write_btn_wrap">
	
</div>
</body>
</html>