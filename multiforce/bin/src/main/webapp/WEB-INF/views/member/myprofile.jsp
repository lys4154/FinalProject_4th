<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${loginMember.nickname}님 | 멀티포스 펀딩</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/css/member/myprofile.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>

<script>
$(document).ready(function() {	
	
	//메뉴탭 선택시 css
	function setMenuTab(element, fontWeight, color) {
	    $(element).css({
	        "font-weight": fontWeight,
	        "color": color
	    });
	}	
	
	
	//자기 소개
	function myDescription() {
		let description = "${loginMember.description}";
		if (description == "") {
			$(".result").html("등록된 자기소개가 없습니다.");
		}else {
			$(".result").html(description);
		};
	}
	
	myDescription();	
	//프로필 클릭
	 $("#myprofile_detail").click(function() {
		 myDescription();
		 setMenuTab("#myprofile_detail", "600", "black");
		 setMenuTab("#myproject_detail", "400", "grey");
		 setMenuTab("#funded_detail", "400", "grey");
		 setMenuTab("#follower_detail", "400", "grey");
		 setMenuTab("#following_detail", "400", "grey");
	    }); //프로필 클릭	 
	 
	
	//올린프로젝트 클릭
	$("#myproject_detail").click(function() {		
		 setMenuTab("#myprofile_detail", "400", "grey");
		 setMenuTab("#myproject_detail", "600", "black");
		 setMenuTab("#funded_detail", "400", "grey");
		 setMenuTab("#follower_detail", "400", "grey");
		 setMenuTab("#following_detail", "400", "grey");
	    
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
	 
	 
	 //후원한 프로젝트 클릭
	 $("#funded_detail").click(function() {
		 setMenuTab("#myprofile_detail", "400", "grey");
		 setMenuTab("#myproject_detail", "400", "grey");
		 setMenuTab("#funded_detail", "600", "black");
		 setMenuTab("#follower_detail", "400", "grey");
		 setMenuTab("#following_detail", "400", "grey");
	
           $.ajax({
               type: "get",
               url: "/getFunded",
               success: function(response) {
	               	console.log(response); 
	               	$(".result").empty();
	               	if(response.length == 0) {
	               		$(".result").append("<div> 후원한 프로젝트가 없습니다. </div>");
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
	                               "<div> "+ response[i].sub_title + "</div>" +
	                               "<div> 현재달성률 : " + Math.round(achievementRate) + "%</div>" +
	                               "<div> 현재모금액 : " + response[i].collection_amount.toLocaleString() + "원</div>" +
	                               "<div> 프로젝트 종료까지 " + statusMessage + "</div> <hr>"
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
                         var description = response.myFollower[i].description;
                         
                         if (description === null) {
                             description = "등록된 자기소개가 없습니다.";
                         }                        

                         $(".result").append(
                             "<div> <a href=\"" + response.myFollower[i].member_url + "\"> <img src=\"" + response.myFollower[i].profile_img + "\"> </a> </div>" +
                             "<div> <a href=\"" + response.myFollower[i].member_url + "\">" + response.myFollower[i].nickname + " </a> </div>" +
                             "<div>" + description + " </div>" +
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
		 setMenuTab("#myprofile_detail", "400", "grey");
		 setMenuTab("#myproject_detail", "400", "grey");
		 setMenuTab("#funded_detail", "400", "grey");
		 setMenuTab("#follower_detail", "600", "black");
		 setMenuTab("#following_detail", "400", "grey");
   	}); 	
	    
    
	    
	//팔로워에서 팔로우추가 클릭		
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
                } else if(response == 3) {
                	if (confirm("이미 팔로우 되어있습니다." +
                			"팔로우를 취소 하시겠습니까?")) {	                		
                        $.ajax({
                            type: "POST",
                            url: "/following_btn",
                            data: { memberSeq: memberSeq },
                            success: function(response) {
                            	console.log(memberSeq); 
            	                if(response == 1) {
            	                	alert("팔로우가 취소되었습니다.");
            	                	getFollower();
            	                }
                            },
                            error: function(error) {
                                console.log(error);
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
	                        var description = response.myFollowing[i].description;
	                        
	                        if (description === null) {
	                            description = "등록된 자기소개가 없습니다.";
	                        }    
	                        
	
	                        $(".result").append(
	                            "<div> <a href=\"" + response.myFollowing[i].member_url + "\"> <img src=\"" + response.myFollowing[i].profile_img + "\"> </a> </div>" +
	                            "<div> <a href=\"" + response.myFollowing[i].member_url + "\"> " + response.myFollowing[i].nickname + " </a> </div>" +
	                            "<div>" + description + " </div>" +
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
		 setMenuTab("#myprofile_detail", "400", "grey");
		 setMenuTab("#myproject_detail", "400", "grey");
		 setMenuTab("#funded_detail", "400", "grey");
		 setMenuTab("#follower_detail", "400", "grey");
		 setMenuTab("#following_detail", "600", "black");
	 
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

	
})//ready

</script>



<body>
<div class="big_con" style="border: solid blue;">
	<div class="top_con" ><!-- 상단 회원정보 고정 -->
		<div><img alt="프로필 이미지" src="${loginMember.profile_img}"  id="profile_img"></div>
		<div class="nick_con">
			<div>
				<span style="font-size: 20px;">${loginMember.nickname} </span>
				<span> <a href="/settings" ><img alt="회원정보 수정으로 가는 이모티콘" src="/settings/settings.png" id="set_icon"></a></span>
			</div>
			<div class="url_con">
				<span>${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}</span><span id="url_new">${loginMember.member_url}</span>
			</div>			
		</div>
	</div>
	<p>
	
	<div class="menu_con"><!-- 상단 선택바 고정 -->
		<div class="menu_item" id="myprofile_detail" style="cursor:pointer; color: black; font-weight:600;" > 프로필 </div>
		<div class="menu_item" id="myproject_detail" style="cursor:pointer;"> 올린 프로젝트 <span></span> </div>
		<div class="menu_item" id="funded_detail" style="cursor:pointer;"> 후원한 프로젝트 </div>
		<div class="menu_item" id="follower_detail" style="cursor:pointer;"> 팔로워 </div>
		<div class="menu_item" id="following_detail" style="cursor:pointer;"> 팔로잉 </div>		
	</div>
	<hr class="menu_under_hr">
	
	
	<div>
		<div class="result" style="color: green"></div>
	</div>
</div>

</body>

</html>