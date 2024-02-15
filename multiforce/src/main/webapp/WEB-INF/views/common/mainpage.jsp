<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/css/common/mainpage.css">

<script>
$(document).ready(function() {	
	

    $(".dibs_btn").click(function() {
    	
    	var projectSeq = $(this).data("project_seq");
    	
		if("${login_user_seq}" == ""){
			if(confirm("로그인 후에 이용하실 수 있는 서비스입니다. 로그인 하시겠습니까?")){
				location.href = "/login?from=" + location.search;
			}
		}else{
			$.ajax({
				data : {
					"project_seq": projectSeq,
					"member_seq": '${login_user_seq}'
						},
				type : "POST",
				dataType: 'json',
				url : "/addprojectdibs",
				success : function(r){
					console.log(r);
					if(r.result == "성공"){
						alert("관심 프로젝트 목록에 추가되었습니다.")
					}else if(r.result == "취소"){
						alert("관심 프로젝트 목록에서 삭제되었습니다.")
					}else{
						alert("알 수 없는 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
					}
				}

			});
		}
	})
	
	
    var currentDate = new Date();
    
    var year = currentDate.getFullYear().toString().slice(-2); 
    var month = ('0' + (currentDate.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 1을 더하고 두 자리로 표시
    var day = ('0' + currentDate.getDate()).slice(-2); 
    var hours = ('0' + currentDate.getHours()).slice(-2); 
    var minutes = ('0' + currentDate.getMinutes()).slice(-2); 
    
    // #popular_time 요소에 현재 시간 표시
    $(".popular_time").html(year + "." + month + "." + day + " " + hours + ":" + minutes + " 기준");
    
 	var current_page = 1;
 	let banner_slider = $("#banner_slider");
 	let end_page = ${fn:length(eventmap)};
 	$("#event_count").text(current_page + "/" +end_page);
 	$("#banner_slider").css("width", end_page * 665.59 + "px");
   	$("#slider_right_btn").on('click', function(){
		if(end_page != current_page){
			banner_slider.css("transform", "translate(-" + (665.59 * current_page) + "px)")
			banner_slider.css("transitionProperty","transition-property: transform")
			banner_slider.css("transitionDuration", '0.5s');
			current_page++;
			console.log(current_page);
			console.log("endpage:" +end_page);
			$("#event_count").text(current_page + "/" +end_page);
		}
	});
   	
   	$("#slider_left_btn").on('click', function(){
		if(current_page != 1){
			current_page--;
			banner_slider.css("transform", "translate(-" + (664 * (current_page -1)) + "px)")
			banner_slider.css("transitionProperty","transition-property: transform")
			banner_slider.css("transitionDuration", '0.5s');
			$("#event_count").text(current_page + "/" +end_page);
			console.log(current_page);
		}
	});
   	
   	
/*	btn_left.addEventListener('click', function(){
		if(current_page != 1){
			current_page--;
			document.getElementById("movieList").style.transform = "translate(-" + (1428 * (current_page - 1))+ "px)"
			document.getElementById("movieList").style.transitionProperty = "transition-property: transform;";
			document.getElementById("movieList").style.transitionDuration = "0.5s";
			console.log(current_page);
			
		}
	});
*/    
    
})
</script>
<style>

</style>
<body>
<div class="wrap">
	<div class="out_con">
		<div class="banner_update_popular_out_con">
			<div class="banner_update_out_con">
				<div class="main_banner">
					<div id="banner_slider">
						<c:forEach items="${eventmap }" var="item">
							<a href="${item.key}"><img src="${item.value }" class = "banner"></a>
						</c:forEach>
					</div>
					<div id="slider_btn_wrap">
						<div id="event_count"></div>
						<button id="slider_left_btn"><</button>
						<button id="slider_right_btn">></button>
					</div>
				</div>
				<!-- 
				넣을만한 컨텐츠
				인기순
				에디터 pick(관리자가 찜한거 리스트 보여주기?)
				-->
			
				<div class="main_update_popular">
					<div class="update_out_con">
						<div id="update_main_title">업데이트 프로젝트</div>
						<div class="update_container">
							<c:forEach var="update" items="${update }">
								<div class="update_inner_con">
									<div class="update_img"><a href="${update.url }"><img src="${update.main_images_url}"></a></div>
									<div class="update_category">${update.category_kor} ㅣ ${update.nickname}</div>
									<div class="update_title"><a href="${update.url }">${update.long_title}</a></div>
									<div class="achaive_dibs">
										<div class="update_achaive">${Math.round((update.collection_amount * 100) / update.goal_price)}% 달성</div>
										<button class="dibs_btn" data-project_seq="${update.project_seq }">프로젝트 찜</button>
									</div>						
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>	
				
			<div class="main_popular_container">
				<div class="popular_main_title">인기 프로젝트 </div>
				<div class="popular_time">랄라</div>
				<div class="popular_container">
					<c:forEach var="popular" items="${popular }" varStatus="rank">
						<div class="popular_inner_con">
							<div class="popular_img"><a href="${popular.url }"><img src="${popular.main_images_url}" ></a></div>
							<div class="popular_rank">${rank.index + 1}</div>
							<div class="popular_inner_right_con">
								<div class="popular_category">${popular.category_kor} ㅣ ${popular.nickname}</div>
								<div class="popular_title"><a href="${popular.url }">${popular.long_title}</a></div>
								<div class="popular_achaive">${Math.round((popular.collection_amount * 100) / popular.goal_price)}% 달성</div>
								<div class="popular_view_dibs">조회 ${popular.view_count } ㅣ 찜 ${popular.dibs_count }</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>
</body>
</html>