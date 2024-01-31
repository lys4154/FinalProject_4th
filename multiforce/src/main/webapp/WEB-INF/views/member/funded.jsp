<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/css/member/funded.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>

<script>
$(document).ready(function() {
	
	//후원 총개수
	var ongoingCount = ${ongoingFunded.size()};
    var successCount = ${successFunded.size()};
    var cancelCount = ${cancelFunded.size()};
    var totalCount = ongoingCount + successCount + cancelCount;
    $("#total_funded").html(totalCount);
    
    if (totalCount === 0) {
    	$(".no_funded").html(
    			"<div> 아직 참여하신 후원 내역이 없습니다.<div> " +
    			"<input type='button' value='프로젝트 둘러보기' id='backToMain'>");
    }
    
    $("#backToMain").click(function() {
    	location.href = '/';
    });
  

	//프로젝트 긴제목 검색
 	$("#search_keyword").keyup(function() {
 		let keyword = $("#search_keyword").val();
	       $.ajax({
	          type: "get",
	          data: { "keyword": keyword},
	          url: "/funded_search",	          
	          dataType: "JSON",
	          success: function(response) {
	        	$("#total_funded").html(response.length);
	          	$(".all_funded").empty();
	          	if(response.length == 0) {
	          		$(".all_funded").append("<div> 검색어와 일치하는 내역이 없습니다. </div>");
	          	} else {
	          		$("#total_funded").html(response.length);
	  	            for (var i = 0; i < response.length; i++) {
	  	            	
	  	            	//후원일
	  	            	var fund_date = new Date(response[i].fund_date);
	  	                var fundDate =  fund_date.getFullYear() + "년 " + (fund_date.getMonth() + 1) + "월 " + fund_date.getDate() + "일";             
	  	                
	                    //취소일이 있는 경우만 출력
	                    var delDate = "";
	                    if(response[i].del_date){
	                    	var del_date = new Date(response[i].del_date);
	                    	delDate = "<div> 취소 완료일: " + del_date.getFullYear() + "년 " + (del_date.getMonth() + 1) + "월 " + del_date.getDate() + "일</div>";	                    	
	                    } 

	                    //결제완료된 경우에만 출력
	                    var payDate = "";
	                    if (response[i].pay_date) {
	                        var pay_date = new Date(response[i].pay_date);
	                        payDate = "<div> 결제 완료일: " + pay_date.getFullYear() + "년 " + (pay_date.getMonth() + 1) + "월 " + pay_date.getDate() + "일</div>";
	                    }
	                    
	                    //현재진행중인 경우에만 출력
	                    var ongoing = "";
	                    if (response[i].pay_status == false && response[i].del_status == false) {
	                        var due_date = new Date(response[i].due_date);
	                        ongoing = "<div> 결제 예정일: " + due_date.getFullYear() + "년 " + (due_date.getMonth() + 1) + "월 " + (due_date.getDate() +1) + "일</div>";
	                    }
	                    

	  	                $(".all_funded").append(
	  	                		"<div> <a href=\"" + response[i].url + "\"> <img src=\"" + response[i].main_images_url + "\" </a> </div>" +
	  	                		"<div> <a href=\"" + response[i].url + "\"> " + response[i].long_title + "</a> </div>" +
	  	                		"<div>" + response[i].sub_title + "</div>" +   	                		
	  	                		"<div> 후원일 : " + fundDate + "</div> " +	                		
	  	                		"<div> 후원번호 : " + response[i].fund_seq + "</div> " +
	  	                		ongoing +
	  	                		delDate +
	  	                		payDate + "<hr>"
	  	                	);
	  	                }
	  	            }
	          },
	          error: function(error) {
	              console.log(error);
	          }
	     });        
	 }); 

    
});

</script>





<body>

