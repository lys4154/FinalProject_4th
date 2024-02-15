<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.List" %>




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
  <link rel="stylesheet" type="text/css" href="/css/project/update_and_community.css">
  <link rel="stylesheet" type="text/css" href="/css/board/main.css">

</head>
<body>

<div>
<%
int loggedInUserId = 0;
int user_id = 0;
if(session.getAttribute("login_user_seq") != null){
	loggedInUserId = (Integer) session.getAttribute("login_user_seq");

	}
%>
<c:choose>
    <c:when test="${project_manager}">
        
        <div class="update_big_btn"><a href="/update/write/${project_id}" class="btn-2">업데이트 글쓰기</a></div>
    </c:when>
</c:choose>
<c:choose>
    <c:when test="${empty project}">
        <p class="update_empty">게시물이 없습니다.</p>
    </c:when>
    <c:otherwise>
        <c:forEach var="update" items="${project}">
		
		
				
		        
		    <div style="padding:5px; margin-bottom:5px;">
		    <!-- 자기 글이면 삭제 보여주기 -->
		       
				
				<div class="update_post_box">
				
			    
			    <div class="header">
			    	<div>
			    	${update.nickname} | ${update.formattedDate }
			    	</div>
			    	
			    	<div>
			    	<c:if test="${update.member_seq eq loggedin_user}">
			            <button class="btn-1" onclick="deleteUpdate(${update.update_seq})">삭제하기</button>
			        </c:if>
			    	</div>
			    </div>
			    
			    <div class="content">${update.content}</div>
			

				<div class="bottom">
					<div>
					<%
					if (loggedInUserId != 0) {
					%>       
					    <div>
					    <i id="heartIcon_${update.update_seq}" class="${update.likedByCurrentUser ? 'fa fa-heart' : 'fa fa-heart-o'}" 
					    aria-hidden="true" style="${update.likedByCurrentUser ? 'color: red;' : ''}" onclick="likePost(${update.update_seq})"></i>
					    <span id="like_${update.update_seq}"></span>
					    </div>
					    <%
					}
					
					%>
					</div>
					<div>
					<c:if test="${userIsFunding}">
					    <a href="#" onclick="toggleCommentForm(event, ${update.update_seq})">댓글달기</a>
					</c:if>
					</div>
				</div>
				
				</div>
					
				<div  class="comm-write-textarea" id="commentForm_${update.update_seq}" style="display: none;">
		            <div><textarea id="commentText_${update.update_seq}" rows="4" cols="50"></textarea> </div>
		            <div><button class="btn-1" onclick="submitComment(${update.update_seq})">댓글 등록</button></div>
		        </div>		
		        
				<div class="sub-comment" id="comments_${update.update_seq}">
				</div>
		
		        
		    
		        
		    </div>
		    
		    </hr>
		
		</c:forEach>
    </c:otherwise>
</c:choose>




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
                var currentUrl = window.location.href;
             	var strippedUrl = currentUrl.split('?')[0];
             	window.location.href = strippedUrl + "?category=update";
                
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
                var currentUrl = window.location.href;
             	var strippedUrl = currentUrl.split('?')[0];
             	window.location.href = strippedUrl + "?category=update";
            },
            error: function(error) {
                console.error('댓글 전송 중 오류가 발생했습니다:', error);
            }
        });
    }

    var loggedInUser = {
            id: '<%= request.getAttribute("loggedin_user") %>',
        };
    function deleteComment(comment_id) {
        var confirmDelete = confirm('정말로 삭제하시겠습니까?');

        if (confirmDelete) {
            console.log('삭제진행 ㄱㄱ');

    		
            $.ajax({
                type: 'POST',
                url: '/delete_update_reply',
                data: { update_reply_seq: comment_id },
                success: function(response) {
                    console.log('삭제 성공:', response);
                    var currentUrl = window.location.href;
                 	var strippedUrl = currentUrl.split('?')[0];
                 	window.location.href = strippedUrl + "?category=update";
                    
                },
                error: function(error) {
                    console.error('삭제 실패:', error);
                }
            });

        } else {
            console.log('삭제가 실패함');
        }
    }
    function loadComments(updateSeq) {
        $.ajax({
            type: 'GET',
            url: '/getComments',
            data: { updateSeq: updateSeq },
            success: function (comments) {
                var commentsDiv = $('#comments_' + updateSeq);
                commentsDiv.empty();
                
                var loggedInUserId = loggedInUser.id;

                
                $.each(comments, function (index, comment) {
                	var commentTime = new Date(comment.time);
                	var year = commentTime.getFullYear();
                	var month = (commentTime.getMonth() + 1).toString().padStart(2, '0'); // Add 1 to month as it is zero-indexed
                	var day = commentTime.getDate().toString().padStart(2, '0');
                	var formattedTime = year + '-' + month + '-' + day;
                	
                	var commentHtml = '<div class="update_post_box"><div class="header"><div>' + comment.member.nickname + ' | ' +
                	formattedTime  + '</div>';
	
	                if (comment.member_seq == loggedInUserId) {
	                    commentHtml += '<div><button class="btn-1" onclick="deleteComment(' + comment.update_reply_seq + ')">삭제하기</button></div>';
	                }
	
	                commentHtml += '</div>';
	                commentHtml += '<div class="content">'+ comment.content +'</div></div>';
	
	                commentsDiv.append(commentHtml);
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