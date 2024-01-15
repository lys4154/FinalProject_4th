<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 반려 상세</title>
</head>
<body>

<table border=1>
   <tr>
      <td>프로젝트 번호:</td><td>${project.project_seq}</td>
   </tr>
   <tr>
      <td>회원 번호:</td><td>${project.member_seq}</td>
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
      <td>승인 여부:</td><td>${project.approval_status}</td>
      </tr>
   <tr>
      <td>승인 버튼:</td><td>${project.approval_status}</td>
   </tr>
   <tr>
      <td>반려 이유:</td><td><textarea style="height:300px;width:200px;"></textarea></td>
   </tr>
   <tr>
      <td colspan=2>                                                                                                                                                                                                                                                                                                                                                                                                                                                          
      <center> <input type="submit" name="submit" value="반려하기"></center>
      </td>
   </tr>
   

</table>

</body>
</html>