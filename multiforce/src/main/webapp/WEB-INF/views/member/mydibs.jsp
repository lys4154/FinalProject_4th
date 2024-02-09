<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="project.dto.ProjectMemberDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<link rel="stylesheet" href="/css/member/mydibs.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
</head>

<!-- 프로젝트 리스트를 렌더링할 Handlebars 템플릿 정의 -->
<script id="project-template" type="text/x-handlebars-template">
<div class=out_container>
    {{#if projects.length}}
        {{#each projects}}
            <div class="container">
                <a href="{{url}}">
                    <div><img src="{{main_images_url}}" alt="Project Image"></div>
                </a>
				<div class="pro_container">
               		<div class="pro_info">
              		 	<div class="category">{{category}} ㅣ{{nickname}}</div>
               		 	<a href="{{url}}">
                    		<div class="long_title">{{long_title}}</div>
               			</a>
                		<div class="sub_title">{{sub_title}}</div>

                		<div>
                   			<input type="button" class="cancel_btn_t" value="관심 취소" data-project_seq="{{project_seq}}" data-member_seq="${memberSeq}">        
                		</div>
					</div>


					<div class="pro_footer">
                   		<!-- 달성률 출력 -->
                   		<div class="achieve" >
                       		 {{calculateAchievementRateText goal_price collection_amount}}
                   		</div>
                    	<div class="amount">{{formatCurrency collection_amount}}원</div>                
                		<div class="term">
                   			{{checkTerm term}}
                		</div>
               		</div>
            	</div>
            </div>
        {{/each}}
    {{else}}
		<div class="empty_result">
			<div class="empty_ment">관심 프로젝트가 없습니다.</div>
		    <div><button class='backToMain'> 프로젝트 둘러보기 </button> </div>
	    </div>
    {{/if}}
</div>
</script>

<!-- Handlebars.js 헬퍼 함수 정의 -->
<script>
	//달성률
    Handlebars.registerHelper('calculateAchievementRateText', function(goalPrice, collectionAmount) {
        return Math.floor((collectionAmount / goalPrice) * 100) + "%";
    });
    //원화
    Handlebars.registerHelper('formatCurrency', function(value) {
        return new Intl.NumberFormat().format(value);
    });
    Handlebars.registerHelper('checkTerm', function(term) {
        return term >= 0 ? term + '일 남음' : '펀딩 종료';
    });

</script>


<script>
$(document).ready(function() {	
	
    <%
    List<ProjectMemberDTO> myDibs = (List<ProjectMemberDTO>) request.getAttribute("myDibs");
    int allCount = (myDibs != null) ? myDibs.size() : 0;
	%>	

	$("#total_dibs").html(<%= allCount %>);	

	
	
	$(".selected_menu").click(function () {
		if ($(".menu").css("display") === "block") {
			$(".menu").css("display", "none")
		}else {
			$(".menu").css("display", "block");
		}		
	})
	
	

	
	
	
	
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
                
				var count = response.length;
                
				$("#total_dibs").html(count);
                $(".result").html(html);

                $(".selected_menu").html("진행중");
                $(".menu").css("display", "none")
                
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
            	
                var templateSource = $("#project-template").html();
                var template = Handlebars.compile(templateSource);

                var context = { projects: response };
                var html = template(context);
                
				var count = response.length;
                
				$("#total_dibs").html(count);
                $(".result").html(html);  
                
                $(".selected_menu").html("종료된");
                $(".menu").css("display", "none")
            },
            error: function(error) {
                console.log(error);
            }
        });
    });
    
 	
    $("#all").click(function() {
    	window.location.href ="/mydibs"
    })
    
    
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
    
    
    
    //관심취소 - 템플릿용
    $(document).on('click', '.cancel_btn_t', function() {
	    var projectSeq = $(this).data("project_seq");
	    var memberSeq = $(this).data("member_seq");
	    
	    if (confirm("확인을 누르면 관심 프로젝트에서 삭제됩니다.") == true) {
	        $.ajax({
	            type: "POST",
	            url: "/dibsCancel",
	            data: {
	                "projectSeq": projectSeq,
	                "memberSeq": memberSeq
	            },
	            success: function(response) {
	                console.log(response);
	                alert("삭제되었습니다.");
	                window.location.href = "/mydibs"
	            },
	            error: function(error) {
	                console.log(error);
	            }
	        });
    	}
    });
    
    
	$(".backToMain").click(function() {
		location.href = '/';
	});
	
	//템플릿용
	$(document).on('click', '.backToMain', function() {
		location.href = '/';
	})

})
</script>


<body>
<div class="wrap">
	<div class="out_con">
		<span class="dibs_title">관심 프로젝트</span>
		<div class="top_con">
			<div class="top_count"> <span id="total_dibs" style="color: red"></span> 건의 관심 내역이 있습니다. </div>			
		</div>
		<hr class="top_under_hr">
	
		<div class="selected_menu">전체</div>
		<div class="menu" style="display: none;">
			<div class="css_menu" id="all" style="cursor:pointer;">전체</div>
			<div class="css_menu" id="ongoing" style="cursor:pointer;">진행중</div>
			<div class="css_menu" id="end" style="cursor:pointer;">종료된</div>
		</div>
	
	
		<div class="result_con">
			<div class="result">
				<c:choose>
		            <c:when test="${empty myDibs}">
		                <div class="empty_result">
			                <div class="empty_ment">관심 프로젝트가 없습니다.</div>
			                <div><button class='backToMain'> 프로젝트 둘러보기 </button> </div>
		                </div>
		            </c:when>
		            <c:otherwise>	
			            <div class=out_container>
				            <c:forEach var="project" items="${myDibs}">
				                <div class="container">
				                	<a href="${project.url}">
				                    	<div><img src="${project.main_images_url}" alt="Project Image"></div>
				                    </a>
				                    <div class="pro_container">
				                    <div class="pro_info">
					                    <div class="category"> ${project.category} ㅣ ${project.nickname }</div>
					                    <a href="${project.url}">
					                    	<div class="long_title"> ${project.long_title}</div>
					                    </a>
					                    <div class="sub_title"> ${project.sub_title}</div>
					                    
		   			                    <div> <!-- 관심버튼 수정해야함 -->
					                    	<input type="button" class="cancel_btn" value="관심 취소" data-project_seq="${project.project_seq}" data-member_seq="${memberSeq}">
					                    </div>
				                    </div>
					                    	
			                    	<div class="pro_footer">
									<c:set var="achievementRate" value="${(project.collection_amount / project.goal_price) * 100}" />									
									    <script>
									        $(document).ready(function() {                
									            // achievementRate 값을 JSTL 변수에서 가져와서 사용
									            var achievementRate = ${achievementRate};
									            
									            // 달성률 출력
									            var achievementText = Math.floor(achievementRate) + "%";
									            $("#achievementRate-${project.project_seq}").text(achievementText);
									        });
									    </script>       
		
				                    	<div class="achieve" id="achievementRate-${project.project_seq}"></div>
				                    	<div class="amount"> <fmt:formatNumber value="${project.collection_amount}" type="currency" currencySymbol="" />원 </div>
				                    	<div class="term">
									        <c:choose>
									            <c:when test="${project.term >= 0}">
									                ${project.term}일 남음
									            </c:when>
									            <c:otherwise>
									                펀딩종료
									            </c:otherwise>
									        </c:choose>							       							        
				                    	</div>		                    	                 	
			                    	</div>	                    	
								</div>	              		
		                	</div>            
						</c:forEach>		            
	     				</div>
	     			</c:otherwise>
				</c:choose>            
			</div>
		</div>
		
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>
</body>
</html>