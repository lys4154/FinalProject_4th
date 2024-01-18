<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/js/jquery-3.7.1.min.js"></script>
<title>ProjectMain</title>
</head>
<body>
<h1>프로젝트 메인페이지</h1>

<div id="projectInfo">



</div>


<script>
        $(document).ready(function() {
            // 페이지 로드 시 서버에서 프로젝트 정보를 가져와서 표시
            $.ajax({
                type: "GET",
                url: "/getProjectInfo",  // 실제로는 해당 URL을 서버에서 제공해야 함
                success: function(response) {
                    // 서버에서 받은 데이터를 동적으로 화면에 표시
                    $("#projectInfo").html(response);
                },
                error: function(error) {
                    console.error(error);
                }
            });
        });
    </script>    
</body>
</html>