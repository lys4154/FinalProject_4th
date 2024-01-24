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
	
	//후원한 프로젝트 초기
	function fundedDetailClick() {
        $.ajax({
            type: "POST",
            url: "/follow_getFunded",
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
	                   for (var i = 0; i < response.fundedMember.length; i++) {
	                       var memberSeq = response.fundedMember[i].member_seq;
	                       var followerCount = response.followerCounts[memberSeq];
	                       var projectCount = response.followerProject[memberSeq];
	
	                       $(".result").append(
	                           "<div>" + response.fundedMember[i].profile_img + " </div>" +
	                           "<div>" + response.fundedMember[i].nickname + " </div>" +
	                           "<div>" + response.fundedMember[i].description + " </div>" +
	                           "<div> 팔로워 : " + followerCount + " </div>" +
	                           "<div> 올린 프로젝트 : " + projectCount + " </div>" +
	                           '<div class="modal-dialog modal-dialog-centered">' +                                
	                           "<button class='follower_btn' data-member_seq='" + memberSeq + "'> 팔로우</button> </div> <hr>"  
	                       );
	                   }
	               }
	
	           },
            error: function(request, e) {
				console.log("코드 : " + request.status + " 메시지 : " + request.responseText + " 오류" + e);
            }
        });		
	}
	
	
	
	//후원한 프로젝트 클릭
	fundedDetailClick();
	
    $("#funded_detail").click(fundedDetailClick);
	  
    
	//팔로잉 찾기   
    function getFollowing(){
       $.ajax({
           type: "get",
           url: "/getFollowing",
           success: function(response) {
           	console.log(response); 
           	$(".result").empty();
           	if (Object.keys(response).length === 0) {
           		$(".result").append("<div> 팔로잉한 사용자가 없습니다. </div>");
               } else {
                   for (var i = 0; i < response.myFollowing.length; i++) {
                       var memberSeq = response.myFollowing[i].member_seq;
                       var followerCount = response.followerCounts[memberSeq];
                       var projectCount = response.followerProject[memberSeq];

                       $(".result").append(
                           "<div>" + response.myFollowing[i].profile_img + " </div>" +
                           "<div>" + response.myFollowing[i].nickname + " </div>" +
                           "<div>" + response.myFollowing[i].description + " </div>" +
                           "<div> 팔로워 : " + followerCount + " </div>" +
                           "<div> 올린 프로젝트 : " + projectCount + " </div>" +
                           "<button class='following_btn' data-member_seq='" + memberSeq + "'> 팔로잉 - 클릭시 취소</button> <hr>"
                       );
                   }
               }

           },
           error: function(error) {
               console.log(error);
           }
       });
    }
    
	//팔로잉 클릭 
	$("#following_detail").click(function() {
		getFollowing();
	});
	
	
	
	//팔로잉에서 팔로우 취소
	$(".result").on("click", ".following_btn", function() {
		
		    var memberSeq = $(this).data("member_seq");
		   if(confirm("팔로우를 취소하시겠습니까?") == true) {
			    $.ajax({
			        type: "POST",
			        url: "/following_btn",
			        data: { memberSeq: memberSeq },
			        success: function(response) {
			            console.log(response);
			            if(response == 1) {
			            	alert("팔로우가 취소되었습니다.");
			            	getFollowing();
			            	
			            }         	                
			        },
				error : function(request, e) {
					console.log(error);
			        }
			    });
		   }
	
	});
	
	
	    
	
	
	//팔로워 찾기
	function getFollower() {
       $.ajax({
           type: "get",
           url: "/getFollower",
           success: function(response) {
           	console.log(response); 
           	$(".result").empty();
           	if (Object.keys(response).length === 0) {
           		$(".result").append("<div> 팔로워가 없습니다. </div>");
               } else {
                   for (var i = 0; i < response.myFollower.length; i++) {
                       var memberSeq = response.myFollower[i].member_seq;
                       var followerCount = response.followerCounts[memberSeq];
                       var projectCount = response.followerProject[memberSeq];

                       $(".result").append(
                           "<div>" + response.myFollower[i].profile_img + " </div>" +
                           "<div>" + response.myFollower[i].nickname + " </div>" +
                           "<div>" + response.myFollower[i].description + " </div>" +
                           "<div> 팔로워 : " + followerCount + " </div>" +
                           "<div> 올린 프로젝트 : " + projectCount + " </div>" +
                           '<div class="modal-dialog modal-dialog-centered">' +                                
                           "<button class='follower_btn' data-member_seq='" + memberSeq + "'> 팔로우</button> </div> <hr>"  
                       );
                   }
               }

           },
           error: function(error) {
               console.log(error);
           }
       }); 
	}
	    
	//팔로워 클릭
	$("#follower_detail").click(function() {
		getFollower();
	}); 
 
	
	// 팔로워에서 팔로우추가 클릭
	$(".result").on("click", ".follower_btn", function() {
	    var memberSeq = $(this).data("member_seq");
	    $.ajax({
	        type: "POST",
	        url: "/follower_btn",
	        data: { memberSeq: memberSeq },
	        success: function(response) {
	            console.log(response);
	            if(response == 1) {
	            	alert("성공적으로 팔로우 했습니다.");
	            	getFollower();
	            } else {
	            	alert("이미 팔로우 되어있습니다.");
	            }             	                
	        },
	        error: function(error) {	            	
	            console.log(error);
	        }
	    });
	});

 
	
})//ready

</script>





<body>

<h1>팔로우</h1>
<p>
<div><!-- 상단 선택바 고정 -->
	<div id="funded_detail" style="cursor:pointer;" > 후원한 창작자 </div>
	<div id="following_detail" style="cursor:pointer;"> 팔로잉 </div>
	<div id="follower_detail" style="cursor:pointer;"> 팔로워 </div>
</div>
<p>

<div>
	<div class="result" style="color: red"></div>
</div>


</body>
</html>