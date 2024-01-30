<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project Community</title>
  <style>
  #com_box{
  border:solid 1px black;
  }
  </style>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
 <script>
    function updateCharacterCount() {
      var content = document.getElementById("comment_text").value;
      var maxLength = 1000;
      var currentLength = content.length;
      var remainingLength = maxLength - currentLength;
      document.getElementById("character_count").innerText = remainingLength;
      if (remainingLength < 0) {
        document.getElementById("comment_text").value = content.slice(0, maxLength);
        document.getElementById("character_count").innerText = 0;
      }
    }
  </script>
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
<section class="community-section">
    <h2>프로젝트 커뮤니티</h2>
    

    <div class="post">
        <p>프로젝트 번호: ${projects.project_seq }</p>
        <p>프로젝트 내용: ${projects.content }</p>
        <p>목표 금액: ${projects.goal_price }</p>
        
        <p></p>
    </div>
    <hr>
    

     <form action="/community_post" method="POST" onsubmit="return validateForm()">
    <div>
      <input type="radio" name="post_category" value="cheer" checked>응원글
      <input type="radio" name="post_category" value="feedback">의견
    </div>
    <label for="comment_text">댓글:</label><br>
    <input type="hidden" name="post_id" value="${projects.project_seq}">
    <textarea id="comment_text" name="content" rows="4" cols="50" oninput="updateCharacterCount()"></textarea><br>
    <span id="character_count">1000</span>자 남음<br><br>
    <input type="submit" value="등록">
  </form>
	<c:forEach var="community" items="${community_posts}">
		<p>작성자: ${community.member_seq}</p>
		<p>날짜: ${community.date}</p>
	    <p>내용: ${community.content}</p>
	    
	    
	    <a href="#" onclick="toggleCommentForm(event, ${community.pro_board_seq})">댓글달기</a>
 
	    <div id="comments_${community.pro_board_seq}"></div>
	    
	    <div id="commentForm_${community.pro_board_seq}" style="display: none;">
            <textarea id="commentText_${community.pro_board_seq}" rows="4" cols="50"></textarea> 
            <button onclick="submitComment(${community.pro_board_seq})">댓글 등록</button>
        </div>
		
			<hr>
	</c:forEach>
</section>

<script>
function toggleCommentForm(event, board_seq) {
    event.preventDefault();

    var commentForm = document.getElementById("commentForm_" + board_seq);
    if (commentForm.style.display === "none") {
        commentForm.style.display = "block";
    } else {
        commentForm.style.display = "none";
    }
}
function submitComment(board_seq) {
    var commentText = $('#commentText_' + board_seq).val();

    var data = {
        comment: commentText,
        board_seq: board_seq
    };

    $.ajax({
        type: 'POST',
        url: '/communtiy_comment',
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
function loadComments(board_seq) {
    $.ajax({
        type: 'GET',
        url: '/getCommComments',
        data: { board_seq: board_seq },
        success: function (comments) {
            var commentsDiv = $('#comments_' + board_seq);
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

<c:forEach var="community" items="${community_posts}">
    loadComments(${community.pro_board_seq});
</c:forEach>
</script>

</body>
</html>