<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="/css/project/design.css">
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
			<a href="#" id="tab_info">기본정보</a>
		</li>
		
		<li class="tab_fundingPlan">
			<a href="#" id="tab_fundingPlan">펀딩 계획</a>
		</li>
		
		<li class="tab_gift">
			<a href="#" id="tab_gift">상품 구성</a>
		</li>
		
		<li class="tab_projectPlan">
			<a href="#" id="tab_projectPlan">프로젝트 계획</a>
		</li>
	</ul>
	<hr>
</div>

<div id="content_container">
</div>
<script>
    $(document).ready(function () {

    	$("#tab_info").click();
    	
    	$("#tab_info").click(function (e) {
            e.preventDefault();
            //var pid = $(this).data("project-id");
            var baseUrl = window.location.origin;
            loadContent(baseUrl + "/tab_info");
        });

    	/* $("#tab_fundingPlan").click();
    	
        $("#tab_fundingPlan").click(function (e) {
            e.preventDefault();
           // var pid = $(this).data("project-id");
            var baseUrl = window.location.origin;
            loadContent(baseUrl + "/tab_fundingPlan"); 
        }); */
        
		/* $("#tab_gift").click();
    	
        $("#tab_gift").click(function (e) {
            e.preventDefault();
           // var pid = $(this).data("project-id");
            var baseUrl = window.location.origin;
            loadContent(baseUrl + "/tab_gift"); 
        }); */
        
		$("#tab_projectPlan").click();
    	
        $("#tab_projectPlan").click(function (e) {
            e.preventDefault();
           // var pid = $(this).data("project-id");
            var baseUrl = window.location.origin;
            loadContent(baseUrl + "/tab_projectPlan"); 
        });
        
        
        function loadContent(url) {
        
            $.ajax({
                url: url,
                type: "GET",
                success: function (data) {

                    $("#content_container").html(data);
                },
                error: function (xhr, status, error) {
                    console.error("Error loading content:", error);
                }
            });
        }
    });
</script>
<hr>
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</html>