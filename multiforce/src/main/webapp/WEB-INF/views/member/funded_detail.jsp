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

	if (${dDay} < 0) {
		$("#pro_status").html("펀딩 종료")
		$("#d_day").html("펀딩 종료")
	}
	

	console.log(${getItem})
	
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

${projectDetail}

${fundedDetail}



	<div style="border: 2px solid; ">
		<div>선물 정보</div> <input type="button" value="변경"><br>
		<div>선물 구성 </div> <div >꾸러미 이름</div><br>
			<ul>
			<li> 아이템 이름 </li>
				<div> 아이템</div>
			</ul>
		<div>배송 예정일, 전달 예정</div><br>
		<div>후원 금액 </div> <div id="총금액">50000원</div>
	</div>
<p>

	<div style="border: 2px solid; ">
		<div>결제 정보</div> <input type="button" value="변경"><br>
		<div>결제 수단 </div> <div id="결제 수단">신용카드</div><br>
		<div>결제 금액 </div> <div id="총금액">50000원</div><br>
		<div>결제 상태 </div> <div id="프로젝트 종료일자+1"> 24.01.05 </div> <div>결제 예정</div><br>
	</div>
<p>

	<div style="border: 2px solid; ">
		<div>배송 정보</div> <input type="button" value="변경"><br>
		<div>받는 사람 </div> <div id="받는분 성함">받는분 성함</div><br>
		<div>연락처 </div> <div id="받는분 전화번호">010-3333-3333</div><br>
		<div>주소 </div> (<div id="우편번호">우편번호</div>) <div id="받는분 주소">받는분 주소 </div>
		<div id="상세주소">상세 주소(동,호수)</div><br>
		<div>운송장 번호 </div> <div id="운송장">운송장 번호</div>
		<p>
		
		<input type="button" value="후원 목록 보기">
		<input type="button" value="후원을 취소하시겠어요?">
		<!-- 후원 취소 다시묻는 모달창 -->
	</div>
</div>

</body>
</html>