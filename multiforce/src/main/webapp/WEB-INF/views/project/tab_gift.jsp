<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Reward Setting</title>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>
    $(document).ready(function() {
    $("#addBundle").click(function() {
        var data = {
            bundle_price: $("#bundle_price").val(),
            bundle_name: $("#bundle_name").val(),
            item_name: $("#item_name").val(),
        };

        // AJAX를 통해 서버에 JSON 형태의 데이터 전송
        $.ajax({
            type: "POST",
            url: "/addBundle",
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
  <h1>선물 계획</h1>
  <label for="bundle_price">후원 금액</label>
  <input type="text" id="bundle_price" name="bundle_price"><br><br>

  <label for="bundle_name">선물 이름</label>
  <input type="text" id="bundle_name" name="bundle_name"><br><br>
  <label for="item_name">상품 이름</label>
  <input type="text" id="item_name" name="item_name"><br><br>

  <input type="button" id="addBundle" value="추가">

  <h2>선물 목록</h2>
  <p>후원금에 따른 선물</p>
  <ul id="reward-list">
    <!-- 보상이 여기에 동적으로 추가됩니다 -->
  </ul>
  <hr>
</body>
</html>