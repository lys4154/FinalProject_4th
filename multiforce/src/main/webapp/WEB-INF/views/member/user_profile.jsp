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
<link rel="stylesheet" href="/css/member/myprofile.css">
</head>

<script>
$(document).ready(function() {
	
	//메뉴탭 선택시 css
	function setMenuTab(element, fontWeight, color) {
	    $(element).css({
	        "font-weight": fontWeight,
	        "color": color
	    })	    
	}
	
	//.result에 내용이 있을때만 테두리 만들기
    function checkResultContent() {
        if ($.trim($('.result').html()) !== '') {
            $('.res_con').css({
            	'border': '1px solid ',
            	'border-color': '#cfcfcf',
            	'border-radius': '5px'
            });
        } else {
        	 $('.res_con').css('border', 'none'); // .result 내용이 없을 때는 border를 제거
        }
     };
	
	
	let memberSeq = ${user.member_seq};
	let followerSeq;
	

	//자기 소개
	function myDescription() {
		let description = "${user.description}";
		if (description == "") {
			$(".result").html("등록된 소개가 없습니다.");
		}else {
			$(".result").html(description);
		};
	}	
	myDescription();
	 

	
	//프로필 클릭
	 $("#myprofile_detail").click(function() {
		myDescription();
		$(".empty_result").empty();
		$(".result_count").html('');
		setMenuTab("#myprofile_detail", "600", "#292929");
		setMenuTab("#myproject_detail", "400", "#5c5c5c");
		setMenuTab("#follower_detail", "400", "#5c5c5c");
		setMenuTab("#following_detail", "400", "#5c5c5c");
		$('.res_con').css('border', 'none');
	    }); //프로필 클릭	 
	 
	 
	//올린프로젝트 클릭
	$("#myproject_detail").click(function() {
		 setMenuTab("#myprofile_detail", "400", "#5c5c5c");
		 setMenuTab("#myproject_detail", "600", "#292929");
		 setMenuTab("#follower_detail", "400", "#5c5c5c");
		 setMenuTab("#following_detail", "400", "#5c5c5c");
		
	           $.ajax({
	              type: "get",
	              url: "/getUserproject",
	              data: {memberSeq : memberSeq},
	              success: function(response) {
	              	console.log(response);
	              	$(".result").empty();
	              	checkResultContent();
	              	if(response.length == 0) {
	              		$(".empty_con").html(
		               				"<div class='empty_result'>" +
			           					"<div class='empty_ment'> 등록한 프로젝트가 없습니다. </div>" +
			       					"</div>"	
	              				);
	              	} else {                		
	                      $(".result_count").append("<div> <span style='color: red;'> " + response.length + "</span> 개의 프로젝트가 있습니다.</div>")
	                      $(".empty_result").empty();
	                      
	              		for (var i = 0; i < response.length; i++) {                			
	              		    // 모금 달성률 계산
	              		    var achievementRate = (response[i].collection_amount / response[i].goal_price) * 100;
		
	                          $(".result").append(
  	                		    "<div class=\"pro_con\">" +
	                		    	"<div class=\"pro_left\">" +			                	        
			                	        "<div> <a href=\"" + response[i].url + "\"> <img src=\"" + response[i].main_images_url + "\" class=\"pro_img\"></a> </div>" +
		                	        "</div>" +
		                	        "<div class=\"pro_right\">" +
		                	        	"<div class=\"pro_title\">" +
			                	       		"<div class=\"pro_category\"> 카테고리 " + response[i].category + "</div>" +
				                	        "<div class=\"pro_longtitle\">  <a href=\"" + response[i].url + "\">" + response[i].long_title + "  </a> </div>" +
			                	        "</div>" +
			                	        "<div> 기간 " + response[i].start_date + " ~ " + response[i].due_date + "<span id=\"pro_day\"> (D-" + response[i].term + ")</span></div>" +
			                	        "<div> 목표금액  " + response[i].goal_price.toLocaleString() + "원</div>" +
			                	        "<div> 현재모금액  " + response[i].collection_amount.toLocaleString() + "원" +
			                	        "<span id=\"pro_goal\"> (" + Math.round(achievementRate) + "% 달성) </span></div>" +
		                	        "</div>" +
		                	    "</div>"
	                          );
	                           if (i < response.length - 1) {
	                               $(".result").append("<hr class=\"follo_hr\">");	                          
	              				}
	              			}
	              		checkResultContent();
              		}                   
	              },
	              error: function(error) {
	                  console.log(error);
	              }
	          });        
	   });  

	
	 //팔로워 찾기
	 function getUserFollower() {
		 $(".result_count").html('');
         $.ajax({
             type: "get",
             url: "/getUserFollower",
             data: {memberSeq : memberSeq},
             success: function(response) {
             	console.log(response); 
             	$(".result").empty();
             	checkResultContent();
             	if (Object.keys(response).length === 0) {
             		$(".empty_con").html(
             				"<div class='empty_result'>" +
         						"<div class='empty_ment'> 팔로워가 없습니다.</div>" +
         					"</div>"
             				);
                 } else {
                	 
                	 $(".empty_result").empty();
                	 
                     for (var i = 0; i < response.myFollower.length; i++) {
                         var memberSeq = response.myFollower[i].member_seq;
                         var description = response.myFollower[i].description;
                         var followerCount = response.followerCounts[memberSeq];
                         var projectCount = response.followerProject[memberSeq];
                         
                         if (description === null) {
                             description = "등록된 자기소개가 없습니다.";
                         }

                         $(".result").append(
                       		 "<div class=\"follo_con\">" +
                       		 	"<div class=\"follo_left\">" +                       		 	
 	                            	"<div> <a href=\"" + response.myFollower[i].member_url + "\"> <img src=\"" + response.myFollower[i].profile_img + "\" class=\"follo_img\"> </a> </div>" +
 	                       		"</div>" +
 	                        	"<div class=\"follo_right\">" +
 		                            "<div class=\"follo_nick\"> <a href=\"" + response.myFollower[i].member_url + "\">" + response.myFollower[i].nickname + " </a> </div>" +
 		                            "<div class=\"follo_desc\">" + description + " </div>" +
 		                            "<div> 팔로워 " + followerCount + " | 올린 프로젝트 " + projectCount + " </div>" +
 	                            "</div>" +
 	                            "<div class=\"follo_btn\">" +
 		                            "<button class=\"follower_btn\" data-member_seq=" + memberSeq + "> + &nbsp; 팔로우 </button> </div>" +
 	                            "</div>" +
                            "</div>"
                         );
                         if (i < response.myFollower.length - 1) {
                             $(".result").append("<hr class=\"follo_hr\">");
                         }
                     }
                     checkResultContent();
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
		 setMenuTab("#myprofile_detail", "400", "#5c5c5c");
		 setMenuTab("#myproject_detail", "400", "#5c5c5c");
		 setMenuTab("#follower_detail", "600", "#292929");
		 setMenuTab("#following_detail", "400", "#5c5c5c");
			 
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
		$(".result_count").html('');
         $.ajax({
             type: "get",
             url: "/getUserFollowing",
             data: {memberSeq : memberSeq},
             success: function(response) {
             	console.log(response); 
             	$(".result").empty();
             	checkResultContent();
             	if (Object.keys(response).length === 0) {
             		$(".empty_con").append(
             				"<div class='empty_result'>" +
         						"<div class='empty_ment'> 팔로잉한 사용자가 없습니다.</div>" +
         					"</div>"            				
             				);
                 } else {
                	 
                	 $(".empty_result").empty();
                	 
                     for (var i = 0; i < response.myFollowing.length; i++) {
                         var memberSeq = response.myFollowing[i].member_seq;
                         var followerCount = response.followerCounts[memberSeq];
                         var projectCount = response.followerProject[memberSeq];
                         var description = response.myFollowing[i].description;
                         
                         if (description === null) {
                             description = "등록된 자기소개가 없습니다.";
                         }                         
                         
                         $(".result").append(
                       		"<div class=\"follo_con\">" +
                    			"<div class=\"follo_left\">" +
		                            "<div> <a href=\"" + response.myFollowing[i].member_url + "\"> <img src=\"" + response.myFollowing[i].profile_img + "\" class=\"follo_img\"> </a> </div>" +
	                            "</div>" +
	                            "<div class=\"follo_right\">" +
		                            "<div class=\"follo_nick\"> <a href=\"" + response.myFollowing[i].member_url + "\"> " + response.myFollowing[i].nickname + " </a> </div>" +
		                            "<div class=\"follo_desc\">" + description + " </div>" +
		                            "<div> 팔로워 " + followerCount + " | 올린 프로젝트 " + projectCount + " </div>" +
	                            "</div>" +
	                            "<div class=\"follo_btn\">" +
		                            "<button class='following_btn' data-member_seq='" + memberSeq + "'> + &nbsp; 팔로우</button>" +
	                            "</div>" +
                            "</div>"
                         );
                         if (i < response.myFollowing.length - 1) {
                             $(".result").append("<hr class=\"follo_hr\">");
                         }
                     }
                     checkResultContent();
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
		 setMenuTab("#myprofile_detail", "400", "#5c5c5c");
		 setMenuTab("#myproject_detail", "400", "#5c5c5c");
		 setMenuTab("#follower_detail", "400", "#5c5c5c");
		 setMenuTab("#following_detail", "600", "#292929");
		 
		});
	    

})//ready

</script>





<body>


<div class="out_con" >
	<div class="top_con" >
		<div><img alt="프로필 이미지" src="${user.profile_img}" id="profile_img"></div>
		<div class="nick_con">
			<div>
				<span id="my_nick">${user.nickname}</span>
			</div>				
			<div class="url_con">
				<span>${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}</span><span id="url_new">${user.member_url}</span>
			</div>	
		</div>
	</div>

	
	<div class="menu_con"><!-- 상단 선택바 고정 -->
		<div class="menu_item" id="myprofile_detail" style="cursor:pointer; color: #292929; font-weight:600;"> 프로필 </div>
		<div class="menu_item" id="myproject_detail" style="cursor:pointer;"> 올린 프로젝트 </div>
		<div class="menu_item" id="follower_detail" style="cursor:pointer;"> 팔로워 </div>
		<div class="menu_item" id="following_detail" style="cursor:pointer;"> 팔로잉 </div>
	</div>
	<hr class="menu_under_hr">
	
	<div class="result_count" ></div>
	<div class="res_con" >
		<div class="result" ></div>
	</div>
	
	<div class="empty_con">
	</div>
	
</div>

</body>
</html>