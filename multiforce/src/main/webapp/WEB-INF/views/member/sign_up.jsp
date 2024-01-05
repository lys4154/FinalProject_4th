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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function(){
	
	let user_id = $("#user_id");
	let user_pw = $("#user_pw");
	let user_pw_check = $("#user_pw_check");
	let user_birth = $("#user_birth");
	let user_birth_errmsg = $("#user_birth_errmsg");
	let user_pw_errmsg_spcl_num = $("#user_pw_errmsg_spcl_num");
	let user_pw_errmsg_pw_num = $("#user_pw_errmsg_pw_num");
	let user_pw_check_errmsg = $("#user_pw_check_errmsg");
	let user_name = $("#user_name");
	let user_name_errmsg = $("#user_name_errmsg");
	let user_pw_on_caps = $("#user_pw_on_caps");
	let btn_join = $("#btn_join");

	let user_data = {
		id: "",
		email: "",
		pw: "",
		name: "",
		birth: ""
	}

	//이름 양식: 완성된 한글 + 알파벳
	let user_name_reg = /^[가-힣a-zA-z]{1,}$/g;

	user_name.on("change", function(){
		if(user_name_reg.test(user_name.val()) == false && user_name.val() != ""){
			user_name_errmsg.css("display", "block");
		}else{
			user_name_errmsg.css("display", "none");
		}
	})

	//생년월일: 오늘 날짜 이후를 선택하면 잘못된 날짜라고 알려주기
	user_birth.on("change", function(){
		if(new Date(user_birth.value) - Date.now() > 0){
			user_birth_errmsg.css("display", "block");
		}else{
			user_birth_errmsg.css("display", "none");
		}
	});
	
	//비밀번호 양식 체크
	let user_pw_reg = /[~!@#$%^*+=-?_]{1}/g; //이 이외의 특수문자 걸러내기

	user_pw.on("input",function(e){
		let spcl_num = user_pw.val().match(user_pw_reg) == null ? 0 : user_pw.val().match(user_pw_reg).length;
		
		if(spcl_num < 2 && user_pw.val() != ""){
			user_pw_errmsg_spcl_num.css("display","block");
		}else{
			user_pw_errmsg_spcl_num.css("display","none");
		}
		
		if(user_pw.val().length < 8 && user_pw.val() != ""){
			user_pw_errmsg_pw_num.css("display","block");
		}else{
			user_pw_errmsg_pw_num.css("display","none");
		}
		
	});
	//암호 capslock 체크
	user_pw.on("keydown",function(e){
		if (e.originalEvent.getModifierState("CapsLock")) {
			user_pw_on_caps.css("display","block");
		}else {
			user_pw_on_caps.css("display","none");
		}
	});

	//비밀번호 확인: 일치하는지
	user_pw_check.on("change",function(){
		if(user_pw_check.val() != user_pw.val()){
			user_pw_check_errmsg.css("display","block");
		}else{
			user_pw_check_errmsg.css("display","none");
		}
	});
	//이메일
	let user_email = $("#user_email");
	let user_email_dir = $("#user_email_dir");
	let email_select = $("#email_select");
	let user_email_id_errmsg = $("#user_email_id_errmsg");
	let user_email_domain_errmsg = $("#user_email_domain_errmsg");
	let user_email_reg = /^[A-Za-z0-9]{4,12}$/;
	let user_email_dir_reg = /^[A-Za-z0-9]{1,}.(co\.kr|com|net)$/
	let email_reg =/^[A-Za-z0-9]{4,12}@[A-Za-z0-9]{1,}.(co\.kr|com|net)$/
	
	user_email.on("change", emailCheck);
	user_email_dir.on("change", emailCheck);
	
	email_select.on("change",function () {
		if (email_select.val() == "직접입력") {
			user_email_dir.css("display","inline-block");
		}else {
			emailCheck();
			user_email_dir.css("display","none");
			user_email_dir.val("");
		}
	});
	
	function emailCheck(){
		console.log("emailCheck");
		if (user_email_reg.test(user_email.val()) == false) {
			user_email_id_errmsg.css("display","block");
		}else{
			user_email_id_errmsg.css("display","none");
		}
		
		if (email_select.val() == "직접입력" && user_email_dir_reg.test(user_email_dir.val()) == false) {
			user_email_domain_errmsg.css("display","block");
		}else{
			user_email_domain_errmsg.css("display","none");
			if(email_select.val() == "직접입력"){
				let email = user_email.val() + "@" + user_email_dir.val();
				console.log(email);
				$("#email").val(email);
			}else{
				let email = user_email.val() + "@" + email_select.val();
				console.log(email);
				$("#email").val(email);
			}
		}
	}

	//회원가입 클릭시
	//양식에 적혀있는 것들을 재검증한 후 통과못하면 오류메세지 + 포커스
	function goBack(err_target, e){
		err_target.focus();
		e.preventDefault();
		alert("다시 입력해주세요");
	}
	btn_join.on("click", event =>{
		let spcl_char_num = user_pw.val().match(user_pw_reg) == null ? 0 : user_pw.val().match(user_pw_reg).length;
		
		console.log(user_name_reg.test(user_name.val()));
		if(user_name_reg.test(user_name.val()) == false){
			goBack(user_name, event);
			console.log("이름값: " + user_name.value);
			console.log("이름 확인: " +user_name_reg.test(user_name.value));
			console.log("이름 오류");
		}
		else if(new Date(user_birth.val()) - Date.now() > 0 || user_birth.val() == ""){
			goBack(user_birth, event);
			console.log("생년월일 오류");
		}
		else if(spcl_char_num < 2){
			goBack(user_pw, event);
			console.log("비번 오류1");
		}
		else if(user_pw.val().length < 8){
			goBack(user_pw, event);
			console.log("비번 오류2");
		}
		else if(user_pw_check.val() != user_pw.val()){
			goBack(user_pw_check, event);
			console.log("비번확인 오류");
		}
	})
	
	$("#find_address").on("click", execDaumPostcode);
	function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

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

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
	
	
});

