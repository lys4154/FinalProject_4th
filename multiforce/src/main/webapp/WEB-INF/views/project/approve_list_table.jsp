<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<title></title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<meta charset="UTF-8">
</head>
<body>
<div id="reasonModal" class="modal">

  <div class="modal-content">
    <span class="close">&times;</span>
    <div class="modal-head1">반려이유</div>
    <p id="reason"></p>
  </div>

</div>

<c:if test="${style eq 'unapproved'}">
    <table class="approval-table">
	    <thead>
	        <tr>
	            <th>프로젝트 번호</th>
				<th>회원</th>
				<th>목표 금액</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>승인 버튼</th>

	        </tr>
	    </thead>
	    <tbody>
	        <c:forEach items="${projects}" var="project">
	            <tr>
	                <td>${project.project_seq}</td>
	                <td>${project.nickname}</td>
	                <td>${project.goal_price}</td>
	                <td>${project.short_title}</td>
	                <td>${project.category}</td>
	                <td style="text-align:center">
	                <a class="accept-btn" href="#" onclick="confirmApproval(${project.project_seq})">승인</a>
	                <a class="reject-btn" href="project_reject/${project.project_seq}">반려</a>
	                </td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
		<c:if test="${totalPages > 1}">
        <div class="pagination-container">
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
<table class="approval-table">
	    <thead>
	        <tr>
	            <th>프로젝트 번호</th>
	            <th>회원</th>
	            <th>목표 금액</th>
	            <th>제목</th>
	            <th>카테고리</th>


	        </tr>
	    </thead>
	    <tbody>
	        <c:forEach items="${projects}" var="project">
	            <tr>
	                <td>${project.project_seq}</td>
	                <td>${project.nickname}</td>
	                <td>${project.goal_price}</td>
	                <td>${project.short_title}</td>
	                <td>${project.category}</td>


	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
	<c:if test="${totalPages > 1}">
        <div class="pagination-container">
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
<table class="approval-table">
    <thead>
        <tr>
            <th>프로젝트 번호</th>
            <th>회원</th>
            <th>목표 금액</th>
            <th>제목</th>
            <th>카테고리</th>
            <th>반려 이유</th>

        </tr>
    </thead>
    <tbody>
        <c:forEach items="${projects}" var="project">
            <tr>
                <td>${project.project_seq}</td>
                <td>${project.nickname}</td>
                <td>${project.goal_price}</td>
                <td>${project.short_title}</td>
                <td>${project.category}</td>
                <td style="text-align:center;"><a class="accept-btn" id="view-reason" href="#" data-projectSeq="${project.project_seq}">반려 이유</a></td>

            </tr>
        </c:forEach>
    </tbody>
</table>
<c:if test="${totalPages > 1}">
        <div class="pagination-container">
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
function confirmApproval(projectSeq) {
    var confirmation = confirm("프로젝트를 승인 하시겠습니까?");
    if (confirmation) {
        window.location.href = "project_approve_accept/" + projectSeq;
    }
}

$(document).ready(function(){
    $("#view-reason").click(function(){
        $("#reasonModal").css("display", "block");
        
        var projectSeq = $(this).data('projectseq'); // 데이터 속성 이름을 올바르게 가져옵니다.

        $.ajax({
            url: "/rejection-reason/" + projectSeq, 
            type: "GET",
            success: function(response) {
                $("#reason").text(response);
            },
            error: function(xhr, status, error) {
                console.error("AJAX request failed:", error);
                $("#reason").text("반려 이유를 가져오는 데 실패했습니다.");
            }
        });
    });

    $(".close").click(function(){
        $("#reasonModal").css("display", "none");
    });
});



</script>
</body>
</html>