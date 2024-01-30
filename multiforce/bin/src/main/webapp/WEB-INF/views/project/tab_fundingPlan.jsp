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
<script>
    $(document).ready(function() {
    $("#submitBtn").click(function() {
        var data = {
            start_date: $("#start_date").val(),
            due_date: $("#due_date").val(),
            goal_price: $("#goal_price").val()
        };

        // AJAX를 통해 서버에 JSON 형태의 데이터 전송
        $.ajax({
            type: "POST",
            url: "/submitFundingPlan",
            contentType: "application/json",  // JSON 형태로 데이터 전송
            data: JSON.stringify(data),  // 데이터를 JSON 문자열로 변환
            success: function(response) {
                console.log(response);
            },
            error: function(error) {
                console.error(error);
            }
        });
    });
});
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
  
  <button type="button" id="submitBtn">저장</button>
</form>

</body>
</html>