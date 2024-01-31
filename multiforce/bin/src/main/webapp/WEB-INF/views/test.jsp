<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function(){
	$("#ask_btn").on("click",function(){
		if("${login_user_seq}" != ""){
			let url = "/ask?";
			let project_seq = 1;//나중엔 프로젝트 상세페이지 들어오면 자동으로 넣어지게
			let collector_seq = 2;//마찬가지
			let asker_seq = "${login_user_seq}";
			url += ("project_seq=" + project_seq);
			url += ("&collector_seq=" + collector_seq);
			url += ("&asker_seq=" + asker_seq);
			window.open(url, "_blank","width: 500, height: 500");
		}else{
			if(confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")){
				location.href = "/login";
			}
		}
	});
});
</script>
<body>
<input type="button" value="판매자 문의" id="ask_btn">
</body>
</html>