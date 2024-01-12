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
    <h2>������Ʈ Ŀ�´�Ƽ</h2>
    

    <div class="post">
        <p>������Ʈ ��ȣ: ${projects.project_seq }</p>
        <p>������Ʈ ����: ${projects.content }</p>
        <p>��ǥ �ݾ�: ${projects.goal_price }</p>
        
        <p></p>
    </div>
    <hr>
    

     <form action="/community_post" method="POST">
    <div>
      <input type="radio" name="post_category" value="cheer" checked>������
      <input type="radio" name="post_category" value="feedback">�ǰ�
    </div>
    <label for="comment_text">���:</label><br>
    <input type="hidden" name="post_id" value="${projects.project_seq}">
    <textarea id="comment_text" name="content" rows="4" cols="50" oninput="updateCharacterCount()"></textarea><br>
    <span id="character_count">1000</span>�� ����<br><br>
    <input type="submit" value="���">
  </form>

</section>
</body>
</html>