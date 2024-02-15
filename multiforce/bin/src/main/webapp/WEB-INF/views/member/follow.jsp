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
<link rel="stylesheet" href="/css/member/follow.css">
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
	
	
	//.result에 내용이 있을때만 테두리 만들기
    function checkResultContent() {
        if ($.trim($('.result').html()) !== '') {
            $('.result_con').css({
            	'border': '1px solid ',
            	'border-color': '#cfcfcf',
            	'border-radius': '5px'
            });
        } else {
        	 $('.result_con').css('border', 'none'); // .result 내용이 없을 때는 border를 제거
        }
     };

	
	
	//후원한 프로젝트 초기화면
	function fundedDetailClick() {
		
		setMenuTab("#funded_detail", "600", "black");
		setMenuTab("#following_detail", "400", "grey");
		setMenuTab("#follower_detail", "400", "grey");	
		
        $.ajax({
            type: "POST",
            url: "/follow_getFunded",
            success: function(response) {
            	console.log(response); // 받은 JSON 데이터 확인
            	$(".result").empty();
            	checkResultContent();
            	if(response.length == 0) {
            		$(".empty_con").html(
            				"<div class='empty_result'>" +
            					"<div class='empty_ment'> 후원한 프로젝트가 없습니다. </div>" +
            					"<button class='backToMain'> 프로젝트 둘러보기 </button>" +
           					"</div>"
                  		 );
            		$(".backToMain").click(function() {
            			location.href = '/';
            		});
            	} else {
            		
            		$(".empty_con").empty();
            		
	                   for (var i = 0; i < response.fundedMember.length; i++) {
	                       var memberSeq = response.fundedMember[i].member_seq;
	                       var followerCount = response.followerCounts[memberSeq];
	                       var projectCount = response.followerProject[memberSeq];
	                       var description = response.fundedMember[i].description;
	                         
	                       if (description === null) {
	                             description = "등록된 자기소개가 없습니다.";
	                       }    
	
	                       $(".result").append(
                    		   "<div class='follow_con'>" +
		                           "<div> <a href=\"" + response.fundedMember[i].member_url + "\"><img src=\"" + response.fundedMember[i].profile_img + "\"> </a></div>" +
		                           "<div class='result_contents'>" +
			                           "<div class='follo_nick'>" + response.fundedMember[i].nickname + " </div>" +
			                           "<div>" + description + " </div>" +
			                           "<div> 팔로워 : " + followerCount + " ㅣ " + " 올린 프로젝트 : " + projectCount + " </div>" +
		                           "</div>" +
		                           "<div class='follow_btn'>" + 
			                           "<button class='css_btn' id='follower_btn' data-member_seq='" + memberSeq + "'> + &nbsp; 팔로우</button>" +
		                           "</div>"  +
	                           "</div>"
	                       );
	                         if (i < response.fundedMember.length - 1) {
	                             $(".result").append("<div><hr class=\"follo_hr\"></div>");
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
	
	
	
	//후원한 프로젝트 클릭
	fundedDetailClick();	
    $("#funded_detail").click(fundedDetailClick);
	  
    
	//팔로잉 찾기   
    function getFollowing(){
		
		setMenuTab("#funded_detail", "400", "grey");
		setMenuTab("#following_detail", "600", "black");
		setMenuTab("#follower_detail", "400", "grey");	
		
       $.ajax({
           type: "get",
           url: "/getFollowing",
           success: function(response) {
           	console.log(response); 
           	$(".result").empty();
           	checkResultContent();
           	if (Object.keys(response).length === 0) {
           		$(".empty_con").html(
           				"<div class='empty_result'>" +
           					"<div class='empty_ment'> 팔로잉한 사용자가 없습니다. </div>" +
        				"</div>"           					
           				);
           		
               } else {
            	   
            	   $(".empty_con").empty();
            	   
                   for (var i = 0; i < response.myFollowing.length; i++) {
                       var memberSeq = response.myFollowing[i].member_seq;
                       var followerCount = response.followerCounts[memberSeq];
                       var projectCount = response.followerProject[memberSeq];
                       var description = response.myFollowing[i].description;
                       
                       if (description === null) {
                           description = "등록된 자기소개가 없습니다.";
                       } 
                       $(".result").append(
						"<div class='follow_con'>" +                    		   
							"<div> <a href=\"" + response.myFollowing[i].member_url + "\"> <img src=\"" + response.myFollowing[i].profile_img + "\"> </a> </div>" +
							"<div class='result_contents'>" +
							 	"<div class='follo_nick'> <a href=\"" + response.myFollowing[i].member_url + "\">" + response.myFollowing[i].nickname + "</a> </div>" +
							    "<div>" + description + " </div>" +
							    "<div> 팔로워 : " + followerCount + " ㅣ " + " 올린 프로젝트 : " + projectCount + " </div>" +
						    "</div>" +
						    "<div class='follow_btn'>" + 
							     "<button class='css_btn' id='following_btn' data-member_seq='" + memberSeq + "'>  + &nbsp; 팔로우 </button>" +
						     "</div>" +
					     "</div>"
                       );
                       if (i < response.myFollowing.length - 1) {
                           $(".result").append("<div><hr class=\"follo_hr\"></div>");
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
		getFollowing();
	});
	
	
	
	//팔로잉에서 팔로우 취소
	$(".result").on("click", "#following_btn", function() {
		
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
		
		setMenuTab("#funded_detail", "400", "grey");
		setMenuTab("#following_detail", "400", "grey");
		setMenuTab("#follower_detail", "600", "black");
		
       $.ajax({
           type: "get",
           url: "/getFollower",
           success: function(response) {
           	console.log(response); 
           	$(".result").empty();
           	checkResultContent();
           	if (Object.keys(response).length === 0) {
           		$(".empty_con").html(
           				"<div class='empty_result'>" +
           					"<div class='empty_ment'> 팔로워한 사용자가 없습니다. </div>" +
       					"</div>"            					
           				);         		
               } else {
            	   
            	   $(".empty_con").empty();
            	   
                   for (var i = 0; i < response.myFollower.length; i++) {
                       var memberSeq = response.myFollower[i].member_seq;
                       var followerCount = response.followerCounts[memberSeq];
                       var projectCount = response.followerProject[memberSeq];
                       var description = response.myFollower[i].description;
                       
                       if (description === null) {
                           description = "등록된 자기소개가 없습니다.";
                       }                      

                       $(".result").append(
                   		   "<div class='follow_con'>" +                    		   
                   		  		"<div> <a href=\"" + response.myFollower[i].member_url + "\"> <img src=\"" + response.myFollower[i].profile_img + "\"> </a> </div>" +
                   		  		"<div class='result_contents'>" +
                   		  			"<div class='follo_nick'> <a href=\"" + response.myFollower[i].member_url + "\">" + response.myFollower[i].nickname + "</a> </div>" +
                           			"<div>" + description + " </div>" +
                           			"<div> 팔로워 : " + followerCount + " ㅣ " + " 올린 프로젝트 : " + projectCount + " </div>" +
                       			"</div>" +
                           		"<div class='follow_btn'>" +                                
                           			"<button class='css_btn' id='follower_btn' data-member_seq='" + memberSeq + "'> + &nbsp; 팔로우</button>" +
                       			"</div>" +
                   			"</div>"
                       );
                       if (i < response.myFollower.length - 1) {
                           $(".result").append("<div><hr class=\"follo_hr\"></div>");
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
		getFollower();
	}); 
 
	
	// 팔로워에서 팔로우추가 클릭
	$(".result").on("click", "#follower_btn", function() {
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
		    	                	getFollowing();
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
	
})//ready

</script>





<body>

<div class="out_con">

	<div class="follow_title">팔로우</div>
	
	<div class="menu_con"><!-- 상단 선택바 고정 -->
		<div class="menu_item" id="funded_detail" style="color: black; font-weight:600;"> 후원한 창작자 </div>
		<div class="menu_item" id="following_detail" > 팔로잉 </div>
		<div class="menu_item" id="follower_detail" > 팔로워 </div>
	</div>
	<hr class="menu_under_hr">
	
	<div class="result_con">
		<div class="result" ></div>
	</div>

	<div class="empty_con">
	</div>

</div>

</body>
</html>