</script>
<body>
<table>
	<form action="welcome" method="post">
		<tr>
			<th>이름</th>
			<td>
				<input type="text" class="text" id="user_name" name="user_name" placeholder="성함을 입력해주세요.">
				<p style="display:none" id="user_name_errmsg">올바르지 않은 이름입니다</p>
			</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>
				<input type="date" id="user_birth" name="user_birthday">
				<p style="display:none" id="user_birth_errmsg">올바르지 않은 날짜입니다</p>
			</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td><input type="text" id="user_id" name="user_id"></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<input type="password" id="user_pw" name="user_pw" placeholder="특수문자 2개 이상을 포함한 8~16자의 비밀번호를 입력해주세요" maxlength="16">
				<p style="color: black">사용가능한 특수문자 ~ ! @ # $ % ^ * + = - ? _</p>
				<p id="user_pw_on_caps" style="display:none">CAPS LOCK이 켜져있습니다</p>
				<p id="user_pw_errmsg_spcl_num" style="display:none">특수문자를 반드시 2글자 이상 넣어야합니다</p>
				<p id="user_pw_errmsg_pw_num" style="display:none">비밀번호를 최소 8자리 입력해주세요</p>
			</td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td>
				<input type="password" id="user_pw_check">
				<p style="display:none" id="user_pw_check_errmsg">비밀번호가 일치하지 않습니다</p>
			</td>
		</tr>
		<tr>
			<th>별명</th>
			<td>
				<input type="text" id="user_nickname" name="nickname">
				<p style="display:none" id="user_nickname_errmsg_dup">중복된 별명입니다</p>
				<p style="display:none" id="user_nickname_errmsg_check">형식에 맞지않는 별명입니다</p>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<input type="text" class="text" id="user_email" placeholder="이메일을 입력해주세요" >
				@
				<select id="email_select">
					<option>naver.com</option>
					<option>google.com</option>
					<option>daum.net</option>
					<option>직접입력</option>
				</select>
				<input type="text" class="text" id="user_email_dir" placeholder="도메인을 입력해주세요" style="display:none" >
				<input type="hidden" id="email" name="email">
				<p class="error_message" id="user_email_id_errmsg" style="display:none">입력 양식이 올바르지 않습니다</p>
				<p class="error_message" id="user_email_domain_errmsg" style="display:none">도메인 입력 양식이 올바르지 않습니다</p>
			</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>
				남<input type="radio" name="gender" value="0" checked>
				녀<input type="radio" name="gender" value="1">
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<input type="text" id="postcode" placeholder="우편번호">
				<input type="button" id="find_address" value="우편번호 찾기"><br>
				<input type="text" id="roadAddress" placeholder="도로명주소">
				<input type="text" id="jibunAddress" placeholder="지번주소">
				<span id="guide" style="color:#999;display:none"></span>
				<input type="text" id="detailAddress" placeholder="상세주소">
				<input type="text" id="extraAddress" placeholder="참고항목">
			</td>
		</tr>
		</table>
		<div id="btn_join_wrap">
			<button id="btn_join">회원가입</button>
		</div>
	</form>
</body>
</html>