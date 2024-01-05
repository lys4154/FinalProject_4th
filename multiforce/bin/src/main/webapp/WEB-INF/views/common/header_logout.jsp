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
</style>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function(){
// =======================카테고리 이벤트=========================
	$("#category").on("mouseenter", function(e){
		$("#category_list").css("display","block");
	});
	
	$("#navigator").on("mouseleave", function(e){
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
	
	$("#search").on("input", function(){
		let result = "";
		let checkWord = $("#search").val();
		$("#search_result").html();
		
		if(checkWord == ""){
			$("#search_result").html();
		}else{
			for(let i = 0; i < dummyProjectNameArr.length; i++){
				if(dummyProjectNameArr[i].includes(checkWord)){
					result += ("<a href='discover?query= " + checkWord + "'>" + dummyProjectNameArr[i] +"</a>" + "<br>");
				}
			}
		}
		$("#search_result").html(result);
	})
	
});

</script>
<header>
	<div>
		<h1><a href="">멀티포스 펀딩</a></h1>
		<input id="search" type="text">
		<div id="search_result"></div>
	</div>
	<div id="navigator">
		<a class="category" id="category">카테고리</a>
		<a href="">신규</a>
		<a href="">인기</a>
		<a href="">마감임박</a>
		<button><a href="">프로젝트 등록</a></button>
		<a href="login">로그인</a>
		<a href="sign_up">회원가입</a>
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