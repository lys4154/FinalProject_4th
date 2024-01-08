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

	let result = "${result}";
	if(result == "실패"){
		alert("아이디, 암호를 다시 입력해주세요");
		$("#id").val("${fail_id}");
	}
	
	let fromPath = window.location.search.substring(6);
	$("#login_form").attr("action", "login?from=" + fromPath);
	
});
</script>
<body>
<h1><a href="/">멀티포스 펀딩</a></h1>
<form id="login_form" action="login" method="post">
	<input type="text" id="id" name="id" placeholder="아이디를 입력해주세요">
	<input type="password" id="pw" name="pw" placeholder="암호를 입력해주세요">
	<input type="submit" value="로그인">
	<br><br><br>테스트용 아이디 test 비번 1234
</form>
<a href="">회원 가입</a>
<a href="">아이디 찾기</a>
<a href="">비밀번호 찾기</a>
</body>
</html>