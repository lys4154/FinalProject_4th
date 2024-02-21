<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="project.code.ProjectCategory"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<div id="write">
<li class="writeMessage">작성중이던 프로젝트가 있어요</li>
<div id="showWrite"></div>
</div>
<br>
<div id="newCategory">
<h2>계획중인 프로젝트를 알려주세요</h2>
<li class="newMessage">나중에 변경 가능합니다.</li>
	<div class="contents">
		<div class="projectForms">
			<div class="projectForms_style">
				<div class="projectForms_selectCategory">
					<div class="category" id="category_list_select">
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
	</div>
	
	<div id="newIntro">
	<h2>프로젝트를 간단하게 소개해주세요.</h2>
	<li class="simpleIntro">나중에 수정 가능하니 편하게 입력해주세요.</li>
	<textarea cols="50" rows="10" id="newSummary" placeholder="프로젝트 요약"></textarea>
	</div>
</div>
</body>
</html>