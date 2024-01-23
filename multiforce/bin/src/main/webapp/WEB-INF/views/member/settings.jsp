<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<script>
$(document).ready(function() {
	
	//이메일 변경 
    $("#email_btn").click(function() {
        if ($("#email_btn").val() == "변경") {

            $("#email_btn").val("수정");
            $("#email_origin").hide();
            $("#email_text").show();
        } else {
            // 수정 버튼을 누르면 Ajax로 전송.
            var newEmail = $("#email_new").val();

            $.ajax({
                type: "POST",
                url: "/changeEmail",
                data: { newEmail: newEmail },
                success: function(response) {
                    
                    $("#email_origin").text(newEmail);
                    $("#email_btn").val("변경");
                    $("#email_origin").show();
                    $("#email_text").hide();
                },
                error: function(error) {
                    console.error(error);
                }
            });
        }
    });
	
	
	
	//비번 변경 버튼값
    $("#pw_btn").click(function() {
        if ($("#pw_btn").val() == "변경") {
            $("#pw_btn").val("취소");
            $("#pw_text").show();
        } else {
        	 $("#pw_btn").val("변경");
        	 $("#pw_text").hide();
        }
	})
	
	
	//비번 변경 ajax
	$("#pw_save").click(function() {
		var newPw = $("#pw_new").val();
		
        $.ajax({
            type: "POST",
            url: "/changePw",
            data: { newPw: newPw },
            success: function(response) {                

                $("#pw_btn").val("변경");
                $("#pw_text").hide();
            },
            error: function(error) {
                console.error(error);
            }
        });
		
		
		
	})//비번 ajax
	
	
});
</script>



<body>
<div>
	<div>프로필</div>
	<div>계정</div>
	<div>결제수단</div>
	<div>배송지</div>
</div>
<p>
<hr>

<div><!-- 계정 -->
	<div>
		<div>이메일</div>
		<div id="email_origin">aaa@naver.com</div>
		<div style="display: none;" id="email_text"><input type="text" id="email_new"></div>
		<input type="button" id="email_btn" value="변경">
		<hr>
	</div>
	
	<div>
		<div>비밀번호</div>
		<div style="display: none;" id="pw_text">
			<div>현재 비밀번호</div>
			<div><input type="text" id="" placeholder="현재 비밀번호"></div>
			<p>
			<div>변경할 비밀번호</div>
			<div><input type="text" id="pw_new" placeholder="변경할 비밀번호"></div>
			<div><input type="text" id="pw_new_check" placeholder="변경할 비밀번호 확인"></div>
			<div><input type="button" id="pw_save" value="저장"></div>			
		</div>
		<input type="button" id="pw_btn" value="변경">
		<hr>
	</div>
</div>

</body>



</html>