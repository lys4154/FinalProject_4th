<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<script>
$(document).ready(function() {	
	
	if ("${user.description}" == null) {
		$(".result").html("등록된 자기소개가 없습니다.");
	}else {
		$(".result").html("${user.description}");
	}	
	
	 
	
	//프로필 클릭
	 $("#myprofile_detail").click(function() {
		    $(".result").html("${user.description}");
	    }); //프로필 클릭	 
	 
	 
	//올린프로젝트 클릭
	$("#myproject_detail").click(function() {		 
	    
	           $.ajax({
	              type: "get",
	              url: "/getMyproject",
	              success: function(response) {
	              	console.log(response);
	              	$(".result").empty();
	              	if(response.length == 0) {
	              		$(".result").append("<div> 등록된 프로젝트가 없습니다. </div>");
	              	} else {                		
	                      $(".result").append("<div> <span style='color: red;'> " + response.length + "</span> 개의 프로젝트가 있습니다.</div>")
	                      
	              		for (var i = 0; i < response.length; i++) {                			
	              		    // 모금 달성률 계산
	              		    var achievementRate = (response[i].collection_amount / response[i].goal_price) * 100;
	              		    
	                          // 날짜 포매팅
	                          var startDate = new Date(response[i].start_date);
	                          var dueDate = new Date(response[i].due_date);
	                          var formattedStart = startDate.getFullYear() + "년 " + (startDate.getMonth() + 1) + "월 " + startDate.getDate() + "일";
	                          var formattedDue = dueDate.getFullYear() + "년 " + (dueDate.getMonth() + 1) + "월 " + dueDate.getDate() + "일";
	
	                          // 프로젝트 종료일과 현재 날짜 차이 계산
	                          var currentDate = new Date();
	                          var timeDifference = dueDate - currentDate;
	                          var daysRemaining = Math.ceil(timeDifference / (1000 * 60 * 60 * 24));
	
	                          var statusMessage = (daysRemaining > 0) ? daysRemaining + "일 남음" : "펀딩 종료";
	
	                          $(".result").append(
	                              "<div> 카테고리 : " + response[i].category + "</div>" +
	                              "<div> <a href=\"" + response[i].url + "\"> <img src=" + response[i].main_images_url + "></a> </div>" +
	                              "<div> <strong> [ <a href=\"" + response[i].url + "\">" + response[i].long_title + " ]</strong></a> </div>" +
	                              "<div> 프로젝트 시작일 : " + formattedStart + "</div>" +
	                              "<div> 프로젝트 종료일 : " + formattedDue + " (" + statusMessage + ")</div>" +
	                              "<div> 목표금액 : " + response[i].goal_price.toLocaleString() + "원</div>" +
	                              "<div> 현재모금액 : " + response[i].collection_amount.toLocaleString() + "원</div>" +
	                              "<div> 현재달성률 : " + Math.round(achievementRate) + "%</div> <hr>"
	                          );
	              		}                		
	              	}                   
	              },
	              error: function(error) {
	                  console.log(error);
	              }
	          });        
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
                             "<div> <img src=\"" + response.myFollower[i].profile_img + "\"> </div>" +
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
	
	 
	 
	 //팔로잉 찾기
	 function getFollowing() {
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
                             "<div> <img src=\"" + response.myFollowing[i].profile_img + "\"> </div>" +
                             "<div>" + response.myFollowing[i].nickname + " </div>" +
                             "<div>" + response.myFollowing[i].description + " </div>" +
                             "<div> 팔로워 : " + followerCount + " </div>" +
                             "<div> 올린 프로젝트 : " + projectCount + " </div>" +
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
	 
	 
	 //팔로잉 클릭
	 $("#following_detail").click(function() {	
		 getFollowing();
	    });
	    

})//ready

</script>





<body>

<div><!-- 상단 회원정보 고정 -->
	<div><img alt="프로필 이미지" src="${user.profile_img}"></div>
	<div>${user.member_name}</div>
	<div><a href="/settings" ><img alt="회원정보 수정으로 가는 이모티콘" src=""></a></div>
</div>
<p>

<div><!-- 상단 선택바 고정 -->
	<div id="myprofile_detail" style="cursor:pointer;"> 프로필 </div>
	<div id="myproject_detail" style="cursor:pointer;"> 올린 프로젝트 </div>
	<div id="follower_detail" style="cursor:pointer;"> 팔로워 </div>
	<div id="following_detail" style="cursor:pointer;"> 팔로잉 </div>
</div>
<p>


<div>
	<div class="result" style="color: green"></div>
</div>


</body>

</html>