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
    <h2>������Ʈ Ŀ�´�Ƽ</h2>
    

    <div class="post">
        <h3>�Ŀ��� �����մϴ�!</h3>
        <p>�ȳ��ϼ���! ���� ������Ʈ�� ���� ���ɰ� �Ŀ� ��Ź�帳�ϴ�.</p>
        </br>
        <span class="comment">����1: ���� ������Ʈ����! ��������!</span></br>
        <span class="comment">����2: �Ŀ��߽��ϴ�. ���˴ϴ�!</span></br>
    </div>
    

    <form action="/cs_comment" method="POST">
    <label for="comment_text">���:</label><br>
    <input type="hidden" name="post_id" value="${board.help_ask_seq}">
    <textarea id="comment_text" name="comment" rows="4" cols="50"></textarea><br><br>
    <input type="submit" value="��� �ۼ�">
</form>

</section>
</body>
</html>