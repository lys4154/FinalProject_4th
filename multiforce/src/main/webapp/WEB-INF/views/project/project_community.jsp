<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project Community</title>
  <link rel="stylesheet" type="text/css" href="/css/project/update_and_community.css">
  <link rel="stylesheet" type="text/css" href="/css/board/main.css">
  <style>
  #com_box{
  border:solid 1px black;
  }
  </style>
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
  />
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

  <script>
    function validateForm() {
        var commentText = document.getElementById("comment_text").value.trim();

        if (commentText === "") {
            alert("댓글을 입력해주세요.");
            
            return false;
        }

        return true;
    }

</script>
</head>
<body>
<%
int loggedInUserId = 0;
int user_id = 0;
if(session.getAttribute("login_user_seq") != null){
	loggedInUserId = (int) session.getAttribute("login_user_seq");

	}
%>
<section class="community-section">
<c:choose>
    <c:when test="${empty community_posts}">
        <p class="update_empty">게시물이 없습니다.</p>
    </c:when>
</c:choose>
    
<c:if test="${userIsFunding}">
     <form class="comm-post-form" action="/community_post" method="POST" onsubmit="return validateForm()">
	    <div class="comm-radio">
	      <input type="radio" name="post_category" value="cheer" checked>응원글
	      <input type="radio" name="post_category" value="feedback">의견
	    </div>

	    <input type="hidden" name="post_id" value="${projects.project_seq}">
	    <textarea class="comm_post_ta" id="comment_text" name="content"></textarea><br>
	    <input class="btn-1" type="submit" value="등록">
	  </form>
</c:if>
	<c:forEach var="community" items="${community_posts}">
	
		<div class="update_post_box">
			<div class="header">
		    	<div>

		    	${community.nickname} | <fmt:formatDate value="${community.date}" pattern="yyyy-MM-dd" />
		    	</div>
		    	
		    	<div>
		    	 <c:if test="${community.member_seq eq loggedin_user}">
		            <button class="btn-1" onclick="deleteCommunity(${community.pro_board_seq})">삭제하기</button>
		        </c:if>
		    	</div>
		    </div>
		    
		    <div class="content">${community.content}</div>
		    
		    <div class="bottom">
		    	   <%
					if (loggedInUserId != 0) {
					%>       
					    <div>
					    <i id="heartIcon_${community.pro_board_seq}" class="${community.likedByCurrentUser ? 'fa fa-heart' : 'fa fa-heart-o'}" 
					    aria-hidden="true" style="${community.likedByCurrentUser ? 'color: red;' : ''}" onclick="likePost(${community.pro_board_seq})"></i>
					    <span id="like_${community.pro_board_seq}"></span>
					    </div>
					    <%
					}
					
					%>
		 		<c:if test="${userIsFunding}">
				     <a href="#" onclick="toggleCommentForm(event, ${community.pro_board_seq})">댓글달기</a>
				</c:if>
		    </div>
		    
		</div>
		

	    

 		<div class="comm-write-textarea" id="commentForm_${community.pro_board_seq}" style="display: none;">
            <textarea id="commentText_${community.pro_board_seq}" rows="4" cols="50"></textarea> 
            <button class="btn-1" onclick="submitComment(${community.pro_board_seq}, ${community.project_seq })">댓글 등록</button>
        </div>
        
	    <div class="sub-comment" id="comments_${community.pro_board_seq}">
	    </div>
	    
	    
		
			
	</c:forEach>
</section>