<div class="out_con">

	<div class="funded_title">후원한 프로젝트</div>
	<div class="top_con">
		<div class="top_count"> <span id="total_funded" style="color: red"></span> 건의 후원 내역이 있습니다. </div>	
		<div class="top_search">
			<input type="text" size="30" id="search_keyword" placeholder=" 프로젝트 제목으로 검색할 수 있습니다." 
			onfocus="this.placeholder=''" onblur="this.placeholder='  프로젝트 제목으로 검색할 수 있습니다.'">
		</div>				
	</div>
	
	<hr class="top_under_hr">
	<div class="no_funded_par">
		<div class="no_funded"></div>
	</div>	
	
	<div class="all_funded" >
	    <!-- 후원 진행중 리스트 -->
	    <c:if test="${not empty ongoingFunded}">	    	    	
	        <div class="status_title">후원 진행중 <span class="status_count"> ( ${ongoingFunded.size()} ) </span> </div>
	        <div class="ongoing_out">
	        <c:forEach var="fund" items="${ongoingFunded}" varStatus="out">
				<div class="flex">
	            <c:forEach var="project" items="${ongoingProject}" varStatus="inner">
	            	<c:if test="${out.index eq inner.index}">
	            		<div class="pro_left">
			            	<div><a href="/ongoing_detail/${fund.fund_seq }"><img src="${project.main_images_url}" alt="프로젝트 이미지"></a></div>
		            	</div>
		            	<div class="pro_right">
			            	<div class="funded_day_seq"><span> 후원일 ${fund.fund_date.toLocalDate()}</span> | <span> 후원번호 ${fund.fund_seq}</span></div>
			            	<div class="long_title"><a href="/ongoing_detail/${fund.fund_seq }"> ${project.long_title } </a></div>
			            	<div> ${fund.fund_option}</div>
			            	<div> <span class="pay_status"> 후원 성공시 결제 예정일 ${fund.fund_duedate.toLocalDate().plusDays(1)} </span> </div>
			            	<div class="amount"> <fmt:formatNumber value="${fund.price }" type="currency" currencySymbol="" />원 결제 예정</div>
			            	
			            </div>			            	
	            	</c:if>
            	</c:forEach> 
				</div>
            <c:if test="${!out.last}">
                <hr class="inner_hr">
            </c:if>
	        </c:forEach>
        </div>
	    </c:if>
	
	    <!-- 후원 성공 리스트 -->
	    <c:if test="${not empty successFunded}">	    	    	
	        <div class="status_title">후원 성공 <span class="status_count"> ( ${successFunded.size()} ) </span> </div>
	        <div class="success_out">
	        <c:forEach var="fund" items="${successFunded}" varStatus="out">
				<div class="flex">
        		<c:forEach var="project" items="${successProject}" varStatus="inner">
        			<c:if test="${out.index eq inner.index}">	
	            		<div class="pro_left">
			            	<div><a href="/success_detail/${fund.fund_seq }"><img src="${project.main_images_url}" alt="프로젝트 이미지"></a></div>
		            	</div>
		            	<div class="pro_right">
			            	<div class="funded_day_seq"><span> 후원일 ${fund.fund_date.toLocalDate()}</span> | <span> 후원번호 ${fund.fund_seq}</span></div>
			            	<div class="long_title"><a href="/success_detail/${fund.fund_seq }"> ${project.long_title } </a></div>
			            	<div> ${fund.fund_option}</div>
			            	<div> <span class="pay_status"> 후원 성공  ${fund.fund_duedate.toLocalDate().plusDays(1)} 결제 완료</span> </div>
			            	<div class="amount"> <fmt:formatNumber value="${fund.price }" type="currency" currencySymbol="" />원 결제 완료</div>
	            		</div>
	            	</c:if>
	            </c:forEach>
				</div>
            <c:if test="${!out.last}">
                <hr class="inner_hr">
            </c:if>
	        </c:forEach>
        </div>
	    </c:if>
	
	    <!-- 후원 실패 리스트  -->
	    <c:if test="${not empty cancelFunded}">	    	    	
	        <div class="status_title">후원 실패 <span class="status_count"> ( ${cancelFunded.size()} ) </span></div>
	        <div class="cancel_out">
	        <c:forEach var="fund" items="${cancelFunded}" varStatus="out">
				<div class="flex">
        		<c:forEach var="project" items="${cancelProject}" varStatus="inner">
        			<c:if test="${out.index eq inner.index}">
        				<div class="pro_left">
			            	<div><a href="/cancel_detail/${fund.fund_seq }"><img src="${project.main_images_url}" alt="프로젝트 이미지"></a></div>
		            	</div>
		            	<div class="pro_right">	
			            	<div class="funded_day_seq"><span> 후원일 ${fund.fund_date.toLocalDate()}</span> | <span> 후원번호 ${fund.fund_seq}</span></div>
			            	<div class="long_title"> <a href="/cancel_detail/${fund.fund_seq }"> ${project.long_title } </a></div>
			            	<div> ${fund.fund_option}</div>
			            	<div> <span class="pay_status">결제 예약 취소일 ${fund.del_date.toLocalDate()}</span></div>
			            	<div class="amount"> <fmt:formatNumber value="${fund.price }" type="currency" currencySymbol="" />원 결제 예약 취소</div>			            	
						</div>												
	            	</c:if>		            	            
	            </c:forEach>	            	            
         		</div>
            <c:if test="${!out.last}">
                <hr class="inner_hr">
            </c:if>
	        </c:forEach>	        
        </div>
	    </c:if>	
	    
	</div>	
</div>

</body>
</html>