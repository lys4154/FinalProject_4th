<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/project/cardpay.css">
<style type="text/css">
	.moveNumber {
		text-align:center;
		width:40px;
	}
	
	.validThru {
        text-align:center;
        width:60px;
    }
    
    .passWord {
    	text-align:center;
    	width:20px;
    };
</style>

<script>
	function inputMoveNumber(num) {
		if(isFinite(num.value) == false) {
			alert("카드번호는 숫자만 입력할 수 있습니다.");
			num.value = "";
			return false;
		}
		max = num.getAttribute("maxlength");
		if(num.value.length >= max) {
			num.nextElementSibling.focus();
		}
	}
	
	function inputValidThru(period) {

        // replace 함수를 사용하여 슬래시( / )을 공백으로 치환한다.
        var replaceCard = period.value.replace(/\//g, "");

        // 텍스트박스의 입력값이 4~5글자 사이가 되는 경우에만 실행한다.
        if(replaceCard.length >= 4 && replaceCard.length < 5) {

            var inputMonth = replaceCard.substring(0, 2);    // 선언한 변수 month에 월의 정보값을 담는다.
            var inputYear = replaceCard.substring(2, 4);       // 선언한 변수 year에 년의 정보값을 담는다.



            // 현재 날짜 값을 구한다.

            var nowDate = new Date();

            var nowMonth = autoLeftPad(nowDate.getMonth() + 1, 2);

            var nowYear = autoLeftPad(nowDate.getFullYear().toString().substr(2, 2), 2);


            // isFinite함수를 사용하여 문자가 선언되었는지 확인한다.
            if(isFinite(inputMonth + inputYear) == false) {
                alert("문자는 입력하실 수 없습니다.");
                period.value = autoLeftPad((Number(nowMonth) + 1), 2) + "/" + nowYear;
                return false;
            }

            // 입력한 월이 12월 보다 큰 경우
            if(inputMonth > 12) {
                alert("12월보다 큰 월수는 입력하실 수 없습니다. ");
                period.value = "12/" + inputYear;
                return false;
            }



            // 입력한 유효기간을 현재날짜와 비교하여 사용 가능 여부를 판단한다.
            if((inputYear + inputMonth) <= (nowYear + nowMonth)) {
                alert("유효기간이 만료된 카드는 사용하실 수 없습니다.");
                period.value = inputMonth + "/" + autoLeftPad((Number(nowYear) + 1), 2);
                return false;
            }

            period.value = inputMonth + "/" + inputYear;
        }
    }



    // 1자리 문자열의 경우 앞자리에 숫자 0을 자동으로 채워 00형태로 출력하기위한 함수
    function autoLeftPad(num, digit) {
        if(String(num).length < digit) {
            num = new Array(digit - String(num).length + 1).join('0') + num;
        }
        return num;
    }
    
    function inputPassWord(pw) {
    	var replacePw = pw.value.replace(/[^\d]/g, '');
    	if(replacePw.length > 2) {
    		replacePw = replacePw.slice(0, 2) + '**';
    	}
    	this.pw = replacePw;
    	
    	
    	if(isFinite(pw.value) == false) {
    		alert("문자는 입력하실 수 없습니다.");
    		pw.value = "";
    		return false;
    	}
    }
</script>

</head>
<body>


<div style="text-align:center;">
<h1>카드결제 페이지</h1>
</div>

<table border=1 class="cardpay-table">
<tr>
<td class="cardpay-head">카드사</td>
<td>
<select id="select_company">
	<option value="신한">신한</option>
	<option value="국민">국민</option>
	<option value="농협">농협</option>
	<option value="기업">기업</option>
	<option value="우리">우리</option>
	<option value="하나">하나</option>
</select>
</td>
</tr>
<tr>
<td class="cardpay-head">
카드번호
</td>
<td>
<input type="text" class="moveNumber" onKeyup="inputMoveNumber(this);" maxlength="4"/>&nbsp;-&nbsp;
<input type="text" class="moveNumber" onKeyup="inputMoveNumber(this);" maxlength="4"/>&nbsp;-&nbsp;
<input type="text" class="moveNumber" onKeyup="inputMoveNumber(this);" maxlength="4"/>&nbsp;-&nbsp;
<input type="text" class="moveNumber" maxlength="4"/>
</td>
</tr>
<tr>
<td class="cardpay-head">
카드 유효기간
</td>
<td>
<input type="text" class="validThru" onKeyup="inputValidThru(this);" placeholder="MM/YY" maxlength="5"/>
</td>
</tr>
<tr>
<td class="cardpay-head">
카드 비밀번호 2자리<br>
</td>
<td>
<input type="text" class="passWord" onKeyup="inputPassWord(this);" maxlength="2"/> **
</td>
</tr>
<tr>

<td colspan=2 style="text-align:center;">
<input class="btn-1" type="button" id="pay" value="인증">
<input class="btn-1" type="button" id="cancel" value="취소">

</td>
</tr>
</table>



<script>
document.getElementById('pay').addEventListener('click', function(ev) {
	let cardNumber = "";
	$(".moveNumber").each(function(i, item){
		cardNumber += $(item).val();
	})
	$("#pay_number", opener.document).val(cardNumber);
	$("#pay_company", opener.document).val($("#select_company").val());
	window.close();
	//window.location.href = "payresult"
});
document.getElementById("cancel").addEventListener("click", function() {
	  if (confirm("결제를 취소하시겠습니까?")) {
	    window.close(); // 사용자가 확인을 누르면 현재 창을 닫음
	  }
	});
</script>
</body>
</html>