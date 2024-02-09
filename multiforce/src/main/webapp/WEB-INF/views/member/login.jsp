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

<body>
<div class="wrap">
	<div class="out_con">
		<div class="login_con">
			<div id="login_ment">세상에 하나뿐인 특별한 프로젝트를 발견해보세요.</div>
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
						<input type="submit" id="login_btn_loginpage" value="로그인">
					</div>
				</form>
				
				<div id="menu_list_wrap">
					<div class="menu_wrap">
						<div class="menu_wrap_ment"> 아직 계정이 없으신가요?</div>
						<div class="menu_wrap_href"> <a href="signup">회원 가입</a></div>					
					</div>
					<div class="menu_wrap">
						<div class="menu_wrap_ment"> 아이디를 잊으셨나요?</div>
						<div class="menu_wrap_href"> <a href="findid">아이디 찾기</a></div>					
					</div>
					<div class="menu_wrap">
						<div class="menu_wrap_ment"> 비밀번호를 잊으셨나요? </div>
						<div class="menu_wrap_href"><a href="resetpw">비밀번호 재설정</a></div>					
					</div>
				</div>	
				
			</div>		
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>
</body>
</html>