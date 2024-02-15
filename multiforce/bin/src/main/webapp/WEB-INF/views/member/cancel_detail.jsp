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
<link rel="stylesheet" href="/css/member/cancel_detail.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>

<script>

$(document).ready(function() {	
	if ("${dDay}" < 0) {
	    $("#pro_status").html("펀딩 종료")
	    $("#d_day").html("펀딩 종료")
	}

	if ("${trackNum}" == 0) {
	    $("#track_num").html("등록된 운송장이 없습니다.")
	}

	
});

</script>




<body>

<div class="out_con">
	<div class="content">	
		<div class="top">
			<div ><a href="${dto.pDTO.url }"><img alt="프로젝트 이미지" src="${dto.pDTO.main_images_url }"></a></div>
			<div class="top_right">
				<div class="category_creator"> ${dto.pDTO.category_kor} ㅣ ${dto.collectorDTO.nickname }</div>
				<div class="long_title"><a href="${dto.pDTO.url }">${dto.pDTO.long_title }</a></div>
				<div class="pro_info">
					<span class="amount"> <fmt:formatNumber value="${dto.pDTO.collection_amount }" type="currency" currencySymbol="" />원 </span>
						<script>
						    let amount = ${dto.pDTO.collection_amount * 100};
						    let goal = ${dto.pDTO.goal_price};
						    let achieve = Math.floor(amount/goal);
						    document.write('<span class="achieve">' + achieve + '%</span>');
						</script>				
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
				    			<c:forEach var="item" items="${bundle.itemListDTOList}">	
				    				<div class="item_option">
				    					<span>${item.itemDTO.item_name} </span>
				    						<c:forEach var="option" items="${item.itemDTO.optionDTOList }">
				    							<span>(${option.item_option_name })</span>
			    							</c:forEach>
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
				<div class="info_flex_right"> ${dto.del_date.toLocalDate()} 결제 예약 취소</div>
			</div>
		</div>
	</div>
	

	<div class="button_con">
		<input type="button" onclick="location='../funded'" value="후원 목록 보기" id="fund_list">
	</div>	

</div>

</body>
</html>