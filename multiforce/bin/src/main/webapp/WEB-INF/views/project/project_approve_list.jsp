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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/board/main.css">
	<link rel="stylesheet" type="text/css" href="/css/board/approval_page.css">
</head>
<body>

	<div class="main-container">
		<h1>프로젝트 검토</h1>
	    
	    <div id="tab-menu">
	        <a class="button-3" href="#" onclick="getApproveList('unapproved')">승인 대기 (${unapprovedCount})</a>
	        <a class="button-3" href="#" onclick="getApproveList('approved')">승인 완료 (${approvedCount})</a>
	        <a class="button-3" href="#" onclick="getApproveList('rejected')">반려 (${rejectedCount})</a>
	    </div>
	    
	
	    
	    <!-- 리스트 보여질 div -->
	    <div id="list_box">
	    </div>
	</div>

<script>
function getApproveList(approve_status){
	$.ajax({
		url: '/approve_list/'+approve_status,
		method:'GET',
		success: function(data){
			$('#list_box').html(data);
		},
		error:function(){
			alert("에러남");
		}
	});
}
</script>


</body>
</html>
