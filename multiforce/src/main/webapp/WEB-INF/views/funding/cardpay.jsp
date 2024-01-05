<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.moveNumber {
		text-align:center;
		width:40px;
	};
</style>

<script type="text/javascript">
	function inputMoveNumber(num) {
		if(isFinite(num.value) == false) {
			alert("카드번호는 숫자만 입력할 수 있습니다.");
			num.value = "";
			return false;
		}
		max = num.getAttribute("maxlength");
		if(num.value.length >= max) {
			num.nextElementSibling.focus();
		}
	}
</script>

</head>
<body>
<h1>카드결제 페이지</h1>
카드번호를 입력하세요 <br>
<input type="text" class="moveNumber" onKeyup="inputMoveNumber(this);" maxlength="4"/>&nbsp;-&nbsp;
<input type="text" class="moveNumber" onKeyup="inputMoveNumber(this);" maxlength="4"/>&nbsp;-&nbsp;
<input type="text" class="moveNumber" onKeyup="inputMoveNumber(this);" maxlength="4"/>&nbsp;-&nbsp;
<input type="text" class="moveNumber" maxlength="4"/>
<br>
<br>

<!-- 카드 기간, cvc 3자리, 비밀번호 2자리 입력 -->



<input type="button" id="pay" value="결제">
<input type="button" id="cancel" value="취소">

</body>
</html>