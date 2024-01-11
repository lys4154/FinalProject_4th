<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function inputAmount(num) {
	if(isFinite(num.value) == false) {
		alert("목표금액은 숫자만 입력할 수 있습니다.");
		num.value = "";
		return false;
	}
}
</script>
</head>
<body>
 <h1>펀딩 계획</h1>
  <label for="start-date">시작일:</label>
  <input type="date" id="start-date" name="start-date"><br><br>
  
  <label for="end-date">마감일:</label>
  <input type="date" id="end-date" name="end-date"><br><br>
  
  <label for="goal-amount">목표 금액:</label>
  <input type="text" id="goal-amount" name="goal-amount" onKeyup="inputAmount(this);"><br><br>
  
  <button onclick="submitPlan()">계획 제출</button>

  <script>
    function submitPlan() {
      var startDate = document.getElementById("start-date").value;
      var endDate = document.getElementById("end-date").value;
      var goalAmount = document.getElementById("goal-amount").value;
    }
  </script>
</body>
</html>