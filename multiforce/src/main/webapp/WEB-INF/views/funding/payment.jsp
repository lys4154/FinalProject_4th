<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/project/payment.css">
</head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<body>
<div>
	<div>
	
	
	<div class="project-head-box">
	
	<div style="text-align:center;font-size:20px;"><h3>프로젝트 정보</h3></div>
		<c:set var="project" value="${paymentList[fn:length(paymentList) -1] }"/>
		<div>
			<div class="image-part">
				<div>
				<img src="${project.main_image_url }">
				</div>

				
				
				<div class="project-title">
				<a href="${project.url }">
					${project.longTitle}
				</a>
				</div>
			</div>
			<span style="padding-right:5px;font-weight:bold;">프로젝트 작성자 - </span><span>${project.collector}</span>
		</div>
		<h3>선물 정보</h3>
		<div>
			<h4>선물 구성</h4>
			<c:set var="totalPrice" value="0"/>
		<c:forEach var="bundle" items="${paymentList}" end="${fn:length(paymentList) -2 }">
			<c:set var="extraPrice" value="추가 후원금"/>
			<c:if test="${bundle.name == extraPrice}">
				<span>${bundle.name }</span>
				<div><fmt:formatNumber value="${bundle.price }" pattern="#,###" />원</div>
				<c:set var="totalPrice" value="${totalPrice + bundle.price}"/>
			</c:if>
			<c:if test="${bundle.name != extraPrice}" >
				<span>${bundle.name }</span>
				<span>(x${bundle.count })</span>
				<div><fmt:formatNumber value="${bundle.price }" pattern="#,###" />원</div>
				<c:set var="totalPrice" value="${totalPrice + bundle.price * bundle.count}"/>
			</c:if>
			
			<ul>
				<c:forEach var="item" items="${bundle.item }" >
					<li>
						<div>
							<span>
								${item.name }
							</span>
							<span>
								(x${item.count })
							</span>
						</div>
						<div>
							<c:if test="${item.optionName != ''}">
							옵션:${item.optionName }
							</c:if>
						</div>
					</li>
				</c:forEach>
			</ul>
		
		</c:forEach>
	</div>
	</div>
		
	<hr>
	
	
	<div class="payment-form-container">
	<h3>배송지 정보</h3>
	<form action="/payresult" method="post">
		<div class="item-group">
		    <label for="name">수취인 명: </label>
		    <input type="text" value="${dto.member_name}" name="name" id="name">
		</div>
		<div class="item-group">
		    <label for="phone">연락처: </label>
		    <input type="text" name="phone" id="phone">
		</div>
		<div class="item-group">
		    <label for="postcode">우편번호: </label>
		    <input type="text" value="${dto.postcode}" name="postcode" id="postcode" readonly>
		</div>
		<div class="item-group">
		    <label for="jibunAddress">지번주소: </label>
		    <input type="text" value="${dto.jibun_address}" name="jibun_address" id="jibunAddress" readonly>
		</div>
		<div class="item-group">
		    <label for="roadAddress">도로명주소: </label>
		    <input type="text" value="${dto.road_address}" name="road_address" id="roadAddress" readonly>
		</div>
		<div class="item-group">
		    <label for="detailAddress">상세주소: </label>
		    <input type="text" value="${dto.detail_address}" name="detail_address" id="detailAddress">
		</div>
		<div class="item-group">
		    <label for="extraAddress">추가주소: </label>
		    <input type="text" value="${dto.extra_address}" name="extra_address" id="extraAddress" readonly>
		</div>

		<input type="button" value="주소찾기" id="find_address" class="btn-1">
		<input type="hidden" value="${totalPrice }" name="price">
		<input type="hidden" value="${login_user_seq }" name="member_seq">
		
		<div class="payment-box">
		<h3>결제 방법</h3>
		<label for="payment">결제수단</label>
		
		<div class="pay-info-box">
		<select id="payment" name="pay_option">
			<option value="">--결제수단--</option> <!-- 여기서는 팝업창 안 나오게 수정 해야됨!! -->
			<option value="card">카드결제</option>
			<option value="cash">계좌이체</option>
		</select>
		</div>
		
		
		
		<div class="payment-comp-info">
		<input type="text" name="pay_company" readonly id="pay_company">
		<input type="text" name="pay_number" readonly id="pay_number">
		</div>
		
		</div>
		
		<div id="result">
		</div>
		 <div class="total-price-box">
			<h3>총 금액</h3>
			<div class="price">
				<fmt:formatNumber value="${totalPrice }" pattern="#,###" />원
			</div>
			<input type="submit" value="후원하기" id="funding_btn" class="funding_button">
		</div>
		
	</form>
	</div>
	<!-- 결제 방법 영역-->
		
		<!-- 누르면 팝업창 띄우고, option 값에 따른 결제창 보여주기
		카드 : 15~16 숫자 들어가면 결제 완료
		계좌이체 : 10~30 숫자 들어가면 결제 완료
		 -->	
	
	</div>
		
