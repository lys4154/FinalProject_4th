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
<link rel="stylesheet" href="/css/member/success_detail.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>

<script>

$(document).ready(function() {	

	if ("${trackNum}" == 0) {
	    $("#track_num").html("등록된 운송장이 없습니다.")
	}

	if ("${dDay}" < 0) {
	    $("#d_day").html("펀딩 성공")
	}
	
})

</script>




<body>
<div class="out_con">
	<div class="content">	
		<div class="top">
			<div ><a href="${projectDetail.url }"><img alt="프로젝트 이미지" src="${projectDetail.main_images_url }"></a></div>
			<div class="top_right">
				<div class="category_creator">${projectDetail.category} ㅣ ${creator }</div>
				<div class="long_title"><a href="${projectDetail.url }">${projectDetail.long_title }</a></div>
				<div class="pro_info">
					<span class="amount"> <fmt:formatNumber value="${projectDetail.collection_amount }" type="currency" currencySymbol="" />원 </span>
						<script>
						    let amount = ${projectDetail.collection_amount * 100};
						    let goal = ${projectDetail.goal_price};
						    let achieve = Math.floor(amount/goal);
						    document.write('<span class="achieve">' + achieve + '%</span>');
						</script>		        	
		        	<span id="d_day">${dDay }일 남음</span>
		        </div>
			</div>
		</div>
	
		<div class="contents_con">
			<div class="contents_title">후원 정보</div>
			<div class="info_flex">
				<div class="info_flex_left">펀딩 상태 </div>
				<div class="info_flex_right" id="pro_status">펀딩 성공</div>
			</div>
			<div class="info_flex">
				<div class="info_flex_left">후원 번호 </div>
				<div class="info_flex_right">${fundedDetail.fund_seq }</div>
			</div>
			<div class="info_flex">
				<div class="info_flex_left">후원 날짜 </div>
				<div class="info_flex_right">${fundedDetail.fund_date.toLocalDate() }</div>
			</div>
			<div class="info_flex">
				<div class="info_flex_left">펀딩 마감일 </div>
				<div class="info_flex_right">${projectDetail.due_date}</div>
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
				    <c:forEach var="bundleEntry" items="${bundleItem}">
				        <div>* ${bundleEntry.key} <span>${bundleCount[bundleEntry.key]}개</span></div>
				        <c:forEach var="itemEntry" items="${bundleEntry.value}">
				            <div class="item_option">
				            	<span>${itemEntry} </span>
				           		<c:forEach var="optionEntry" items="${itemOption[itemEntry]}">
				                <span> (옵션 - ${optionEntry})</span>				            
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
				<div class="info_flex_right"> ${fundedDetail.pay_option }</div>
			</div>
			<div class="info_flex">
				<div class="info_flex_left">결제 금액 </div>
				<div class="info_flex_right">
					<fmt:formatNumber value="${fundedDetail.price }" type="currency" currencySymbol="" />원
				</div>				
			</div>
			<div class="info_flex">
				<div class="info_flex_left">결제 상태 </div>
				<div class="info_flex_right"> ${fundedDetail.fund_duedate.toLocalDate().plusDays(1)} 결제 완료</div>
			</div>
		</div>
	
	
		<div class="contents_con" >
			<div class="contents_title">배송 정보</div>
			<div class="info_flex">
				<div class="info_flex_left">받는 사람 </div>
				<div class="info_flex_right"> ${fundedDetail.name}</div>
			</div>
			<div class="info_flex">
				<div class="info_flex_left">연락처 </div>
				<div class="info_flex_right"> ${fundedDetail.phone }</div><br>
			</div>
			<div class="info_flex">
				<div class="info_flex_left">주소 </div>
				<div class="info_flex_right">(${fundedDetail.postcode })</div>
				<div class="info_flex_right"> ${fundedDetail.road_address } ${fundedDetail.extra_address } ${fundedDetail.detail_address }</div>
			</div>
			<div class="info_flex">
				<div class="info_flex_left">배송 완료일 </div>
				<div class="info_flex_right">${projectDetail.delivery_date.toLocalDate().plusDays(5)}</div>
			</div>
			<div class="info_flex">
				<div class="info_flex_left">운송장 번호 </div>
				<div class="info_flex_right" id="track_num"> ${trackNum }</div>
			</div>			
		</div>
				
	</div>
			
	<div class="button_con">
		<input type="button" onclick="location='../funded'" value="후원 목록 보기" id="fund_list">
	</div>
			
</div>
</body>
</html>