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
	
    $("ul li").click(function() {
        var section = $(this).data("section");
        location.href = '/' + section;
    }); //각 항목 클릭시 url 이동	 
    
})//ready

</script>



<body>

<div class="">
	<div>로그인</div>
		<ul class="">
		    <li style="cursor:pointer;" data-section="myprofile">프로필</li>
		    <li style="cursor:pointer;" data-section="funded">후원한 프로젝트</li>
		    <li style="cursor:pointer;" data-section="mydibs">관심 프로젝트</li>
		    <li style="cursor:pointer;" data-section="follow">팔로우</li>
		    <li style="cursor:pointer;" data-section="message">메시지</li>
		    <li style="cursor:pointer;" data-section="myproject">내가 만든 프로젝트</li>
		    <li style="cursor:pointer;" data-section="settings">설정</li>
		    <li style="cursor:pointer;" data-section="aaaaaa">로그아웃</li>
	  	</ul>
</div>

</body>
</html>