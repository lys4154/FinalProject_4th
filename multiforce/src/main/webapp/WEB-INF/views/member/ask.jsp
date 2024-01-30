<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>
//이건 프로젝트 내부에서 누를 때
var chatroomSeq = 0;
var whoAmI = "asker";
if("${dto.asker_seq}" != "${login_user_seq}"){
	alert("잘못된 접근입니다.");
	location.href = "/";
}
$(document).ready(function(){
	if("${result}" == "채팅기록 있음"){
		chatroomSeq = "${dto.chatroom_seq}";
		appendChat("${dto.chat}");
	}
	var readAt = 0;
	function appendChat(allChat){
		chatArr = allChat.split("|");
		console.log(chatArr);
		let commonDate = "";
		for(let i = 0; i < chatArr.length - 1; i++){
			readAt += 1;
			let chatSplited = chatArr[i].split("]");
			let chatterSeq = chatSplited[0].substr(1);
			let chatterNickname = chatSplited[1].substr(1);
			let chatDateTime = new Date(chatSplited[2].substr(1));
			let chatContent = chatSplited[3];
			const options = {
					  weekday: "long",
					  year: "numeric",
					  month: "long",
					  day: "numeric",
					  hour: "numeric",
					  minute: "numeric"
					};
			let chatDateTimeStr = chatDateTime.toLocaleString('ko-KR', options);
			let chatTimeStr = chatDateTimeStr.substr(chatDateTimeStr.indexOf("요일") + 3);
			let chatDateStr = chatDateTimeStr.substr(0, chatDateTimeStr.indexOf("요일") + 2);
			if(chatDateStr != commonDate){
				commonDate = chatDateStr;
				$("#chat_list").append("<div class='common_date'>"+"======"+commonDate+"======"+"</div>");
			}
			if(chatterSeq == "${login_user_seq}"){
				$("#chat_list").append("<div class='my_chat'>"+ chatTimeStr + " " +chatContent + "</div>");
			}else{
				$("#chat_list").append("<div class='opponent_chat'>"+chatContent +"</div>");
			}
		}
	}
	
	
	$("#send_my_chat").on("click", function(){
		let myChat = myChatPlusInfo($("#input_my_chat").val());	
		if(chatroomSeq == 0){
			$.ajax({
				data: {
					asker_seq: "${login_user_seq}",
					collector_seq: "${dto.collector_seq}",
					project_seq: "${dto.project_seq}",
					my_chat: myChat
				},
				type : "POST",
				url : "/insertmyfirstchat",
				dataType: 'json',
				success : function(r){
					console.log(r);
					if(r.result == "오류"){
						alert("알 수 없는 오류가 발생했습니다.")
					}else if(r.result == "성공"){
						chatroomSeq = r.chatroom_seq;
						appendChat(myChat);
						$("#input_my_chat").val("");
					}
				}
			});
		}else{
			console.log(readAt);
			$.ajax({
				data: {
					chatroom_seq: chatroomSeq,
					my_chat: myChat,
					who_am_i: whoAmI,
					read_at: readAt + 1
				},
				type : "POST",
				url : "/insertmychat",
				dataType: 'json',
				success : function(r){
					$("#input_my_chat").val("");
				}
			});
		}
	});
	
	function myChatPlusInfo(myChat){
		const TIME_ZONE = 9 * 60 * 60 * 1000;
		let result = "";
		result += "[${login_user_seq}]";
		result += "[${login_user_nickname}]";
		result += "["+new Date(new Date().getTime() + TIME_ZONE).toISOString().replace('T', ' ').slice(0, -5)+"]";
		result += myChat;
		result += "|";
		return result;
	}
});
</script>
<style>
.my_chat{
	text-align: right;
}
.opponent_chat{
	text-align: left;
}
.common_date{
	text-align: center;
}
</style>
<body>
<div>
	<div>
		<div><a href="/user_profile/${dto.member_url }">${dto.nickname }</a></div>
		<div>${dto.long_title }</div>
	</div>
	<div id="chat_list" style="border: 1px black solid">
	</div>
	<input type="text" id="input_my_chat">
	<input type="button" id="send_my_chat" value="보내기">
</div>
</body>
</html>