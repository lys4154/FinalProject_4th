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

var chatroomSeq = 0;
var readAt = 0;
var whoAmI = "asker";
var commonDate = "";
/*
if("${dto.asker_seq}" != "${login_user_seq}"){
	alert("잘못된 접근입니다.");
	location.href = "/";
}
*/
$(document).ready(function(){
	
	//현재 url이 ask인가 allask 인가
	//ask면 바로 랜더링
	//allask면 대기
	if(location.pathname = "ask"){
		if("${result}" == "채팅기록 있음"){
			chatroomSeq = "${dto.chatroom_seq}";
			appendChat("${dto.chat}", "${dto.asker_read}");
			$.ajax({
				data: {
					chatroom_seq: chatroomSeq,
					who_am_i: whoAmI,
					read_at: readAt
				},
				type : "POST",
				url : "/updatemyread",
				dataType: 'json',
				success : function(r){
					if(r.result == 0){
						alert("알 수 없는 오류가 발생했습니다");
					}else{
						$("#input_my_chat").val("");
						appendChat(myChat);
					}
				}
			});
		}
	}
	
	function fillChatInfo(longTitle, projectUrl, mainImagesUrl){
		$("#project_img").attr("href", mainImagesUrl);
		$("#project_long_title").html("<a href='"+projectUrl+"'></a>");
		$("#project_long_title a").text(longTitle);
	}
	
	function appendChat(allChat, read){
		chatArr = allChat.split("|");
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
			
			if(i == read){
				$("#chat_list").append("<div style='text-align:center'>(여기까지 읽으셨습니다)</div>");
			}
			
			$("#chat_list").append(createChatForm(chatDateStr, chatTimeStr, chatterSeq, chatContent));
		}
	}
	
	function clearChatList(){
		$("#chat_list").html("");
	}
	function clearProjectInfo(){
		$("#project_img").attr("href", "");
		$("#project_long_title").html("");
	}
	
	function createChatForm(chatDate, chatTime, chatterSeq, chatContent, img, nickname){
		if(chatDate != commonDate){
			//채팅에 있는 날짜가 commonDate의 날짜와 다르다면 채팅창에 날짜 넣어주기
			commonDate = chatDate;
			$("#chat_list").append("<div class='common_date'>"+"======"+commonDate+"======"+"</div>");
		}
		let chatForm = $(".chat_form").clone();
		if(chatterSeq == "${login_user_seq}"){
			chatForm.attr("class", "my_chat");
			chatForm.find(".message").text(chatContent);
			chatForm.prepend("<div class='time_part' style='display:inline-block'>"+chatTime+"</div>");
		}else{
			chatForm.attr("class", "opponent_chat");
			chatForm.find(".message").text(chatContent);
			chatForm.find(".sender img").attr("href", img);
			chatForm.find(".sender span").text(nickname);
			chatForm.append("<div class='time_part'>"+chatTime+"</div>");
		}
		return chatForm;
	}
	
	$("#send_my_chat").on("click", function(){
		let myChat = myChatPlusInfo($("#input_my_chat").val());	
		//채팅기록이 없을 경우
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
					if(r.result == 0){
						alert("알 수 없는 오류가 발생했습니다");
					}else{
						$("#input_my_chat").val("");
						appendChat(myChat);
					}
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
<div id="chatting_space">
	<div id="project_info">
		<img id="project_img">
		<div id="project_long_title"></div>
	</div>
	<div id="chat_list" style="border: 1px black solid">
	</div>
	<textarea id="input_my_chat"></textarea>
	<input type="button" id="send_my_chat" value="보내기">
	
	<!-- 채팅 폼 -->
	<div class="chat_form">
		<div class="text_part"  style='display:inline-block'>
			<div class="sender" style='display:inline-block'>
				<img>
				<span>
				</span>
			</div>
			<div class="message" style='display:inline-block'>
			</div>
		</div>
	</div>
</div>
</body>
</html>