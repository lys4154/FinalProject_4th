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

</script>
<body>
	<div>
<!-- 
	대표 이미지
	긴 제목
	짧은 설명
	진행중이면 시작 + 끝 날짜 들고와서 며칠남았는지 계산
	시작전, 끝이라면 그렇게 표시
	카테고리
	유저의 닉네임 + 유저의 프로필주소 연결해줄 정보
	목표금액, 현재금액 => 계산해서 몇퍼센트 달성중인지 할 수 있다면 그래프도 구현
 -->
 	<c:forEach var="item" items="${list}">
 		<img src="${item.main_images_url}">
 		${item.long_title}
 		${item.sub_title }
 	</c:forEach>
	</div>
</body>
</html>