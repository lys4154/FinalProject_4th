<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/css/member/ongoing_detail.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>

<script>

var bundleData;

$(document).ready(function() {	
	
	//넘길 꾸러미 정보 
	bundleData = [
	   <c:forEach var="bundleEntry" items="${bundleItem}" varStatus="status">
	     {
	       name: "${bundleEntry.key}",
	       count: ${bundleCount[bundleEntry.key]},
	       items: [
	         <c:forEach var="itemEntry" items="${bundleEntry.value}" varStatus="innerStatus">
	           {
	             itemName: "${itemEntry}",
	             options: [
	               <c:forEach var="optionEntry" items="${itemOption[itemEntry]}" varStatus="optionStatus">
	                 "${optionEntry}"<c:if test="${!optionStatus.last}">, </c:if>
	               </c:forEach>
	             ]
	           }<c:if test="${!innerStatus.last}">, </c:if>
	         </c:forEach>
	       ]
	     }<c:if test="${!status.last}">, </c:if>
	   </c:forEach>
	 ];	
	
	document.getElementById("bundleDataInput").value = JSON.stringify(bundleData);
	
	
	//모달띄우기
	$("#fund_cancel").click(function() {
		 $(".modal").css("display", "block");
	});
	
	$("#fund_keep").click(function() {
		$(".modal").css("display", "none");
	});
	
	

    $("#cancel").click(function() {
        let fundSeq = ${dto.fund_seq};
        let longTitle = "${dto.pDTO.long_title}";
        let dueDate = "${dto.pDTO.due_date}";
        let price = ${dto.price };
        let creator = "${dto.collectorDTO.nickname }";

        // 폼에 값을 설정
        $("#priceInput").val(price);
        $("#fundSeqInput").val(fundSeq);
        $("#longTitleInput").val(longTitle);
        $("#dueDateInput").val(dueDate);
        $("#creatorInput").val(creator);
        $("#bundleDataInput").val(JSON.stringify(bundleData));

        // 폼을 제출
        $("#cancelForm").submit();
    });	

	//달성률
    let amount = ${dto.pDTO.collection_amount * 100};
    let goal = ${dto.pDTO.goal_price};
    let achieve = Math.floor(amount/goal);
    $(".achieve").html(achieve + "%");


    //운송장번호
    if ("${dto.track_num}" == "") {
    	$("#track_num").html("등록된 운송장 정보가 없습니다.");
    }
    
    
})

</script>



