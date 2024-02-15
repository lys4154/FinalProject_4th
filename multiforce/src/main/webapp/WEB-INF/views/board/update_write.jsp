<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


	<script src="/js/summernote/summernote-lite.js"></script>
	<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
	<link rel="stylesheet" type="text/css" href="/css/board/edit_post.css">
	<link rel="stylesheet" type="text/css" href="/css/board/main.css">


    <title>업데이트 글쓰기</title>


<script>
    function validateForm() {
        var commentText = document.getElementById("contents").value.trim();

        if (commentText === "") {
            alert("글을 입력해주세요.");
            
            return false;
        }

        return true;
    }
    $(document).ready(function(){
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
    			data.append("path", "C:\\fullstack\\workspace_springboot\\images\\update\\");
    			data.append("url", "/updateimages/");
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
    });
   

</script>
</head>
<body>
    <div class="main-container">
        <h2>업데이트 글쓰기</h2>
        <div id="cs_menu_bar">
            
        </div>
     
        <form id="write_form" action="/update_write" method="POST" onsubmit="return validateForm()">
           

            <div class="write-content">
                <textarea name="contents" id="summernote" placeholder="내용"></textarea>
            </div>
            <div class="cs-submit-btn">
                <input class="btn-2" type="submit" value="업데이트 등록" name="submit">
            </div>
            <input type="hidden" name="project_seq" value="${project_seq }">
        </form>
    </div>
 


</body>
</html>
