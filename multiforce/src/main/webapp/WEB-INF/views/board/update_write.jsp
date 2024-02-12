<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


	<link rel="stylesheet" type="text/css" href="/css/board/edit_post.css">
	<link rel="stylesheet" type="text/css" href="/css/board/main.css">


    <title>업데이트 글쓰기</title>


<script>
    function validateForm() {
        var commentText = document.getElementById("contents").value.trim();

        if (commentText === "") {
            alert("글을 입력해주세요.");
            
            return false;
        }

        return true;
    }

</script>
</head>
<body>
    <div class="main-container">
        <h2>업데이트 글쓰기</h2>
        <div id="cs_menu_bar">
            
        </div>
     
        <form id="write_form" action="/update_write" method="POST" onsubmit="return validateForm()">
           

            <div class="write-content">
                <textarea class="content-textarea" name="contents" cols="30" id="content" rows="10" placeholder="내용"></textarea>
            </div>
            <div class="cs-submit-btn">
                <input class="btn-2" type="submit" value="업데이트 등록" name="submit">
            </div>
            <input type="hidden" name="project_seq" value="${project_seq }">
        </form>
    </div>
 


</body>
</html>
