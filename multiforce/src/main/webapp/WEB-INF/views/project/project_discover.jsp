<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	//===================페이지 접근 시 컨트롤러에서 보내준 값을 통해 select 선택 및 버튼 생성============
	$("#select_process option[value='${process}']").attr("selected", true);
	if($("#select_process").val() != 0){
		let process = $("#select_process").val()
		//기본값이 아닌 process 선택 시 폼에 넣어주기
		$("#search_form").append("<input type='hidden' value='"+ process +"' name='process' id='process_input'>");
	}
	$("#select_sort option[value='${sort}']").attr("selected", true);
	if($("#select_sort").val() != 0){
		let sort = $("#select_sort").val()
		//기본값이 아닌 sort 선택 시 폼에 넣어주기
		$("#search_form").append("<input type='hidden' value='"+ sort +"' name='sort' id='sort_input'>");
	}
	if('${category}' != 'all'){
		$("#search_condition_wrap").append("<input type='button' value='카테고리: ${category}' id='category_condition_btn'>")
		//검색창 폼 내부에도 input을 넣어주어 category가 선택된 상황에서 다시 검색해도 categroy까지 같이 검색되게끔
		$("#search_form").append("<input type='hidden' value='${category}' name='category' id='category_input'>");
	}
	if('${query}' != ""){
		$("#search_condition_wrap").append("<input type='button' value='검색어: ${query}' id='query_condition_btn'>")	
	}
	
	//버튼 클릭 시 검색 조건에서 빠지게 만드는 로직
	var categoryCondition = '${category}';
	var queryCondition = '${query}';
	$("#category_condition_btn").on("click", function(){
		$("#category_condition_btn").css("display","none");
		//카테고리 name 속성을 빼버려 다시 검색할 때엔 category를 고려하지 않게
		$("#category_input").attr("name", "");
		categoryCondition = "";
		relocateHref();
	});
	$("#query_condition_btn").on("click", function(){
		$("#query_condition_btn").css("display","none");
		queryCondition = "";
		relocateHref();
	});

	$("#select_process").on("change", function(){
		relocateHref();
	});
	
	$("#select_sort").on("change", function(){
		relocateHref();
	});
	
	function relocateHref(){
		let href = "/discover?process="+$("#select_process").val()+"&sort=" + $("#select_sort").val();
		if(categoryCondition != null && categoryCondition != ""){
			href += "&category=" + categoryCondition;
		}
		if(queryCondition != null && queryCondition != ""){
			href += "&query=" + queryCondition;
		}
		location.href = href;
	}
//	===========================================================
	var start = ${start};
	var step = ${step};
	console.log("start: " + start);
	console.log("step: " + step);
	$("#more_project_btn").on("click", function(){
		console.log("동작");
		$.ajax({
			data : {"start": start,
					"category": "${category}",
					"query": "${query}",
					"sort": "${sort}",
					"process": ${process},
					"step" : step
					},
			type : "POST",
			url : "/moreproject",
			dataType: 'json',
			success : function(r){
				moreProject(r);
			}
		});
	});
	let forCount = 1;
	function moreProject(r){
		console.log("step: " + step);
		for(let i=0; i < r.length; i++){
			if(step != r[i].project_process && ${process} == 0){
				console.log("step != r[i].project_process 조건 동작")
				start = 0;
				step = r[i].project_process;
			}
			console.log(i +")" + r[i].long_title + " / start: "+start);
			let result = "";
			//================ 태그 부분 ====================
			result += (16 * forCount + i + 1);
			result += ("<img src='"+r[i].main_images_url+"'>");
			result += (r[i].long_title + "/")
			result += ("카테고리: " + r[i].category + "/")
			if(r[i].project_process == 4){
				if(r[i.term == 0]){
					result += ("오늘 마감/");
				}else{
					result += (" "+ r[i].term + "일 남음/");
				}
			}else{
				result += (r[i].project_process_name + "/")
			}
			result += ("시작일: "+ r[i].start_date + "/ ");
			result += ("마감일: "+ r[i].due_date);
			result += "<hr>";
			$("#project_list").append(result);
			//==============================================
			
			start += 1;
		}
		forCount += 1;
	
	}
//====================찜기능==========================
	$(".project_dibs_btn").on("click", function(e){
		console.log(e.target.getAttribute("id"));
		if("${login_user_seq}" == ""){
			if(confirm("로그인 후에 이용하실 수 있는 서비스입니다. 로그인 하시겠습니까?")){
				
			}else{
				
			}
		}else{
			$.ajax({
				data : {
					"project_seq": e.target.getAttribute("id"),
					"member_seq": '${login_user_seq}'
						},
				type : "POST",
				url : "/addprojectdibs",
				dataType: 'json',
				success : function(r){
					console.log(r.result);
					if(r.result == "성공"){
						e.target.value = "찜 취소";
						e.target.setAttribute("class", "dib_cancel_btn");
					}else{
						alert("알 수 없는 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
					}
				}
			});
		}
		
		
	});
	
	
	
});
</script>
<style>
img {
	width: 100px;
	height: 80px;
}
</style>
<body>
<!-- 
	대표 이미지
	긴 제목
	짧은 설명
	진행중이면 시작 + 끝 날짜 들고와서 며칠남았는지 계산
	시작전, 끝이라면 그렇게 표시
	카테고리
	유저의 닉네임 + 유저의 프로필주소 연결해줄 정보
	목표금액, 현재금액 => 계산해서 몇퍼센트 달성중인지 할 수 있다면 그래프도 구현
	
	프로필은 어떻게 연결하지
 -->
<h3>${count }개의 프로젝트가 있습니다</h3>
<div id="search_condition_wrap">
	<select id="select_process">
		<option value="0">전체</option>
		<option value="4">진행 중</option>
		<option value="3">예정</option>
		<option value="6">종료</option>
	</select>
	<select id="select_sort">
		<option value="popular">인기순</option>
		<option value="end">마감 임박순</option>
		<option value="new">최신순</option>
	</select>
</div>
<div id="project_list">
 	<c:forEach var="item" items="${list}" varStatus="status">
 		<div>
	 		${status.count}
	 		<img src="${item.main_images_url}">
	 		${item.long_title}/
	 		카테고리: ${item.category }/
	 		<c:choose>
	 			<c:when test="${item.project_process == 4 }">
	 				<c:choose>
	 					<c:when test="${item.term == 0 }">
	 						오늘 마감/
	 					</c:when>
	 					<c:otherwise>
	 						${item.term }일 남음/
	 					</c:otherwise>
	 				</c:choose>
	 			</c:when>
	 			<c:otherwise>
	 				${item.project_process_name}/
	 			</c:otherwise>
	 		</c:choose>
	 		시작일: ${item.start_date }/
	 		마감일: ${item.due_date }
	 		<input type="button" id="${item.project_seq}" value="찜하기" class="project_dibs_btn">
 		</div>
 		<hr>
 	</c:forEach>
</div>
<input type="button" value="더보기" id="more_project_btn">
</body>
</html>