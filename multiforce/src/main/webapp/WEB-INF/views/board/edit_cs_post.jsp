<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
<link rel="stylesheet" type="text/css" href="/css/board/edit_post.css">
<link rel="stylesheet" type="text/css" href="/css/board/main.css">
</head>
<body>

<div class="main-container">
	
	<h2>글 수정</h2>
	<form method="POST" action="/editCsPost" onsubmit="return validateForm()">
		<div><input type="text" class="title-bar-input" name="title" value="${board.getTitle()}"></input></div>
		<div><textarea name="content" class="content-textarea">${board.getContent()}</textarea></div>
		<input type="hidden" name="post_id" value="${board.help_ask_seq}">
		<input class="btn-2" style="margin-top:10px;" type="submit" name="submit" value="수정">
	</form>
</div>


<script>
    function validateForm() {

        var title = document.getElementsByName("title")[0].value.trim();
        var content = document.getElementsByName("content")[0].value.trim();


        if (title === "" || content === "") {
 
            alert("제목과 내용을 모두 입력하세요.");
            return false; 
        }

        return true;
    }
</script>

</body>
</html>