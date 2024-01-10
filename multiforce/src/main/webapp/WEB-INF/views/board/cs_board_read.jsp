<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<title>${board.title}</title>
</head>
<body>
<div class="board_view" style="border:solid black 1px">
	<h3>1:1 고객센터</h3>
    <div class="title" style="background-color: #f5f5f5;">
        ${board.title}
    </div>
    <div class="info">
        <dl>
            <dt>번호</dt>
            <dd>${board.help_ask_seq}</dd>
        </dl>
        <dl>
            <dt>글쓴이</dt>
            <dd>${board.member_seq}</dd>
        </dl>
        <dl>
            <dt>작성일</dt>
            <dd>
            <fmt:parseDate var="parsedDate" value="${board.help_ask_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
			<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
            </dd>
        </dl>
         
    </div>
    <div class="content">
        ${board.content}

        
    </div>
</div>
<form action="/cs_comment" method="POST">
    <label for="comment_text">댓글:</label><br>
    <input type="hidden" name="post_id" value="${board.help_ask_seq}">
    <textarea id="comment_text" name="comment" rows="4" cols="50"></textarea><br><br>
    <input type="submit" value="댓글 작성">
</form>

<div>
</div>

</body>
</html>