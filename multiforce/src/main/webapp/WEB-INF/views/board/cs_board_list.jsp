<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html>
<head>

<title>1:1 고객센터 게시판</title>
</head>
<body>
<table class="table table-hover">  
    <colgroup>
        <col style="width:7%">
        <col>
        <col style="width:15%">
        <col style="width:6%">

    </colgroup>
    <thead>
        <tr>
            <th scope="col">No.1</th>
            <th scope="col" style="text-align: center;">제목</th> 
            <th scope="col">작성자</th>
            <th scope="col">작성일</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${posts}" var="post">
            <tr>
                <td>${post.help_ask_seq}</td>
                <td><a href="/cs/read_post/${post.help_ask_seq}">${post.title}</a></td>
                <td>${post.member_seq}</td>
                <td>
					<fmt:parseDate var="parsedDate" value="${post.help_ask_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
					<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />


				</td>
            </tr>
         </c:forEach>
    </tbody>
</table>
         
</body>
</html>