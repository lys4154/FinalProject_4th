<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>프로젝트 정보</h1>
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
</div>

</body>
</html>