<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/board/main.css">
<link rel="stylesheet" type="text/css" href="/css/board/approval_page.css">
<title>프로젝트 미리보기</title>
</head>
<body>

<table class="preview_table">
	<tr>
        <th>대표 이미지</th>
        <td style="text-align:center">
        <img src="https://ichef.bbci.co.uk/news/976/cpsprodpb/14F78/production/_127908858_gettyimages-129920589.jpg.webp" class="preview_img">
        <!-- <img src="${project.main_images_url}" class="preview_img"> -->
        </td>
    </tr>
    <tr>
        <th>프로젝트 번호</th>
        <td>${project.project_seq}</td>
    </tr>
    <tr>
        <th>프로젝트 관리자</th>
        <td>${member_nickname.nickname}</td>
    </tr>
   
    <tr>
        <th>목표금액</th>
        <td>${project.goal_price}</td>
    </tr>

    <tr>
        <th>프로젝트 시작날짜</th>
        <td>${project.start_date}</td>
    </tr>
    <tr>
        <th>프로젝트 종료날짜</th>
        <td>${project.due_date}</td>
    </tr>
    <tr>
        <th>긴 제목</th>
        <td>${project.long_title}</td>
    </tr>
    <tr>
        <th>짧은 제목</th>
        <td>${project.short_title}</td>
    </tr>
    <tr>
        <th>프로젝트 요약</th>
        <td>${project.sub_title}</td>
    </tr>
    <tr>
        <th>페이지 주소</th>
        <td>${project.url}</td>
    </tr>
    <tr>
        <th>분류</th>
        <td>${project.category}</td>
    </tr>

    <tr>
        <th>입금 계좌</th>
        <td>${project.account}</td>
    </tr>
    
    <tr>
        <th>프로젝트 계획</th>
        <td class="preview_content">${project.content}</td>
    </tr>
 
</table>


</body>
</html>