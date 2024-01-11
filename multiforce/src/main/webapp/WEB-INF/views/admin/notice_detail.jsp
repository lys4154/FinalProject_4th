<%@page import="admin.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function(){
	let login_user_level = "${login_user_level}";
	if(login_user_level == "2"){
		$("#modify_btn_wrap").html("<button id='modify_btn'>수정</button>");
	}
	
});

</script>
<body>
<%NoticeDTO dto = (NoticeDTO)request.getAttribute("dto"); %>

<div><%=dto.getTitle() %></div>
<div><%=dto.getContent() %></div>
<div><%=dto.getCategory() %></div>
<div><%=dto.getWrite_date() %></div>
<div id="modify_btn_wrap"></div>
<a href="/notices" id="notices_list">목록</a>

</body>
</html>