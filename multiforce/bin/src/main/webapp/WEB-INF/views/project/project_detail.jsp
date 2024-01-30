<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>������Ʈ �� ������</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<section class="project-info">
    <h1>������Ʈ �� ����</h1>
    <p>������Ʈ ����: ${project.short_title}</p>
    <p>���� �ݾ�: ${project.collection_amount}</p>
    <p>��ǥ �ݾ�: ${project.goal_price}</p>
    <p>�ݵ� �Ⱓ: ${project.start_date} - ${project.due_date}</p>
    <p>������Ʈ �Ұ�: ${project.content}</p>
 
</section>
<a href="#" id="updateLink" data-project-id="${project.project_seq}">������Ʈ</a>
<a href="#" id="communityLink" data-project-id="${project.project_seq}">Ŀ�´�Ƽ</a>
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