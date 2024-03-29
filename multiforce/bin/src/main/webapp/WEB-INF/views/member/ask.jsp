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
<style>

*{
	font-family: 'Noto Sans KR', sans-serif;
	color: #5c5c5c;	
}
a{
	text-decoration: none;
	color: #292929;
}

.my_chat{
	display: flex;
    flex-direction: row;
    justify-content: flex-end;
    align-items: flex-end;
   	margin: 10px 0;
   	max-width: 400px;
}
.my_chat .message{
	border: none;
	border-radius: 5px;
	background-color: #82c8a0;
	padding: 5px 10px;	
	color: #fff;
}

.opponent_chat{	
	display: flex;
	width: 360px;
	align-items: flex-end;
	margin: 10px 0;	
	max-width: 400px;
}
.opponent_chat .message{
	border: none;
	border-radius: 5px;
	background-color: #f0f0f0;
	padding: 5px 10px;
}
.my_chat .text_part, .opponent_chat .text_part{
	max-width: 300px;
}

.common_date{
	text-align: center;
	margin-bottom: 10px;
}
#project_img{
	width: 100px;
	height: 100px;
	object-fit: cover;
	margin: 10px 0;
}
#chat_list{
	height: 390px;
	overflow-y: auto;
	border-bottom: 1px solid #cfcfcf;
	padding: 10px;
}
#send_chat_wrap{
	font-size: 0px;
}
#input_my_chat{
	width: 340px;
	height: 64px;
	resize: none;
	border: none;
	border-bottom-left-radius: 5px;
	padding: 10px;
}
#input_my_chat:focus{
	outline: none;
}
#send_my_chat{
	width: 80px;
	height: 84px;
	position: absolute;
	float: right;
	border: 0px;
	border-bottom-right-radius: 5px;
	cursor: pointer;
}
#chat_wrap{
	border: 1px solid #cfcfcf;
	width: 440px;
	border-radius: 5px;
	outline: none;
}
#project_info{
	flex-direction: column;
    align-items: center;
    margin: 20px; 
    border: 1px solid #cfcfcf;
    border-radius: 5px;  	
}
#project_long_title{
	margin-bottom: 10px;
}

.text_part{
	display: flex;
	align-items: baseline
}
.time_part{
	font-size: 10px;
}
.sender, .message{
	margin-right: 5px;
}
.sender{
	min-width: fit-content;
}
.chatroom_last_chat_date{
	color: #fc035a;
}


</style>
<body>

<div id="chatting_space">

	<div id="chat_wrap">
		<div id="project_info" style="display: none;">
			<img id="project_img" >
			<span id="project_long_title"></span>
		</div>
		<div id="chat_list">
		</div>
		<div id="send_chat_wrap">
			<textarea id="input_my_chat"></textarea>
			<input type="button" id="send_my_chat" value="보내기">
		</div>
	</div>
</div>	


<!-- 복사용 채팅 폼 -->
<div class="chat_form">
	<div class="text_part"  >
		<div class="sender" >
			<img>
			<span>
			</span>
		</div>
		<div class="message" style='display:inline-block'>
		</div>
	</div>
</div>

</body>
<script>

var chatroomSeq = 0;
var readAt = 0; //기본적으로 0 appendchat으로 올라가는 채팅의 갯수만큼 올림
var whoAmI = "";
var commonDate = "";
//ask로 들어왔을 때 첫화면 띄워주기
if(location.pathname == "/ask"){
	if("${dto.asker_seq}" != "${login_user_seq}"){
		alert("잘못된 접근입니다.");
		location.href = "/";
	}
	whoAmI = "asker";
	if("${result}" == "채팅기록 있음"){
		console.log("if가 도나");
		let read = "${dto.asker_read}";
		chatroomSeq = "${dto.chatroom_seq}";
		let chat = `${dto.chat}`;
		console.log("${dto.main_images_url}");
		appendChat(chat, read, "${dto.profile_img}");
		fillChatInfo("${dto.long_title}","${dto.url}", "${dto.main_images_url}");
		updateMyRead(chatroomSeq, whoAmI, readAt);
	}else{
		chatroomSeq = "${dto.chatroom_seq}";
		fillChatInfo("${dto.long_title}","${dto.url}", "${dto.main_images_url}");
	}
}

