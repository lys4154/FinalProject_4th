<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="board.dto.UpdateReplyDTO" %>




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
  
  <style>
  #com_box{
  border:solid 1px black;
  }
  </style>
</head>
<body>

<div>
<%
String loggedInUserId = null;
int user_id = 0;
if(session.getAttribute("login_user_seq") != null){
	loggedInUserId = (String) session.getAttribute("login_user_seq");

	}
%>
아이디 번호2: ${loggedin_user }
<c:forEach var="update" items="${project}">


		
        
    <div style="padding:5px; border:solid 1px black;margin-bottom:5px;">
    <!-- 자기 글이면 삭제 보여주기 -->
        <c:if test="${update.member_seq eq loggedin_user}">
            <button onclick="deleteUpdate(${update.update_seq})">삭제하기</button>
        </c:if>
    프로젝트 번호: ${update.project_seq}</br>
    글쓴이: ${update.member_seq}</br>
    글번호: ${update.update_seq}</br>
    글: ${update.content }
   

     	
        
    <div>
    <i id="heartIcon_${update.update_seq}" class="${update.likedByCurrentUser ? 'fa fa-heart' : 'fa fa-heart-o'}" 
    aria-hidden="true" style="${update.likedByCurrentUser ? 'color: red;' : ''}" onclick="likePost(${update.update_seq})"></i>
    <span id="like_${update.update_seq}"></span>
    </div>
    <%
if (loggedInUserId != null) {
%>
    <a href="#" onclick="toggleCommentForm(event, ${update.update_seq})">댓글달기</a>
<%
}
%>

		
			
	<div id="comments_${update.update_seq}">
	</div>

        
    
        <div id="commentForm_${update.update_seq}" style="display: none;">
            <textarea id="commentText_${update.update_seq}" rows="4" cols="50"></textarea> 
            <button onclick="submitComment(${update.update_seq})">댓글 등록</button>
        </div>
    </div>
    
    </hr>

</c:forEach>

</div>

<script>
function deleteUpdate(updateSeq) {
    var confirmDelete = confirm('정말로 삭제하시겠습니까?');

    if (confirmDelete) {
        console.log('삭제진행 ㄱㄱ');

		
        $.ajax({
            type: 'POST',
            url: '/delete_update_post',
            data: { update_seq: updateSeq },
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
function likePost(updateSeq) {
    $.ajax({
        type: 'POST',  
        url: '/toggleUpdateLike',  
        data: { updateSeq: updateSeq },
        success: function (response) {
  			
            console.log('게시물 좋아요 성공');
            updateIconStyle(updateSeq, response.likedByCurrentUser);
            getLikeCount(updateSeq);
        },
        error: function (error) {

            console.error('게시물 좋아요 실패:', error);
        }
    });
}
function updateIconStyle(updateSeq, likedByCurrentUser) {
    var icon = $('#heartIcon_' + updateSeq);
    icon.removeClass('fa-heart fa-heart-o');
    if (likedByCurrentUser) {
        icon.addClass('fa-heart').css('color', 'red');
    } else {
        icon.addClass('fa-heart-o').css('color', '');
    }
}
    
function getLikeCount(updateSeq) {
    $.ajax({
        type: 'GET',
        url: '/getLikeCount',
        data: { updateSeq: updateSeq },
        success: function (count) {
            console.log('Updated Like Count:', count);
            $('#like_' + updateSeq).text(count);
        },
        error: function (error) {
            console.error('Error fetching updated like count:', error);
        }
    });
}
function toggleCommentForm(event, updateSeq) {
    event.preventDefault();

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
            update_seq: updateSeq
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

 
    function loadComments(updateSeq) {
        $.ajax({
            type: 'GET',
            url: '/getComments',
            data: { updateSeq: updateSeq },
            success: function (comments) {
                var commentsDiv = $('#comments_' + updateSeq);
                commentsDiv.empty();

                $.each(comments, function (index, comment) {
                    commentsDiv.append('<div id="com_box">댓글: ' + comment.content + '</br>아이디:'+
                    		comment.member.nickname
                    		+'</br>날짜: '+comment.time+'</div>');
                });
            },
            error: function (error) {
                console.error('Error fetching comments:', error);
            }
        });
    }

    <c:forEach var="update" items="${project}">
		getLikeCount(${update.update_seq});
	    loadComments(${update.update_seq});
	</c:forEach>
</script>

</body>
</html>