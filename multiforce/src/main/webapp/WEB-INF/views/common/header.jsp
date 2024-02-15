<%@page import="project.code.ProjectCategory"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/css/common/header.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function(){
	//==============================알림 기능=======================================
	notificationArr = [];
	var notificationBtnClick = 0;
	var isClickedNotiDeleteBtn = false;
	//알림버튼 클릭 시 이벤트) 로그인 여부 확인, 버튼클릭 횟수 체크 후 알림 리스트 보여주거나 숨김 + 읽기 처리
	var noReadCount = 0;
	var lastNotificationSeq = 0;
	if("${login_user_seq}" != ""){
		notificationListLoad();
	}
	
	function notificationListLoad(){
		$.ajax({
			data: {
				member_seq: "${login_user_seq}"
			},
			type : "POST",
			url : "/notificationlist",
			dataType: 'json',
			success : function(r){
				for(let i = 0; i < r.length; i++){
					if(i == 0){
						lastNotificationSeq = r[0].notification_seq;
					}
					
					if(r[i].is_read == false){
						noReadCount++;
					}
					
					$("#header_notification_list").append(
							"<div id='notification_"+r[i].notification_seq+"' class='notifications'><a href='/projectdetail/"
							+r[i].project_seq+"'>"+r[i].message + "</a><input type='button' value='삭제' class='notification_delete_btn' id='delete_"
							+r[i].notification_seq+"'><span> 읽음 여부: "+r[i].is_read+"</span></div>");
					
				}
				if(r.length == 0){
					$("#header_notification_list").append("<h3 id='no_notification'>알림이 없습니다.</<h3>");
				}
				addNotiDelBtnEvent();
				addNotiEvent();
				$("#notification_no_read_count").text(noReadCount);
				if(noReadCount > 0 ){
					$("#notification_no_read_count").css("display", "inline-block");
				}
			}//css할 때 스크롤로 만들기
		});
	}
	
	$("#notification_btn").on("click", function(){
		if("${login_user_seq}" != "" && notificationBtnClick % 2 == 0){
			$("#header_notification_list").css("display","block");
			$.ajax({
				data: {
					member_seq: "${login_user_seq}",
					last_notification_seq: lastNotificationSeq
				},
				type : "POST",
				url : "/readnotification",
				dataType: 'json',
				success : function(r){
					noReadCount = 0;
					$("#notification_no_read_count").text(noReadCount).css("display", "none");
				}
				//css할 때 스크롤로 만들기
			});
		}else if("${login_user_seq}" != "" && notificationBtnClick % 2 == 1){
			$("#header_notification_list").css("display","none");
			
		}else{
			if(confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")){
				location.href = "/login?from=" + fromPath;
			}
		}
		notificationBtnClick++;
	})
	//알림 생성 ajax 처리 후 이벤트 추가
	function addNotiDelBtnEvent(){
		$(".notification_delete_btn").on("click",function(e){
			console.log("버튼 클릭");
			isClickedNotiDeleteBtn = true;
		});
	}
	function addNotiEvent(){
		$(".notifications").on("click", function(e){
			console.log("div 이벤트 확인");
			if(isClickedNotiDeleteBtn){
				console.log(e.target.parentNode);
				$.ajax({
					url: "deletenotification",
					data:{
						notification_seq: e.target.getAttribute("id").substring(e.target.getAttribute("id").indexOf("_") + 1)
						},
					type: 'post',
					dataType: 'json',
					success: function(r){
						if(r.result == 1){
							e.target.parentNode.innerHTML = "";
							isClickedNotiDeleteBtn = false;
						}else{
							alert("삭제 오류");
						}
						
					},
					error: function(request, e){
						alert("코드: " + request.status + " 메세지: " + request.responseText + " 오류: " + e);
					}
				});
			}
		})
	}
	
	 $("#project_design_btn").on("click", function(e){
		if("${login_user_seq}" == ""){
			if(confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")){
				location.href = "/login?from=" + fromPath;
				e.preventDefault();
			} else {
				e.preventDefault();
			}
		}	
	}) 
	
// =======================카테고리 이벤트=========================
	$("#category").on("mouseenter", function(e){
		$("#category_list").css("display","block");
	});
	
	$("#category_list").on("mouseleave", function(e){
		$("#category_list").css("display","none");
	});
	
// =======================검색=========================
	projectList = [];
	
	$.ajax({
		type : "POST",
		url : "/realtimesearch",
		dataType: 'json',
		success : function(r){
			for(let i = 0; i < r.length; i++){
				let project = {};
				project.longTitle = r[i].long_title;
				project.url = r[i].url;
				projectList.push(project);
			}
		}
	});
	
	$("#header_search_input").on("keyup", function(){
		let result = "";
		let checkWord = $("#header_search_input").val();
		let ko_reg = /[ㄱ-ㅎㅏ-ㅣ]{1}/g;
		
		if(checkWord == ""){
			$("#search_result").css("display", "none");
		}else if(ko_reg.test(checkWord)){
			
		}else{
			let count = 0;
			$("#search_result").css("display", "inline-block");
			for(let i = 0; i < projectList.length; i++){
				if(projectList[i].longTitle.includes(checkWord)){
					result += ("<a href='"+ projectList[i].url +"'>" + projectList[i].longTitle +"</a>" + "<br>");
					count++;
				}
				if(count == 5){
					break;
				}
				
			}
		}
		$("#search_result").html(result);
	})
	
//		===============================로그인 상태에 따라 change_part부분 다르게====================================
	//url 경로 무조건 절대 경로로 주기
	const loginUserId = '${login_user_id}';
	const loginUserLevel = '${login_user_level}';
	//로그인 상태 아닐때
	if (loginUserId == 'null' || loginUserId == null || loginUserId == '') {
		let html = `<div id = "logout_wrap">
						<a id="login_btn" href="/login">로그인</a> / 
						<a href="/signup">회원가입</a>
					</div>`;
		$("#change_part").html(html);
	//로그인 상태일 때
	} else {
		let html = "";
		if(loginUserLevel == "1"){
			html = 
				`<div id = "login_wrap">
					<div class="user_name_img">
						<div><img src="${login_user_img}" class="login_user_img"></div>
						<div>${login_user_name}</div>
					</div>
				</div>
					<div class="my_menu_list" style="display: none;">
					<a href="/myprofile"><div class="my_menu_list_tab">프로필</div></a>
					<a href="/funded"><div class="my_menu_list_tab">후원 프로젝트</div></a>
					<a href="/mydibs"><div class="my_menu_list_tab">관심 프로젝트</div></a>
					<a href="/follow"><div class="my_menu_list_tab">팔로우</div></a>
					<a href="/allask"><div class="my_menu_list_tab">메세지</div></a>
					<a href="/myproject"><div class="my_menu_list_tab">내 프로젝트</div></a>
					<a href="/settings"><div class="my_menu_list_tab">회원정보 수정</div></a>
					<a href="/logout"><div class="my_menu_list_tab">로그아웃</div>	</a>		
				</div>
				`;
		}else{
			$("#project_design_btn").text("프로젝트 심사").attr("href", "project_approve_list");
			html =
				`<div id = "login_wrap">
					<div class="user_name_img">
						<div><img src="${login_user_img}" class="login_user_img"></div>
						<div>${login_user_name}</div>
					</div>
				</div>
				<div class="my_menu_list" style="display: none;">
					<div class="my_menu_list_tab"><a href="/myprofile">프로필</a></div>
					<div class="my_menu_list_tab"><a href="/logout">로그아웃</a></div>				
				</div>`
		}
			
		$("#change_part").html(html);
	}
	//나의 메뉴 리스트 버튼 클릭 이벤트 처리
	$("#change_part").on("click", function(){
		if($(".my_menu_list").css("display") == "block"){
			$(".my_menu_list").css("display", "none");
		}else{
			$(".my_menu_list").css("display", "block");
		}
	})
	// ==========헤더의 로그인 버튼 클릭시 파라미터로 원래 있던 페이지에 대한 정보 넘겨주면서 로그인 페이지로====================
	var fromPath = window.location.pathname.substring(1) == "" ?
			"mainpage" : location.pathname.substring(1) + location.search;
	$("#login_btn").attr("href", "/login?from=" + fromPath)

});

