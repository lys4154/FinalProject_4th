<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.7.1.min.js"></script>
<style>
div[class*="_chatroom_wrap"]{
	border: 1px solid black;
	cursor: pointer;
}
</style>
<body>
<div id="talk_room_list" style="border: 1px red solid; display: inline-block">
	<div id="my_project_ask">
		<h3>내 프로젝트 문의</h3>
		<c:if test="${fn:length(collector) == 0}">
			<c:out value="결과 없음"/>
		</c:if>
		<c:forEach var="item" items="${collector }">
			<div class="collector_chatroom_wrap" id="chatroom_${item.chatroom_seq }">
				${item.long_title }/
				${item.last_chat }/
				${item.last_chat_date }
			</div>
		</c:forEach>
	</div>
	<div id="project_ask">
		<h3>프로젝트 문의</h3>
		<c:if test="${fn:length(asker) == 0}">
			<c:out value="결과 없음"/>
		</c:if>
		<c:forEach var="item" items="${asker}">
			<div class="asker_chatroom_wrap" id="chatroom_${item.chatroom_seq }">
				${item.long_title }/
				${item.last_chat }/
				${item.last_chat_date }
			</div>
		</c:forEach>
	</div>
</div>
<div style="display: inline-block">
	<%@ include file="/WEB-INF/views/member/ask.jsp" %>
</div>
</body>
<script>
//채팅방 클릭 시 채팅화면 띄워주기
$("div[class*='_chatroom_wrap']").on("click", function(e){
	console.log("클릭확인");
	whoAmI = e.target.getAttribute("class").substr(0, e.target.getAttribute("class").indexOf("_"));
	chatroomSeq = e.target.getAttribute("id").substr(e.target.getAttribute("id").indexOf("_") + 1);
	$.ajax({
		data: {
			chatroom_seq: chatroomSeq,
			who_am_i: whoAmI
		},
		type : "POST",
		url : "/findchatroom",
		dataType: 'json',
		success : function(r){
			console.log("ajax확인");
			clearChatList();
			clearProjectInfo();
			appendChat(r.chat);
			fillChatInfo(r.long_title, r.url, r.main_images_url);
		}
	});
});

</script>
</html>