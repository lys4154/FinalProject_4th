<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>
function inputPrice(num) {
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
 <form action="fundingPlan" method="post">
  <label for="start_date">시작일:</label>
  <input type="date" id="start_date" name="start_date"><br><br>
  
  <label for="due_date">마감일:</label>
  <input type="date" id="due_date" name="due_date"><br><br>
  
  <label for="goal_price">목표 금액:</label>
  <input type="text" id="goal_price" name="goal_price" onKeyup="inputPrice(this);"><br><br>
  
  <input type="button" id="submitPlan" value="계획 제출">
</form>
  <script>
  $(document).ready(function () {
    $("#submitPlan").click(function () {
      submitPlan();
    });
  });

  function submitPlan() {
    var formData = $("#fundingForm").serialize();

    $.ajax({
      type: "POST",
      url: "submitFundingPlan",
      data: JSON.stringify(formData),
      success: function (response) {
        console.log(response);
      },
      error: function (error) {
        console.error(error);
      }
    });
  }
</script>
</body>
</html>