<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<title>${board.title}</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>
#box{
border:solid 1px black;
}
</style>
</head>
<body>
<%
String loggedInUserId = null;
int user_id = 0;
if(session.getAttribute("login_user_seq") != null){
	loggedInUserId = (String) session.getAttribute("login_user_seq");

	}
%>
<div class="board_view" style="border:solid black 1px">
	<h3>1:1 고객센터</h3>
	<a href="#">수정하기</a>
	<a href="#">삭제하기</a>
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
            <dd>${post_writer}</dd>
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
    <label for="post">글쓰기:</label><br>
    <input type="hidden" name="post_id" value="${board.help_ask_seq}">
    <textarea id="content" name="comment" rows="4" cols="50"></textarea><br><br>
    <input type="submit" value="댓글 작성">
</form>

<!-- 댓글 표시 div 영역 -->
<div>
<c:forEach var="comment" items="${comments}">
    <div id="box">

   	    <c:if test="${comment.member_seq eq loggedin_user}">
            <button onclick="deleteComment(${comment.help_ask_seq})">삭제하기</button>
        </c:if>
        <p><b>날짜:</b>
        <fmt:parseDate var="parsedDate" value="${comment.date}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
			<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
        </p>
        <p><b>작성자:</b> ${comment.nickname}</p>
        <p><b>내용:</b> ${comment.content}</p>
        <!-- 추가 필요한 속성들에 대해 필요한대로 출력 -->
    </div>
</c:forEach>
</div>
<script>
var loggedInUser = {
        id: '<%= request.getAttribute("loggedin_user") %>',
    };
function deleteComment(comment_id) {
    var confirmDelete = confirm('정말로 삭제하시겠습니까?');

    if (confirmDelete) {
        console.log('삭제진행 ㄱㄱ');

		
        $.ajax({
            type: 'POST',
            url: '/delete_cs_comment',
            data: { help_ask_seq: comment_id },
            success: function(response) {
                console.log('삭제 성공:', response);
                location.reload();
                
            },
            error: function(error) {
                console.error('삭제 실패:', error);
            }
        });

    } else {
        console.log('삭제가 실패함');
    }
}
</script>
</body>
</html>