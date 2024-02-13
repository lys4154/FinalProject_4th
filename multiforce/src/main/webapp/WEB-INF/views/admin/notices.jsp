<%@page import="java.sql.Timestamp"%>
<%@page import="admin.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function(){
	
	let loginUserLevel = "${login_user_level}"
	if(loginUserLevel == 2){
		$("#write_btn_wrap").html("<a href='/notices/write'><button id='write_btn'>글쓰기</button></a>")
	}
	$("#discover_category").val("${category}");
	
});
</script>
<body>
<h1>공지사항</h1>
<a href="/notices?category=notice&page=1">공지사항</a>
<a href="/notices?category=event&page=1">이벤트</a>
	<form action="/notices/discover" style="display:inline-block">
		<input type="text" name="query">
		<input type="hidden" id="discover_category" name="category">
		<input type="submit" value="검색">
	</form>
<div style="display:inline-block" id="write_btn_wrap"></div>
<hr>

<c:forEach var="item" items="${list }">
	<div style="border: 1px solid black">
		<c:if test="${category == 'notice' }">
			<span>
				공지사항
			</span>
			<span>
				${item.write_date }
			</span>
			<a href="/notices/detail?seq=${item.notice_seq }&category=${category}&page=${nowPage}">
				<h4>${item.title }</h4>
			</a>
		</c:if>
		<c:if test="${category == 'event' }">
			<span>
				이벤트
			</span>
			<span>
				${item.event_status }
			</span>
			<span>
				${item.write_date }
			</span>
			<a href="/notices/detail?seq=${item.notice_seq }&category=${category}&page=${nowPage}">
				<h4>${item.title }</h4>
			</a>
		</c:if>
	</div>
</c:forEach>
<hr>
<div id="page_btn_wrap">
<%	int pageListLength = 5;
	int totalPage = (int)request.getAttribute("totalPage");
	int nowPage = (int)request.getAttribute("nowPage");
	String category = (String)request.getAttribute("category");
	String query = "";
	if(request.getAttribute("query") != null && !request.getAttribute("query").equals("")){
		query = "&query=" + request.getAttribute("query");
	}
	int tmp = nowPage/(pageListLength + 1);
	//<-버튼 기능 구현
	if(tmp == 0){
%>		<a id="prev_page_btn" href="/notices?category=<%=category%>&page=1<%=query%>">←</a>
<%	}else{
%>		<a id="prev_page_btn" href="/notices?category=<%=category%>&page=<%= pageListLength * (tmp - 1) + 1%><%=query%>">←</a>
<%	}
%>	

<%	//페이지 숫자 
	for(int i = 1; i <= pageListLength; i++){
%>		<a class="page_number_btn" href="/notices?category=<%=category%>&page=<%=i + tmp*pageListLength%><%=query%>"><%=i + tmp*pageListLength%></a>
<%	//->버튼 기능 구현	
		if(i + tmp*pageListLength == totalPage){
%>			<a id="next_page_btn" href="/notices?category=<%=category%>&page=<%= totalPage%><%=query%>">→</a>
<%			break;
		}else if(i == pageListLength){
%>			<a id="next_page_btn" href="/notices?category=<%=category%>&page=<%= pageListLength * (tmp + 1) + 1%><%=query%>">→</a>
<%		}
	}
%>	
</div>

</body>
</html>