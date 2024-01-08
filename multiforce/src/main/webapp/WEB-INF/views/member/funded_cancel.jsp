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
<body>

<h1>후원이 취소되었습니다.</h1>
<div id="프로젝트 마감일">24.02.01</div>까지 다시 후원할 수 있습니다.
<p>

<div>
	<div>
		<span>후원 번호</span> <span id="후원 고유번호">333333</span>가 취소되었습니다.
	</div>
	<div>
		<span>프로젝트 </span> <span id="긴제목">프로젝트 긴제목</span>
	</div>
	<div>
		<span>창작자 </span> <span id="프로젝트 회원번호">런워크</span>
	</div>
	<div>
		<span>선택한 선물 </span> <span id="꾸러미 아이템">[얼리버드] 세트</span>
		<ul>
			<li>아이템</li>
				<div>옵션명</div>			
		</ul>
	</div>
	<div>
		<span>후원 금액 </span> <span id="총결제금액">50000원</span>
	</div>

<p>
<input type="button" value="후원한 프로젝트 목록">
</div>



</body>
</html>