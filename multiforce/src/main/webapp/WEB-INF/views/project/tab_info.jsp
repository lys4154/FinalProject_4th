<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    li {
      list-style: none;
    }

    img {
      width: 200px;
      height: 200px;
    }

    .real-upload {
      display: none;
    }

    .upload {
      width: 200px;
      height: 200px;
      background-color: antiquewhite;
    }

    .image-preview {
      width: 200px;
      height: 200px;
      background-color: aquamarine;
      display: flex;
      gap: 20px;
    }
  </style>
</head>
<body>
<h1>프로젝트 정보</h1>
<!-- header -->
<hr>
<div class="contents">
	<div class="planContents">
		<div class="projectItem_itemDesign">
			<dl class="projectItem_infoDescription">
				프로젝트의 카테고리를 선택해주세요.
			</dl>
		</div>
	</div>
	
	<div class="projectForms">
		<div class="projectForms_style">
			<div class="projectForms_selectCategory">
				<select id="category">
					<option value="book">책</option>
					<option value="game">게임</option>
					<option value="perfume">향수</option>
				</select>
			</div>
		</div>
	</div>
	<hr width=100%>
	
	<div class="contentsTitle">
		<div class="projectTitle_titleDesign">
			<dl class="projectTitle_titleDescription">
				프로젝트의 이름을 작성해주세요. 
				<br>
				<input type="text" id="long_title">
				<br>
				프로젝트의 짧은 이름을 작성해주세요.
				<br>
				<input type="text" id="short_title">
			</dl>
		</div>
	</div>
	<hr>
	
	<div class="contentsSummary">
		<div class="projectSummary_titleDesign"> 
			<dl class="projectSummary_titleDescription">
				프로젝트를 요약해 주세요
				<br>
				<textarea cols="50" rows="10" id="sub_title"></textarea>
			</dl>
		</div>
	</div>
	<hr>
	
	<div class="contentsImage">
		<div class="projectImage_titleDesign">
			<dl class="projectImage_titleDescription">
				프로젝트 대표 이미지를 올려주세요
				<br>
				<input type="file" class="real-upload" accept="image/*" id="main_images_url">
				<div class="upload"></div>
				<br>
				이미지 미리보기
				<ul class="image-preview"></ul>
			</dl>
		</div>
	</div>
	<hr>
	
	<div class="projectUrl">
		<div class="projectUrl_titleDesign">
			<dl class="projectUrl_titleDescription">
				프로젝트에 사용할 URL을 작성해주세요
				<br>
				<input type="text" id="url">
			</dl>
		</div>
	</div>
	<hr>
</div>
<!-- footer -->

<script> // 이미지 관련 스크립트
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
  </script>

</body>
</html>