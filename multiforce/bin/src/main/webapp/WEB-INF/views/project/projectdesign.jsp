<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
    .menu {
        display: flex;
        list-style: none;
        padding: 0;
    }
    .menu li {
        margin-right: 20px;
    }
    .active {
        display: block;
    }
    .inactive {
        display: none;
    }
</style>
</head>
<body>
<h1>프로젝트 기획</h1>
<div class="menuTab">
	<ul class="menu">
		<li class="tab_info">
			<a class href="tab_info">기본정보</a>
		</li>
		
		<li class="tab_fundingPlan">
			<a class href="tab_fundingPlan">펀딩 계획</a>
		</li>
		
		<li class="tab_gift">
			<a class href="tab_gift">상품 구성</a>
		</li>
		
		<li class="tab_projectPlan">
			<a class href="tab_projectPlan">기본정보</a>
		</li>
	</ul>
	<hr>
	 <!-- 각 탭에 해당하는 컨텐츠 영역 -->
    <div id="tab_info" class="content">
        기본정보 내용
    </div>
    <div id="tab_fundingPlan" class="content">
        펀딩 계획 내용
    </div>
    <div id="tab_gift" class="content">
        상품 구성 내용
    </div>
    <div id="tab_projectPlan" class="content">
        프로젝트 계획 내용
    </div>
</div>

</body>
</html>