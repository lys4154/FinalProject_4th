<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>

<script>

var bundleData;

$(document).ready(function() {	

	if ("${dDay}" < 0) {
	    $("#pro_status").html("펀딩 종료")
	    $("#d_day").html("펀딩 종료")
	}

	if ("${trackNum}" == 0) {
	    $("#track_num").html("등록된 운송장이 없습니다.")
	}
		
	
	//넘길 꾸러미 정보 
	bundleData = [
	   <c:forEach var="bundleEntry" items="${bundleItem}" varStatus="status">
	     {
	       name: "${bundleEntry.key}",
	       count: ${bundleCount[bundleEntry.key]},
	       items: [
	         <c:forEach var="itemEntry" items="${bundleEntry.value}" varStatus="innerStatus">
	           {
	             itemName: "${itemEntry}",
	             options: [
	               <c:forEach var="optionEntry" items="${itemOption[itemEntry]}" varStatus="optionStatus">
	                 "${optionEntry}"<c:if test="${!optionStatus.last}">, </c:if>
	               </c:forEach>
	             ]
	           }<c:if test="${!innerStatus.last}">, </c:if>
	         </c:forEach>
	       ]
	     }<c:if test="${!status.last}">, </c:if>
	   </c:forEach>
	 ];	
	
	document.getElementById("bundleDataInput").value = JSON.stringify(bundleData);
	
	

    $("#cancel").click(function() {
        let fundSeq = ${fundedDetail.fund_seq};
        let longTitle = "${projectDetail.long_title}";
        let dueDate = "${projectDetail.due_date.toLocalDate()}";
        let price = ${fundedDetail.price };

        // 폼에 값을 설정
        $("#priceInput").val(price);
        $("#fundSeqInput").val(fundSeq);
        $("#longTitleInput").val(longTitle);
        $("#dueDateInput").val(dueDate);
        $("#bundleDataInput").val(JSON.stringify(bundleData));;

        // 폼을 제출
        $("#cancelForm").submit();
    });	
	
})

</script>




<body>
<div>
	<div class="content">
	
		<div style="border: 2px solid; ">
			<div ><a href="${projectDetail.url }"><img alt="프로젝트 이미지" src="${projectDetail.main_images_url }"></a></div>
			<div>
				<div>${projectDetail.category}</div>
				<div><a href="${projectDetail.url }">${projectDetail.long_title }</a></div>
				<div>${projectDetail.collection_amount }원</div>
				<div id="d_day">${dDay }일 남음</div>
				<!-- 창작자 문의 버튼 만들어아햠 -->
			</div>
		</div>
	
		<div style="border: 2px solid; ">
			<div>후원 정보</div>
			<div>펀딩 상태 </div> <div id="pro_status">펀딩 진행중</div>
			<div>후원 번호 </div> <div>${fundedDetail.fund_seq }</div>
			<div>후원 날짜 </div> <div>${fundedDetail.fund_date.toLocalDate() }</div>
			<div>펀딩 마감일 </div> <div>${projectDetail.due_date.toLocalDate()}</div>
		</div>
	
		<div style="border: 2px solid; ">
			<div>
				<div>선물 정보</div>
			</div>
			 
			<div>선물 구성 </div>
			<div>
			    <c:forEach var="bundleEntry" items="${bundleItem}">
			        <div>꾸러미 이름: <strong>${bundleEntry.key}</strong> <span>${bundleCount[bundleEntry.key]}개</span> </div>
			        <c:forEach var="itemEntry" items="${bundleEntry.value}">
			            <div style="color: olive;">아이템 이름 : ${itemEntry}</div>
			            <c:forEach var="optionEntry" items="${itemOption[itemEntry]}">
			                <div style="color:navy; ">옵션 : ${optionEntry}</div>
			            </c:forEach>            
			        </c:forEach>
			        <hr>
			    </c:forEach>
			</div>
				
			<div>배송 예정일 </div> <div>${projectDetail.delivery_date.toLocalDate()}</div>
			<div>후원 금액 </div> <div>${fundedDetail.price }</div>
		</div>
	
	
		<div style="border: 2px solid; ">
			<div>결제 정보</div> 
			<div>결제 수단 </div> <div> ${fundedDetail.pay_option }</div>
			<div>결제 금액 </div> <div> ${fundedDetail.price }</div>
			<div>결제 상태 </div> <div> ${fundedDetail.fund_duedate.toLocalDate().plusDays(1)} 결제 예정</div>
		</div>
	
	
		<div style="border: 2px solid; ">
			<div>배송 정보</div>
			<div>받는 사람 </div> <div> ${fundedDetail.name}</div>
			<div>연락처 </div> <div> ${fundedDetail.phone }</div><br>
			<div>주소 </div> <div>(${fundedDetail.postalcode })</div> <div> ${fundedDetail.address }</div>
			<div> ${fundedDetail.address_detail }</div>
			<div>운송장 번호 </div> <div id="track_num"> ${trackNum }</div>
			<p>
		</div>
	</div>
			
		<div>
			<input type="button" onclick="location='../funded'" value="후원 목록 보기">			
		</div>	
	
			<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
		  후원을 취소하시겠어요?
		</button>
		
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
		    	<div class="modal-content">
		      		<div class="modal-header">
		        		<h1 class="modal-title fs-5" id="exampleModalLabel">이 프로젝트에는 후원자님이 필요해요</h1>
		        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      	</div>
					<div class="modal-body">
						<h2>후원 취소를 원하시나요?</h2>
						<h5>혹시 선물 변경을 원하시나요?</h5>
						후원을 취소하지 않고 원하는 선물로 변경할 수 있어요.<br>
					  	<p><a href="#" data-bs-toggle="tooltip" title="Tooltip">여기</a> 를 눌러 선물을 변경해보세요!</p>
					</div>
				    <div class="modal-footer">
						<button type="button" class="btn btn-primary" data-bs-dismiss="modal">후원 유지</button>
			        	<form id="cancelForm" action="/funded_cancel" method="post">
						    <input type="hidden" id="fundSeqInput" name="fundSeqInput" value="">
						    <input type="hidden" id="longTitleInput" name="longTitleInput" value="">		        
					        <input type="hidden" id="bundleDataInput" name="bundleDataInput" value="">
					        <input type="hidden" id="dueDateInput" name="dueDateInput" value="">
					        <input type="hidden" id="priceInput" name="priceInput" value="">
							<button type="button" class="btn btn-secondary" id="cancel">그래도 취소</button>
						</form>
			      	</div>
		   		</div>
			</div>
		</div>	

</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</body>
</html>