<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업데이트 글읽기</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
  />
</head>
<body>

<div>
<c:forEach var="update" items="${project}">

    <div style="padding:5px; border:solid 1px black;margin-bottom:5px;">
    프로젝트 번호: ${update.project_seq}</br>
    글번호: ${update.update_seq}</br>
    글: ${update.content }
    <div><i class="fa fa-heart-o" aria-hidden="true" onclick="likePost(${update.update_seq})"></i></div>
    <a href="#" onclick="toggleCommentForm(${update.update_seq})">댓글달기</a> 
			
			
			<c:set var="comments" value="${boardService.getCommentsByUpdateSeq(1)}" />
			<c:out value="Number of comments: ${fn:length(comments)}" />
   		 <c:forEach var="comment" items="${boardService.getCommentsByUpdateSeq(1)}">
            <div>댓글: ${comment.content}</div>


        </c:forEach>
        
    
        <div id="commentForm_${update.update_seq}" style="display: none;">
            <textarea id="commentText_${update.update_seq}" rows="4" cols="50"></textarea> 
            <button onclick="submitComment(${update.update_seq})">댓글 등록</button>
        </div>
    </div>
    
    </hr>

</c:forEach>

</div>
<script>
    function toggleCommentForm(updateSeq) {
        var commentForm = document.getElementById("commentForm_" + updateSeq);
        if (commentForm.style.display === "none") {
            commentForm.style.display = "block";
        } else {
            commentForm.style.display = "none";
        }
    }


    function submitComment(updateSeq) {
        var commentText = $('#commentText_' + updateSeq).val();

        var data = {
            comment: commentText,
            updateSeq: updateSeq
        };

        $.ajax({
            type: 'POST',
            url: '/update_comment',
            data: data,
            success: function(response) {
                console.log(response);
                console.log('댓글이 성공적으로 전송되었습니다.');
                location.reload();
            },
            error: function(error) {
                console.error('댓글 전송 중 오류가 발생했습니다:', error);
            }
        });
    }




</script>

</body>
</html>