<body>
<div class="wrap">
	<div class="out_con">
		<div class="content">	
			<div class="top">
				<div ><a href="${dto.pDTO.url }"><img alt="프로젝트 이미지" src="${dto.pDTO.main_images_url }"></a></div>
				<div class="top_right">
					<div class="category_creator"> <span>${dto.pDTO.category}</span>  ㅣ <span>${dto.collectorDTO.nickname }</span></div>
					<div class="long_title"><a href="${dto.pDTO.url }">${dto.pDTO.long_title }</a></div>				
					<div class="pro_info"> 
						<span class="amount"> <fmt:formatNumber value="${dto.pDTO.collection_amount }" type="currency" currencySymbol="" />원 </span>
						<span class="achieve"></span>
		        	
			        	<span id="d_day">${dto.pDTO.term }일 남음</span>
			        </div>				
				</div>
			</div>
		
			<div class="contents_con">
				<div class="contents_title">후원 정보</div>
				<div class="info_flex">
					<div class="info_flex_left">펀딩 상태 </div>
					<div class="info_flex_right" id="pro_status">펀딩 진행중</div>
				</div>
				<div class="info_flex">
					<div class="info_flex_left">후원 번호 </div>
					<div class="info_flex_right">${dto.fund_seq }</div>
				</div>
				<div class="info_flex">
					<div class="info_flex_left">후원 날짜 </div>
					<div class="info_flex_right">${dto.fund_date.toLocalDate() }</div>
				</div>
				<div class="info_flex">
					<div class="info_flex_left">펀딩 마감일 </div>
					<div class="info_flex_right">${dto.pDTO.due_date}</div>
				</div>
			</div>
		
			<div class="contents_con" >
				<div>
					<div class="contents_title">선물 정보</div>
				</div>		
				<div class="info_flex">	 
					<div class="info_flex_left">선물 구성 </div>
					<div class="info_flex_right">
						<div class="bundle">
						
					    <c:forEach var="count" items="${dto.bCountDTOList}">
					    	<c:forEach var="bundle" items="${count.bundleDTOList}">
							    <div class="info_inner">
							        <div>* ${bundle.bundle_name} <span> ( x${count.perchase_count})</span></div>
							        <c:forEach var="item" items="${bundle.itemDTOList}">
							            <div class="item_option">
					                        <span>${item.item_name} </span>
					                        <c:set var="optionsString" value="" />
					                        <c:forEach var="option" items="${item.optionDTOList }">
					                            <c:if test="${not empty option}">
					                                <c:set var="optionsString" value="${optionsString}${option.item_option_name}, " />
					                            </c:if>
					                        </c:forEach>
					                        <c:if test="${not empty optionsString}">
					                            <span>(옵션 - ${optionsString.substring(0, optionsString.length() - 2)})</span>
					                        </c:if>
						           		</div>            
							        </c:forEach>
						        </div>
					        </c:forEach>				        
					    </c:forEach>
					    
					    </div>				    
					</div>
				</div>
			</div>
		
		
			<div class="contents_con" >
				<div class="contents_title">결제 정보</div>
				<div class="info_flex"> 
					<div class="info_flex_left">결제 수단 </div>
					<div class="info_flex_right"> ${dto.pay_option }</div>
				</div>
				<div class="info_flex">
					<div class="info_flex_left">결제 금액 </div>
					<div class="info_flex_right">
						<fmt:formatNumber value="${dto.price }" type="currency" currencySymbol="" />원
					</div>				
				</div>
				<div class="info_flex">
					<div class="info_flex_left">결제 상태 </div>
					<div class="info_flex_right"> ${dto.pDTO.due_date.plusDays(1)} 결제 예정</div>
				</div>
			</div>
		
		
			<div class="contents_con" >
				<div class="contents_title">배송 정보</div>
				<div class="info_flex">
					<div class="info_flex_left">받는 사람 </div>
					<div class="info_flex_right"> ${dto.name}</div>
				</div>
				<div class="info_flex">
					<div class="info_flex_left">연락처 </div>
					<div class="info_flex_right"> ${dto.phone}</div><br>
				</div>
				<div class="info_flex">
					<div class="info_flex_left">주소 </div>
					<div class="info_flex_right">(${dto.postcode })</div>
					<div class="info_flex_right"> ${dto.road_address } ${dto.extra_address } ${dto.detail_address }</div>
				</div>
				<div class="info_flex">
					<div class="info_flex_left">배송 예정일 </div>
					<div class="info_flex_right">${dto.pDTO.delivery_date.toLocalDate()}</div>
				</div>
				<div class="info_flex">
					<div class="info_flex_left">운송장 번호 </div>
					<div class="info_flex_right" id="track_num">${dto.track_num }</div>
				</div>			
			</div>		
		</div>
		
	<c:forEach var="count" items="${dto.bCountDTOList}">
		번들구매개수:${count.perchase_count }<br>
		<c:forEach var="bundle" items="${count.bundleDTOList}">
			번들이름: ${bundle.bundle_name }<br>
			번들가격: ${bundle.bundle_price}<br>
			<c:forEach var="item" items="${bundle.itemDTOList }">
				아이템 명: ${item.item_name}<br>
				<c:forEach var="option" items="${item.optionDTOList }">
					옵션 명:${option.item_option_name }<br>
				</c:forEach>
			</c:forEach>
		</c:forEach>
		<br>
	</c:forEach>	
		
		
		<div class="button_con">
			<input type="button" onclick="location='../funded'" value="후원 목록 보기" id="fund_list">
			<input type="button" id="fund_cancel" value="후원을 취소하시겠어요?">
		</div>	
		
		<!-- Modal -->
		<div class="modal" style="display: none;">
			<div class="modal_contents">
				<div class="modal_header">
					<div>선착순 마감된 선물은 <strong>취소 후 다시 후원할 수 없습니다.</strong></div>
					<div>신중하게 고민하고 취소를 결정해주세요.</div>
					<div>후원자님의 따뜻한 응원과 격려가 누군가에겐 큰 기회가 됩니다.</div>				
				</div>
				<hr>
				<div class="modal_footer">		
					<button type="button" id="fund_keep">후원 유지</button>
			        <form id="cancelForm" action="/funded_cancel" method="post">
					    <input type="hidden" id="fundSeqInput" name="fundSeqInput" value="">
					    <input type="hidden" id="longTitleInput" name="longTitleInput" value="">		        
				        <input type="hidden" id="bundleDataInput" name="bundleDataInput" value="">
				        <input type="hidden" id="dueDateInput" name="dueDateInput" value="">
				        <input type="hidden" id="priceInput" name="priceInput" value="">
				        <input type="hidden" id="creatorInput" name="creatorInput" value="">
						<button type="button" id="cancel">그래도 취소</button>
					</form>
				</div>		
			</div>
			<div class="modal_layer"></div>
		</div> 
		    
	
	
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>


</body>
</html>