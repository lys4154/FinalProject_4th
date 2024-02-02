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
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/css/member/funded_cancel.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>

<script>

$(document).ready(function() {
	
})
	

</script>

<body>

<div class="out_con">
	<div class="cancel_header">
		<div class="cancel_ment">후원이 취소되었습니다.</div>
		<div class="cancel_due"><span id="due_date">${dueDate }</span>까지 다시 후원할 수 있습니다.</div>
	</div>	
	
	<div class="cancel_contents">	
		<div class="cancel_contents_ment"> 후원 번호 <span>${fundSeq }</span>가 취소되었습니다. </div>
		<hr>
		<div class="contents_flex">
			<div class="contents_left">
				<div> 프로젝트 이름 </div>
			</div>		
			<div class="contents_right">
				<div>${longTitle}</div>
			</div>
		</div>
		<div class="contents_flex">
			<div class="contents_left">
				<div> 창작자 </div>
			</div>
			<div class="contents_right">	
				<div >${creator }</div>
			</div>
		</div>
		<div class="contents_flex">
			<div class="contents_left">
				<div>선택한 선물</div>
			</div>
			<div class="contents_right">
				<c:forEach var="bundleEntry" items="${bundle}">
				    <div> * ${bundleEntry.name} <span>${bundleEntry.count}</span>개</div>			    
				    <c:forEach var="itemEntry" items="${bundleEntry.items}">
				        <div class="contents_right_item"> ${itemEntry.itemName} 		        
					        <c:forEach var="option" items="${itemEntry.options}">
				            <span> (옵션 - ${option} )</span>			            
				        </c:forEach>
				        </div>
				    </c:forEach>		    
				</c:forEach>
			</div>			
		</div>
		<div class="contents_flex">
			<div class="contents_left">
				<div> 후원 금액 </div> 
			</div>
			<div class="contents_right">
				<div class="contents_price">
					<fmt:formatNumber value="${price }" type="currency" currencySymbol="" />원 결제 예약 취소 완료
				</div>
			</div>
		</div>			
	</div>
	
	<div class="funded_btn">	
		<input type="button" onclick="location='/funded'" value="후원한 프로젝트 목록" id="btn">
	</div>

</div>
</body>
</html>