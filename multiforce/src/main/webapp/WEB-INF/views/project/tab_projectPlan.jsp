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
<script>
		$(document).ready(function() {
		    // Button click event
		    $("#saveProjectPlan").click(function() {
		        // Get form data
		        var formData = {
		        		purpose: $("#purpose").val(),
		        		planning: $("#planning").val(),
		        		budget: $("#budget").val(),
		        		team_introduce: $("#team_introduce").val(),
		        		item_introduce: $("#item_introduce").val()
		        };
		
		        // AJAX request
		        $.ajax({
		            type: "POST",
		            url: "/saveProjectPlan",  // Replace with your server endpoint
		            contentType: "application/json",
		            data: JSON.stringify(formData),
		            success: function(response) {
		            	alert("저장되었습니다.");
		                console.log("Success:", response);
		            },
		            error: function(error) {
		            	alert("실패하였습니다.");
		                console.error("Error:", error);
		            }
		        });
		    });
		});
</script>
</head>
<body>
<form action="/projectPlan" id="projectPlan">
<h1>프로젝트 계획</h1>
<br>

<h2>프로젝트 목적</h2>
<dl>어떤 프로젝트인지 설명해주세요.</dl>
<div class="container">
	<textarea class="purpose" name="purposeEditor" id="purpose"></textarea>
</div>
<script>
$('.purpose').summernote({
	toolbar: [
	    // [groupName, [list of button]]
	    ['style', ['bold', 'italic', 'underline', 'clear']],
	    ['font', ['strikethrough', 'superscript', 'subscript']],
	    ['fontsize', ['fontsize']],
	    ['color', ['color']],
	    ['para', ['ul', 'ol', 'paragraph']],
	    ['insert',['picture','link','video']],
	    ['height', ['height']]
	  ],
	height:500,  
	lang:"ko-KR"
});
</script>
<hr>

<h2>프로젝트 일정</h2>
<dl>작업 일정을 구체적인 날짜와 작성해주세요.</dl>
<div class="container">
	<textarea class="planning" name="planEditor" id="planning"></textarea>
</div>
<script>
$('.planning').summernote({
	toolbar: [
	    // [groupName, [list of button]]
	    ['style', ['bold', 'italic', 'underline', 'clear']],
	    ['font', ['strikethrough', 'superscript', 'subscript']],
	    ['fontsize', ['fontsize']],
	    ['color', ['color']],
	    ['para', ['ul', 'ol', 'paragraph']],
	    ['insert',['picture','link','video']],
	    ['height', ['height']]
	  ],
	height:500,  
	lang:"ko-KR"
});
</script>
<hr>

<h2>프로젝트 예산</h2>
<dl>후원 금액을 어떻게 사용할 것인지 작성해주세요.</dl>
<div class="container">
	<textarea class="budget" name="budgetEditor" id="budget"></textarea>
</div>
<script>
$('.budget').summernote({
	toolbar: [
	    // [groupName, [list of button]]
	    ['style', ['bold', 'italic', 'underline', 'clear']],
	    ['font', ['strikethrough', 'superscript', 'subscript']],
	    ['fontsize', ['fontsize']],
	    ['color', ['color']],
	    ['para', ['ul', 'ol', 'paragraph']],
	    ['insert',['picture','link','video']],
	    ['height', ['height']]
	  ],
	height:500,  
	lang:"ko-KR"
});
</script>
<hr>

<h2>프로젝트 팀 소개</h2>
<dl>프로젝트를 진행하는 팀에 대해서 소개해주세요.</dl>
<div class="container">
	<textarea class="introduce" name="introduceEditor" id="team_introduce"></textarea>
</div>
<script>
$('.introduce').summernote({
	toolbar: [
	    // [groupName, [list of button]]
	    ['style', ['bold', 'italic', 'underline', 'clear']],
	    ['font', ['strikethrough', 'superscript', 'subscript']],
	    ['fontsize', ['fontsize']],
	    ['color', ['color']],
	    ['para', ['ul', 'ol', 'paragraph']],
	    ['insert',['picture','link','video']],
	    ['height', ['height']]
	  ],
	height:500,  
	lang:"ko-KR"
});
</script>
<hr>

<h2>선물 설명</h2>
<dl>후원 금액별로 받을 수 있는 선물을 설명해주세요.</dl>
<div class="container">
	<textarea class="item" name="itemEditor" id="item_introduce"></textarea>
</div>
<script>
$('.item').summernote({
	toolbar: [
	    // [groupName, [list of button]]
	    ['style', ['bold', 'italic', 'underline', 'clear']],
	    ['font', ['strikethrough', 'superscript', 'subscript']],
	    ['fontsize', ['fontsize']],
	    ['color', ['color']],
	    ['para', ['ul', 'ol', 'paragraph']],
	    ['insert',['picture','link','video']],
	    ['height', ['height']]
	  ],
	height:500,  
	lang:"ko-KR"
});
</script>
<br>
<input type="button" id="saveProjectPlan" value="저장하기">
</form>
</body>
</html>