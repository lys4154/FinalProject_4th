<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="project.dto.ItemDTO" %>
<%@ page import="project.service.ItemService" %>    
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
        	
        	/* var item_name = {
        			item_name : $("#itemSelect").val()
        	};
        	$.ajax({
        		typd:"POST",
        		url:"/setItemName",
        		contentType:"application/json",
        		data:JSON.stringify(packages),
        		success:function(response) {
        			console.log(response);
        		},
        		error:function(error) {
        			console.error(error);
        		}
        	}); */
        });
        
        $("#addItem").click(function() {
        	var item_name = {
        			item_name : $("#item_name").val()
        	};
        	$.ajax({
        		type: "POST",
        		url: "/saveItem",
        		contentType: "application/json",
        		data:JSON.stringify(item_name),
        		success: function(response) {
        			console.log(response);
        			$("#item_name").val("");
        		},
        		error: function(error) {
        			console.error(error);
        		}
        	});
        	var item_option = {
        			item_option_name : $("#item_option_name").val()
        	};
        	$.ajax({
        		type: "POST",
        		url: "/saveItemOption",
        		contentType: "application/json",
        		data:JSON.stringify(optionArr),
        		success: function(response) {
        			console.log(response);
        			optionArr=[];
        			$(".item_wrap_form").html("");
        		},
        		error: function(error) {
        			console.error(error);
        		}
        	});
        });
        
        $("#addCount").click(function() {
        	var item_count = {
        			item_count : $("#item_count").val()
        	};
        	$.ajax({
        		type: "POST",
        		url: "/saveItemCount",
        		contentType: "application/json",
        		data:JSON.stringify(item_count),
        		success: function(response) {
        			console.log(response);
        		},
        		error: function(error) {
        			console.error(error);
        		}
        	});
        });
        
        //option
        var optionArr = [];
        $("#addOption").on("click", function() {
        	let option={};
        	let option_name = $("#item_option_name").val();
        	if(option_name == "") {
        		option.item_option_name = "옵션 없음";
        	} else {
        		option.item_option_name = option_name;
        	}
        	optionArr.push(option);
        	fillOptionList();
        	$("#item_option_name").val("");
        })
        function fillOptionList() {
        	$("option_list").html("");
        	console.log("옵션 리스트");
    		console.log(optionArr);
    		let option_wrap = $(".option_wrap_form").clone();
        	for(let i=0; i<optionArr.length; i++) {    		
        		option_wrap.attr("class", "option_wrap");
        		option_wrap.text(optionArr[i].item_option_name);
        		$("#option_list").append(option_wrap);
        	}
        }
        
        //item
        var itemArr = [];
    	//아이템 생성 버튼 클릭시 아이템 이름, 프로젝트 번호, 아이템 옵션들을 붙여줌
    	$("#addItem").on("click", function(){
    		let item = {};
    		item.item_name = $("#item_name").val();
    		item.optionDTOList = optionArr;
    		itemArr.push(item);
    		
    		$("#item_name").val("");
    		fillItemList();//현재 itemArr 상태를 브라우저 내에 보여주게 하는 메서드
    		
    		console.log("아이템");
    		console.log(item);
    		console.log("아이템배열");
    		console.log(itemArr);    		
    	});
    	
    	function fillItemList(){
    		$("#item_list").html("");
    		for(let i=0; i<itemArr.length; i++){
    			let item_wrap = $(".item_wrap_form").clone();
    			item_wrap.attr("class", "item_wrap");
    			item_wrap.append("<div class='item_name_wrap'>"+itemArr[i].item_name+"</div>");
    			item_wrap.append("<ul class='item_option_list'>");
    			for(let j=0; j<itemArr[i].optionDTOList.length; j++){
    				item_wrap.append("<li class='item_option_wrap'>" + itemArr[i].optionDTOList[j].item_option_name + "</li>");
    			}
    			item_wrap.append("</ul>");
    			$("#item_list").append(item_wrap);
    		}
    	}
    	
    	function fillSavedItemList(){
    		$("#saved_item_list").html("");
    		for(let i=0; i<savedItemArr.length; i++){
    			let item_wrap = $(".item_wrap_form").clone();
    			item_wrap.attr("class", "item_wrap");
    			item_wrap.append("<div class='item_name_wrap'>"+itemArr[i].item_name+"</div>");
    			item_wrap.append("<ul class='item_option_list'>");
    			for(let j=0; j<itemArr[i].optionDTOList.length; j++){
    				item_wrap.append("<li class='item_option_wrap'>" + itemArr[i].optionDTOList[j].item_option_name + "</li>");
    			}
    			item_wrap.append("</ul>");
    			$("#item_list").append(item_wrap);
    		}
    	} 
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
  <label for="item_name">아이템 이름</label> <br>
  <input type="text" id="item_name" name="item_name" placeholder="아이템 이름을 입력해주세요"><br>
  
  <label for="item_option">옵션 이름</label> <br> 
  옵션이 없으면 빈 칸으로 옵션 추가 버튼을 눌러주세요.<br>
  <input type="text" id="item_option_name" name="item_option_name"><br>
  <input type="button" id="addOption" value="옵션 추가">
  <h3>옵션목록</h3>
<div id="option_list"></div>
<div class="option_wrap_form"></div>
  <br><br>
  <input type="button" id="addItem" value="아이템 추가"><br> <br>
  
  <h3>아이템 목록</h3>
  <div id="item_list"></div>  
  <div class="item_wrap_form"></div>
  <div id="add_item_list"></div>
  
  <br><br>
  <div class="bundle">
  <label for="selectItem">선물 아이템</label><br>
  선물을 구성하는 아이템을 추가해주세요.<br>
  <select id="itemSelect" name="selectedItem">
            <c:forEach var="item" items="${itemList}">
                <option value="${item.item_name}">${item.item_name}</option>
            </c:forEach>
  </select>
  <br>
  
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