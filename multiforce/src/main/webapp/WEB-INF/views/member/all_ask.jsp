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
<link rel="stylesheet" href="/css/member/all_ask.css">

<body>
<div class="out_con">
	<div id="ask_title">메세지</div>
	<div id="content_container">
		<div id="all_ask_wrap" >
			<h3>받은 문의</h3>
			<ul id="my_project_ask">
				<li id="collector_chatroom_list">
					</li>
				</ul>
				<h3>보낸 문의</h3>
				<ul id="project_ask">
					<li id="asker_chatroom_list">
					</li>
				</ul>
			</div>
			<div class="chat_window" >
				<%@ include file="/WEB-INF/views/member/ask.jsp" %>
			</div>
			<div style="display:none">
				<ul id="chatroom_list">
					<li class="chatroom_wrap">
						<div class="chatroom_long_title">
						</div >
						<div class="chatroom_nickname">
						</div >
						<div  class="chatroom_last_chat">
						</div>
						<div  class="chatroom_last_chat_date">
						</div >
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>

</body>
<script>
function createChatroomWrap(longTitle, lastChat, lastChatDate, chatroomSeq, nickname, ac){
	let chatroomWrap = $(".chatroom_wrap").clone();
	chatroomWrap.find(".chatroom_long_title").append(longTitle);
	chatroomWrap.find(".chatroom_nickname").append(nickname);
	chatroomWrap.find(".chatroom_last_chat").append(lastChat);
	chatroomWrap.find(".chatroom_last_chat_date").append(lastChatDate);
	chatroomWrap.attr("id", "chatroom_" + chatroomSeq);
	chatroomWrap.attr("class", ac + "_chatroom_wrap");
	return chatroomWrap;
}
//처음 입장 시 대화목록 띄워주기
const LOGIN_USER_SEQ = "${login_user_seq}";
$.ajax({
	data: {
		login_user_seq: LOGIN_USER_SEQ
	},
	type : "POST",
	url : "/allask",
	dataType: 'json',
	success : function(r){
		if(r.collector.length == 0){
			let noData = "<li>대화 기록이 없습니다</li>";
			$("#collector_chatroom_list").append(noData);
		}else{
			for(let i = 0; i < r.collector.length; i++){
				console.log(r.collector.length);
				let longTitle = r.collector[i].long_title;
				let lastChat = r.collector[i].last_chat;
				let lastChatDate = r.collector[i].last_chat_date;
				let chatroomSeq = r.collector[i].chatroom_seq;
				let opNickname = r.collector[i].nickname; //상대방 닉네임
				let ac = "collector";
				let chatroomWrap = createChatroomWrap(longTitle, lastChat, lastChatDate, chatroomSeq,opNickname, ac);
				$("#collector_chatroom_list").append(chatroomWrap);
			}
		}
		
		if(r.asker.length == 0){
			let noData = "<li>대화 기록이 없습니다</li>";
			$("#asker_chatroom_list").append(noData);
		}else{
			for(let i = 0; i < r.asker.length; i++){
				let longTitle = r.asker[i].long_title;
				let lastChat = r.asker[i].last_chat;
				let lastChatDate = r.asker[i].last_chat_date;
				let chatroomSeq = r.asker[i].chatroom_seq;
				let opNickname = r.asker[i].nickname;
				let ac = "asker";
				let chatroomWrap = createChatroomWrap(longTitle, lastChat, lastChatDate, chatroomSeq, opNickname, ac);
				$("#asker_chatroom_list").append(chatroomWrap);
			}
		}
		chatroomWrapClickEAdd();
	}
});
//채팅방 클릭 시 채팅화면 띄워주기
function chatroomWrapClickEAdd(){
	$("li[class*='_chatroom_wrap']").on("click", function(e){
		whoAmI = e.currentTarget.getAttribute("class").substr(0, e.currentTarget.getAttribute("class").indexOf("_"));
		chatroomSeq = e.currentTarget.getAttribute("id").substr(e.currentTarget.getAttribute("id").indexOf("_") + 1);
		$.ajax({
			data: {
				chatroom_seq: chatroomSeq,
				who_am_i: whoAmI
			},
			type : "POST",
			url : "/findchatroom",
			dataType: 'json',
			success : function(r){
				clearInputMessage();
				clearChatList();
				clearProjectInfo();
				readAt = 0;
				commonDate = "";
				if(whoAmI == "asker"){
					appendChat(r.chat, r.asker_read, r.profile_img);
				}else if(whoAmI == "collector"){
					appendChat(r.chat, r.collector_read, r.profile_img);
				}

				//이미지 문자열 치환 추가
				var mainImage = r.main_images_url;
				mainImage = mainImage.replace(/&amp;/g, '&');
				
				fillChatInfo(r.long_title, r.url, mainImage);
				updateMyRead(chatroomSeq, whoAmI, readAt);
			}
		});
	});
}





</script>
</html>