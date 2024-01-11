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
</head>
<body>
    <h1>Project Table</h1>
    
    <div id="menu">
        <a href="#" onclick="getApproveList('unapproved')">승인 대기 (${unapprovedCount})</a>
        <a href="#" onclick="getApproveList('approved')">승인 완료 (${approvedCount})</a>
    </div>
    

    
    <!-- 리스트 보여질 div -->
    <div id="list_box">
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
