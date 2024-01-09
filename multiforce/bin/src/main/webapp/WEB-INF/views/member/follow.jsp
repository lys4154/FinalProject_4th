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

	 $("#funded_detail").click(function() {
         $.ajax({
             type: "post",
             url: "/getFunded",
             success: function(response) {
             	console.log(response); // 받은 JSON 데이터 확인
             	$(".result").empty();
             	if(response.length == 0) {
             		$(".result").append(
             				"<div> 후원한 프로젝트가 없습니다. </div>" +
                            "<button id='backToMain'> 프로젝트 둘러보기 </button>"
                   		 );
	                    $("#backToMain").click(function() {
	                    	location.href = '/';		//최종 메인페이지 넣기
	                    });
             	} else {
     	            for (var i = 0; i < response.length; i++) {
     	                $(".result").append("<div>" + response[i].name + "</div>");
     	            }     		
             	}                 
             },
             error: function(error) {
                 console.log(error);
             }
         });	        
	    }); //후원한 프로젝트 클릭
	   
	    
	 $("#following_detail").click(function() {
            $.ajax({
                type: "post",
                url: "/getFollowing",
                success: function(response) {
                	console.log(response); // 받은 JSON 데이터 확인
                	$(".result").empty();
                	if(response.length == 0) {
                		$(".result").append("<div> 팔로잉한 사용자가 없습니다. </div>");
                	} else {
        	            for (var i = 0; i < response.length; i++) {
        	                $(".result").append("<div>" + response[i].member_name + " / " + response[i].description + "</div>");
        	            }                		
                	}                   
                },
                error: function(error) {
                    console.log(error);
                }
            });	        
	    }); //팔로잉 클릭
	    
	    
	 $("#follower_detail").click(function() {
            $.ajax({
                type: "post",
                url: "/getFollower",
                success: function(response) {
                	console.log(response); // 받은 JSON 데이터 확인
                	$(".result").empty();
                	if(response.length == 0) {
                		$(".result").append("<div> 팔로워가 없습니다. </div>");
                	} else {
        	            for (var i = 0; i < response.length; i++) {
        	                $(".result").append("<div>" + response[i].member_name + " / " + response[i].description + "</div>");
        	            }               		
                	}
                    
                },
                error: function(error) {
                    console.log(error);
                }
            }); 
	    }); //팔로워 클릭
 

 
	
})//ready

</script>





<body>

<h1>팔로우</h1>
<p>
<div><!-- 상단 선택바 고정 -->
	<div id="funded_detail" style="cursor:pointer;"> 후원한 창작자 </div>
	<div id="following_detail" style="cursor:pointer;"> 팔로잉 </div>
	<div id="follower_detail" style="cursor:pointer;"> 팔로워 </div>
</div>
<p>

<div>
	<div class="result" style="color: red"></div>
</div>


</body>
</html>