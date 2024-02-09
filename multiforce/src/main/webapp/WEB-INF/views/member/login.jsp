<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/css/member/login.css">
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
<header>
	<h1><a href="/">멀티포스 펀딩</a></h1>
</header>
<body>
<div id="login_container">
	<form id="login_form" action="login" method="post" >
		<div id="login_info_wrap" >
			<div class="input_wrap" id="id_input_wrap">
				<input type="text" id="id" name="id" placeholder="아이디를 입력해주세요">
			</div>
			<div class="input_wrap" id="pw_input_wrap">
				<input type="password" id="pw" name="pw" placeholder="암호를 입력해주세요">
			</div>
		</div>
		<div id="login_btn_wrap" >
			<input type="submit" value="로그인">
		</div>
	</form>
	<div id="menu_list_wrap">
		<div class="menu_wrap">
			<a href="signup">회원 가입</a>
		</div>
		<div class="menu_wrap">
			<a href="findid">아이디 찾기</a>
		</div>
		<div class="menu_wrap">
			<a href="resetpw">비밀번호 재설정</a>
		</div>
	</div>

</div>
</body>
</html>