<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function(){
	
	var itemArr = [];
	//아이템 생성 버튼 클릭시 아이템 이름, 프로젝트 번호, 아이템 옵션들을 붙여줌
	$("#create_item_btn").on("click", function(){
		let item = {};
		item.item_name = $("#item_name_input").val();
		item.project_seq = 10; //임시
		item.optionDTOList = optionArr;
		itemArr.push(item);
		
		$("#item_name_input").val("");
		fillItemList();//현재 itemArr 상태를 브라우저 내에 보여주게 하는 메서드
		
		console.log("아이템");
		console.log(item);
		console.log("아이템배열");
		console.log(itemArr);
		
	});
	//옵션 생성 버튼 클릭시 옵션 객체 생성 + optionDTO와 같은 이름으로 프로퍼티 채워주기 + 옵션 배열에 넣어줌
	var optionArr = [];
	$("#create_option_btn").on("click", function(){
		let option = {};
		let option_name = $("#item_option_name_input").val();
		if(option_name == ""){
			option.item_option_name = "옵션 없음";
		}else{
			option.item_option_name = option_name;
		}
		optionArr.push(option);
		fillOptionList();//현재 optionArr 상태를 브라우저 내에 보여주게 하는 메서드
		$("#item_option_name_input").val("");
	});
	
	var savedItemArr = [];
	$("#save_items_btn").on("click", function(){
		$.ajax({
			url: "/saveitems",
			data: JSON.stringify(itemArr),
			type: "POST",
			contentType: "application/json; charset=UTF-8",
			success:function (data) {
		          for(let i=0; i < data.length; i++){
		        	  savedItemArr.push(data[i]);//db에 저장 후 자바스크립트 배열내에 다시 넣어주기
		          }
		          console.log(savedItemArr);
	        }
		})
	});
	function fillOptionList(){
		$("#option_list").html("");
		console.log("옵션 리스트");
		console.log(optionArr);
		for(let i=0; i<optionArr.length; i++){
			let option_wrap = $(".option_wrap_form").clone();//아래에 있는 태그을 클론
			option_wrap.attr("class", "option_wrap"); //내용채워넣기
			option_wrap.text(optionArr[i].item_option_name);
			$("#option_list").append(option_wrap); //옵션리스트 태그내에 채워주기
		}
	}
	
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
<body>
아이템 이름<input type="text" id="item_name_input"><br>
옵션 명<input type="text" id="item_option_name_input"><br>
<input type="button" id="create_option_btn" value="옵션 생성"><br>
<h3>옵션목록</h3>
<div id="option_list"></div>
<input type="button" id="create_item_btn"  value="아이템 생성"><br>
<h3>아이템 목록</h3>
<div id="item_list"></div>
<input type="button" id="save_items_btn" value="아이템 저장">
<h3>저장된 아이템 목록</h3>
<div id="saved_item_list"></div>

<!-- 옵션 div -->
<div class="option_wrap_form"></div>
<div class="item_wrap_form"></div>
<!-- <div class="item_wrap_form"></div> -->
</body>
</html>