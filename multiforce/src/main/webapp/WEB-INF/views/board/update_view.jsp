<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업데이트 글읽기</title>

<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
  />
</head>
<body>

<div>
<c:forEach var="update" items="${project}">
    
    <div style="padding:5px; border:solid 1px black;margin-bottom:5px;">
    프로젝트 번호: ${update.project_seq}</br>
    글번호: ${update.update_seq}</br>
    글: ${update.content }
    <div><i class="fa fa-heart-o" aria-hidden="true" onclick="likePost(${update.update_seq})"></i></div>
    </div>
    
    </hr>

</c:forEach>

</div>


</body>
</html>