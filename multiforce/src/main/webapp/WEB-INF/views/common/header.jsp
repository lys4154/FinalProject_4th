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
<style>
#category_list{
	width: 400px;
	height: 200px;
	border: 1px solid rgb(0, 0, 0);
}
#change_part{
	display: inline-block;
}
</style>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function(){
// =======================카테고리 이벤트=========================
	$("#category").on("mouseenter", function(e){
		$("#category_list").css("display","block");
	});
	
	$("#category_list").on("mouseleave", function(e){
		$("#category_list").css("display","none");
	});
	
// =======================검색=========================
	dummyProjectNameArr = [
		"이세계 아이돌", "미스터리 로맨스<Kiling Myself>",
		"2024년 출시 예정 벚나무의 정령을 아이돌로 만드는 법",
		"판타지 엑셀 방탈출<Stranger of Earendel>",
		"안아줘요가 사라졌다?!?!! <안아줘요 동물맨션>",
		"찐여미새들이 만든 비주얼노벨 GL게임 <이클립스>",
		"프로젝트 삶, 연극 <자살극장>",
		"극단고래 창작뮤지컬 프로젝트 [쪽팔림 한 잔 하실래요?]",
		"강아지 슬개골 탈구 예방 미끄럼 방지 실리콘 패드"
	];
	
	$("#search").on("keyup", function(){
		let result = "";
		let checkWord = $("#search").val();
		let ko_reg = /[ㄱ-ㅎㅏ-ㅣ]{1}/g;
		$("#search_result").html();
		
		if(checkWord == ""){
			$("#search_result").html();
		}else if(ko_reg.test(checkWord)){
			
		}else{
			for(let i = 0; i < dummyProjectNameArr.length; i++){
				if(dummyProjectNameArr[i].includes(checkWord)){
					result += ("<a href='discover?query= " + checkWord + "'>" + dummyProjectNameArr[i] +"</a>" + "<br>");
				}
			}
		}
		$("#search_result").html(result);
	})
//		===============================로그인 상태에 따라 change_part부분 다르게====================================
	let loginUserId = '${login_user_id}';
	//로그인 상태 아닐때
	if (loginUserId == 'null' || loginUserId == null || loginUserId == '') {
		let html = `<div id = "logout_wrap">
						<a id="login_btn" href="login">로그인</a>
						<a href="signup">회원가입</a>
					</div>`;
		$("#change_part").html(html);
	//로그인 상태일 때
	} else {
		let html = `<div id = "login_wrap">
						프로필 사진, ${login_user_name}(클릭시 메뉴)<br>
						<div id="my_menu_list" style="display:none">
							<a href="">프로필</a>
							<a href="">후원 프로젝트</a>
							<a href="">관심 프로젝트</a>
							<a href="">팔로우</a>
							<a href="">메세지</a>
							<a href="">내 프로젝트</a>
							<a href="">회원정보 수정</a>
							<a href="/logout">로그아웃</a>
						</div>
					</div>
					`;
		$("#change_part").html(html);
	}
	//나의 메뉴 리스트 버튼 클릭 이벤트 처리
	$("#login_wrap").on("click", function(){
		if($("#my_menu_list").css("display") == "block"){
			$("#my_menu_list").css("display", "none");
		}else{
			$("#my_menu_list").css("display", "block");
		}
	})
	// ==========헤더의 로그인 버튼 클릭시 파라미터로 원래 있던 페이지에 대한 정보 넘겨주면서 로그인 페이지로====================
	let fromPath = window.location.pathname.substring(1) == "" ? "mainpage" : window.location.pathname.substring(1);
	$("#login_btn").attr("href", "login?from=" + fromPath)
});

</script>
<header>
	<div>
		<h1><a href="/">멀티포스 펀딩</a></h1>
		<form>
			<input id="search" type="text">
			<input type="button" value="검색">
		</form>
		<div id="search_result"></div>
	</div>
	<div id="navigator">
		<a class="category" id="category">카테고리</a>
		<a href="">신규</a>
		<a href="">인기</a>
		<a href="">마감임박</a>
		<button><a href="">프로젝트 등록</a></button>
		<div id = "change_part"></div>
		<%
		HashMap<String, String> categoryNameMap = new HashMap<>();
		categoryNameMap.put("보드게임", "board_game");
		categoryNameMap.put("디지털 게임", "digital_game");
		categoryNameMap.put("웹툰·만화", "webtoon_and_comics");
		categoryNameMap.put("웹툰 리소스", "webtoon_resource");
		categoryNameMap.put("디자인 문구", "design_stationery");
		categoryNameMap.put("캐릭터·굿즈", "character_and_goods");
		categoryNameMap.put("홈·리빙", "home_and_living");
		categoryNameMap.put("테크·가전", "technology_and_household_appliance");
		categoryNameMap.put("반려동물", "pet");
		categoryNameMap.put("푸드", "food");
		categoryNameMap.put("향수·뷰티", "perfume_and_beauty");
		categoryNameMap.put("의류", "apparels");
		categoryNameMap.put("잡화", "assorted_goods");
		categoryNameMap.put("주얼리", "jewellery");
		categoryNameMap.put("출판", "publication");
		categoryNameMap.put("디자인", "design");
		categoryNameMap.put("예술", "art");
		categoryNameMap.put("사진", "photography");
		categoryNameMap.put("음악", "music");
		categoryNameMap.put("영화·비디오", "film_and_video");
		categoryNameMap.put("공연", "show");
		%>
		<div class="category" id="category_list" style="display:none">
<%		for(String key : categoryNameMap.keySet()){ %>
			<a class="category_btn" href="discover?category=<%=categoryNameMap.get(key)%>"><%=key%></a>
<%		}%>
		</div>
	</div>
</header>
</html>