</div>
 <script>
    document.getElementById('payment').addEventListener('change', function (ev) {
        var payvalue = document.getElementById("payment").value;
        var url;
        if (payvalue == "card") {
            url = "cardpay";
         // popup 함수에 callback 함수를 전달하여 자식 창이 닫힌 후 실행할 로직을 정의
            popup(url, function (){
            });
        } else if (payvalue == "cash") {
            url = "cashpay";
         // popup 함수에 callback 함수를 전달하여 자식 창이 닫힌 후 실행할 로직을 정의
            popup(url, function () {
            });
        } else {
            document.getElementById("result").innerHTML = "결제수단을 선택해주세요.";
        }
    });
	
    $("#funding_btn").on("click", function(e){
    	let name = $("#name").val();
    	let phone = $("#phone").val();
    	let postcode = $("#postcode").val();
    	let paynumber = $("#pay_number").val();
    	
    	if(name == ""){
    		alert("받으실 분 성함을 입력해주세요");
    		e.preventDefault();
    	}else if(phone == ""){
    		alert("연락처를 입력해주세요");
    		e.preventDefault();
    	}else if(postcode == ""){
    		alert("주소를 입력해주세요");
    		e.preventDefault();
    	}else if(paynumber == ""){
    		alert("결제수단을 인증해주세요");
    		e.preventDefault();
    	}
    });
    
    function popup(url, callback) {	
        var name = "pay";
        var option = "width=500, height=500, top=100, left=200, location=no";
        // window.open에서 새 창을 열 때, window객체를 반환하므로, 반환된 window객체에 이벤트 리스너를 추가할 수 있습니다.
        var childWindow = window.open(url, name, option);
        
        // 자식 창이 닫힌 경우, 콜백 함수를 실행
        if (callback) {
            var interval = setInterval(function () {
                if (childWindow.closed) {
                    clearInterval(interval);
                    callback();
                }
            }, 1000);
        }
    }
    
    $("#find_address").on("click", execDaumPostcode);
	function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				isAddressPassed = true;
                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }               
            }
        }).open();
    }
</script>
<!--  <script>
 	document.getElementById('pay').addEventListener('click', function(ev){
 		var payvalue = document.getElementById("payment").value;
 		var url;
 	 	if(payvalue == "card") {
 	 		url = "cardpay";
 	 	} else if (payvalue == "cash") {
 	 		url = "cashpay";
 	 	} else {
 	 		document.getElementById("result").innerHTML = "결제수단을 선택해주세요.";
 	 		ev.preventDefault();
 	 		// 이 경우에는 팝업창이 나오면 안 됨
 	 	}	 	
 	 	popup(url);	 	
 	});
 	 function popup(url){
			var name = "pay";
			var option = "width = 500, height = 500, top = 100, left = 200, location = no"
			window.open(url, name, option);	
	}
 	 
 </script> -->
</body>

</html>