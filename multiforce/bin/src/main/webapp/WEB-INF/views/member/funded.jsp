<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<script>
$(document).ready(function() {
	
	//후원 총개수
	var ongoingCount = ${ongoingFunded.size()};
    var successCount = ${successFunded.size()};
    var cancelCount = ${cancelFunded.size()};
    var totalCount = ongoingCount + successCount + cancelCount;
    $("#total_funded").html(totalCount); 
  

	//프로젝트 긴제목, 짧은제목 검색
 	$("#search_btn").click(function() {
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
	          		$(".all_funded").empty();
	          		$("#total_funded").html(response.length);
	  	            for (var i = 0; i < response.length; i++) {
	  	                $(".all_funded").append("<div style=\"color: blue\">" + response[i].long_title + "</div>");
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

<h1>후원한 프로젝트</h1>
<p>
<div>
	<div>
		<div>
		<span id="total_funded" style="color: red"></span> 건의 후원 내역이 있습니다.
		</div>
		<div>
		<input type="text" size="30" id="search_keyword" placeholder="프로젝트, 선물, 창작자를 검색하세요">
		<input type="button" id="search_btn" value="검색">
		</div>		
	</div>
	<p>
	
	
	<div class="all_funded" >
	    <!-- 후원 진행중 리스트 -->
	    <c:if test="${not empty ongoingFunded}">
	    	<hr>
	        <div>후원 진행중 <span style="color: orange;"> (${ongoingFunded.size()}) </span> </div>
	        <c:forEach var="ongoing" items="${ongoingFunded}" varStatus="out">
	            <div>
	            <c:forEach var="project" items="${ongoingProject}" varStatus="inner">
	            	<c:if test="${out.index eq inner.index}">	
		            	<div><a href="디테일페이지"><img src="${project.main_images_url}" alt="프로젝트 이미지"></a></div>
		            	<div><span> 후원일 ${ongoing.fund_date.toLocalDate()}</span> | <span> 후원번호 ${ongoing.fund_seq}</span></div>
		            	<div><a href="디테일페이지"> ${project.long_title }</a></div>
		            	<div> ${ongoing.fund_option}</div>
		            	<div> 결제 예정일 ${ongoing.fund_duedate.toLocalDate().plusDays(1)}</div>
		            	<div style="color: purple;"> ${ongoing.price}원 결제 예정</div>		            	
	            	</c:if>
            	</c:forEach> 
	            </div>
	        </c:forEach>
	        <br>
	    </c:if>
	
	    <!-- 후원 성공 리스트 -->
	    <c:if test="${not empty successFunded}">
	    	<hr>
	        <div>후원 성공 <span style="color: orange;"> (${successFunded.size()}) </span> </div>
	        <c:forEach var="success" items="${successFunded}" varStatus="out">
        		<div>
        		<c:forEach var="project" items="${successProject}" varStatus="inner">
        			<c:if test="${out.index eq inner.index}">	
		            	<div><a href="디테일페이지"><img src="${project.main_images_url}" alt="프로젝트 이미지"></a></div>
		            	<div><span> 후원일 ${success.fund_date.toLocalDate()}</span> | <span> 후원번호 ${success.fund_seq}</span></div>
		            	<div><a href="디테일페이지"> ${project.long_title }</a></div>
		            	<div> ${success.fund_option}</div>
		            	<div> 결제 완료일 ${success.fund_duedate.toLocalDate().plusDays(1)}</div>
		            	<div style="color: purple;"> ${success.price}원 결제 완료</div>
	            	</c:if>
	            </c:forEach>
	            </div> 
	        </c:forEach>
	        <br>
	    </c:if>
	
	    <!-- 후원 실패 리스트  -->
	    <c:if test="${not empty cancelFunded}">
	    	<hr>
	        <div>후원 실패 <span style="color: orange;"> (${cancelFunded.size()}) </span></div>
	        <c:forEach var="cancel" items="${cancelFunded}" varStatus="out">
        		<div>
        		<c:forEach var="project" items="${cancelProject}" varStatus="inner">
        			<c:if test="${out.index eq inner.index}">
		            	<div><a href="디테일페이지"><img src="${project.main_images_url}" alt="프로젝트 이미지"></a></div>
		            	<div><span> 후원일 ${cancel.fund_date.toLocalDate()}</span> | <span> 후원번호 ${cancel.fund_seq}</span></div>
		            	<div> <<a href="디테일페이지">${project.long_title }</a></div>
		            	<div> ${cancel.fund_option}</div>
		            	<div> 결제 예약 취소일 ${cancel.del_date.toLocalDate()}</div>
		            	<div style="color: purple;"> ${cancel.price}원 결제 예약 취소</div>
	            	</c:if>
	            </c:forEach>
	            </div>            
	        </c:forEach>
	        <br>
	    </c:if>	
	</div>
</div>

</body>
</html>