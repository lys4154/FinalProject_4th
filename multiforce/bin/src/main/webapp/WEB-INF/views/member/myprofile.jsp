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
	
	if (<%=session.getAttribute("description")%> == null) { //클릭 이벤트 전에는 session이 비어있어서 자기소개가 없는 상태, 클릭 해야지 보인다.
		$(".result").html("등록된 자기소개가 없습니다.");
	}else {
		$(".result").html("${loginMember.description}");
	}
	
	 
	
	 $("#myprofile_detail").click(function() {
            $(".result").html("${loginMember.description}");        
	    }); //프로필 클릭	 
	 
	 
	 $("#reviews_detail").click(function() {
	        $(".result").html("후기 DB에 없음.");
	    }); //프로젝트후기 클릭 
	 
	 
	 $("#myproject_detail").click(function() {
             $.ajax({
                type: "get",
                url: "/getMyproject",
                success: function(response) {
                	console.log(response); // 받은 JSON 데이터 확인
                	$(".result").empty();
                	if(response.length == 0) {
                		$(".result").append("<div> 등록된 프로젝트가 없습니다. </div>");
                	} else {
        	            for (var i = 0; i < response.length; i++) {
        	                $(".result").append("<div>" + response[i].long_title + "</div>");
        	            }                		
                	}                   
                },
                error: function(error) {
                    console.log(error);
                }
            });        
	    }); //올린프로젝트 클릭 
	 
	 
	 $("#funded_detail").click(function() {
            $.ajax({
                type: "get",
                url: "/getFunded",
                success: function(response) {
                	console.log(response); // 받은 JSON 데이터 확인
                	$(".result").empty();
                	if(response.length == 0) {
                		$(".result").append("<div> 후원한 프로젝트가 없습니다. </div>");
                	} else {
        	            for (var i = 0; i < response.length; i++) {
        	                $(".result").append("<div>" + response[i].long_title + "</div>");
        	            }     		
                	}                 
                },
                error: function(error) {
                    console.log(error);
                }
            });	        
	    }); //후원한 프로젝트 클릭
	    
	 
	    
	 $("#follower_detail").click(function() {
            $.ajax({
                type: "get",
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
	 
	 
	 
	 $("#following_detail").click(function() {
            $.ajax({
                type: "get",
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
	    


	
})//ready

</script>





<body>

<div><!-- 상단 회원정보 고정 -->
	<div><img alt="프로필 이미지" src="${loginMember.profile_img}"></div>
	<div>${loginMember.member_name}</div>
	<div><a href="/settings" ><img alt="회원정보 수정으로 가는 이모티콘" src=""></a></div>
</div>
<p>

<div><!-- 상단 선택바 고정 -->
	<div id="myprofile_detail" style="cursor:pointer;"> 프로필 </div>
	<div id="reviews_detail" style="cursor:pointer;"> 프로젝트 후기 </div>
	<div id="myproject_detail" style="cursor:pointer;"> 올린 프로젝트 </div>
	<div id="funded_detail" style="cursor:pointer;"> 후원한 프로젝트 </div>
	<div id="follower_detail" style="cursor:pointer;"> 팔로워 </div>
	<div id="following_detail" style="cursor:pointer;"> 팔로잉 </div>

</div>
<p>


<div>
	<div class="result" style="color: green"></div>
</div>



</body>

</html>