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
$(document).ready(function(){
	
});
</script>
<body>
<div id="talk_room_list" style="border: 1px red solid; display: inline-block">
	대화방 리스트
</div>
<div style="display: inline-block">
	<%@ include file="/WEB-INF/views/member/ask.jsp" %>
</div>
</body>
</html>