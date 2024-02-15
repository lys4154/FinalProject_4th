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
<link rel="stylesheet" type="text/css" href="/css/member/welcome.css">
<script>
if("${result}" == "false"){
	alert("회원가입 중 오류가 발생했습니다.<br> 잠시후 다시 시도해주세요");
	href.location = "/";
}
</script>

<body>

<div class="out_con">

	<div>${member_name } 회원님, </div>
	<div>멀티포스 펀딩의 회원이 되신걸 환영합니다.</div>
	
	<div class="go_login"><a href="login">로그인</a> 후 이용해주세요.</div>

</div>	

</body>

</html>