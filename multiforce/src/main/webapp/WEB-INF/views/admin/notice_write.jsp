<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.7.1.min.js"></script>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
<script>
let login_user_level = "${login_user_level}";
if(login_user_level != "2"){
	alert("잘못된 접근입니다");
	location.href = "/";
}

$(document).ready(function(){
	//수정인지 확인 및 값 채워넣기
	if("${dto.notice_seq}" != ""){
		$("#notice_form").attr("action","/notice/modify")
			.append("<input type='hidden' id='notice_seq' name='notice_seq'>");
		$("#notice_seq").val("${dto.notice_seq}");
		$("#title").val("${dto.title}");
		$("#summernote").val('${dto.content}');
		$("option[value='${dto.category}']").attr("selected", true);
		if("${dto.category}" == "event"){
			$("#event_priod").css("display","inline-block");
			$("#event_start_date").val("${dto.event_start_date}");
			$("#event_end_date").val("${dto.event_end_date}");
		}
		$("#write_btn").val("수정");
	}
	$("#title").focus();
	
	$('#summernote').summernote({
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
	
	
	$("#notice_category").on("change", function(){
		if($("#notice_category").val() == "event"){
			$("#event_priod").css("display","inline-block");
		}else{
			$("#event_priod").css("display","none");
		}
	});
	
	$("#event_start_date").on("change", eventStartCheck);
	function eventStartCheck(){
		if(new Date($("#event_start_date").val()) - Date.now() <= 0 || $("#event_start_date").val() == ""){
			alert("시작날짜를 다시 설정해주세요");
			return false;
		}else{
			return true;
		}
	}
	
	$("#event_end_date").on("change", eventEndCheck);
	function eventEndCheck(){
		if(new Date($("#event_end_date").val()) - Date.now() <= 0 ||
				new Date($("#event_end_date").val()) - new Date($("#event_start_date").val()) <= 0 ||
				$("#event_end_date").val() == ""){
			alert("종료 날짜를 다시 설정해주세요");
			return false;
		}else{
			return true;
		}
	}
	
	$("#write_btn").on("click",function(e){
		if($("#title").val() == "" || $("#title").val() == null){
			alert("제목을 입력해주세요");
			$("#title").focus();
			e.preventDefault();
		}else if($("#summernote").val() == null || $("#summernote").val() == ""){
			alert("내용을 입력해주세요");
			e.preventDefault();
		}else if($("#notice_category").val() == "event" && !eventStartCheck()){
			e.preventDefault();
		}else if($("#notice_category").val() == "event" && !eventEndCheck()){
			e.preventDefault();
		}
	});
	
});
</script>
<body>
<h1>공지사항 작성</h1>

<form id="notice_form" method="post" action="/notices/detail">
	<input type="text" id="title" name="title" placeholder="제목을 입력해주세요">
	<select id="notice_category" name="category">
		<option value="notice">공지사항</option>
		<option value="event">이벤트</option>
	</select>
	<div id="event_priod" style="display: none">
		이벤트 시작<input id="event_start_date" name="event_start_date" type="datetime-local">
		~ 
		이벤트 종료<input id="event_end_date" name="event_end_date" type="datetime-local">
	</div>
	<textarea id="summernote" name="content"></textarea>
	<input type="submit" id="write_btn" value="등록">
</form>
</body>
</html>