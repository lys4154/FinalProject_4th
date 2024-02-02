<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">





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
    <div class="cs-container">
        <h2>업데이트 글쓰기</h2>
        <div style="margin-bottom:15px;" id="cs_menu_bar">
            
        </div>
     
        <form id="write_form" action="/update_write" method="POST" onsubmit="return validateForm()">
           

            <div class="write-content">
                <textarea name="contents" cols="30" id="content" rows="10" placeholder="내용"></textarea>
            </div>
            <div class="cs-submit-btn">
                <input type="submit" value="제출" name="submit">
            </div>
            <input type="hidden" name="project_seq" value="${project_seq }">
        </form>
    </div>
 


</body>
</html>