$("#send_my_chat").on("click", function(){
	sendAllMessage();
});
$(document).on('keydown', 'div.input-div textarea', function(e){
    if(e.keyCode == 13 && !e.shiftKey) {
		sendAllMessage();
	}
});

function sendAllMessage(){
	let myChat = myChatPlusInfo($("#input_my_chat").val());	
	//채팅기록이 없을 경우
	if(chatroomSeq == 0){
		let askerSeq = "${login_user_seq}";
		let collectorSeq = "${dto.collector_seq}";
		let projectSeq = "${dto.project_seq}";
		let lastChat = $("#input_my_chat").val();
		sendFirstMessage(myChat, askerSeq, collectorSeq, projectSeq, lastChat);
	}else{
		//채팅 내용 업데이트, 채팅을 쓴 사람이 지금까지 읽은 부분 및 마지막 채팅까지 업데이트
		sendMessage(myChat);
	}
}

function sendFirstMessage(myChat, askerSeq, collectorSeq, projectSeq, lastChat){
	$.ajax({
		data: {
			asker_seq: askerSeq,
			collector_seq: collectorSeq,
			project_seq: projectSeq,
			my_chat: myChat,
			last_chat: lastChat
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
				clearInputMessage();
				appendChat(myChat);
			}
		}
	});
}

function sendMessage(myChat){
	$.ajax({
		data: {
			chatroom_seq: chatroomSeq,
			my_chat: myChat,
			who_am_i: whoAmI,
			read_at: readAt + 1,
			last_chat: $("#input_my_chat").val()
		},
		type : "POST",
		url : "/insertmychat",
		dataType: 'json',
		success : function(r){
			if(r.result == 0){
				alert("알 수 없는 오류가 발생했습니다");
			}else{
				clearInputMessage();
				appendChat(myChat);
			}
		}
	});
}

function appendChat(allChat, read, profile_img){
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
		
		if(readAt == read + 1){
			$("#chat_list").append("<div style='text-align:center'>(여기까지 읽으셨습니다)</div>");
		}
		
		$("#chat_list").append(createChatForm(chatDateStr, chatTimeStr, chatterSeq,
				chatContent, profile_img,chatterNickname));
	}
}

function updateMyRead(chatroomSeq, whoAmI, readAt){
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
			}
		}
	});
}

function createChatForm(chatDate, chatTime, chatterSeq, chatContent, img, nickname){
	if(chatDate != commonDate){
		//채팅에 있는 날짜가 commonDate의 날짜와 다르다면 채팅창에 날짜 넣어주기
		commonDate = chatDate;
		$("#chat_list").append("<div class='common_date'>"+"====== "+commonDate+" ======"+"</div>");
	}
	let chatForm = $(".chat_form").clone();
	if(chatterSeq == "${login_user_seq}"){
		chatForm.attr("class", "my_chat");
		chatForm.prepend("<div class='time_part' style='display:inline-block;'>"+chatTime+"</div>");
		chatForm.find(".message").text(chatContent);		
	}else{
		chatForm.attr("class", "opponent_chat");
		chatForm.find(".sender img").attr("href", img);
		chatForm.find(".sender span").text(nickname);
		chatForm.find(".message").text(chatContent);
		chatForm.append("<div class='time_part' style='display:inline-block'>"+chatTime+"</div>");
	}
	return chatForm;
}

function fillChatInfo(longTitle, projectUrl, mainImagesUrl){
	$("#project_info").css("display", "flex");
	$("#project_img").attr("src", mainImagesUrl);
	$("#project_long_title").html("<a href='"+projectUrl+"'></a>");
	$("#project_long_title a").text(longTitle);
}

function clearInputMessage(){
	$("#input_my_chat").val("");
}

function clearChatList(){
	$("#chat_list").html("");
}

function clearProjectInfo(){
	$("#project_img").attr("href", "");
	$("#project_long_title").html("");
}

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
</script>
</html>