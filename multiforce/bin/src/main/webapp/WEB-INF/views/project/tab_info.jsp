<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="project.code.ProjectCategory"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기본정보</title>
<script src="/js/jquery-3.7.1.min.js"></script>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    $(document).ready(function() {
    $("#submitBtn").click(function() {
        var data = {
            category: $("#project_category").val(),
            long_title: $("#long_title").val(),
            short_title: $("#short_title").val(),
            sub_title: $("#sub_title").val(),
            main_images_url: $("#main_images_url").val(),
            url : "/project_detail/" + $("#url").val(),
            start_date : $("#start_date").val(),
            due_date : $("#due_date").val(),
            goal_price : $("#goal_price").val()
        };
        console.log($("#category").val());

        // AJAX를 통해 서버에 JSON 형태의 데이터 전송
        $.ajax({
            type: "POST",
            url: "/saveProject",
            contentType: "application/json",  // JSON 형태로 데이터 전송
            data: JSON.stringify(data),  // 데이터를 JSON 문자열로 변환
            success: function(response) {
            	alert("성공하였습니다.");
                console.log(response);
            },
            error: function(error) {
            	alert("실패하였습니다.");
                console.error(error);
            }
        });
    });  
});
</script>
<style>

  </style>
</head>
<body>
<h1>프로젝트 정보</h1>
<h3>이 페이지에서 프로젝트의 기본 정보와 펀딩 계획을 작성해주세요</h3>
<!-- header -->
<hr>
<div class=project_info>
<form action="/saveProject" method="post">
<div class="contents">
	<div class="planContents">
		<div class="projectItem_itemDesign">
			<dl class="projectItem_infoDescription">
				<h2>프로젝트의 카테고리를 선택해주세요.</h2>
			</dl>
		</div>
	</div>
	
	<div class="projectForms">
		<div class="projectForms_style">
			<div class="projectForms_selectCategory">
			<div class="category" id="category_list">
				<select id="project_category">
					<%	for(ProjectCategory item : ProjectCategory.values()){ %>
				<option value="<%=item.getEngName()%>"><%=item.getKorName()%></option>
					<%}
					%>
				</select>				
		</div>
				
				
			</div>
		</div>
	</div>
	<hr width=100%>
	
	<div class="contentsTitle">
		<div class="projectTitle_titleDesign">
			<dl class="projectTitle_titleDescription">
				<h2>프로젝트의 이름을 작성해주세요.</h2> 
				<br>
				<input type="text" id="long_title">
				<br>
				<h2>프로젝트의 짧은 이름을 작성해주세요.</h2>
				<br>
				<input type="text" id="short_title">
			</dl>
		</div>
	</div>
	<hr>
	
	<div class="contentsSummary">
		<div class="projectSummary_titleDesign"> 
			<dl class="projectSummary_titleDescription">
				<h2>프로젝트를 요약해 주세요</h2>
				<br>
				<textarea cols="50" rows="10" id="sub_title"></textarea>
			</dl>
		</div>
	</div>
	<hr>
	
	<div class="contentsImage">
		<div class="projectImage_titleDesign">
			<dl class="projectImage_titleDescription">
			<h2>프로젝트 대표 이미지를 선택해주세요.</h2>
				<!-- <input type="file" class="real-upload" accept="image/*" id="main_images_url"> -->
				<textarea id="main_images_url" name="main_image"></textarea>
				
					<script>
					$(document).ready(function() {
					$('#main_images_url').summernote({
						width:200,
						toolbar: [
						    ['insert',['picture']]
						  ],
					    callbacks: {
					        onImageUpload : function(files) {
					            uploadImageFile(files[0], this);
					        },
					        
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
					            // 항상 업로드된 파일의 url이 있어야 한다.
					            $(editor).summernote('insertImage', data.url);
					            
					            var img = new Image();
					            img.src = data.url;
					            img.onload = function () {
					                var newHeight = img.height + 50; // 50은 여분의 여백
					                var newWidth = img.width;
					                $(editor).summernote('height', newHeight);
					                $(editor).summernote('width', newWidth);
					            };
					        }
					    });
					}
					});
			
				</script>
			
				<!-- 프로젝트 대표 이미지를 올려주세요
				<br>
				<input type="file" class="real-upload" accept="image/*" id="main_images_url">
				
				<div class="upload"></div>
				<br>
				이미지 미리보기
				<ul class="image-preview"></ul> -->
			</dl>
		</div>
	</div>
	<hr>
	
	<div class="projectUrl">
		<div class="projectUrl_titleDesign">
			<dl class="projectUrl_titleDescription">
				<h2>프로젝트에 사용할 URL을 작성해주세요</h2>
				<br>
				<input type="text" id="url" placeholder="/project_detail/">
			</dl>
		</div>
	</div>
	<hr>
</div>
</div>

<!-- footer -->

<!-- <script> // 이미지 관련 스크립트
    function getImageFiles(e) {
      const uploadFiles = [];
      const files = e.currentTarget.files;
      const imagePreview = document.querySelector('.image-preview');
      const docFrag = new DocumentFragment();

      // 파일 타입 검사
      [...files].forEach(file => {
        if (!file.type.match("image/.*")) {
          alert('이미지 파일만 업로드가 가능합니다.');
          return
        }

        // 파일 갯수 검사
        if ([...files].length < 7) {
          uploadFiles.push(file);
          const reader = new FileReader();
          reader.onload = (e) => {
            const preview = createElement(e, file);
            imagePreview.appendChild(preview);
          };
          reader.readAsDataURL(file);
        }
      });
    }

    function createElement(e, file) {
      const li = document.createElement('li');
      const img = document.createElement('img');
      img.setAttribute('src', e.target.result);
      img.setAttribute('data-file', file.name);
      li.appendChild(img);

      return li;
    }

    const realUpload = document.querySelector('.real-upload');
    const upload = document.querySelector('.upload');

    upload.addEventListener('click', () => realUpload.click());

    realUpload.addEventListener('change', getImageFiles);
  </script>  -->
<!-- tab_fundingPlan -->
<script>
function inputPrice(num) {
	if(isFinite(num.value) == false) {
		alert("목표금액은 숫자만 입력할 수 있습니다.");
		num.value = "";
		return false;
	}
}
</script>
 <h1>펀딩 계획</h1>
 
  <label for="start_date">시작일:</label>
  <input type="date" id="start_date" name="start_date"><br><br>
  
  <label for="due_date">마감일:</label>
  <input type="date" id="due_date" name="due_date"><br><br>
  
  <label for="goal_price">목표 금액:</label>
  <input type="text" id="goal_price" name="goal_price" onKeyup="inputPrice(this);"><br><br>
  <button type="button" id="submitBtn">저장</button>
  <!-- <button type="button" id="submitBtn">저장</button>  -->
</form>


</body>
</html>