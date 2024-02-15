<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 상세 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/project/project_detail.css">
</head>
<body>
<div id="project_detail_container">
	<section class="project-info">
		<div id="project_info_upper_part">
	    	<div id="pro_long_title">${project.long_title}</div>
	    </div>
	    <div id="project_info_lower_part">
		    <div id="main_images_wrap">
		    	<img src="${project.main_images_url}" id="main_image">
		    </div>
		    <div id="other_info_wrap">
		    	<div id="project_info_tap">
				    <div>모인 금액</div>
				    <div class="project_info_tap_result">${project.collection_amount_format}원
				    	<span id="project_info_achaive">${Math.round((project.collection_amount * 100) / project.goal_price)}% 달성</span>
				    </div>
   				    <div>남은 기간</div>
				    <div class="project_info_tap_result">${project.term}일</div>
				    
				    <hr class="project_info_tap_hr">
				    <div class="project_info_tap_detail">
					    <div class="project_info_tap_left">목표 금액</div>
					    <div>${project.goal_price_format}원</div>
				    </div>
				    <div class="project_info_tap_detail">
					    <div class="project_info_tap_left">펀딩 기간</div>
					    <div>${project.start_date} ~ ${project.due_date}</div>
				    </div>
				    <div class="project_info_tap_detail">
					    <div class="project_info_tap_left">결제</div>
					    <div>목표 달성시 ${project.due_date.plusDays(1)}에 결제 진행</div>
				    </div>		
					<div>
						<button class="project_dibs_btn" id="dibs_btn" data-project_seq="${project.project_seq }">
							관심 프로젝트 추가
						</button>
					</div>				    		    
				</div>
			
				<div id="collector_info_tap">
					<img src="${project.memberDTO.profile_img }" id="collector_img" >
					<div class="collector_info_right">
						<div class="collector_info_title">창작자
							<span class="collector_info_nick">${project.memberDTO.nickname }</span>
						</div>
						<div class="collector_info_desc">${project.memberDTO.description }</div>						
					</div>
				</div>
				<div class="collector_ask_follow_btn">		
					<input class="collector_btn" type="button" value="판매자 문의" id="ask_btn">			
					<input class="collector_btn" type="button" value="팔로우" id="follow_btn" data-member_seq="${project.memberDTO.member_seq }">			
				</div>
			</div>
			
	    </div>
	</section>
	
	<div class="project_menu_tab">
		<a href="#" id="projectLink" data-project-id="${project.project_seq}">프로젝트 계획</a>
		<a href="#" id="updateLink" data-project-id="${project.project_seq}">업데이트</a>
		<a href="#" id="communityLink" data-project-id="${project.project_seq}">커뮤니티</a>
	</div>
	
	
	
	<div id="content_container">
		${project.content}
	</div>
	<section class="bundle-info">
		<h3>선택 목록</h3>
		<div id="cart">
			<div id="selected_bundle_list">
				<h4>선물</h4>
			</div>
			<div id="cart_result_wrap">
				<h4>추가 후원금(선택)</h4>
				<input type="number" id="extra_price" min="0">원
				<div id="total_price_wrap"></div>
				<div id="support_btn_wrap">
					<input type="button" value="후원하기" id="funding_btn">
				</div>
			</div>
		</div>
		<div id="bundle_list">
			<h3>선물 꾸러미 목록</h3>
			<c:forEach var="bundle" items="${bundleList }" varStatus="status">
				<div class="bundle_box" data-seq="${bundle.bundle_seq}">
					<div class="bundle_name_wrap" data-name='${bundle.bundle_name}'>
						${bundle.bundle_name}
					</div>
					<div class="bundle_price_wrap" data-price='${bundle.bundle_price }'>
						${bundle.bundle_price_format}원
					</div>
					<ul class="item_list">
					<c:forEach var="itemList" items="${bundle.itemListDTOList }" varStatus="status">
						<li class="item">
							<div class="item_name_wrap" data-name='${itemList.itemDTO.item_name}'>
								${itemList.itemDTO.item_name } <span class="item_count_wrap" data-count="${itemList.item_count }">(x${itemList.item_count })</span>
							</div>
							<c:forEach var="option" items="${itemList.itemDTO.optionDTOList }" varStatus="status">
								<c:if test="${fn:length(itemList.itemDTO.optionDTOList) != 1 && status.index == 0}">
									<select class="item_option_select">
								</c:if>
								<c:if test="${fn:length(itemList.itemDTO.optionDTOList) == 1 && status.index == 0}">
									<select class="item_option_select_only_option">
								</c:if>
								<c:choose>
								<c:when test="${status.index == 0 }">
									<option value="${option.item_option_seq }" selected="selected">
										${option.item_option_name }
									</option>
								</c:when>
								<c:otherwise>
									<option value="${option.item_option_seq }">
										${option.item_option_name }
									</option>
								</c:otherwise>
								</c:choose>
								<c:if test="${fn:length(itemList.itemDTO.optionDTOList) != 0 && status.count == fn:length(itemList.itemDTO.optionDTOList)}">
									</select>
								</c:if>
							</c:forEach>
						</li>
					</c:forEach>
					</ul>
					<div class="add_cart_btn_wrap">
						<input class='add_cart_btn' type='button' value='장바구니 추가'>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>
