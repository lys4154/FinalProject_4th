<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">




    <title>1:1 고객센터 게시판 글쓰기</title>



</head>
<body>
    <div class="cs-container">
        <h2>1:1 고객센터 게시판 글쓰기</h2>
        <div style="margin-bottom:15px;" id="cs_menu_bar">
            
        </div>
     
        <form id="write_form" action="/boardwrite" method="POST" >
           
            <div class="write-title">
                <input type="text" name="title" id="title" placeholder="제목">
            </div>
            <div class="write-content">
                <textarea name="contents" cols="30" id="content" rows="10" placeholder="내용"></textarea>
            </div>
            <div class="cs-submit-btn">
                <input type="submit" value="제출" name="submit">
            </div>
        </form>
    </div>
 


</body>
</html>
