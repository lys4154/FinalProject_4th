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
<link rel="stylesheet" href="/css/member/myproject.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>

<script>

$(document).ready(function() {
	
	let memberSeq = <%= session.getAttribute("login_user_seq") %>;
	
	//메뉴탭 선택시 css
	function setMenuTab(element, fontWeight, color) {
	    $(element).css({
	        "font-weight": fontWeight,
	        "color": color
	    })	    
	}
	

	
	//작성중
	$("#write_incomplete").click(function() {
		 setMenuTab("#all", "400", "#5c5c5c");
		 setMenuTab("#write_incomplete", "600", "#292929");
		 setMenuTab("#request_approval", "400", "#5c5c5c");
		 setMenuTab("#request_reject", "400", "#5c5c5c");
		 setMenuTab("#request_admit", "400", "#5c5c5c");
		 setMenuTab("#funding_start", "400", "#5c5c5c");
		 setMenuTab("#funding_failed", "400", "#5c5c5c");
		 setMenuTab("#funding_success", "400", "#5c5c5c");
		 setMenuTab("#funding_complete", "400", "#5c5c5c");		 
		 
       $.ajax({
	          type: "GET",
	          url: "/write_incomplete",
	          data: {"memberSeq" : memberSeq },
	          success: function(response) {
			    	$(".result").empty();
			    	if(response.length == 0) {
			    		$(".result").html("<div class='empty_result'> 작성중인 프로젝트가 없습니다. </div>");
			    	} else {
			         for (var i = 0; i < response.length; i++) {
			             $(".result").append(
			            			"<div class='result_con'>" +
		            		 			"<div><img src=\"" + response[i].main_images_url + "\"></div>" +
		            		 			"<div class='result_right'>" +
		            		 				"<div class='process_title'>" +
			            		 				"<div class='pocess_category'>" + response[i].category + "</div>" +
				            		 			"<div class='process_long_title'>" + response[i].long_title + "</div>" +
			            		 			"</div>" +
			            		 			"<div class='process_sub'>" + 
			            		 				"<div class='process_sub_title'>" + response[i].sub_title + "</div>" +
		            		 				"</div>" +
		            		 				"<div> 아직 프로젝트 작성이 완료되지 않았습니다. </div>" +
		            		 				"<div> 모든 항목을 작성 후 심사 요청을 해주세요. </div>" +
	            		 				"</div>" +
	            		 				"<div class='process_btn'>" +
		            		 				"<div><input type=\"button\" data-porject_seq=\"" + response[i].project_seq + "\" value=\"관리\" class='css_btn_in'></div>" + 
		            		 				"<div><input type=\"button\" id=\"delete_btn\" data-project_seq=\"" + response[i].project_seq + "\" value=\"삭제\" class='css_btn_in'></div>" +
	            		 				"</div>" +		            		 			
	            		 			"</div>"			            		 		
			            		 );
			           	  }
			         }
				},
			   error: function(error) {
			       console.log(error);
				}
	     });
	});
	
	
	
	
	//심사중
	$("#request_approval").click(function() {
		 setMenuTab("#all", "400", "#5c5c5c");
		 setMenuTab("#write_incomplete", "400", "#5c5c5c");
		 setMenuTab("#request_approval", "600", "#292929");
		 setMenuTab("#request_reject", "400", "#5c5c5c");
		 setMenuTab("#request_admit", "400", "#5c5c5c");
		 setMenuTab("#funding_start", "400", "#5c5c5c");
		 setMenuTab("#funding_failed", "400", "#5c5c5c");
		 setMenuTab("#funding_success", "400", "#5c5c5c");
		 setMenuTab("#funding_complete", "400", "#5c5c5c");	
				
       $.ajax({
	          type: "GET",
	          url: "/request_approval",
	          data: {"memberSeq" : memberSeq },
	          success: function(response) {
			    	$(".result").empty();
			    	if(response.length == 0) {
			    		$(".result").html("<div class='empty_result'> 심사중인 프로젝트가 없습니다. </div>");
			    	} else {
			         for (var i = 0; i < response.length; i++) {
			        	 
			        	 var approvalDate = new Date(response[i].approval_req_date);
			        	 
			             $(".result").append(
			            		"<div class='result_con'>" +
				            		"<div> <img src=\"" + response[i].main_images_url + "\"></div>" +
			            		 	"<div class='result_right'>" +
			            		 		"<div class='process_title'>" +
			            		 			"<div class='pocess_category'>" + response[i].category + "</div>" +
			            		 			"<div class='process_long_title'>" + response[i].long_title + "</div>" +
		            		 			"</div>" +
		            		 			"<div class='approval_date'> 승인요청일 : " + approvalDate.toLocaleDateString() + "</div>" +
				            		 	"<div class='process_date'>" +
				            		 		"<div class='pocess_schedule'> 프로젝트 예상 일정 </div>" +
				            		 		"<div>" + response[i].start_date +" 시작 ㅣ " + response[i].due_date + " 종료 </div>" +
			            		 		"</div>" +
			            		 		
		            		 		"</div>" +
		            		 		"<div class='process_btn'>" +
		            					"<div><input type=\"button\" id=\"delete_btn\" data-project_seq=\"" + response[i].project_seq + "\" value=\"삭제\" class='css_btn_in'></div>" +
	            					"</div>" +
            					"</div>"		            		 		
			             		);
			             	}
			         }
				},
			   error: function(error) {
			       console.log(error);
				}
	     });
	});
	
	
	
	//반려됨
	$("#request_reject").click(function() {
		 setMenuTab("#all", "400", "#5c5c5c");
		 setMenuTab("#write_incomplete", "400", "#5c5c5c");
		 setMenuTab("#request_approval", "400", "#5c5c5c");
		 setMenuTab("#request_reject", "600", "#292929");
		 setMenuTab("#request_admit", "400", "#5c5c5c");
		 setMenuTab("#funding_start", "400", "#5c5c5c");
		 setMenuTab("#funding_failed", "400", "#5c5c5c");
		 setMenuTab("#funding_success", "400", "#5c5c5c");
		 setMenuTab("#funding_complete", "400", "#5c5c5c");			
		
       $.ajax({
	          type: "GET",
	          url: "/request_reject",
	          data: {"memberSeq" : memberSeq },
	          success: function(response) {
			    	$(".result").empty();
			    	if(response.length == 0) {
			    		$(".result").html("<div class='empty_result'> 반려된 프로젝트가 없습니다. </div>");
			    	} else {
			         for (var i = 0; i < response.length; i++) {
			        	 
			        	 var approvalDate = new Date(response[i].approval_req_date);
			        	 var evaluationDate = new Date(response[i].evaluation_date);
			        	 
			             $(".result").append(
			            		 "<div class='result_con'>" +
			            		 	"<div><img src=\"" + response[i].main_images_url + "\"></div>" +
			            		 	"<div class='result_right'>" +
			            		 		"<div class='process_title'>" +
			            		 			"<div class='pocess_category'>" + response[i].category + "</div>" +
			            		 			"<div class='process_long_title'>" + response[i].long_title + "</div>" +
		            		 			"</div>" +
		            		 			"<div class='approval_date'> 심사완료일 : " 
		            		 				+ evaluationDate.toLocaleDateString() + " (승인요청일 : " + approvalDate.toLocaleDateString() + ") </div>" +			            		 			
		            		 			"<div class='reason'> 반려 사유 </div> " + response[i].approval_reason +
	            		 			"</div>" +
	            		 			"<div class='process_btn'>" +
	            		 				"<div><input type=\"button\" id=\"delete_btn\" data-project_seq=\"" + response[i].project_seq + "\" value=\"삭제\" class='css_btn_in'></div>" +
	            		 			"</div>" +
            		 			"</div>"			            		 			
			            		);
			             	}
			         }
				},
			   error: function(error) {
			       console.log(error);
				}
	     });
	});
	
	
	
	
	//승인됨
	$("#request_admit").click(function() {
		 setMenuTab("#all", "400", "#5c5c5c");
		 setMenuTab("#write_incomplete", "400", "#5c5c5c");
		 setMenuTab("#request_approval", "400", "#5c5c5c");
		 setMenuTab("#request_reject", "400", "#5c5c5c");
		 setMenuTab("#request_admit", "600", "#292929");
		 setMenuTab("#funding_start", "400", "#5c5c5c");
		 setMenuTab("#funding_failed", "400", "#5c5c5c");
		 setMenuTab("#funding_success", "400", "#5c5c5c");
		 setMenuTab("#funding_complete", "400", "#5c5c5c");		
		
       $.ajax({
	          type: "GET",
	          url: "/request_admit",
	          data: {"memberSeq" : memberSeq },
	          success: function(response) {
			    	$(".result").empty();
			    	if(response.length == 0) {
			    		$(".result").html("<div class='empty_result'> 승인된 프로젝트가 없습니다. </div>");
			    	} else {
			         for (var i = 0; i < response.length; i++) {
			        	 
			        	 var approvalDate = new Date(response[i].approval_req_date);
			        	 var evaluationDate = new Date(response[i].evaluation_date);
			        	 
			             $(".result").append(
			            		 "<div class='result_con'>" +
			            		 	"<div><img src=\"" + response[i].main_images_url + "\"></div>" +
			            		 	"<div class='result_right'>" +
			            		 		"<div class='process_title'>" +
			            		 			"<div class='pocess_category'>" + response[i].category + "</div>" +
			            		 			"<div class='process_long_title'>" + response[i].long_title + "</div>" +
		            		 			"</div>" +
		            		 			"<div class='approval_date'> 심사완료일 : " 
		            		 				+ evaluationDate.toLocaleDateString() + " (승인요청일 : " + approvalDate.toLocaleDateString() + ") </div>" +
				            		 	"<div class='process_date'>" +
			            		 			"<div class='pocess_schedule'> 프로젝트 일정 </div>" +
			            		 			"<div>" + response[i].start_date +" 시작 ㅣ " + response[i].due_date + " 종료 </div>" +
		            		 			"</div>" +	
	            		 			"</div>" +            		 			
	            		 			"<div class='process_btn'>" +
	            		 				"<div><input type=\"button\" id=\"delete_btn\" data-project_seq=\"" + response[i].project_seq + "\" value=\"삭제\" class='css_btn_in'></div>" +
	            		 			"</div>" +
         		 				"</div>"	
			            	);
			           	  }
			         }
				},
			   error: function(error) {
			       console.log(error);
				}
	     });
	});
	
	
	
	
	//진행중
	$("#funding_start").click(function() {
		 setMenuTab("#all", "400", "#5c5c5c");
		 setMenuTab("#write_incomplete", "400", "#5c5c5c");
		 setMenuTab("#request_approval", "400", "#5c5c5c");
		 setMenuTab("#request_reject", "400", "#5c5c5c");
		 setMenuTab("#request_admit", "400", "#5c5c5c");
		 setMenuTab("#funding_start", "600", "#292929");
		 setMenuTab("#funding_failed", "400", "#5c5c5c");
		 setMenuTab("#funding_success", "400", "#5c5c5c");
		 setMenuTab("#funding_complete", "400", "#5c5c5c");	
		
       $.ajax({
	          type: "GET",
	          url: "/funding_start",
	          data: {"memberSeq" : memberSeq },
	          success: function(response) {
			    	$(".result").empty();
			    	if(response.length == 0) {
			    		$(".result").html("<div class='empty_result'> 진행중인 프로젝트가 없습니다. </div>");
			    	} else {
			         for (var i = 0; i < response.length; i++) {
			        	 
			        	 var goalPrice = response[i].goal_price;
			        	 var collectionAmount = response[i].collection_amount;
			        	 var achieve = (collectionAmount / goalPrice) * 100;
			        	 
			             $(".result").append(
			            		 "<div class='result_con'>" +
			            		 	"<div><a href='" + response[i].url + "'> <img src=\"" + response[i].main_images_url + "\"></a></div>" +
			            		 	"<div class='result_right'>" +
			            		 		"<div class='process_title'>" +
			            		 			"<div class='pocess_category'>" + response[i].category + "</div>" +
			            		 			"<div class='process_long_title'> <a href='" + response[i].url +"'>" + response[i].long_title + "</a></div>" +
		            		 			"</div>" +
				            		 	"<div class='process_date'>" +
			            		 			"<div class='pocess_schedule'> 프로젝트 일정 </div>" +
			            		 			"<div>" + response[i].start_date +" 시작 ㅣ " + response[i].due_date + " 종료 </div>" +
		            		 			"</div>" +
				            		 	"<div class='process_goal'>" +
		            		 				"<div class='pocess_schedule'> 후원 현황 </div>" +
		            		 				"<div> 목표액 " + goalPrice.toLocaleString() +"원 ㅣ 현재후원액 " + collectionAmount.toLocaleString() + "원</div>" +
	            		 				"</div>" +		            		 			
	            		 			"</div>" +
	            		 			"<div class='process_achieve'>" +
	            		 				"<div class='css_process_achieve'>달성률<span id='final_achieve'>" + achieve.toFixed(0) + "% </span></div>" +
	            		 			"</div>" +
      		 					"</div>"
			            		 );
			           	  }
			         }
				},
			   error: function(error) {
			       console.log(error);
				}
	     });
	});
	
	
	
	//펀딩 실패
	$("#funding_failed").click(function() {
		 setMenuTab("#all", "400", "#5c5c5c");
		 setMenuTab("#write_incomplete", "400", "#5c5c5c");
		 setMenuTab("#request_approval", "400", "#5c5c5c");
		 setMenuTab("#request_reject", "400", "#5c5c5c");
		 setMenuTab("#request_admit", "400", "#5c5c5c");
		 setMenuTab("#funding_start", "400", "#5c5c5c");
		 setMenuTab("#funding_failed", "600", "#292929");
		 setMenuTab("#funding_success", "400", "#5c5c5c");
		 setMenuTab("#funding_complete", "400", "#5c5c5c");			
		
       $.ajax({
	          type: "GET",
	          url: "/funding_failed",
	          data: {"memberSeq" : memberSeq },
	          success: function(response) {
			    	$(".result").empty();
			    	if(response.length == 0) {
			    		$(".result").html("<div class='empty_result'> 펀딩에 실패한 프로젝트가 없습니다. </div>");
			    	} else {
			         for (var i = 0; i < response.length; i++) {
			        	 
			        	 var goalPrice = response[i].goal_price;
			        	 var collectionAmount = response[i].collection_amount;
			        	 var achieve = (collectionAmount / goalPrice) * 100;			        	 
			        	 
			             $(".result").append(
			            		 "<div class='result_con'>" +
			            		 	"<div><a href='" + response[i].url + "'> <img src=\"" + response[i].main_images_url + "\"></a></div>" +
			            		 	"<div class='result_right'>" +
			            		 		"<div class='process_title'>" +
			            		 			"<div class='pocess_category'>" + response[i].category + "</div>" +
			            		 			"<div class='process_long_title'> <a href='" + response[i].url +"'>" + response[i].long_title + "</a></div>" +
		            		 			"</div>" +
		            		 			"<div class='process_date'>" +
		            		 				"<div class='pocess_schedule'> 프로젝트 일정 </div>" +
		            		 				"<div>" + response[i].start_date +" 시작 ㅣ " + response[i].due_date + " 종료 </div>" +
	            		 				"</div>" +
	            		 				"<div class='process_goal'>" +
	            		 					"<div class='pocess_schedule'> 후원 결과 </div>" +
	            		 					"<div> 목표액 " + goalPrice.toLocaleString() +"원 ㅣ 최종후원액 " + collectionAmount.toLocaleString() + "원</div>" +
            		 					"</div>" +
           		 					"</div>" +
           		 					"<div class='process_achieve'>" +
           		 						"<div class='css_process_achieve'>달성률<span id='final_achieve'>" + achieve.toFixed(0) + "% </span></div>" +
           		 					"</div>" +
       		 					"</div>"
			             	);	
			           	  }
			         }
				},
			   error: function(error) {
			       console.log(error);
				}
	     });
	});
	
	
	
	
	//펀딩 성공
	$("#funding_success").click(function() {
		 setMenuTab("#all", "400", "#5c5c5c");
		 setMenuTab("#write_incomplete", "400", "#5c5c5c");
		 setMenuTab("#request_approval", "400", "#5c5c5c");
		 setMenuTab("#request_reject", "400", "#5c5c5c");
		 setMenuTab("#request_admit", "400", "#5c5c5c");
		 setMenuTab("#funding_start", "400", "#5c5c5c");
		 setMenuTab("#funding_failed", "400", "#5c5c5c");
		 setMenuTab("#funding_success", "600", "#292929");
		 setMenuTab("#funding_complete", "400", "#5c5c5c");			
		
       $.ajax({
	          type: "GET",
	          url: "/funding_success",
	          data: {"memberSeq" : memberSeq },
	          success: function(response) {
			    	$(".result").empty();
			    	if(response.length == 0) {
			    		$(".result").html("<div class='empty_result'> 펀딩에 성공한 프로젝트가 없습니다. </div>");
			    	} else {
			         for (var i = 0; i < response.length; i++) {
			     		
			        	var goalPrice = response[i].goal_price;
			    		var collectionAmount = response[i].collection_amount;
			    		var achieve = (collectionAmount / goalPrice) * 100;		        	 
			        	 
			             $(".result").append(
			     				"<div class='result_con'>" +
			    				"<div><a href='" + response[i].url + "'> <img src=\"" + response[i].main_images_url + "\"></a></div>" +
			    				"<div class='result_right'>" +
			    					"<div class='process_title'>" +
			    						"<div class='pocess_category'>" + response[i].category + "</div>" +
			    						"<div class='process_long_title'> <a href='" + response[i].url +"'>" + response[i].long_title + "</a></div>" +
			    					"</div>" +
			    					"<div class='process_date'>" +
			    						"<div class='pocess_schedule'> 프로젝트 일정 </div>" +
			    						"<div>" + response[i].start_date +" 시작 ㅣ " + response[i].due_date + " 종료 </div>" +
			    					"</div>" +
			    					"<div class='process_goal'>" +
			    						"<div class='pocess_schedule'> 후원 결과 </div>" +
			    						"<div> 목표액 " + goalPrice.toLocaleString() +"원 ㅣ 최종후원액 " + collectionAmount.toLocaleString() + "원</div>" +
			    					"</div>" +
			    					"</div>" +
			    					"<div class='process_achieve'>" +
			    						"<div class='css_process_achieve'>달성률<span id='final_achieve'>" + achieve.toFixed(0) + "% </span></div>" +
			    					"</div>" +
			    				"</div>"		            		 
			            	);
			           	  }
			         }
				},
			   error: function(error) {
			       console.log(error);
				}
	     });
	});
	
	
	
	
	//펀딩 종료
	$("#funding_complete").click(function() {
		 setMenuTab("#all", "400", "#5c5c5c");
		 setMenuTab("#write_incomplete", "400", "#5c5c5c");
		 setMenuTab("#request_approval", "400", "#5c5c5c");
		 setMenuTab("#request_reject", "400", "#5c5c5c");
		 setMenuTab("#request_admit", "400", "#5c5c5c");
		 setMenuTab("#funding_start", "400", "#5c5c5c");
		 setMenuTab("#funding_failed", "400", "#5c5c5c");
		 setMenuTab("#funding_success", "400", "#5c5c5c");
		 setMenuTab("#funding_complete", "600", "#292929");		
		
       $.ajax({
	          type: "GET",
	          url: "/funding_complete",
	          data: {"memberSeq" : memberSeq },
	          success: function(response) {
			    	$(".result").empty();
			    	if(response.length == 0) {
			    		$(".result").html("<div class='empty_result'> 종료된 프로젝트가 없습니다. </div>");
			    	} else {
			         for (var i = 0; i < response.length; i++) {			        	 
				     		
				        	var goalPrice = response[i].goal_price;
				    		var collectionAmount = response[i].collection_amount;
				    		var achieve = (collectionAmount / goalPrice) * 100;		        	 
				        	 
				             $(".result").append(
				     				"<div class='result_con'>" +
				    				"<div><a href='" + response[i].url + "'> <img src=\"" + response[i].main_images_url + "\"></a></div>" +
				    				"<div class='result_right'>" +
				    					"<div class='process_title'>" +
				    						"<div class='pocess_category'>" + response[i].category + "</div>" +
				    						"<div class='process_long_title'> <a href='" + response[i].url +"'>" + response[i].long_title + "</a></div>" +
				    					"</div>" +
				    					"<div class='process_date'>" +
				    						"<div class='pocess_schedule'> 프로젝트 일정 </div>" +
				    						"<div>" + response[i].start_date +" 시작 ㅣ " + response[i].due_date + " 종료 </div>" +
				    					"</div>" +
				    					"<div class='process_goal'>" +
				    						"<div class='pocess_schedule'> 후원 결과 </div>" +
				    						"<div> 목표액 " + goalPrice.toLocaleString() +"원 ㅣ 최종후원액 " + collectionAmount.toLocaleString() + "원</div>" +
				    					"</div>" +
				    					"</div>" +
				    					"<div class='process_achieve'>" +
				    						"<div class='css_process_achieve'>달성률<span id='final_achieve'>" + achieve.toFixed(0) + "% </span></div>" +
				    					"</div>" +
				    				"</div>"
			    				);
			           	  }
			         }
				},
			   error: function(error) {
			       console.log(error);
				}
	     });
	});
	
	
	
	
	//삭제 버튼
	$(document).on('click', '#delete_btn', function() {
		var projectSeq = $(this).data("project_seq");
		
		if (confirm("해당 프로젝트를 삭제하시겠습니까?" +
					"이 작업은 되돌릴 수 없습니다.")) {
		       $.ajax({
			        type: "POST",
			        url: "/project_delete",
			        data: {"projectSeq" : projectSeq },
			        success: function(response) {
				    	if(response == "삭제 완료") {
				    		alert("해당 프로젝트가 삭제되었습니다.");
				    		window.location.href ="/myproject"
							}
			        },
					error: function(error) {
					       console.log(error);
						}
			     });
			}
	});
		
		

	
	
	
	
	
	
})