</script>
<header>

	<div id="header_wrap">
		<div id="header_upper_part">
			<h1 id="header_logo" style="display: inline-block"><a href="/">멀티포스 펀딩</a></h1>
			<div id="header_search_wrap"  style="display: inline-block">
				<form action="/discover" method="get" id="header_search_form" style="display: inline-block">
					<input id="header_search_input" type="text" name="query">
					<button id="header_search_btn">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  							<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
						</svg>
					</button>
				</form>
				<div id="search_result"></div>
			</div>
			<div id="notification_wrap" style="display: inline-block">
				<i id="notification_btn">
					<svg xmlns="http://www.w3.org/2000/svg" width="27" height="27" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
	  					<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2M8 1.918l-.797.161A4 4 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4 4 0 0 0-3.203-3.92zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5 5 0 0 1 13 6c0 .88.32 4.2 1.22 6"/>
					</svg>
				</i>
				<span id="notification_no_read_count" style="display:none"></span>
				<div id="header_notification_list" style="display:none"></div>
			</div>
		</div>
		<nav id="navigator">
			<div id="category_wrap" style="display:inline-block">
				<div class="category_tab" style="display:inline-block">
					<a class="category" id="category">카테고리</a>
				</div>
				<div class="category_tab" style="display:inline-block">
					<a href="/discover?sort=new">신규</a>
				</div>
				<div class="category_tab" style="display:inline-block">
					<a href="/discover?sort=popular">인기</a>
				</div>
				<div class="category_tab" style="display:inline-block">
					<a href="/discover?sort=end">마감임박</a>
				</div>
				<div style="display:inline-block">
					<a id="project_design_btn" href="/projectdesign" >프로젝트 등록</a>
				</div>
				<div style="display:inline-block">				
					<div id = "change_part" ></div>					
				</div>	
			</div>

			<div class="category" id="category_list" style="display:none">
<%			for(ProjectCategory item : ProjectCategory.values()){ %>
				<div class="category_btn_wrap">
					<a class="category_btn" href="/discover?category=<%=item.getEngName()%>"><%=item.getKorName()%></a>
				</div>
<% 			}
%>
			</div>
		</nav>
		
	</div>


</header>

</html>