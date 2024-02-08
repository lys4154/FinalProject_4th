<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>

</script>
<body>
<h1>정보</h1>
${dto.price }<br>
${dto.pay_option}<br>
${dto.pay_number }<br>
${dto.name}<br>
${dto.phone}<br>
${dto.postcode}<br>
${dto.pDTO.long_title }<br>
<h1>판매자 정보</h1>
${dto.collectorDTO.nickname }
<h1>선택 옵션</h1>
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
</body>
</html>