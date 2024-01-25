<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 상세 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<section class="project-info">
    <h1>프로젝트 상세 정보</h1>
    <p>프로젝트 제목: ${project.short_title}</p>
    <p>모인 금액: ${project.collection_amount}</p>
    <p>목표 금액: ${project.goal_price}</p>
    <p>펀딩 기간: ${project.start_date} - ${project.due_date}</p>
    <p>프로젝트 소개: ${project.content}</p>
 
</section>
<a href="#" id="updateLink" data-project-id="${project.project_seq}">업데이트</a>
<a href="#" id="communityLink" data-project-id="${project.project_seq}">커뮤니티</a>
<hr>
<div id="content_container">
</div>
<script>
    $(document).ready(function () {

    	$("#updateLink").click();
    	
    	$("#communityLink").click(function (e) {
            e.preventDefault();
            var pid = $(this).data("project-id");
            var baseUrl = window.location.origin;
            loadContent(baseUrl + "/project_detail/community/"+pid);
        });


        $("#updateLink").click(function (e) {
            e.preventDefault();
            var pid = $(this).data("project-id");
            var baseUrl = window.location.origin;
            loadContent(baseUrl + "/update/view/"+pid); 
        });
        
        $("#updateLink").click();
        
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
</body>
</html>