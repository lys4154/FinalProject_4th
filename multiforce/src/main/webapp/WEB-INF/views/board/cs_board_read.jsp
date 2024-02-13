<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>${board.title}</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<link rel="stylesheet" type="text/css" href="/css/board/board_view.css">
<link rel="stylesheet" type="text/css" href="/css/board/main.css">
</head>
<body>

<%
String loggedInUserId = null;
int user_id = 0;
if(session.getAttribute("login_user_seq") != null){
	loggedInUserId = (String) session.getAttribute("login_user_seq");

	}
%>

<div class="main-container">
<h3>1:1 고객센터</h3>
<div class="board_view">
	
	
	<div style="padding-bottom:10px;">
	<a class="btn-1" href="/edit_cs_post/${board.help_ask_seq}">수정하기</a>
	<a class="btn-1" href="#" onclick="deletePost(${board.help_ask_seq})">삭제하기</a>
	</div>
    <div class="title-bar">
        ${board.title}
    </div>
    <div class="board-read-header">
           
           <div class="sub-name board-read-header">
	           <div class="read-header-name padding-a name-tag" style="width:150px;">글쓴이</div>
	           <div class="padding-a">${post_writer}</div>
           </div>
           
           <div class="sub-name board-read-header">
	           <div class="read-header-name padding-a name-tag" style="width:150px;">등록일</div>
	           <div class="padding-a">
	           <fmt:parseDate var="parsedDate" value="${board.help_ask_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
			   <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
	           </div>
           </div>
           
                 
    </div>
 
    <div class="board-view-content">
        ${board.content}

        
    </div>
</div>

<div class="comment-container">
<form action="/cs_comment" method="POST">
    <input type="hidden" name="post_id" value="${board.help_ask_seq}">
    <textarea class="comment-area" id="content" name="comment" placeholder="댓글작성"></textarea><br>
    <input type="submit" value="댓글 작성" class="btn-1">
</form>
</div>

<!-- 댓글 표시 div 영역 -->
<div class="comment-box-container">
<c:forEach var="comment" items="${comments}">
    <div class="comment-box">

   	    

        
        <div class="comment-box-header">
	        <div>
		        <span class="writer">${comment.nickname}</span>
		        <span class="date">
		        <fmt:parseDate var="parsedDate" value="${comment.date}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
				<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
		        </span>
	        </div>
        	<div>
        	<c:if test="${comment.member_seq eq loggedin_user}">
	            <button class="btn-1" onclick="deleteComment(${comment.help_ask_seq})">삭제하기</button>
	        </c:if>
        	</div>
        </div>
        <p>${comment.content}</p>
        <!-- 추가 필요한 속성들에 대해 필요한대로 출력 -->
    </div>
</c:forEach>
</div>
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
function deletePost(comment_id) {
    var confirmDelete = confirm('정말로 삭제하시겠습니까?');

    if (confirmDelete) {
        console.log('삭제진행 ㄱㄱ');

		
        $.ajax({
            type: 'POST',
            url: '/delete_cs_comment',
            data: { help_ask_seq: comment_id },
            success: function(response) {
                console.log('삭제 성공:', response);
                window.location.href = "/board_list/cs";
                
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
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>