<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>결제 페이지</h1>

<!-- 상품 정보 영역-->
<div class="title">상품 정보</div>
<p>토스 티셔츠</p>
<p>결제 금액: 15,000원</p>

<!-- 결제 방법 영역-->
<div class="title">결제 방법</div>
<div id="payment-method"></div>
<div id="agreement"></div>

<label for="payment">결제수단</label>
<select id="payment">
	<option value="">--결제수단--</option>
	<option value="card">카드결제</option>
	<option value="cash">계좌이체</option>
</select>
<input type="button" id="pay" value="결제하기"> <!-- 누르면 팝업창 띄우고, option 값에 따른 결제창 보여주기
카드 : 15~16 숫자 들어가면 결제 완료
계좌이체 : 10~30 숫자 들어가면 결제 완료
 -->
</body>
</html>