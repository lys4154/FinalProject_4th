<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<script>
$(document).ready(function() {
	
    $("#ongoing").click(function() {
        var projectSeqArray = []; // 프로젝트 번호를 담을 배열

        // 각 프로젝트의 번호를 배열에 추가
        <c:forEach var="project" items="${myDibs}">
            projectSeqArray.push(${project.project_seq});
        </c:forEach>

        // Ajax 요청 보내기
        $.ajax({
            type: "POST",
            url: "/getDibsOngoing",
            contentType: "application/json"
            data: {projectSeqArray: projectSeqArray},
            success: function(response) {
                console.log(response); // 받은 JSON 데이터 확인
                $(".result").empty();
                if (response.length == 0) {
                    $(".result").append("<div> 진행중인 관심 프로젝트가 없습니다. </div>");
                } else {
                    for (var i = 0; i < response.length; i++) {
                        $(".result").append("<div>" + response[i].long_title + "</div>");
                    }
                }
            },
            error: function(error) {
                console.log(error);
                console.log(projectSeqArray);
            }
        });
    });//진행중

	

})
</script>


<body>

<h1>관심 프로젝트</h1>

<div>
	<div>
		<div id="all" style="cursor:pointer;">전체</div>
		<div id="ongoing" style="cursor:pointer;">진행중</div>
		<div id="end" style="cursor:pointer;">종료된</div>	
	</div>
	
	<p>
		
	<div>
		<div id="add" style="cursor:pointer;">추가순</div>
		<div id="deadline" style="cursor:pointer;">마감 임박순</div>
	</div>
	
	<p>
	
	<div>
		<div id="result">
		
            <c:forEach var="project" items="${myDibs}">
                <div>
                    <div><img src="${project.main_images_url}" alt="Project Image"></div>
                    <div> ${project.category}</div>
                    <div> ${project.long_title}</div>
                    <div> ${project.sub_title}</div>
                    <div>
                    	<!-- 반복문 안에서 달성률 -->
				        <script>
				            $(document).ready(function() {				                
				                var goalPrice = ${project.goal_price};
				                var collectionAmount = ${project.collection_amount};
				                
				                var achievementRate = Math.floor((collectionAmount / goalPrice) * 100);
				                
				                // 달성률 출력
				                var achievementText = achievementRate + "%";
				                $("#achievementRate-${project.project_seq}").text(achievementText);
				            });
				        </script>         
                    
                    	<span id="achievementRate-${project.project_seq}"></span>
                    	<span> ${project.collection_amount} </span>
                    	
                    	<!-- 반복문 안에서 날짜 차이  -->
			            <script>
			                $(document).ready(function() {
			                    var dueDate = new Date("${project.due_date}");
			                    var currentDate = new Date();
			
			                    var timeDiff = dueDate.getTime() - currentDate.getTime();
			                    var daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24)); // 일 단위로 변환
			
			                    // 차이 출력
			                    var dueDateDiffText = (daysDiff >= 0) ? "종료까지 " + daysDiff + "일 남음" : "펀딩 종료";
			                    $("#dueDateDiff-${project.project_seq}").text(dueDateDiffText);
			                });
			            </script>
                    	
                    	<span id="dueDateDiff-${project.project_seq}"></span>                    	
                    </div>
                </div>
                <hr>
            </c:forEach>
            
		</div>
	</div>
</div>

</body>
</html>