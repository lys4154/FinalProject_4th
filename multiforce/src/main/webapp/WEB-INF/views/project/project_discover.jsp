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
	function getParameterByName(name) {
		name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	    results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
	getParameterByName("category");
	getParameterByName("sort");
	getParameterByName("process");
	getParameterByName("query");
	
	$("#select_process option[value='3']").attr("selected", true);
	var start = ${fn:length(list)};
	var step = 4;
	$("#more_project_btn").on("click", function(){
		if(${fn:length(list)} < ${projectNumber}){
			$("#more_project_btn").css("display", "none");
		}else if(${count} == start){
			$("#more_project_btn").css("display", "none");
		}else{
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
		}
	});
	
	function moreProject(r){
		for(let i=0; i < r.length; i++){
			let result = "";
			//================ 태그 부분 ====================
			result += ("<img src='"+r[i].main_images_url+"'>");
			result += (r[i].long_title + "/")
			result += (r[i].category + "/")
			if(r[i].project_process == 4){
				result += (" "+ r[i].term + "일 남음/");
			}else{
				result += (r[i].project_process_name + "/")
			}
			result += r[i].due_date;
			result += "<hr>";
			$("#project_list").append(result);
			//==============================================
			if(step != r[i].project_process){
				start = 0;
				step = r[i].project_process;
			}
			start += 1;
		}
	}
//	===========================================================
	$("#select_process").on("change", function(){
		location.href = "/discover?process="+$("#select_process").val()+"&sort=" + $("#select_sort").val();
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
<div id="project_list">
 	<c:forEach var="item" items="${list}">
 		<img src="${item.main_images_url}">
 		${item.long_title}/
 		${item.category }/
 		<c:choose>
 			<c:when test="${item.project_process == 4 }">
 				${item.term }일 남음/
 			</c:when>
 			<c:otherwise>
 				${item.project_process_name}/
 			</c:otherwise>
 		</c:choose>
 		${item.due_date }
 		<hr>
 	</c:forEach>
</div>
<input type="button" value="더보기" id="more_project_btn">
</body>
</html>