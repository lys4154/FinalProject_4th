<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
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
                <a href="#">승인</a>
                <a href="project_reject/${project.project_seq}">반려</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</body>
</html>