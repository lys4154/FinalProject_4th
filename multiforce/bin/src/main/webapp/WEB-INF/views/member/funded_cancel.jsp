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
</head>





<script>



$(document).ready(function() {
	
})
	


</script>

<body>



<h1>후원이 취소되었습니다.</h1>
<div>
	<span>${dueDate }</span>까지 다시 후원할 수 있습니다.
</div>
<p>

<div>
	<div> 후원 번호 <span>${fundSeq }</span>가 취소되었습니다. </div>
	<div> 프로젝트 이름 <span>${longTitle}</span> </div>
	<div> 창작자 <span id="프로젝트 회원번호">런워크</span> </div>
	
	<div>
		<div>
			<div>선택한 선물</div>
			<c:forEach var="bundleEntry" items="${bundle}">
			    <div>  ${bundleEntry.name} <span>${bundleEntry.count} </span>개</div>			    
			    <c:forEach var="itemEntry" items="${bundleEntry.items}">
			        <div> ${itemEntry.itemName} </div>			        
			        <c:forEach var="option" items="${itemEntry.options}">
			            <div> 옵션 ${option} </div>
			        </c:forEach>
			    </c:forEach>			    
			    <hr>
			</c:forEach>
		</div>			
	</div>
	<div> 후원 금액 <span> ${price }원</span> </div>
	<p>
</div>
	
<input type="button" onclick="location='/funded'" value="후원한 프로젝트 목록">


</body>
</html>