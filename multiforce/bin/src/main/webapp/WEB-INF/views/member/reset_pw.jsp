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
	$("#email_select").on("change",function () {
		if ($("#email_select").val() == "직접입력") {
			$("#user_email_dir").css("display","inline-block");
		}else {
			$("#user_email_dir").css("display","none");
			$("user_email_dir").val("");
			$("#email").val($("#user_email").val()+"@"+$("#email_select").val());
		}
	});
	
	$("#user_email").on("change", function(){
		if ($("#email_select").val() == "직접입력") {
			$("#email").val($("#user_email").val()+"@"+$("#user_email_dir").val());
		}else {
			$("#email").val($("#user_email").val()+"@"+$("#email_select").val());
		}
	});
	
	$("#reset_pw_btn").on("click", function(){
		$("#sending_msg").css("display","inline-block");
		$.ajax({
			url: "resetpw",
			data:{
				'email': $("#email").val(),
				'id' : $("#id").val()
				},
			type: 'post',
			dataType: 'json',
			success: function(response){
				$("#sending_msg").css("display","none");
				if(response.result == "전송 완료"){
					alert("메일을 발송했습니다. 메일을 확인해주세요.");
					console.log("전송완료");
				}else if(response.result == "메일 전송 오류"){
					alert("오류로 인해 메일이 발송되지 않았습니다. 잠시 후 다시 시도해주세요.");	
				}else if(response.result == "결과 없음"){
					alert("메일을 발송했습니다. 메일을 확인해주세요.");
					console.log("결과없음");
				}else if(response.result == "임시 비밀번호 설정 오류"){
					alert("오류로 인해 메일이 발송되지 않았습니다. 잠시 후 다시 시도해주세요.");
				}
			},
			error: function(request, e){
				alert("코드=" + request.status + " 메세지=" + request.responseText + " 오류=" + e);
			}
		});
	});
	
});
</script>
<body>
<h1>비밀번호 재설정</h1>
<input type="text" class="text" id="id" placeholder="아이디를 입력해주세요"><br>
<input type="text" class="text" id="user_email" placeholder="이메일을 입력해주세요" >
@
<select id="email_select">
	<option>naver.com</option>
	<option>gmail.com</option>
	<option>daum.net</option>
	<option>직접입력</option>
</select>
<input type="text" class="text" id="user_email_dir" placeholder="도메인을 입력해주세요" style="display:none" >
<input type="hidden" id="email" name="email">
<input type="submit" id="reset_pw_btn" value="비밀번호 재설정">
<span id="sending_msg" style="display: none">발송 중</span><br>
<a href="login">로그인</a>
<a href="findid">아이디 찾기</a>

</body>
</html>