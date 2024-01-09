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
	
    $("div[data-section]").click(function() {
        var section = $(this).data("section");
        location.href = '/' + section;
    }); //각 항목 클릭시 url 이동	 
    
})//ready






</script>



<body>

<div class="">
	<div>로그인</div>

		<form action="myprofile" method="post">
		    <div style="cursor:pointer;" data-section="myprofile">프로필</div>
	    </form>
		    <div style="cursor:pointer;" data-section="funded">후원한 프로젝트</div>
		    <div style="cursor:pointer;" data-section="mydibs">관심 프로젝트</div>
		    <div style="cursor:pointer;" data-section="follow">팔로우</div>
		    <div style="cursor:pointer;" data-section="message">메시지</div>
		    <div style="cursor:pointer;" data-section="myproject">내가 만든 프로젝트</div>
		    <div style="cursor:pointer;" data-section="settings">설정</div>
		    <div style="cursor:pointer;" data-section="aaaaaa">로그아웃</div>
	  	
</div>

</body>
</html>