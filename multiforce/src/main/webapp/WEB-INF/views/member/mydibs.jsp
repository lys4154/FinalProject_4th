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
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
</head>

<!-- 프로젝트 리스트를 렌더링할 Handlebars 템플릿 정의 -->
<script id="project-template" type="text/x-handlebars-template">
    {{#if projects.length}}
        {{#each projects}}
            <div>
                <a href="{{url}}">
                    <div><img src="{{main_images_url}}" alt="Project Image"></div>
                </a>
                <div>{{category}}</div>
                <a href="{{url}}">
                    <div>{{long_title}}</div>
                </a>
                <div>{{sub_title}}</div>
                <div>
                    <!-- 달성률 출력 -->
                    <span class="achievement-rate" data-achievement-rate="{{calculateAchievementRate goal_price collection_amount}}">
                        {{calculateAchievementRateText goal_price collection_amount}}
                    </span>
                    <span>{{collection_amount}}</span>                
                    <!-- 날짜 차이 출력 -->
                    <span class="due-date-diff" data-due-date="{{due_date}}">
                        {{calculateDueDateDiffText due_date}}
                    </span>
                </div>
                <div>
                    <input type="button" class="cancel_btn" value="관심 취소" data-project_seq="{{project_seq}}" data-member_seq="${memberSeq}">        
                </div>
            </div>
            <hr>
        {{/each}}
    {{else}}
        <div>
            조건에 맞는 관심 프로젝트가 없습니다.
        </div>
    {{/if}}
</script>

<!-- Handlebars.js 헬퍼 함수 정의 -->
<script>
    Handlebars.registerHelper('calculateAchievementRate', function(goalPrice, collectionAmount) {
        return Math.floor((collectionAmount / goalPrice) * 100);
    });

    Handlebars.registerHelper('calculateAchievementRateText', function(goalPrice, collectionAmount) {
        return Math.floor((collectionAmount / goalPrice) * 100) + "%";
    });

    Handlebars.registerHelper('calculateDueDateDiffText', function(dueDate) {
        var dueDateObj = new Date(dueDate);
        var currentDate = new Date();
        var timeDiff = dueDateObj.getTime() - currentDate.getTime();
        var daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));

        return (daysDiff >= 0) ? "종료까지 " + daysDiff + "일 남음" : "펀딩 종료";
    });
</script>


<script>
$(document).ready(function() {	
	
	
	//진행중
    $("#ongoing").click(function() {
        var projectSeqArray = [];	// 각 프로젝트의 번호를 배열에 추가
        
        <c:forEach var="project" items="${myDibs}">
            projectSeqArray.push(${project.project_seq});
        </c:forEach>

        $.ajax({
            type: "POST",
            url: "/getDibsOngoing",
            contentType: "application/json",
            data: JSON.stringify(projectSeqArray),
            success: function(response) {
                console.log(response);

                var templateSource = $("#project-template").html();
                var template = Handlebars.compile(templateSource);

                var context = { projects: response };
                var html = template(context);

                $(".result").html(html);
            },
            error: function(error) {
                console.log(error);
            }
        });
    });
    
    
 	//종료된
    $("#end").click(function() {
        var projectSeqArray = [];	// 각 프로젝트의 번호를 배열에 추가
        
        <c:forEach var="project" items="${myDibs}">
            projectSeqArray.push(${project.project_seq});
        </c:forEach>

        $.ajax({
            type: "POST",
            url: "/getDibsEnd",
            contentType: "application/json",
            data: JSON.stringify(projectSeqArray),
            success: function(response) {
                console.log(response);

                var templateSource = $("#project-template").html();
                var template = Handlebars.compile(templateSource);

                var context = { projects: response };
                var html = template(context);

                $(".result").html(html);
            },
            error: function(error) {
                console.log(error);
            }
        });
    });
    
    
    
    //관심 취소
    $(".cancel_btn").click(function() {
        var projectSeq = $(this).data("project_seq");
        var memberSeq = $(this).data("member_seq");
        
        if(confirm("확인을 누르면 관심 프로젝트에서 삭제됩니다.") == true) {
	        $.ajax({
	            type: "POST",
	            url: "/dibsCancel",
	            data: {
	                "projectSeq" : projectSeq,
	                "memberSeq": memberSeq
	            },
	            success: function(response) {
	                console.log(response);
	                alert("삭제되었습니다.");
	                window.location.href ="/mydibs"
	            },
	            error: function(error) {
	                console.log(error);
	            }
	        });
        }
    });
    
    
    
	

})
</script>


<body>

<h1>관심 프로젝트</h1>

<div>
	<div>
		<div id="all" style="cursor:pointer;"><a href="/mydibs" >전체</a></div>
		<div id="ongoing" style="cursor:pointer;">진행중</div>
		<div id="end" style="cursor:pointer;">종료된</div>	
	</div>
	
	<p>

	<div>
		<div class="result">
			<c:choose>
	            <c:when test="${empty myDibs}">
	                <div>관심 프로젝트가 없습니다.</div>
	            </c:when>
	            <c:otherwise>
		            <c:forEach var="project" items="${myDibs}">
		                <div>
		                	<a href="${project.url}">
		                    	<div><img src="${project.main_images_url}" alt="Project Image"></div>
		                    </a>
		                    <div> ${project.category}</div>
		                    <a href="${project.url}">
		                    	<div> ${project.long_title}</div>
		                    </a>
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
					                    var dueDateDiffText = (daysDiff >= 0) ? daysDiff + "일 남음" : "펀딩 종료";
					                    $("#dueDateDiff-${project.project_seq}").text(dueDateDiffText);
					                });
					            </script>
		                    	
		                    	<span id="dueDateDiff-${project.project_seq}"></span>                    	
		                    </div>
		                    <div>
		                    	<input type="button" class="cancel_btn" value="관심 취소" data-project_seq="${project.project_seq}" data-member_seq="${memberSeq}">
		                    </div>
		                </div>
		                <hr>
		            </c:forEach>
				</c:otherwise>
			</c:choose>            
		</div>
	</div>
</div>

</body>
</html>