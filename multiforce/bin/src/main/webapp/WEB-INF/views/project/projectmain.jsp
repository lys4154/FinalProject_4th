<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>프로젝트 메인</title>
 
</head>
<body>

<h1>프로젝트 메인 페이지</h1>

<c:forEach var="project" items="${projectList}">
    <div>
        <h2>${project.long_title}</h2>
        <p>${project.short_title}</p>
        <p>${project.sub_title}</p>
        <img src="${project.main_images_url}" alt="프로젝트 이미지">
        <p>${project.url}</p>
        
    </div>
    <hr>
</c:forEach>



</body>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</html>