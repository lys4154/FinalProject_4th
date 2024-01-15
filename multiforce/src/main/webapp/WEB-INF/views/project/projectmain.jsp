<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>프로젝트 메인페이지</h1>

<h2>프로젝트 정보</h2>
    <ul>
        <li>카테고리: ${dto.category}</li>
        <li>프로젝트 이름: ${dto.long_title}</li>
        <li>짧은 이름: ${dto.short_title}</li>
        <li>프로젝트 요약: ${dto.sub_title}</li>
        <li>대표 이미지 URL: ${dto.main_images_url}</li>
        <li>프로젝트 URL: ${dto.url}</li>
    </ul>
    
</body>
</html>