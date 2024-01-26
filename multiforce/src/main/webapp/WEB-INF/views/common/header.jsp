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
	projectNameArr = [];
	
	$.ajax({
		type : "POST",
		url : "/realtimesearch",
		dataType: 'json',
		success : function(r){
			for(let i = 0; i < r.length; i++){
				projectNameArr.push(r[i].long_title);
			}
		}
	});
	
	$("#search").on("keyup", function(){
		let result = "";
		let checkWord = $("#search").val();
		let ko_reg = /[ㄱ-ㅎㅏ-ㅣ]{1}/g;
		$("#search_result").html();
		
		if(checkWord == ""){
			$("#search_result").html();
		}else if(ko_reg.test(checkWord)){
			
		}else{
			let count = 0;
			for(let i = 0; i < projectNameArr.length; i++){
				if(projectNameArr[i].includes(checkWord)){
					result += ("<a href='discover?query= " + checkWord + "'>" + projectNameArr[i] +"</a>" + "<br>");
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
						<a id="login_btn" href="/login">로그인</a>
						<a href="/signup">회원가입</a>
					</div>`;
		$("#change_part").html(html);
	//로그인 상태일 때
	} else {
		let html = "";
		if(loginUserLevel == "1"){
			html = 
				`<div id = "login_wrap">
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
		}else{
			$("#project_design_btn").text("프로젝트 심사").attr("href", "프로젝트 승인 페이지 url");
			html =
				`<div id = "login_wrap">
					프로필 사진, ${login_user_name}(클릭시 메뉴)<br>
					<div id="my_menu_list" style="display:none">
						<a href="">프로필</a>
						<a href="/logout">로그아웃</a>
					</div>
				</div>`
		}
			
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
	let fromPath = window.location.pathname.substring(1) == "" ?
			"mainpage" : location.pathname.substring(1) + location.search;
	$("#login_btn").attr("href", "/login?from=" + fromPath)
});

</script>
<header>
	<div>
		<h1><a href="/">멀티포스 펀딩</a></h1>
		<a href="">알림</a>
		<form action="/discover" method="get" id="search_form">
			<input id="search" type="text" name="query">
			<input type="submit" value="검색">
		</form>
		<div id="search_result"></div>
	</div>
	<div id="navigator">
		<a class="category" id="category">카테고리</a>
		<a href="/discover?sort=new">신규</a>
		<a href="/discover?sort=popular">인기</a>
		<a href="/discover?sort=end">마감임박</a>
		<a id="project_design_btn" href="">프로젝트 등록</a>
		<div id = "change_part"></div>
		<div class="category" id="category_list" style="display:none">
<%		for(ProjectCategory item : ProjectCategory.values()){ %>
			<a class="category_btn" href="discover?category=<%=item.getEngName()%>"><%=item.getKorName()%></a>
<%		}
%>
		</div>
	</div>
</header>
</html>