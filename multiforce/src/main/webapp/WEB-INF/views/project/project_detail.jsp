<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 상세 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>
#project_detail_container{
	width: 1200px;
	margin: 0 auto;
}

.project-info{
	border: 1px solid black;
}
#project_info_upper_part{
	text-align: center;
}
#project_info_lower_part{
	height:500px;
}
#main_images_wrap{
	display: inline-block;
	height:100%;
}
#main_images_wrap img{
	height: 100%;
}
#other_info_wrap{
	height: 100%;
	display: inline-block;
	position:relative;
	float: right;
}
#content_container{
	display: inline-block;
	width: 900px;
	position:relative;
	float: left;
	border: 1px solid black;
}
.bundle-info{
	display: inline-block;
	width: 256px;
	border: 1px solid black;
	padding: 20px 20px 20px 20px;
}
.bundle_box{
	cursor: pointer;
	border: 1px solid black;
}
.bundle_box_chosen{
	cursor: pointer;
	border: 1px solid red;
}
</style>
</head>
<body>
<div id="project_detail_container">
	<section class="project-info">
		<div id="project_info_upper_part">
	    	<h1>${project.long_title}</h1>
	    </div>
	    <div id="project_info_lower_part">
		    <div id="main_images_wrap">
		    	<img src="${project.main_images_url}">
		    </div>
		    <div id="other_info_wrap">
		    	<div id="project_info_tap">
				    <p>모인 금액: ${project.collection_amount_format}</p>
				    <p>목표 금액: ${project.goal_price_format}</p>
				    <p>펀딩 기간: ${project.start_date} - ${project.due_date}</p>
				    <p>남은 시간: ${project.term}일</p>
				    <button id="funding_btn">후원하기</button>
				</div>
				<div id="collector_info_tap">
					<span>
						<img src="${project.memberDTO.profile_img }">
					</span>
					<p>
						${project.memberDTO.nickname }
					</p>
					<p>
						한줄소개
					</p>
					<input type="button" value="판매자 문의" id="ask_btn">
				</div>
			</div>
			
	    </div>
	</section>
	<a href="#" id="projectLink" data-project-id="${project.project_seq}">프로젝트 계획</a>
	<a href="#" id="updateLink" data-project-id="${project.project_seq}">업데이트</a>
	<a href="#" id="communityLink" data-project-id="${project.project_seq}">커뮤니티</a>
	<hr>
	<div id="content_container">
		${project.content}
	</div>
	<section class="bundle-info">
		<c:forEach var="bundle" items="${bundleList }" varStatus="status">
			<div class="bundle_box" data-id="${bundle.bundle_seq}">
				<div class="bundle_name_wrap">
					${bundle.bundle_name}
				</div>
				<div class="bundle_price_wrap">
					${bundle.bundle_price_format}원
				</div>
				<ul class="item_list">
				<c:forEach var="item" items="${bundle.itemDTOList }" varStatus="status">
					<li class="item">
						<div class="item_name_wrap">
							${item.item_name }
						</div>
						<c:forEach var="option" items="${item.optionDTOList }" varStatus="status">
							<c:if test="${fn:length(item.optionDTOList) != 1 && status.index == 0}">
								<select class="item_option_select">
							</c:if>
							<c:if test="${fn:length(item.optionDTOList) != 1}">
								<option value="${option.item_option_seq }">
									${option.item_option_name }
								</option>
							</c:if>
							<c:if test="${fn:length(item.optionDTOList) != 0 && status.count == fn:length(item.optionDTOList)}">
								</select>
							</c:if>
						</c:forEach>
					</li>
				</c:forEach>
				</ul>
			</div>
		</c:forEach>
	</section>
	
</div>
<script>
$(document).ready(function () {
//==================== 프로젝트 계획, 업데이트, 커뮤니티 클릭 이벤트 ============================
	$.ajax({
        url: "/viewcountupdate",
        type: "POST",
        data:{
        	project_seq: "${project_seq}"
        }
	});
	
	
	$("#communityLink").click(function (e) {
	    e.preventDefault();
	    var pid = $(this).data("project-id");
	    var baseUrl = window.location.origin;
	    loadContent(baseUrl + "/project_detail/community/"+pid);
	});
	
	
	$("#updateLink").click(function (e) {
	    e.preventDefault();
	    var pid = $(this).data("project-id");
	    var baseUrl = window.location.origin;
	    loadContent(baseUrl + "/update/view/"+pid); 
	});
	
	$("#projectLink").click(function(e){
		e.preventDefault();
		$("#content_container").html("${project.content}");
	});
	
	function loadContent(url) {
	    $.ajax({
	        url: url,
	        type: "GET",
	        success: function (data) {
	            $("#content_container").html(data);
	        },
	        error: function (xhr, status, error) {
	            console.error("Error loading content:", error);
	        }
	    });
	}
//==========================번들 이벤트================================
	var click_bundle_seq = 0;
	$(".bundle_box").click(function(e){
		//이벤트 발생 객체의 class 명이 bundle_box인 경우
		if(e.currentTarget.getAttribute("class") == "bundle_box"){
			$(this).attr("class","bundle_box_chosen");
		//아니면서 select를 클릭한게 아닌 경우
		}else if(e.currentTarget.getAttribute("class") != "bundle_box" && e.target.tagName != "SELECT"){
			$(this).attr("class","bundle_box");
		}
		
	});
	
//==========================1:1 대화=================================
	$("#ask_btn").on("click",function(){
		if("${login_user_seq}" != ""){
			let url = "/ask?";
			let project_seq = "${project.project_seq}";//나중엔 프로젝트 상세페이지 들어오면 자동으로 넣어지게
			let collector_seq = "${project.memberDTO.member_seq}";//마찬가지
			let asker_seq = "${login_user_seq}";
			url += ("project_seq=" + project_seq);
			url += ("&collector_seq=" + collector_seq);
			url += ("&asker_seq=" + asker_seq);
			window.open(url, "_blank","width= 500, height= 600");
		}else{
			if(confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")){
				var fromPath = window.location.pathname.substring(1) == "" ?
						"mainpage" : location.pathname.substring(1) + location.search;
				location.href = "/login?from=" + fromPath;
			}
		}
	});
});
</script>
</body>
</html>