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
<link rel="stylesheet" href="/css/common/mainpage.css">

<script>

</script>
<style>
img{
	width: 600px;
}
</style>
<body>
<div class="wrap">
	<div class="out_con">
		<h1>메인페이지</h1>
		<c:forEach items="${eventmap }" var="item">
			<a href="${item.key}">${item.value } class = "temp"></a>
		</c:forEach>
		<!-- 
		넣을만한 컨텐츠
		인기순
		에디터 pick(관리자가 찜한거 리스트 보여주기?)
		-->
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>
</body>
</html>