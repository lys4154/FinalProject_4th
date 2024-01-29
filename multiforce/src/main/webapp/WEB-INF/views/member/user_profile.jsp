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
	
	let memberSeq = ${user.member_seq};
	let followerSeq;
	
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
	              url: "/getUserproject",
	              data: {memberSeq : memberSeq},
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
	 function getUserFollower() {
         $.ajax({
             type: "get",
             url: "/getUserFollower",
             data: {memberSeq : memberSeq},
             success: function(response) {
             	console.log(response); 
             	$(".result").empty();
             	if (Object.keys(response).length === 0) {
             		$(".result").append("<div> 팔로워가 없습니다. </div>");
                 } else {
                     for (var i = 0; i < response.myFollower.length; i++) {
                         var memberSeq = response.myFollower[i].member_seq;
                         var description = response.myFollower[i].description;
                         var followerCount = response.followerCounts[memberSeq];
                         var projectCount = response.followerProject[memberSeq];
                         
                         if (description === null) {
                             description = "등록된 자기소개가 없습니다.";
                         }

                         $(".result").append(
                             "<div> <a href=\"" + response.myFollower[i].member_url + "\"> <img src=\"" + response.myFollower[i].profile_img + "\"> </a> </div>" +
                             "<div> <a href=\"" + response.myFollower[i].member_url + "\"> " + response.myFollower[i].nickname + " </a> </div>" +
                             "<div>" + description + " </div>" +
                             "<div> 팔로워 : " + followerCount + " </div>" +
                             "<div> 올린 프로젝트 : " + projectCount + " </div>" +
                             '<div class="modal-dialog modal-dialog-centered">' +                                
                             "<button class='userFollower_btn' data-follower_seq='" + response.myFollower[i].member_seq + "'> 팔로우</button> </div> <hr>"  
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
		 getUserFollower();
	 }); 	
	    
    
	 // memberSeq - 현재회원, follower_seq - 현재 회원의 팔로워의 seq
	 // 팔로워에서 팔로우추가 클릭
	    $(".result").on("click", ".userFollower_btn", function() {
	        var follower_seq = $(this).data("follower_seq");
	        $.ajax({
	            type: "POST",
	            url: "/userFollower_btn",
	            data: { followerSeq: follower_seq },
	            success: function(response) {
	                console.log(response);
	                if(response == 1) {
	                	alert("성공적으로 팔로우 했습니다.");
	                } else if(response == 2) {
	                	alert("로그인 후 이용해주세요.")
	                	
	                }  else {
	                	if (confirm("이미 팔로우 되어있습니다." +
	                			"팔로우를 취소 하시겠습니까?")) {	                		
	                        $.ajax({
	                            type: "POST",
	                            url: "/unFollow",
	                            data: { followerSeq: follower_seq },
	                            success: function(response) {
	                            	console.log(response); 
	            	                if(response == 1) {
	            	                	alert("팔로우가 취소되었습니다.");
	            	                }
	                            },
	                            error: function(error) {
	                                console.log(error);
	                                console.log(followerSeq);
	                            }
	                        });
	                		
	                	}
	                }             	                
	            },
	            error: function(error) {	            	
	                console.log(error);
	            }
	        });
	    });
	
	 
	 
	 //팔로잉 찾기
	 function getUserFollowing() {
         $.ajax({
             type: "get",
             url: "/getUserFollowing",
             data: {memberSeq : memberSeq},
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
                         var description = response.myFollowing[i].description;
                         
                         if (description === null) {
                             description = "등록된 자기소개가 없습니다.";
                         }                         
                         
                         $(".result").append(
                             "<div> <a href=\"" + response.myFollowing[i].member_url + "\">  <img src=\"" + response.myFollowing[i].profile_img + "\"> </a> </div>" +
                             "<div> <a href=\"" + response.myFollowing[i].member_url + "\"> " + response.myFollowing[i].nickname + " </a> </div>" +
                             "<div>" + description + " </div>" +
                             "<div> 팔로워 : " + followerCount + " </div>" +
                             "<div> 올린 프로젝트 : " + projectCount + " </div>" +
                             "<button class='userFollower_btn' data-follower_seq='" + response.myFollowing[i].member_seq + "'> 팔로우</button> </div> <hr>"
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
		 getUserFollowing();
	    });
	    

})//ready

</script>





<body>

<div><!-- 상단 회원정보 고정 -->
	<div><img alt="프로필 이미지" src="${user.profile_img}"></div>
	<div>${user.member_name}</div>
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


<h1>${user.member_seq }</h1>


</body>

</html>