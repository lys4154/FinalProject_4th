<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="/WEB-INF/views/common/header.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.7.1.min.js"></script>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
</head>
<body>
<h1>프로젝트 계획</h1>
<br>
<div class="container">
	<textarea class="summernote" name="editordata"></textarea>
</div>
<script>
$('.summernote').summernote({
	toolbar: [
	    // [groupName, [list of button]]
	    ['style', ['bold', 'italic', 'underline', 'clear']],
	    ['font', ['strikethrough', 'superscript', 'subscript']],
	    ['fontsize', ['fontsize']],
	    ['color', ['color']],
	    ['para', ['ul', 'ol', 'paragraph']],
	    ['height', ['height']]
	  ],
	lang:"ko-KR"
});
</script>
<h2>프로젝트 목적</h2>
<hr>
<h2>프로젝트 일정</h2>
<hr>
<h2>프로젝트 팀 소개</h2>
</body>
</html>