<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<script>
$(document).ready(function() {	
    $(".detail-section").hide();
    $("#myprofile_detail").show();
    
    $(".detail-button").click(function () {        
        $(".detail-section").hide();
        var targetDetail = $(this).data("target");
        $("#" + targetDetail).show();
    });//각 항목 클릭시

	
})//ready

</script>





<body>

<div><!-- 상단 회원정보 고정 -->
	<div><img alt="프로필 이미지" src=""></div>
	<div>회원 이름</div>
	<div><a href="/settings" ><img alt="회원정보 수정으로 가는 이모티콘" src=""></a></div>
</div>
<p>

<div><!-- 상단 선택바 고정 -->
    <input type="button" class="detail-button" data-target="myprofile_detail" value="프로필">
    <input type="button" class="detail-button" data-target="reviews_detail" value="프로젝트 후기">
    <input type="button" class="detail-button" data-target="myproject_detail" value="올린 프로젝트">
    <input type="button" class="detail-button" data-target="funded_detail" value="후원한 프로젝트">
    <input type="button" class="detail-button" data-target="follower_detail" value="팔로워">
    <input type="button" class="detail-button" data-target="following_detail" value="팔로잉">
</div>
<p>


<div>
	<div id="myprofile_detail" class="detail-section">
	    등록된 자기소개
	</div>
	
	<div id="reviews_detail" class="detail-section">
	    프로젝트 후기
	</div>
	
	<div id="myproject_detail" class="detail-section">
	    올린 프로젝트
	</div>
	
	<div id="funded_detail" class="detail-section">
	    후원한 프로젝트
	</div>
	
	<div id="follower_detail" class="detail-section">
	    팔로워
	</div>
	
	<div id="following_detail" class="detail-section">
	    팔로잉
	</div>
</div>



</body>

</html>