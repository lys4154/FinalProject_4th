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
    $("#funded_creator").show();
    
    $(".detail-button").click(function () {
        $(".detail-section").hide();
        var targetDetail = $(this).data("target");
        $("#" + targetDetail).show();
    });//각 항목 클릭시

	
})//ready

</script>




<body>

<h1>팔로우</h1>
<p>
<div><!-- 상단 선택바 고정 -->
    <input type="button" class="detail-button" data-target="funded_creator" value="후원한 창작자">
    <input type="button" class="detail-button" data-target="following" value="팔로잉">
    <input type="button" class="detail-button" data-target="follower" value="팔로워">
</div>
<p>

<div>
	<div id="funded_creator" class="detail-section">
	    후원한 창작자들
	</div>
	
	<div id="following" class="detail-section">
	    팔로잉 내용
	</div>
	
	<div id="follower" class="detail-section">
	    팔로워 내용
	</div>
</div>

</body>
</html>