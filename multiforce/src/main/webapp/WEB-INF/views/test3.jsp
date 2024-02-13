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
<c:if test="${query !=  '' || not empty query}">
	<c:set var="queryPara" value="${'&query=' + query }"/>
</c:if>
<c:forEach var="item" items="${list }">
	
	<div>
		<a href="/notices/detail?seq=${item.notice_seq }&category=${category}&page=${nowPage}">
			<div>
				${item.title }
			</div>
		</a>
		<span>
			${item.category }
		</span>
		<span>
			${item.write_date }
		</span>
	</div>
</c:forEach>
<div>
	<c:set var="pageListLength" value="5"/>
	<c:set var="tmp" value="${nowPage/(pageListLength + 1) }"/>
	<c:if test="${tmp == 0}">
		<a href="/notices?category=${category }&page=1${queryPara }">←</a>
	</c:if>
	<c:if test="${tmp != 0}">
		<a href="/notices?category=${category }&page=${pageListLength * (tmp - 1) + 1}${queryPara }">←</a>
	</c:if>
	<c:forEach begin="1" end="${pageListLength }" varStatus="status">
		<a href="/notices?category=${category}&page=${status.index + tmp * pageListLength}${queryPara}">
			${status.index + tmp * pageListLength}
		</a>
		<c:choose>
			<c:when test="${status.index + tmp * pageListLength == totalPage}">
				<a href="/notices?category=${category }&page=${totalPage}${queryPara}">→</a>
			</c:when>
			<c:when test="${status.index + tmp * pageListLength == totalPage}">
				<a href="/notices?category=${category }&page=${pageListLength * (tmp + 1) + 1}${queryPara}">→</a>
			</c:when>
		</c:choose>
	</c:forEach>
</div>
</body>
</html>