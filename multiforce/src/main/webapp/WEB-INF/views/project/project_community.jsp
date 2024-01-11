<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project Community</title>
</head>
<body>
<section class="community-section">
    <h2>프로젝트 커뮤니티</h2>
    

    <div class="post">
        <h3>후원자 모집합니다!</h3>
        <p>안녕하세요! 저희 프로젝트에 많은 관심과 후원 부탁드립니다.</p>
        </br>
        <span class="comment">김찬1: 좋은 프로젝트에요! 힘내세요!</span></br>
        <span class="comment">김찬2: 후원했습니다. 기대됩니다!</span></br>
    </div>
    

    <form action="/cs_comment" method="POST">
    <label for="comment_text">댓글:</label><br>
    <input type="hidden" name="post_id" value="${board.help_ask_seq}">
    <textarea id="comment_text" name="comment" rows="4" cols="50"></textarea><br><br>
    <input type="submit" value="댓글 작성">
</form>

</section>
</body>
</html>