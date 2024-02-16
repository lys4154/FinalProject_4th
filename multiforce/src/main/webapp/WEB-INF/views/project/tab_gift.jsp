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
$(document).ready(function(){
	
	var itemArr = [];
	var nowItemArrIdx = 0;
	//아이템 생성 버튼 클릭시 아이템 이름, 프로젝트 번호, 아이템 옵션들을 붙여줌
	$("#create_item_btn").on("click", function(){
		console.log(projectSeq);
		let item = {};
		item.item_name = $("#item_name_input").val();
		item.project_seq = projectSeq; //임시
		item.optionDTOList = [];
		itemArr.push(item);
		nowItemArrIdx = itemArr.length - 1;
		$("#item_name_input").val("");
		fillItemList();//현재 itemArr 상태를 브라우저 내에 보여주게 하는 메서드
	});
	//옵션 생성 버튼 클릭시 옵션 객체 생성 + optionDTO와 같은 이름으로 프로퍼티 채워주기 + 옵션 배열에 넣어줌
	$("#create_option_btn").on("click", function(){
		let option = {};
		let option_name = $("#item_option_name_input").val();
		if(option_name == ""){
			option.item_option_name = "옵션 없음";
		}else{
			option.item_option_name = option_name;
		}
		itemArr[nowItemArrIdx].optionDTOList.push(option);
		fillItemList();//현재 optionArr 상태를 브라우저 내에 보여주게 하는 메서드
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
		          itemArr = [];
		          fillItemList();
		          fillSavedItemList();
		          console.log(savedItemArr);
		          
	        }
		})
	});
/*	function fillOptionList(){
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
*/	
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
		$("#select_item_list").html("");
		for(let i=0; i < savedItemArr.length; i++){
			let saved_item_wrap = $(".saved_item_wrap_form").clone();
			saved_item_wrap.attr("class", "saved_item_wrap");
			saved_item_wrap.append("<div class='saved_item_name_wrap'>"+savedItemArr[i].item_name+"</div>");
			saved_item_wrap.append("<ul class='saved_item_option_list'>");
			for(let j=0; j<savedItemArr[i].optionDTOList.length; j++){
				saved_item_wrap.append("<li class='saved_item_option_wrap'>" + savedItemArr[i].optionDTOList[j].item_option_name + "</li>");
			}
			saved_item_wrap.append("</ul>");
			$("#saved_item_list").append(saved_item_wrap);
			//=========번들 만드는 곳에 넘겨주기==================
			$("#select_item_list").append("<label class='select_item_name_wrap'><input type='checkbox' class='select_item'>"
					+ savedItemArr[i].item_name + "</label>");
		}
	} 
	var nowBundleIdx = 0;
	var bundleArr = [];
	var itemListDTOList = [];
	$("#add_item_in_bundle_btn").on("click",function(){
		$("#select_item_list").find(".select_item:checked").each(function(i, element){
			let index = $(element).index("input:checkbox[class='select_item']");
			let itemListDTO = {};
			itemListDTO.item_seq = savedItemArr[index].item_seq;
			itemListDTO.item_count = 1;
			itemListDTO.itemDTO = savedItemArr[index];
			itemListDTOList.push(itemListDTO);
		})
		fillAddedItemList();
	});
	
	function fillAddedItemList(){
		$("#added_item_list").html("");
		for(let i = 0; i < itemListDTOList.length; i++){
			let added_item_wrap = $(".added_item_wrap_form").clone();
			added_item_wrap.attr("class", "added_item_wrap");
			added_item_wrap.children(".added_item_name_wrap").append(itemListDTOList[i].itemDTO.item_name);
			for(let j = 0; j < itemListDTOList[i].itemDTO.optionDTOList.length; j++){
				added_item_wrap.children(".added_item_option_list")
				.append("<li>" + itemListDTOList[i].itemDTO.optionDTOList[j].item_option_name + "</li>")
			}
			
			$("#added_item_list").append(added_item_wrap);
		}
	}
	
	$("#create_bundle_btn").on("click", function(){
		let bundle = {};
		let bundle_name = $("#bundle_name_input").val();
		let bundle_price = $("#bundle_price_input").val();
		bundle.project_seq = projectSeq //임시 프로젝트 기획화면에서 바로 끌어올수있어야함
		bundle.bundle_name = bundle_name;
		bundle.bundle_price = bundle_price;
		bundle.itemListDTOList = [];
		for(let i = 0; i < itemListDTOList.length; i++){
			let count = i+1;
			itemListDTOList[i].item_count = $("#added_item_list div:nth-child("+count+")").find(".item_count_input").val();
			bundle.itemListDTOList.push(itemListDTOList[i]);
		}
		bundleArr.push(bundle);
		$.ajax({
			url: "/savebundles",
			data: JSON.stringify(bundleArr),
			type: "POST",
			contentType: "application/json; charset=UTF-8",
			success:function (data) {
		        
	        }
		})
		fillBundleList()
	});
	
	function fillBundleList(){
		$("#bundle_list").html();
		for(let i = 0; i < bundleArr.length; i++){
			$("#bundle_list").append(bundleArr[i].bundle_name);
			$("#bundle_list").append("<ul>");
			for(let j = 0; j < bundleArr[i].itemListDTOList.length; j++){
				bundleArr[i].itemListDTOList[j].itemDTO.item_name
			}
		}
		console.log(bundleArr);
	}
	
});
</script>
<body>
아이템 이름<input type="text" id="item_name_input"><br>
<input type="button" id="create_item_btn"  value="아이템 생성"><br>
옵션 명<input type="text" id="item_option_name_input"><br>
<input type="button" id="create_option_btn" value="옵션 생성"><br>
<h3>아이템 목록</h3>
<div id="item_list"></div>


<div id="option_list"></div>

<input type="button" id="save_items_btn" value="아이템 저장">
<h3>저장된 아이템 목록</h3>
<div id="saved_item_list"></div>
<hr>
<h3>선물 꾸러미 만들기</h3>
<div id="select_item_list"></div>
<input type="button" id="add_item_in_bundle_btn" value="아이템 추가"><br>
<div id="added_item_list"></div>

번들이름<input type="text" id="bundle_name_input"><br>
가격<input type="number" id="bundle_price_input"><br>
<input type="button" id="create_bundle_btn" value="번들만들기"><br>

<div id="bundle_list"></div>

<!-- 옵션 div -->
<hr>
<div class="option_wrap_form"></div>
<div class="item_wrap_form"></div>
<div class="saved_item_wrap_form"></div>

<div class="added_item_wrap_form">
	<div class="added_item_name_wrap">
	</div>
	<ul class="added_item_option_list">
	</ul>
	<input type="number" class="item_count_input">
</div>
<!--  -->
</body>
</html>