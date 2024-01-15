<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project Community</title>
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
    

     <form action="/community_post" method="POST">
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

</section>
</body>
</html>