<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<h3>선물 정보</h3>
	<div>
		<h4>선물 구성</h4>
		<c:set var="totalPrice" value="0"/>
		<c:forEach var="bundle" items="${paymentList}">
			<c:set var="extraPrice" value="추가 후원금"/>
			<c:if test="${bundle.name == extraPrice}">
				<span>${bundle.name }</span>
				<div>${bundle.price }원</div>
			</c:if>
			<c:if test="${bundle.name != extraPrice}">
				<span>${bundle.name }</span>
				<span>(x${bundle.count })</span>
				<div>${bundle.price }원</div>
			</c:if>
			<c:set var="totalPrice" value="${totalPrice + bundle.price }"/>
			<ul>
				<c:forEach var="item" items="${bundle.item }">
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
		<hr>
		</c:forEach>
	</div>
	
	<h3>배송지 정보</h3>
	<form action="/payresult" method="post">
		<div>
			수취인 명: <input type="text" value="${dto.member_name }" name="name">
		</div>
		<div>
			연락처: <input type="text" name="phone">
		</div>
		<div>
			우편번호: <input type="text" value="${dto.postcode}" name="postcode" readonly>
		</div>
		<div>
			지번주소: <input type="text" value="${dto.jibun_address }" name="jibun_address" readonly>
		</div>
		<div>
			도로명주소: <input type="text" value="${dto.road_address }" name="road_address" readonly>
		</div>
		<div>
			상세주소: <input type="text" value="${dto.detail_address }" name="detail_address">
		</div>
		<div>
			추가주소: <input type="text" value="${dto.extra_address }" name="extra_address" readonly>
		</div>
		<input type="hidden" value="${totalPrice }" name="price">
		<h3>결제 방법</h3>
		<label for="payment">결제수단</label>
		<select id="payment" name="pay_option">
			<option value="">--결제수단--</option> <!-- 여기서는 팝업창 안 나오게 수정 해야됨!! -->
			<option value="card">카드결제</option>
			<option value="cash">계좌이체</option>
		</select>
		<input type="text" name="pay_company" readonly id="pay_company">
		<input type="text" name="pay_number" readonly id="pay_number">
		<div id="result">
		</div>
		 <div>
			<h3>총 금액</h3>
			<div>
				<fmt:formatNumber value="${totalPrice }" pattern="#,###" />원
			</div>
		</div>
		<input type="button" value="후원하기">
	</form>
	<!-- 결제 방법 영역-->
		
		<!-- 누르면 팝업창 띄우고, option 값에 따른 결제창 보여주기
		카드 : 15~16 숫자 들어가면 결제 완료
		계좌이체 : 10~30 숫자 들어가면 결제 완료
		 -->	
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
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</html>