<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%@ include file="/WEB-INF/views/common/header_logout.jsp" %>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>

</script>
<body>
	<!--자바에서 결과가 false면 login.jsp 뷰 + 아이디값 모델로 보내서 그대로 다시 채워주고 메세지 띄워주기  -->
	<form action="loginProcess" method="post">
		<input type="text">
		<input type="password">
		<input type="submit" value="로그인">
	</form>
</body>
</html>