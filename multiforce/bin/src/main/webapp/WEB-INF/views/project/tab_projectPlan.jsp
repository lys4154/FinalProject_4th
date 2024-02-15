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
	/* toolbar: [
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
	lang:"ko-KR" */
	width:1000,
	height: 500,                 // 에디터 높이
	minHeight: 500,             // 최소 높이
	maxHeight: 500,             // 최대 높이
	focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
	lang: "ko-KR",					// 한글 설정
	placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
	callbacks: {	//여기 부분이 이미지를 첨부하는 부분
		onImageUpload : function(files) {
			uploadImageFile(files[0], this);
		},
		onPaste: function (e) {
			var clipboardData = e.originalEvent.clipboardData;
			if (clipboardData && clipboardData.items && clipboardData.items.length) {
				var item = clipboardData.items[0];
				if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
					e.preventDefault();
				}
			}
		}
	}
});
function uploadImageFile(file, editor) {
	data = new FormData();
	data.append("file", file);
	data.append("path", "C:\\fullstack\\workspace_springboot\\images\\notices\\");
	data.append("url", "/noticesimages/");
	$.ajax({
		data : data,
		type : "POST",
		url : "/uploadSummernoteImageFile",
		contentType : false,
		processData : false,
		success : function(data) {
        	//항상 업로드된 파일의 url이 있어야 한다.
			$(editor).summernote('insertImage', data.url);
		}
	});
}
</script>
<hr>

<h2>프로젝트 일정</h2>
<dl>작업 일정을 구체적인 날짜와 작성해주세요.</dl>
<div class="container">
	<textarea class="planning" name="planEditor" id="planning"></textarea>
</div>
<script>
$('.planning').summernote({
	width:1000,
	height: 500,                 // 에디터 높이
	minHeight: 500,             // 최소 높이
	maxHeight: 500,             // 최대 높이
	focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
	lang: "ko-KR",					// 한글 설정
	placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
	callbacks: {	//여기 부분이 이미지를 첨부하는 부분
		onImageUpload : function(files) {
			uploadImageFile(files[0], this);
		},
		onPaste: function (e) {
			var clipboardData = e.originalEvent.clipboardData;
			if (clipboardData && clipboardData.items && clipboardData.items.length) {
				var item = clipboardData.items[0];
				if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
					e.preventDefault();
				}
			}
		}
	}
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
	width:1000,
	height: 500,                 // 에디터 높이
	minHeight: 500,             // 최소 높이
	maxHeight: 500,             // 최대 높이
	focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
	lang: "ko-KR",					// 한글 설정
	placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
	callbacks: {	//여기 부분이 이미지를 첨부하는 부분
		onImageUpload : function(files) {
			uploadImageFile(files[0], this);
		},
		onPaste: function (e) {
			var clipboardData = e.originalEvent.clipboardData;
			if (clipboardData && clipboardData.items && clipboardData.items.length) {
				var item = clipboardData.items[0];
				if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
					e.preventDefault();
				}
			}
		}
	}
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
	width:1000,
	height: 500,                 // 에디터 높이
	minHeight: 500,             // 최소 높이
	maxHeight: 500,             // 최대 높이
	focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
	lang: "ko-KR",					// 한글 설정
	placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
	callbacks: {	//여기 부분이 이미지를 첨부하는 부분
		onImageUpload : function(files) {
			uploadImageFile(files[0], this);
		},
		onPaste: function (e) {
			var clipboardData = e.originalEvent.clipboardData;
			if (clipboardData && clipboardData.items && clipboardData.items.length) {
				var item = clipboardData.items[0];
				if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
					e.preventDefault();
				}
			}
		}
	}
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
	width:1000,
	height: 500,                 // 에디터 높이
	minHeight: 500,             // 최소 높이
	maxHeight: 500,             // 최대 높이
	focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
	lang: "ko-KR",					// 한글 설정
	placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
	callbacks: {	//여기 부분이 이미지를 첨부하는 부분
		onImageUpload : function(files) {
			uploadImageFile(files[0], this);
		},
		onPaste: function (e) {
			var clipboardData = e.originalEvent.clipboardData;
			if (clipboardData && clipboardData.items && clipboardData.items.length) {
				var item = clipboardData.items[0];
				if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
					e.preventDefault();
				}
			}
		}
	}
});
</script>
<br>
<input type="button" id="saveProjectPlan" value="저장하기">
</form>
</body>
</html>