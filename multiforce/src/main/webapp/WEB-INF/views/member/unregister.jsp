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
<link rel="stylesheet" href="/css/member/unregister.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>

<script>
$(document).ready(function() {
	
	$("#btn").click(function() {
		if(!$("#check").prop("checked")){
			$(".check_res").html(" 유의사항을 확인해주세요.");			
		}else if ($("#check").prop("checked")){
			$(".check_res").html("");
			
			var memberSeq = ${loginMember.member_seq};
			
			$.ajax({
		        type: "POST",
		        url: "/member_unregister",
		        data: {
		        	"memberSeq" : memberSeq
		        },		        
		        success: function(response) { 
		        	if (response == "resign 업데이트") {
		        		alert("탈퇴 완료되었습니다.")
		        		window.location.href = "/logout";
		        	}else {
		        		console.log(response)
		        	}    		

		    	},
				error: function(error) {
				       console.log(error);
				}
		     });	
			
		}
	});
	
	
	

	
});
</script>

<body>
<div class="wrap">
	<div class="out_con">				
	
			<div class="leave_title">회원 탈퇴</div>
			
			<div class="leave_title2">탈퇴 전, 유의 사항을 확인해주세요.</div>
			<hr class="menu_under_hr">
	
			<div class="leave_con">
				<div class="leave_footer_title">후원 및 결제</div>
					<ul>
						<li> <strong>이미 결제된 후원은 취소되지 않습니다.</strong></li>
						<li> 결제 완료 후 탈퇴하더라도, 선물 전달이 완료될 때까지 <strong>창작자가 배송 정보를 열람할 수 있습니다.</strong></li>
						<li> 관련 법령에 따라 후원 및 후원취소에 관한 기록, 결제 및 선물 전달에 대한 기록은 5년 동안 보관됩니다.</li>
					</ul>							
			
				
				<hr class="dividing_hr">
				
				<div class="leave_footer_title">프로젝트</div>
					<ul>
						<li> 작성중, 제출, 반려 및 승인된 프로젝트는 모두 삭제됩니다.</li>
						<li> 펀딩 진행중인 프로젝트는 모두 중단됩니다.</li>
						<li> <strong>펀딩이 종료된 프로젝트는 삭제되지 않습니다.</strong></li>
					</ul>		
			
				<hr class="dividing_hr">
				
				<div class="leave_save_out">
					<div class="leave_save_inner">
						<input type="checkbox" id="check" > 탈퇴 유의사항을 확인했습니다.
						<span class="check_res" style="color: #fc035a; font-size: 13px;"></span>					
					</div>
					<input type="button" value="클릭시 탈퇴 처리됩니다." id="btn">			
				</div>
				
			</div>
				
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>
</body>
</html>