</script>

<body>
<div class="wrap">
	<div class="out_con">
		<div class="mypro_title">내가 만든 프로젝트</div>
		
		
		<div class="menu_con">
	
			<div class="menu_item" id="all" onclick="location='/myproject'" style="color: #292929; font-weight: 600;">전체</div>
			<div class="menu_item" id="write_incomplete">작성중</div>
			<div class="menu_item" id="request_approval">심사중</div>
			<div class="menu_item" id="request_reject">반려됨</div>
			<div class="menu_item" id="request_admit">승인됨</div>
			<div class="menu_item" id="funding_start">진행중</div>
			<div class="menu_item" id="funding_failed">펀딩실패</div>
			<div class="menu_item" id="funding_success">펀딩성공</div>
			<div class="menu_item" id="funding_complete">종료</div>
			
		</div>
	
		<hr class="menu_under_hr">	
	
	
			
		<div class="result">
		    <c:if test="${empty myprojectList}">
		        <div class="empty_result">제작하신 프로젝트가 없습니다.</div>
		    </c:if>
		    <c:forEach var="project" items="${myprojectList}">
		    	<div class="result_con">
			        <div><a href="${project.url}"><img src="${project.main_images_url}"></a></div>
			        <div class="result_right">
			        	<div class="process_status"> ${project.getProject_process_name()} </div>
	
				        <div class="process_title">
			        		<div class="process_ment">메인 제목</div>
			        		<div class="process_long_title"><a href="${project.url}">${project.long_title}</a></div>
				        </div>
				        <div class="process_sub">
			        		<div class="process_sub_title">${project.sub_title}</div>
				        </div>			        
						
						<c:choose>
							<c:when test="${project.project_process eq 0 or project.project_process eq 1 or project.project_process eq 2 or project.project_process eq 3}">
								 <div class="process_date">
									<c:choose>
									    <c:when test="${empty project.start_date}">
										   <div>시작일을 작성해주세요.</div>
									    </c:when>
									    <c:otherwise>
										   <div>${project.start_date} 시작 예정</div>
									    </c:otherwise>
									</c:choose>
									<c:choose>
									    <c:when test="${empty project.due_date}">
										   <div>종료일을 작성해주세요.</div>
									    </c:when>
									    <c:otherwise>
										   <div>${project.due_date} 종료 예정</div>
									    </c:otherwise>
									</c:choose>
								 </div>
							</c:when>
							<c:otherwise>
								<div class="process_date">
									<div>${project.start_date} 시작</div>
									<div>${project.due_date} 종료</div>
								</div>
							</c:otherwise>
					  	</c:choose>										
					</div>
				        <c:choose>
				        	
				            <c:when test="${project.project_process eq 0}">
					        	<div class="process_btn">    
					                <input type="button" class="css_btn" data-porject_seq="${project.project_seq }" value="관리">
					                <input type="button" class="css_btn" id="delete_btn" data-project_seq="${project.project_seq }" value="삭제">
				                </div>
				            </c:when>
				            <c:when test="${project.project_process eq 1 or project.project_process eq 2 or project.project_process eq 3}">
			                	<div class="process_btn">
				                	<input type="button" class="css_btn" id="delete_btn" data-project_seq="${project.project_seq }" value="삭제">
			                	</div>
				            </c:when>
				            			            
			        	</c:choose>
		        	
	        	</div>		        
		    </c:forEach>
		</div>	
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>	
</body>

</html>