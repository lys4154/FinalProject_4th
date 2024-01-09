<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html>
<head>
    <title>Project Table</title>

</head>
<body>
    <h1>Project Table</h1>
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
                <td>${project.projectSeq}</td>
                <td>${project.memberSeq}</td>
                <td>${project.goalPrice}</td>
                <td>${project.shortTitle}</td>
                <td>${project.category}</td>
                <td>${project.shareCount}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>
