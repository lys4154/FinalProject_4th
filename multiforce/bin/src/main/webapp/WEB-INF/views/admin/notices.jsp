<%@page import="java.sql.Timestamp"%>
<%@page import="admin.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		$("#write_btn_wrap").html("<button id='write_btn'><a href='/notices/write'>글쓰기</a></button>")
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
<%	List<NoticeDTO> list = (List<NoticeDTO>)request.getAttribute("list");%>

<% 	
	int totalPage = (int)request.getAttribute("totalPage");
	int nowPage = (int)request.getAttribute("nowPage");
	String query = "";
	if(request.getAttribute("query") != null && !request.getAttribute("query").equals("")){
		query = "&query=" + request.getAttribute("query");
	}
	
	//현재 페이지의 게시물 생성(10개)
	String category = (String)request.getAttribute("category");
	for(NoticeDTO dto : list){
%>		<div>
			<a href="/notices/detail?seq=<%=dto.getNotice_seq()%>&category=<%=category%>
			&page=<%=nowPage%><%=query%>"><%=dto.getTitle() %></a>
<% 		if(dto.getCategory().equals("event")){
%>			이벤트
<%			Timestamp startDate = Timestamp.valueOf(dto.getEvent_start_date());
			Timestamp endDate = Timestamp.valueOf(dto.getEvent_end_date());
			Timestamp today = new Timestamp(System.currentTimeMillis());
			if(startDate.after(today)){
%>				<span id="event_status">예정</span>
<%			}else if(startDate.before(today) && endDate.after(today)){
%>				<span id="event_status">진행 중</span>
<%			}else{
%>				<span id="event_status">종료</span>
<%			}	
		}else if(dto.getCategory().equals("notice")){
%>			공지사항
<%		}
%>			<%=dto.getWrite_date() %>
		</div>
<%	}
%>
<hr>
<div>
<%	int pageListLength = 5;
	int tmp = nowPage/(pageListLength + 1);
	//<-버튼 기능 구현
	if(tmp == 0){
%>		<a href="/notices?category=<%=category%>&page=1<%=query%>">←</a>
<%	}else{
%>		<a href="/notices?category=<%=category%>&page=<%= pageListLength * (tmp - 1) + 1%><%=query%>">←</a>
<%	}
%>	
<%	//페이지 숫자 
	for(int i = 1; i <= pageListLength; i++){
%>		<a href="/notices?category=<%=category%>&page=<%=i + tmp*pageListLength%><%=query%>"><%=i + tmp*pageListLength%></a>
<%	//->버튼 기능 구현	
		if(i + tmp*pageListLength == totalPage){
%>			<a href="/notices?category=<%=category%>&page=<%= totalPage%><%=query%>">→</a>
<%			break;
		}else if(i == pageListLength){
%>			<a href="/notices?category=<%=category%>&page=<%= pageListLength * (tmp + 1) + 1%><%=query%>">→</a>
<%		}
	}
%>	
</div>
</body>
</html>