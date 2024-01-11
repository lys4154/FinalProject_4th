<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<script>
$(document).ready(function() {	

	${fundedDetail.track_num}
	if (${dDay} < 0) {
		$("#pro_status").html("펀딩 종료")
		$("#d_day").html("펀딩 종료")
	}
	
	if (${fundedDetail.track_num }.equals() == null) {
		#("track_num").html("등록된 운송장이 없습니다.")
	}
	
})

</script>




<body>

<div>
	<div style="border: 2px solid; ">
		<div ><a href="${projectDetail.url }"><img alt="프로젝트 이미지" src="${projectDetail.main_images_url }"></a></div>
		<div>
			<div>${projectDetail.category}</div>
			<div><a href="${projectDetail.url }">${projectDetail.long_title }</a></div>
			<div>${projectDetail.collection_amount }원</div>
			<div id="d_day">${dDay }일 남음</div>
			<!-- 창작자 문의 버튼 만들어아햠 -->
		</div>
	</div>
<p>

	<div style="border: 2px solid; ">
		<div>후원 정보</div><br>
		<div>펀딩 상태 </div> <div id="pro_status">펀딩 진행중</div><br>
		<div>후원 번호 </div> <div >${fundedDetail.fund_seq }</div><br>
		<div>후원 날짜 </div> <div >${fundedDetail.fund_date.toLocalDate() }</div><br>
		<div>펀딩 마감일 </div> <div >${projectDetail.due_date.toLocalDate()}</div><br>
	</div>
<p>


	<div style="border: 2px solid; ">
		<div>
			<div>선물 정보</div>
		</div>
		 
		<div>선물 구성 </div>
		<c:forEach var="bundle" items="${getBundle }" varStatus="current">
		</c:forEach>
		<div >꾸러미 이름</div><br>
			<ul>
			<li> 아이템 이름 </li>
				<div> 아이템</div>
			</ul>
		<div>배송 예정일 </div> <div>${projectDetail.delivery_date.toLocalDate()}</div>
		<div>후원 금액 </div> <div >${fundedDetail.price }</div>
	</div>
<p>

	<div style="border: 2px solid; ">
		<div>결제 정보</div> 
		<div>결제 수단 </div> <div> ${fundedDetail.pay_option }</div>
		<div>결제 금액 </div> <div> ${fundedDetail.price }</div>
		<div>결제 상태 </div> <div> ${fundedDetail.fund_duedate.toLocalDate().plusDays(1)} 결제 예정</div>
	</div>
<p>

	<div style="border: 2px solid; ">
		<div>배송 정보</div>
		<div>받는 사람 </div> <div> ${fundedDetail.name}</div>
		<div>연락처 </div> <div> ${fundedDetail.phone }</div><br>
		<div>주소 </div> <div>(${fundedDetail.postalcode })</div> <div> ${fundedDetail.address }</div>
		<div> ${fundedDetail.address_detail }</div><br>
		<div>운송장 번호 </div> <div id="track_num" >${fundedDetail.track_num }</div>
		<p>
		
		<input type="button" value="후원 목록 보기">
		<input type="button" value="후원을 취소하시겠어요?">
		<!-- 후원 취소 다시묻는 모달창 -->
	</div>
</div>

</body>
</html>