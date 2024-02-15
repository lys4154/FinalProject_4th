<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
function inputAccount(num) {
		if(isFinite(num.value) == false) {
			alert("계좌번호는 숫자만 입력할 수 있습니다.");
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
<h1>계좌이체 페이지</h1>
은행과 계좌번호를 입력해 주세요
<br>
<select id="#select_company">
<option value="NH">농협</option>
<option value="Woori">우리</option>
<option value="KB">국민은행</option>
<option value="Kakao">카카오뱅크</option>
<option value="SH">수협</option>
</select>
<input type="text" class="account" onKeyUp="inputAccount(this);" maxlength="20">
<!-- 여기에 입력한 값들을 DB에 전송 -->


<br>
<input type="button" id="pay" value="인증">
<input type="button" id="cancel" value="취소">

<script>
document.getElementById('pay').addEventListener('click', function(ev) {
	$("#pay_number", opener.document).val($(".account").val());
	$("#pay_company", opener.document).val($("#select_company").val());
	window.close();
	//window.location.href = "payresult"
});
document.getElementById("cancel").addEventListener("click", function() {
	  if (confirm("결제를 취소하시겠습니까?")) {
	    window.close();
	  }
	});
</script>
</body>
</html>