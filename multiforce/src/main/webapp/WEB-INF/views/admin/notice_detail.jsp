<%@page import="admin.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="/css/admin/notice_detail.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.7.1.min.js"></script>
<style>
.out_con {
	width: 1040px;
	margin:0 auto;
	padding: 10px 10px;
}
</style>

<script>
if("${result}" == "false"){
	alert("삭제된 게시물입니다")
	location.href = "/notices"
}	
$(document).ready(function(){
	let login_user_level = "${login_user_level}";
	if(login_user_level == "2"){
		$("#modify_btn_wrap")
		.html("<a href='/notices/write?seq=" + ${dto.notice_seq} + "'>수정</a>"
			+ "<button id='delete_btn'>삭제</button>");
		$("#delete_btn").on("click", function(){
			if(confirm("삭제 하시겠습니까?")){
				$.ajax({
					data : {"notice_seq": '${dto.notice_seq}'},
					type : "POST",
					url : "/deletenotice",
					dataType: 'json',
					success : function(r) {
						if(r.result == "true"){
							alert("삭제되었습니다");
							location.href = "/notices";
						}else{
							alert("오류가 발생했습니다");
						}
					}
				});
			}
		});
	}
	function getParameterByName(name) {
		name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	    results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
	
	let result = "/notices";
	if(getParameterByName("category") != "" || getParameterByName("page") != ""){
		result += "?category=" + getParameterByName("category") + "&page=" + getParameterByName("page");
	}
	if(getParameterByName("query") != ""){
		result += ("&query=" + getParameterByName("query"));
	}
	$("#notice_list_btn").attr("href", result);
});

</script>
<body>
<div id="container">
<div id="notice_seq">게시물 번호: ${dto.notice_seq}</div>
<div id="cat">분류: ${dto.category}</div>
<div id="title">제목: ${dto.title}</div>
<div id="write_date">작성 날짜: ${dto.write_date}</div>
<c:if test="${dto.category eq 'event'}">
	<div id="date">이벤트 시작 ${dto.event_start_date } ~ 종료 ${dto.event_end_date }</div>
</c:if>
<div id="content">내용: ${dto.content}</div>
</div>
<div id="modify_btn_wrap">
<a id="notice_list_btn" href="/notices" id="notices_list">목록</a>
</div>

</body>
</html>