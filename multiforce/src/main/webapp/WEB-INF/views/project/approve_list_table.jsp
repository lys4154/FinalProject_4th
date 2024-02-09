<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title></title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>


<c:if test="${style eq 'unapproved'}">
    <table border="1">
	    <thead>
	        <tr>
	            <th>프로젝트 번호</th>
	            <th>회원 번호</th>
	            <th>목표 금액</th>
	            <th>제목</th>
	            <th>카테고리</th>
	            <th>승인 여부</th>
	            <th>승인 버튼</th>
	        </tr>
	    </thead>
	    <tbody>
	        <c:forEach items="${projects}" var="project">
	            <tr>
	                <td>${project.project_seq}</td>
	                <td>${project.member_seq}</td>
	                <td>${project.goal_price}</td>
	                <td>${project.short_title}</td>
	                <td>${project.category}</td>
	                <td>${project.project_process}</td>
	                <td>
	                <a href="project_approve_accept/${project.project_seq}">승인</a>
	                <a href="project_reject/${project.project_seq}">반려</a>
	                </td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
		<c:if test="${totalPages > 1}">
        <div>
            <c:forEach begin="0" end="${totalPages-1}" var="i">
                <c:url value="unapproved" var="unpageUrl">
                    <c:param name="page" value="${i}" />
                </c:url>
                <c:choose>
                    <c:when test="${currentPage eq i}">
                        <span>${i+1}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="#" onclick="getApproveList('${unpageUrl}')">${i+1}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </c:if>
	
</c:if>
<c:if test="${style eq 'approved'}">
<table border="1">
	    <thead>
	        <tr>
	            <th>프로젝트 번호</th>
	            <th>회원 번호</th>
	            <th>목표 금액</th>
	            <th>제목</th>
	            <th>카테고리</th>
	            <th>승인 여부</th>

	        </tr>
	    </thead>
	    <tbody>
	        <c:forEach items="${projects}" var="project">
	            <tr>
	                <td>${project.project_seq}</td>
	                <td>${project.member_seq}</td>
	                <td>${project.goal_price}</td>
	                <td>${project.short_title}</td>
	                <td>${project.category}</td>
	                <td>${project.project_process}</td>

	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
	<c:if test="${totalPages > 1}">
        <div>
            <c:forEach begin="0" end="${totalPages-1}" var="i">
                <c:url value="approved" var="pageUrl">
                    <c:param name="page" value="${i}" />
                </c:url>
                <c:choose>
                    <c:when test="${currentPage eq i}">
                        <span>${i+1}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="#" onclick="getApproveList('${pageUrl}')">${i+1}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </c:if>
	
</c:if>
<c:if test="${style eq 'rejected'}">
<table border="1">
    <thead>
        <tr>
            <th>프로젝트 번호</th>
            <th>회원 번호</th>
            <th>목표 금액</th>
            <th>제목</th>
            <th>카테고리</th>
            <th>승인 여부</th>

        </tr>
    </thead>
    <tbody>
        <c:forEach items="${projects}" var="project">
            <tr>
                <td>${project.project_seq}</td>
                <td>${project.member_seq}</td>
                <td>${project.goal_price}</td>
                <td>${project.short_title}</td>
                <td>${project.category}</td>
                <td>${project.project_process}</td>

            </tr>
        </c:forEach>
    </tbody>
</table>
<c:if test="${totalPages > 1}">
        <div>
            <c:forEach begin="0" end="${totalPages-1}" var="i">
                <c:url value="rejected" var="pageUrl">
                    <c:param name="page" value="${i}" />
                </c:url>
                <c:choose>
                    <c:when test="${currentPage eq i}">
                        <span>${i+1}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="#" onclick="getApproveList('${pageUrl}')">${i+1}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </c:if>

</c:if>
<script>
function getApproveList(approve_status){
	$.ajax({
		url: '/approve_list/'+approve_status,
		method:'GET',
		success: function(data){
			$('#list_box').html(data);
		},
		error:function(){
			alert("에러남");
		}
	});
}
</script>
</body>
</html>