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

});

</script>





<body>

<h1>후원한 프로젝트</h1>
<p>
<div>
	<div>
	후원수량 <span id="total_funded"></span> 건의 후원 내역이 있습니다.
	</div>
<input type="text" placeholder="프로젝트, 선물, 창작자를 검색하세요">
<p>

<div>후원 진행중</div><div id="미결제이고, 취소를 안한">1</div><br>
<div><img alt="대표 이미지" src=""></div> 
<div>후원일 </div><div id="후원일자"> 24.01.04 </div> | 
<div>후원번호 </div><div id="후원고유번호"> 111111 </div> <br>
<div id="긴제목"><a href="">[다시 만난 블루베어] 내 노트 속 파란 곰이 돌아왔다!</a></div><br>
<div id="꾸러미 이름">스마트톡 S 세트</div><div id="꾸러미 개수">2</div><div>개</div><br>
<div>결제 예정일 </div><div id="프로젝트 종료일자 +1 "> 24.01.05</div><br>
<div id="총계">50000</div><div>원 결제예정</div>
<p>



<div>후원 성공</div><div id="성공수량">1</div><br>
<div><img alt="대표 이미지" src=""></div> 
<div>후원일 </div><div id="후원일자"> 24.01.04 </div> | 
<div>후원번호 </div><div id="후원고유번호"> 111111 </div> <br>
<div id="긴제목"><a href="">[다시 만난 블루베어] 내 노트 속 파란 곰이 돌아왔다!</a></div><br>
<div id="꾸러미 이름">스마트톡 S 세트</div><div id="꾸러미 개수">2</div><div>개</div><br>
<div>결제 완료일 </div><div id="프로젝트 종료날짜 +1 "> 24.01.05</div><br>
<div id="총계">50000</div><div>원 결제 완료</div>
<p>

<div>후원 실패</div><div id="실패수량">1</div><br>
<div><img alt="대표 이미지" src=""></div> 
<div>후원일 </div><div id="후원일자"> 24.01.04 </div> | 
<div>후원번호 </div><div id="후원고유번호"> 111111 </div> <br>
<div id="긴제목"><a href="">[다시 만난 블루베어] 내 노트 속 파란 곰이 돌아왔다!</a></div><br>
<div id="꾸러미 이름">스마트톡 S 세트</div><div id="꾸러미 개수">2</div><div>개</div><br>
<div>결제 예약 취소일 </div><div id="취소 날짜 "> 24.01.04</div><br>
<div id="총계">50000</div><div>원 결제 예약 취소</div>
<p>
</div>

</body>
</html>