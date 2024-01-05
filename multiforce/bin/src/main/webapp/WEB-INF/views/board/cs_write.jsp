<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/cs_style.css" />">



	<%

	    String data = (String) request.getAttribute("boardType");
	    String board = "";
	    

	    if (data != null) {
	        if (data.equals("community")) {
	            board = "커뮤니티";
	        } else if (data.equals("cs")) {
	            board = "고객센터";
	        }
	    }
	%>

    <title><%= board %> 글쓰기</title>



</head>
<body>
    <div class="cs-container">
        <h2><%= board %> 글쓰기</h2>
        <div style="margin-bottom:15px;" id="cs_menu_bar">
            
        </div>
     
        <form id="write_form" action="/multiforce/boardwrite" method="POST" >
           
            <div class="write-title">
                <input type="text" name="title" id="title" placeholder="제목">
            </div>
            <div class="write-content">
                <textarea name="contents" cols="30" id="content" rows="10" placeholder="내용"></textarea>
            </div>
            <div class="cs-submit-btn">
                <input type="submit" value="제출" name="submit">
            </div>
        </form>
    </div>
 


</body>
</html>
