<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 반려 상세</title>
<link rel="stylesheet" type="text/css" href="/css/board/main.css">
<link rel="stylesheet" type="text/css" href="/css/project/reject.css">
</head>
<body>

<div class="main-container">


<form action="/post_project_reject" method="post">
<table border=1 class="reject-table">
   <tr>
      <td>프로젝트 번호:</td><td>${project.project_seq}</td>
   </tr>
   <tr>
      <td>프로젝트 관리자:</td><td>${member_nickname.nickname}</td>
   </tr>
   <tr>
      <td>목표 금액:</td><td>${project.goal_price}</td>
      </tr>
   <tr>
      <td>제목:</td><td>${project.short_title}</td>
      </tr>
   <tr>
      <td>카테고리:</td><td>${project.category}</td>
      </tr>


   <tr>
      <td>반려 이유:</td><td><textarea name="content"></textarea></td>
   </tr>
   <tr>
      <td colspan=2>                                                                                                                                                                                                                                                                                                                                                                                                                                                          
      <center> <input class="btn-2" type="submit" name="submit" value="반려하기"></center>
      </td>
   </tr>
   <input type="hidden" name="project_seq" id=""project_seq"" value="${project.project_seq}">
   

</table>
</form>

</div>


</body>
</html>