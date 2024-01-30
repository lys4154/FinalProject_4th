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
	$("#send_my_talk").on("click", function(){
		$.ajax({
			data: {
				my_talk: $("#input_my_talk").val();
			},
			type : "POST",
			url : "/insertmytalk",
			dataType: 'json',
			success : function(r){
				
			}
		});
	});
});
</script>
<body>
<div id="talk_room_list" style="border: 1px red solid">
	대화방 리스트
</div>
<div>
	<div id="talk_list" style="border: 1px black solid">
	안녕
	</div>
	<input type="text" id="input_my_talk">
	<input type="hidden" id="input_chat_room"><!-- 채팅방 번호 넘겨주기 -->
	<input type="button" id="send_my_talk" value="보내기">
</div>
</body>
</html>