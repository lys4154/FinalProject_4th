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
<%NoticeDTO dto = (NoticeDTO)request.getAttribute("dto"); %>
$(document).ready(function(){
	let login_user_level = "${login_user_level}";
	if(login_user_level == "2"){
		$("#modify_btn_wrap").html("<a href='/notices/write?seq=" + <%=dto.getNotice_seq()%> + "'>수정</a>");
		$("#modify_btn_wrap").html("<a href='/notices/delete?seq=" + <%=dto.getNotice_seq()%> + "'>삭제</a>");
	}
	function getParameterByName(name) {
		name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	    results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
	if(getParameterByName("category") != "" || getParameterByName("page") != ""){
		$("#notice_list_btn").attr("href", "/notices?category=" + getParameterByName("category") 
				+ "&page=" + getParameterByName("page"));
	}else{
		$("#notice_list_btn").attr("href", "/notices");
	}
	
});

</script>
<body>
<div>게시물 번호: <%=dto.getNotice_seq() %></div>
<div>제목: <%=dto.getTitle() %></div>
<div>내용: <%=dto.getContent() %></div>
<div>분류: <%=dto.getCategory() %></div>
<div>작성 날짜: <%=dto.getWrite_date() %></div>
<%if(dto.getCategory().equals("event")){%>
	<div>이벤트 기간 <%=dto.getEvent_start_date() %>~<%=dto.getEvent_end_date() %></div>
<%}
%>
<div id="modify_btn_wrap"></div>
<a id="notice_list_btn" href="/notices" id="notices_list">목록</a>

</body>
</html>