<!-- 번들 형식 모음 -->
	<div class='selected_bundle_box_form'>
		<div class='selected_bundle_name_wrap' >
		</div>
		<div class="delete_btn_wrap">
			<input type="button" value="x" class="delete_btn">
		</div>
		<ul class='selected_bundle_item_list'>
		</ul>
		<div class='selected_bundle_box_lower_wrap'>
			<div class='count_btn_wrap'>
				<input type='button' value='-' class="minus_btn">
				<input type='number' min="1" class="count">
				<input type='button' value='+' class="plus_btn">
			</div>
			<div class='selected_bundle_price_wrap'>
			</div>
		</div>
	</div>
	<ul>
		<li class='selected_item_form'>
			<div class='selected_item_name_wrap'>
			</div>
			<div class='selected_item_option_wrap'>
			</div>
		</li>
	</ul>
</div>
<script>
$(document).ready(function () {
	//==========================후원하기 버튼 이벤트============================
	
	$("#funding_btn").on("click", function(){
		if("${login_user_seq}" != ""){
			if(selectBundleInfo.length <= 1 && $("#extra_price").val() == 0){
				alert("장바구니가 비어있습니다");
			}else if("${project.project_process_name}" != "진행중"){
				alert("후원이 불가합니다");
			}else{
				$.ajax({
					url: "/fundingcheck",
					type: "post",
					data: {
						login_user_seq: "${login_user_seq}",
						project_seq: "${project.project_seq}"
					},
					success: function(result){
						if(result > 0){
							alert("이미 후원하셨습니다");
						}else{
							fillSelectBundleInfo();
							$.ajax({
						        url: "/payment",
						        type: "POST",
						        data: JSON.stringify(selectBundleInfo),
								dataType:"json",
								contentType: "application/json; charset=UTF-8",
						        success: function (data) {
						           location.href = "/payment";
						        },
						        error: function (xhr, status, error) {
						            console.error("Error loading content:", error);
						        }
						    });
						}
					}
				})
				
			}
			console.log(selectBundleInfo);
		}else{
			if(confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")){
				var fromPath = window.location.pathname.substring(1) == "" ?
						"mainpage" : location.pathname.substring(1) + location.search;
				location.href = "/login?from=" + fromPath;
			}
		}
	});
		
	//==========================번들 이벤트================================
	//장바구니에 추가
	$(".add_cart_btn").click(function(e){
		let clickedBox = $(e.target.parentNode.parentNode);
		let selectedBundleBox = $("#selected_bundle_list .selected_bundle_box");
		let sameBox = findSameBox(selectedBundleBox, clickedBox);
		//같은 번들 번호, 같은 옵션 선택이면 + 1 아니면 번들 추가
		if(sameBox != ""){
			let count = sameBox.children(".selected_bundle_box_lower_wrap").children(".count_btn_wrap").children(".count");
			count.val(Number(count.val()) + 1);
			
		}else{
			let chosenBox = createChosenBox(clickedBox);
			$("#selected_bundle_list").append(chosenBox);
			addPMBtnClickEvent(chosenBox);
			addDelBtnClickEvent(chosenBox);
		}
		updateTotalPrice(getTotalPrice());
		fillSelectBundleInfo();
		
	});
	var selectBundleInfo = [];
	function fillSelectBundleInfo(){
		selectBundleInfo = [];
		$("#selected_bundle_list .selected_bundle_box").each(function(i, dom){
			dom = $(dom);
			let bundle = {};
			bundle.name = dom.find(".selected_bundle_name_wrap").text().trim();
			bundle.price = dom.find(".selected_bundle_price_wrap").data("price");
			bundle.seq = dom.data("seq");
			bundle.count = dom.children(".selected_bundle_box_lower_wrap").children(".count_btn_wrap")
						.children(".count").val();
			bundle.item = [];
			dom.find(".selected_item").each(function(j, dom2){
				let item = {};
				dom2 = $(dom2);
				item.name = dom2.find(".selected_item_name_wrap").data("name").trim();
				item.count = dom2.find(".selected_item_name_wrap").data("count");
				item.optionName = dom2.find(".selected_item_option_wrap").data("name").trim();
				item.optionSeq = dom2.find(".selected_item_option_wrap").data("seq");
				bundle.item.push(item);
			});
			selectBundleInfo.push(bundle);
		});
		let extraPrice = {};
		extraPrice.name = "추가 후원금";
		extraPrice.price = $("#extra_price").val() == "" ? 0 : $("#extra_price").val();
		selectBundleInfo.push(extraPrice);
		
		let project = {};
		project.longTitle = "${project.long_title}";
		project.projectSeq = "${project.project_seq}";
		project.url = "${project.url}";
		project.mainImage = "${project.main_images_url}";
		project.collector = "${project.memberDTO.nickname}";
		project.profile = "${project.memberDTO.profile_img}";
		project.dueDate = "${project.due_date}";
		selectBundleInfo.push(project);
		
	}
	
	function findSameBox(selectedBundleBox, clickedBox){
		let sameBox = "";
		let clickedItem = clickedBox.children(".item_list").children(".item");
		let clickedBoxSeq = clickedBox.data("seq");
		selectedBundleBox.each(function(i, item){ 
			if($(item).data("seq") == clickedBoxSeq){
				let selectedItem = $(item).children(".selected_bundle_item_list").children(".selected_item");
				let count = 0;
				selectedItem.each(function(j, item2){
					clickedItem.each(function(k, item3){
						if($(item2).children(".selected_item_option_wrap").data("seq") 
								== $(item3).children(".item_option_select").val()){
							count++;
							return false;
						}
					});
				});
				if(count == selectedItem.length){
					sameBox = $(item);
				}
			}
		});
		return sameBox;
	}
	
	//추가 후원 값 변경 시 총 금액 변경
	$("#extra_price").on("change", function(){
		updateTotalPrice(getTotalPrice());
	});
	
	//번들 박스 클릭 시 select 태그와 추가 버튼 숨김/보이기 처리
	var clickedBundleBoxSeq = 0;
	$(".bundle_box").on("click", function(e){
		let bundleBox = $(e.currentTarget);
		let clickTag = e.target.tagName;
		if(clickTag != "SELECT"){
			if(clickedBundleBoxSeq == bundleBox.data("seq")){
				hideParts(bundleBox);
				clickedBundleBoxSeq = 0;
			}else{
				hideParts($(".bundle_box_chosen"));
				showHiddenParts(bundleBox);
				clickedBundleBoxSeq = bundleBox.data("seq");
			}
		}
		
	});
	
	function showHiddenParts(bundleBox){
		bundleBox.attr("class", "bundle_box_chosen");
		bundleBox.find(".item_option_select").css("display", "inline-block");
		bundleBox.find(".add_cart_btn_wrap").css("display", "block");
	}
	
	function hideParts(bundleBox){
		bundleBox.attr("class", "bundle_box");
		bundleBox.find(".item_option_select").css("display", "none");
		bundleBox.find(".add_cart_btn_wrap").css("display", "none");
	}
	
	function addDelBtnClickEvent(chosenBox){
		let deleteBtn = chosenBox.children(".delete_btn_wrap").children(".delete_btn");
		deleteBtn.on("click", function(e){
			console.log("이벤트 확인");
			$(e.target.parentNode.parentNode).remove();
			updateTotalPrice(getTotalPrice());
			fillSelectBundleInfo();
		})
	}
	
	function addPMBtnClickEvent(chosenBox){
		let btnWrap = chosenBox.children(".selected_bundle_box_lower_wrap").children(".count_btn_wrap");
		let minusBtn = btnWrap.children(".minus_btn");
		let plusBtn = btnWrap.children(".plus_btn");
		minusBtn.click(function(e){
			let count = $(e.target.parentNode).children(".count");
			if(count.val() > 1){
				count.val(Number(count.val()) - 1);
				updateTotalPrice(getTotalPrice());
			}
		});
		plusBtn.click(function(e){
			let count = $(e.target.parentNode).children(".count");
			count.val(Number(count.val()) + 1);
			updateTotalPrice(getTotalPrice());
		});
	}
	
	function updateTotalPrice(totalPrice){
		let totalPriceFormat = totalPrice.toLocaleString()+ "원";
		$("#total_price_wrap").data("total_price", totalPrice).text(totalPriceFormat);
	}
	
	function getTotalPrice(){
		let selectedBundleBox = $("#selected_bundle_list .selected_bundle_box");
		let totalPrice = 0;
		let extraPrice = Number($("#extra_price").val());
		selectedBundleBox.each(function(i, item){
			let count = $(item).children(".selected_bundle_box_lower_wrap")
							.children(".count_btn_wrap").children(".count").val();
			console.log(count);
			let bundlePrice = $(item).children(".selected_bundle_box_lower_wrap").children(".selected_bundle_price_wrap").data("price");
			totalPrice += (count * bundlePrice);
		})
		totalPrice += extraPrice;
		return totalPrice;
	}
	
	function createChosenBox(bundleBox){

		let bundleSeq = bundleBox.data("seq");
		let bundleName = bundleBox.children(".bundle_name_wrap").data("name");
		let bundlePrice = bundleBox.children(".bundle_price_wrap").data("price");
		let bundlePriceFormat = bundleBox.children(".bundle_price_wrap").text().trim();
		let bundleItemList = bundleBox.children(".item_list");
		let bundleItemArr = bundleItemList.children(".item");
		
		let chosenBoxForm = $(".selected_bundle_box_form").clone();
		chosenBoxForm.attr("class","selected_bundle_box");
		chosenBoxForm.data("seq", bundleSeq);
		chosenBoxForm.children(".selected_bundle_name_wrap").text(bundleName);
		chosenBoxForm.children(".selected_bundle_box_lower_wrap")
					 .children(".selected_bundle_price_wrap").text(bundlePriceFormat).data("price", bundlePrice);
		chosenBoxForm.find(".count").val(1);
		bundleItemArr.each(function(i, item){
			let bundleItemName = $(item).children(".item_name_wrap").data("name");
			let itemOptionSeq = $(item).children("select[class^='item_option_select']").val();
			let itemOptionName = $(item).children("select[class^='item_option_select']").find(":selected").text() == "" ?
									"" : "옵션: " + $(item).children("select[class^='item_option_select']").find(":selected").text();
			let itemOptionRealName = $(item).children(".item_option_select").find(":selected").text();
			let itemCount = $(item).find(".item_count_wrap").data("count");
			
			let selectedItemForm = $(".selected_item_form").clone();
			selectedItemForm.attr("class", "selected_item");
			selectedItemForm.children(".selected_item_name_wrap").text(bundleItemName + "(x" + itemCount +")");
			selectedItemForm.children(".selected_item_name_wrap").data("count", itemCount);
			selectedItemForm.children(".selected_item_name_wrap").data("name", bundleItemName)
			selectedItemForm.children(".selected_item_option_wrap").text(itemOptionName);
			selectedItemForm.children(".selected_item_option_wrap").data("seq",itemOptionSeq);
			selectedItemForm.children(".selected_item_option_wrap").data("name",itemOptionRealName);
			
			chosenBoxForm.children(".selected_bundle_item_list").append(selectedItemForm);
		});
		
		return chosenBoxForm;
	}
//==================== 조회수 업데이트=======================
	$.ajax({
        url: "/viewcountupdate",
        type: "POST",
        data:{
        	project_seq: "${project.project_seq}"
        }
	});
//==================== 프로젝트 계획, 업데이트, 커뮤니티 클릭 이벤트 ============================
	$("#communityLink").click(function (e) {
	    e.preventDefault();
	    var pid = $(this).data("project-id");
	    var baseUrl = window.location.origin;
	    loadContent(baseUrl + "/project_detail/community/"+pid);
	});
	
	
	$("#updateLink").click(function (e) {
	    e.preventDefault();
	    var pid = $(this).data("project-id");
	    var baseUrl = window.location.origin;
	    loadContent(baseUrl + "/update/view/"+pid); 
	});
	
	$("#projectLink").click(function(e){
		e.preventDefault();
		$("#content_container").html("<div class='content_container_inner_title'> 프로젝트 소개 </div>" +'${project.purpose}');
		
		$("#content_container").append("<div class='content_container_inner_title'> 프로젝트 일정 </div>" + '${project.planning}');
		$("#content_container").append("<div class='content_container_inner_title'> 프로젝트 예산 </div>" + '${project.budget}');
		$("#content_container").append("<div class='content_container_inner_title'> 프로젝트 팀 소개 </div>" + '${project.team_introduce}');
		$("#content_container").append("<div class='content_container_inner_title'> 선물 설명 </div>" +'${project.item_introduce}');
	});
	
	function loadContent(url) {
	    $.ajax({
	        url: url,
	        type: "GET",
	        success: function (data) {
	            $("#content_container").html(data);
	        },
	        error: function (xhr, status, error) {
	            console.error("Error loading content:", error);
	        }
	    });
	}
//==========================1:1 대화=================================
	$("#ask_btn").on("click",function(){
		if("${login_user_seq}" != ""){
			if("${login_user_seq}" != "${project.memberDTO.member_seq}"){
				let url = "/ask?";
				let project_seq = "${project.project_seq}";//나중엔 프로젝트 상세페이지 들어오면 자동으로 넣어지게
				let collector_seq = "${project.memberDTO.member_seq}";//마찬가지
				let asker_seq = "${login_user_seq}";
				url += ("project_seq=" + project_seq);
				url += ("&collector_seq=" + collector_seq);
				url += ("&asker_seq=" + asker_seq);
				window.open(url, "_blank","width= 500, height= 600");
			}else{
				location.href = "/allask";
			}
			
		}else{
			if(confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")){
				var fromPath = window.location.pathname.substring(1) == "" ?
						"mainpage" : location.pathname.substring(1) + location.search;
				location.href = "/login?from=" + fromPath;
			}
		}
	});
	
	
	
//======================== 찜 =====================================
    var projectSeq = $("#dibs_btn").data("project_seq");
    var userSeq = "${login_user_seq}";
    if ("${login_user_seq}" == "") {
    	userSeq = 0;
    }
    
    $.ajax({
        data : {
            "project_seq": projectSeq,
            "member_seq": userSeq
        },
        type : "GET",
        url : "/checkprojectdibs",
        success : function(r){
            console.log(r);
            if(r >= 1){
                $("#dibs_btn").html("관심 프로젝트 취소");
            }
        }
    }); 
	
	
	$("#dibs_btn").on("click",function(){
		
		var projectSeq = $(this).data("project_seq");
		
		if("${login_user_seq}" == ""){
			if(confirm("로그인 후에 이용하실 수 있는 서비스입니다. 로그인 하시겠습니까?")){
				location.href = "/login?from=" + location.search;
			}
		}else{			
			$.ajax({
				data : {
					"project_seq": projectSeq,
					"member_seq": '${login_user_seq}'
						},
				type : "POST",
				url : "/addprojectdibs",
				dataType: 'json',
				success : function(r){
					if(r.result == "성공"){
						alert("관심 프로젝트 목록에 추가되었습니다.");
						$("#dibs_btn").html("관심 프로젝트 취소");
					}else if(r.result == "취소"){
						alert("관심 프로젝트 목록에서 삭제되었습니다.")
						$("#dibs_btn").html("관심 프로젝트 추가");						
					}else{
						alert("알 수 없는 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
					}
				}
			});
		}		
	})

	
	
//========================== 팔로우 ======================================
	$("#follow_btn").click(function() {		
	    var memberSeq = $(this).data("member_seq"); //프로젝트의 멤버seq
	    
		if("${login_user_seq}" == ""){
			if(confirm("로그인 후에 이용하실 수 있는 서비스입니다. 로그인 하시겠습니까?")){
				location.href = "/login?from=" + location.search;
			}
		}else {
			
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
			
		}
	    
	    

	})



	
	
	
	
	
	
	
	
	
	
	
	
	

});
</script>
</body>
</html>