<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>

    <title>1:1 고객센터 게시판</title>
    <link rel="stylesheet" type="text/css" href="/css/board/main.css">
    <meta charset="UTF-8">
</head>
<body>


    
    <div class="main-container">
    	<div style="margin-bottom:15px;text-align:right;">
    	<c:if test="${user_available eq true}">
		    <a class="btn-1" href="/cs/write-form">글쓰기</a>
		</c:if>
    	</div>
	    <table class="board-table">
	        <colgroup>
	            <col style="width:7%">
	            <col>
	            <col style="width:10%">
	            <col style="width:10%">
	        </colgroup>
	        <thead>
	            <tr>
	                <th scope="col">No.</th>
	                <th scope="col" style="text-align: center;">제목</th>
	                <th scope="col">작성자</th>
	                <th scope="col">작성일</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach items="${posts}" var="post">
	                <tr class="board_body_title">
	                    <td class="text-center">${post.help_ask_seq}</td>
	                    <td><a class="board-link" href="/cs/read_post/${post.help_ask_seq}">${post.title}</a></td>
	                    <td class="text-center">${post.nickname}</td>
	                    <td class="text-center">
	                    <c:set var="rawDate" value="${post.help_ask_date}" />
						<c:set var="formattedDate" value="${fn:substring(rawDate, 0, 10)}" />
	                    <c:out value="${formattedDate}" />
	                    </td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	    
    <div class="pagination-container">
	    <c:if test="${totalPages > 1}">
	        <c:forEach begin="0" end="${totalPages - 1}" var="pageNumber">
	            <c:set var="pageNumberPlusOne" value="${pageNumber + 1}"/>
	            <a class="${pageNumber eq currentPage ? 'active-pagination' : ''}" href="?page=${pageNumber}">${pageNumberPlusOne}</a>
	        </c:forEach>
	    </c:if>
	</div>
    </div>



</body>
</html>
