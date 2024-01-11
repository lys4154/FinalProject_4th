<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Reward Setting</title>
</head>
<body>
  <h1>선물 목록</h1>
  <label for="backer-amount">후원 금액:</label>
  <input type="text" id="backer-amount" name="backer-amount"><br><br>

  <label for="reward">보상:</label>
  <input type="text" id="reward" name="reward"><br><br>

  <button onclick="addReward()">보상 추가</button>

  <h2>선물 목록</h2>
  <p>후원금에 따른 선물</p>
  <ul id="reward-list">
    <!-- 보상이 여기에 동적으로 추가됩니다 -->
  </ul>

  <script>
    function addReward(event) {
     // event.preventDefault(); // 기본 동작 방지

      var backerAmountInput = document.getElementById("backer-amount");
      var rewardInput = document.getElementById("reward");
      var rewardList = document.getElementById("reward-list");

      var backerAmount = parseInt(backerAmountInput.value.replace(/[^\d]+/g, ''));
      var reward = rewardInput.value.trim();

      if (isNaN(backerAmount) || backerAmount <= 0 || !reward) {
        alert("후원 금액과 선물을 입력하세요.");
        return;
      }

      var rewardItem = document.createElement("li");
      rewardItem.appendChild(document.createTextNode(`금액: ${backerAmount.toLocaleString()}원 - 보상: ${reward}`));
      rewardList.appendChild(rewardItem);

      // 추가 후에 입력 필드 초기화
      backerAmountInput.value = "";
      rewardInput.value = "";
    }
  </script>
</body>
</html>