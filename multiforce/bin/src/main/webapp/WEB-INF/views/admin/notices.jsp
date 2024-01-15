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
		$("#write_btn_wrap").html("<button id='write_btn'><a href='notices/write'>글쓰기</a></button>")
	}
});
</script>
<body>
<a href="notices?category=notice&page=1">공지사항</a>
<a href="notices?category=event&page=1">이벤트</a>
<div id="write_btn_wrap"></div>
<%	List<NoticeDTO> list = (List<NoticeDTO>)request.getAttribute("list");%>

<% 	int totalPage = (int)request.getAttribute("totalPage");
	int nowPage = (int)request.getAttribute("nowPage");
	String category = (String)request.getAttribute("category");
	for(NoticeDTO dto : list){ %>
		<div>
			<a href="notices/detail?seq=<%=dto.getNotice_seq()%>&category=<%=category%>&page=<%=nowPage%>"><%=dto.getTitle() %></a>
			<%=dto.getCategory()%>
			<%=dto.getWrite_date() %>
		</div>
<%	}
%>
<div>
<%	int pageListLength = 5;
	int tmp = nowPage/(pageListLength + 1);
	if(tmp == 0){
%>		<a href="notices?category=<%=category%>&page=1">←</a>
<%	}else{
%>		<a href="notices?category=<%=category%>&page=<%= pageListLength * (tmp - 1) + 1%>">←</a>
<%	}
%>	
<%	
	for(int i = 1; i <= pageListLength; i++){
%>		<a href="notices?category=<%=category%>&page=<%=i + tmp*pageListLength%>"><%=i + tmp*pageListLength%></a>
<%		
		if(i + tmp*pageListLength == totalPage){
%>			<a href="notices?category=<%=category%>&page=<%= totalPage%>">→</a>
<%			break;
		}else if(i == pageListLength){
%>			<a href="notices?category=<%=category%>&page=<%= pageListLength * (tmp + 1) + 1%>">→</a>
<%		}
	}

%>
	
</div>
</body>
</html>