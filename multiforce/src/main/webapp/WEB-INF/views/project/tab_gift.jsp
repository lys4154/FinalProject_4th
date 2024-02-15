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
        	var packages = {
        			bundle_price : $("#bundle_price").val(),
        			bundle_name : $("#bundle_name").val()
        			/* item_name : $("#item_name").val() */
        	};
        	$.ajax({
        		type: "POST",
        		url: "/saveBundle",
        		contentType: "application/json",
        		data:JSON.stringify(packages),
        		success: function(response) {
        			console.log(response);
        		},
        		error: function(error) {
        			console.error(error);
        		}
        	});
        });
        
        $("#addItem").click(function() {
        	var item = {
        			item_name : $("#item_name").val()
        	};
        	$.ajax({
        		type: "POST",
        		url: "/saveItem",
        		contentType: "application/json",
        		data:JSON.stringify(item),
        		success: function(response) {
        			console.log(response);
        		},
        		error: function(error) {
        			console.error(error);
        		}
        	});
        });
        
        $("#addCount").click(function() {
        	var item = {
        			item_count : $("#item_count").val()
        	};
        	$.ajax({
        		type: "POST",
        		url: "/saveItemCount",
        		contentType: "application/json",
        		data:JSON.stringify(item),
        		success: function(response) {
        			console.log(response);
        		},
        		error: function(error) {
        			console.error(error);
        		}
        	});
        });
        
        $("#addOption").click(function() {
        	var item = {
        			item_option_name : $("#item_option_name").val()
        	};
        	$.ajax({
        		type: "POST",
        		url: "/saveItemOption",
        		contentType: "application/json",
        		data:JSON.stringify(item),
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
<style>
.bundle {
	text-align : center;
}

.item {
	text-align : center;
}
</style>  
</head>
<body>
 <!-- tab_gift -->
<h1>선물 계획</h1>
<div class="item">  
  <label for="item_name">상품 이름</label> <br>
  <input type="text" id="item_name" name="item_name" placeholder="아이템 이름을 입력해주세요"><br>
  <input type="button" id="addItem" value="상품명 추가">
  
  <br><br>
  <label for="item_option">옵션 이름</label> <br>
  옵션이 없으면 빈 칸으로 옵션 추가 버튼을 눌러주세요.<br>
  <input type="text" id="item_option_name" name="item_option_name"><br>
  <input type="button" id="addOption" value="옵션 추가">
  <div id="item_list"></div>
  
  <br><br>
  <div class="bundle">
  <label for="bundle_name">선물 이름</label><br>
  어떤 아이템으로 구성되어있는지 이름을 붙여주세요.<br>
  <input type="text" id="bundle_name" name="bundle_name"><br>
  
  <label for="bundle_price">후원 금액</label> <br>
  <input type="text" id="bundle_price" name="bundle_price"><br>
  <input type="button" id="addBundle" value="번들 추가">
	</div>  
  
  <br><br>
  <label for="item_count">상품 개수</label> <br>
  <input type="text" id="item_count" name="item_count"><br>
  <input type="button" id="addCount" value="상품 개수 추가">
</div>  
</body>
</html>