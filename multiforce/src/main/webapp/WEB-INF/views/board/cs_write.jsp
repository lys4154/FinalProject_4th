<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>


<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link rel="stylesheet" type="text/css" href="/css/board/edit_post.css">
	<link rel="stylesheet" type="text/css" href="/css/board/main.css">


    <title>1:1 고객센터 게시판 글쓰기</title>



</head>
<body>
    <div class="main-container">
        <h2>1:1 고객센터 게시판 글쓰기</h2>
        <div style="margin-bottom:15px;" id="cs_menu_bar">
            
        </div>
     
        <form id="write_form" action="/boardwrite" method="POST" onsubmit="return validateForm()" >
           
            <div class="write-title">
                <input type="text" class="title-bar-input" name="title" id="title" placeholder="제목">
            </div>
            <div class="write-content">
                <textarea name="contents" class="content-textarea" cols="30" id="content" rows="10" placeholder="내용"></textarea>
            </div>
            <div class="cs-submit-btn">
                <input class="btn-2" type="submit" value="제출" name="submit">
            </div>
        </form>
    </div>
 

<script>
    function validateForm() {

        var title = document.getElementsByName("title")[0].value.trim();
        var content = document.getElementsByName("contents")[0].value.trim();


        if (title === "" || content === "") {
 
            alert("제목과 내용을 모두 입력하세요.");
            return false; 
        }

        return true;
    }
</script>
</body>
</html>