<script>
function deleteCommunity(pro_board_seq) {
    var confirmDelete = confirm('정말로 삭제하시겠습니까?');

    if (confirmDelete) {
        console.log('삭제진행 ㄱㄱ');

		
        $.ajax({
            type: 'POST',
            url: '/delete_community_post',
            data: { pro_board_seq: pro_board_seq},
            success: function(response) {
                console.log('삭제 성공:', response);
                var currentUrl = window.location.href;
             	var strippedUrl = currentUrl.split('?')[0];
             	window.location.href = strippedUrl + "?category=community";
                
            },
            error: function(error) {
                console.error('삭제 실패:', error);
            }
        });

    } else {
        console.log('삭제가 실패함');
    }
}
function toggleCommentForm(event, board_seq) {
    event.preventDefault();

    var commentForm = document.getElementById("commentForm_" + board_seq);
    if (commentForm.style.display === "none") {
        commentForm.style.display = "block";
    } else {
        commentForm.style.display = "none";
    }
}
function submitComment(board_seq, project_seq) {
    var commentText = $('#commentText_' + board_seq).val();

    var data = {
        comment: commentText,
        board_seq: board_seq,
        project_seq: project_seq
    };

    $.ajax({
        type: 'POST',
        url: '/communtiy_comment',
        data: data,
        success: function(response) {

            var currentUrl = window.location.href;
         	var strippedUrl = currentUrl.split('?')[0];
         	window.location.href = strippedUrl + "?category=community";
        },
        error: function(error) {
            console.error('댓글 전송 중 오류가 발생했습니다:', error);
        }
    });
}
function likePost(pro_board_seq) {
    $.ajax({
        type: 'POST',  
        url: '/toggleCommunityLike',  
        data: { pro_board_seq: pro_board_seq },
        success: function (response) {
  			
            console.log('게시물 좋아요 성공');
            updateIconStyle(pro_board_seq, response.likedByCurrentUser);
            getLikeCount(pro_board_seq);
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
    
function getLikeCount(pro_board_seq) {
    $.ajax({
        type: 'GET',
        url: '/getCommLikeCount',
        data: { pro_board_seq: pro_board_seq },
        success: function (count) {
            console.log('Updated Like Count:', count);
            $('#like_' + pro_board_seq).text(count);
        },
        error: function (error) {
            console.error('Error fetching updated like count:', error);
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
            url: '/delete_community_reply',
            data: { pro_board_seq: comment_id },
            success: function(response) {
                console.log('삭제 성공:', response);
                var currentUrl = window.location.href;
             	var strippedUrl = currentUrl.split('?')[0];
             	window.location.href = strippedUrl + "?category=community";
                
            },
            error: function(error) {
                console.error('삭제 실패:', error);
            }
        });

    } else {
        console.log('삭제가 실패함');
    }
}
function loadComments(board_seq) {
    $.ajax({
        type: 'GET',
        url: '/getCommComments',
        data: { board_seq: board_seq },
        success: function (comments) {
        	var commentsDiv = $('#comments_' + board_seq);
            commentsDiv.empty();
            
            var loggedInUserId = loggedInUser.id;

            
            $.each(comments, function (index, comment) {
            	var commentHtml = '<div class="update_post_box "><div class="header"><div> ' + comment.member.nickname + ' | ' +
            	formatDate(comment.date) + '</div>';

                if (comment.member_seq == loggedInUserId) {
                    commentHtml += '<div><button class="btn-1" onclick="deleteComment(' + comment.pro_board_seq + ')">삭제하기</button></div>';
                }

                commentHtml += '</div>';
                commentHtml += '<div class="content">'+comment.content+'</div></div>';

                commentsDiv.append(commentHtml);
            });
        },
        error: function (error) {
            console.error('Error fetching comments:', error);
        }
    });
}
function formatDate(date) {
    var formattedDate = new Date(date);
    var year = formattedDate.getFullYear();
    var month = (formattedDate.getMonth() + 1).toString().padStart(2, '0');
    var day = formattedDate.getDate().toString().padStart(2, '0');
    var formattedDateString = year + '-' + month + '-' + day;
    return formattedDateString;
}

<c:forEach var="community" items="${community_posts}">
	getLikeCount(${community.pro_board_seq});
    loadComments(${community.pro_board_seq});
</c:forEach>
</script>

</body>
</html>