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

    let memberSeq = ${loginMember.member_seq};

	//프로필이미지 변경 클릭
	$("#img_change").click(function() {
		if ($("#img_change").val() === "변경") {
			$("#img_change").val("취소");
			$(".img_container").show();
		} else {
			$(".img_container").hide();
			$("#img_change").val("변경");			
		}		
	});

	//이미지 저장 클릭
	$("#img_save").click(function() {		
		var file = $("#img_upload")[0].files[0];
		var let formData
       $.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: "/profileimg_upload",
	        contentType: false,
	        processData: false,
	        data: {"projectSeq" : projectSeq },
	        success: function(response) {
		    	if(response == "삭제 완료") {
		    		alert("해당 프로젝트가 삭제되었습니다.");
		    		window.location.href ="/myproject"
					}
	        },
			error: function(error) {
			       console.log(error);
				}
	     });
			
	});
	
	
});
</script>



<body>

<h1>설정</h1>

<div>
	<div id="profile_detail" style="cursor:pointer;">프로필</div>
	<div id="account_detail" style="cursor:pointer;">계정</div>
	<div id="payment_detail" style="cursor:pointer;">결제수단</div>
	<div id="delivery_detail" style="cursor:pointer;">배송지</div>
</div>
<hr>
<p>

<div class="result">
	<div>
		<div>프로필 사진</div>
		<div><img src="${loginMember.profile_img }"></div>
		<div><input type="button" value="변경" id="img_change"></div>
<!-- 		<form action="profileimg_upload" method="post" enctype="multipart/form-data"> -->
			<div style="display: none;" class="img_container">
				<div><input type="file" value="이미지업로드"  id="img_upload"></div>
				<div><input type="button" value="저장" id="img_save" ></div>
 				<input type="hidden" value="${loginMember.member_seq }">
			</div>
<!-- 		</form>	 -->	
	</div>
	<hr>
	<div>
		<div>이름</div>
		<div>${loginMember.nickname }</div>
		<div><input type="button" value="변경"></div>
	</div>
	<hr>
	<div>
		<div>사용자 이름(URL)</div>
		<div>DB에 없는 상태, 팔로우 팔로잉에서 방문하려면 필요</div>
		<div><input type="button" value="변경"></div>
	</div>
	<hr>
	<div>
		<div>자기소개</div>
        <c:if test="${not empty loginMember.description}">
            ${loginMember.description}
        </c:if>
        <c:if test="${empty loginMember.description}">
            변경 버튼을 눌러 자기 소개를 작성해주세요.
        </c:if>
        <div><input type="button" value="변경"></div>
	</div>
	<hr>
	
	
	
</div>

</body>



</html>