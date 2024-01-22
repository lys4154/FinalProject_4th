<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
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
	let user_name_en_reg = /^[a-zA-Z]{1,}$/g;
	let user_name_ko_reg = /^[가-힣]{1,}$/g;

	user_name.on("change", userNameCheck);
	
	let isNamePassed = false;
	function userNameCheck(){
		if(user_name_en_reg.test(user_name.val())== true){
			user_name_errmsg.css("display", "none");
			isNamePassed = true;
		}else if(user_name_ko_reg.test(user_name.val())== true){
			user_name_errmsg.css("display", "none");
			isNamePassed = true;
		}else if(user_name.val() == ""){
			user_name_errmsg.css("display", "none");
			isNamePassed = false;
		}else{
			user_name_errmsg.css("display", "block");
			isNamePassed = false;
		}
	}

	//생년월일: 오늘 날짜 이후를 선택하면 잘못된 날짜라고 알려주기
	user_birth.on("change", userBirthCheck);
	let isBirthPassed = false;
	function userBirthCheck(){
		if(new Date(user_birth.val()) - Date.now() > 0){
			user_birth_errmsg.css("display", "block");
			isBirthPassed = false;
		}else{
			user_birth_errmsg.css("display", "none");
			isBirthPassed = true;
		}
	}
	
	//아이디 중복체크 및 형식체크
	let user_id_reg = /^[A-Za-z0-9]{4,12}$/;
	let isIdTestPassed = false;
	let isIdDupCheckPassed = false;
	$("#user_id").on("change", function(){
		//형식체크
		if(user_id_reg.test($("#user_id").val()) == true){
			$("#user_id_check_errmsg").css("display","none");
			isIdTestPassed = true;
		}else{
			$("#user_id_check_errmsg").css("display","block");
			isIdTestPassed = false;
		}
		//아이디 입력 변경있으면 중복체크 false로 
		$("#user_id_pass_msg").css("display", "none");
		$("#user_id_dup_errmsg").css("display", "none");
		isIdDupCheckPassed = false;
	});
	
	$("#user_id_dup_check_btn").on("click", function(e){
		e.preventDefault();
		if(isIdTestPassed == true){
			$.ajax({
				url: "iddupcheck",
				data:{'id': $("#user_id").val()},
				type: 'post',
				dataType: 'json',
				success: function(response){
					//중복 아이디 없을 경우
					if(response.isUniqueId == "true"){
						$("#user_id_pass_msg").css("display", "block");
						$("#user_id_dup_errmsg").css("display", "none");
						isIdDupCheckPassed = true;
					//중복 아이디 있는 경우
					}else{
						$("#user_id_pass_msg").css("display", "none");
						$("#user_id_dup_errmsg").css("display", "block");
						isIdDupCheckPassed = false;
					}
				},
				error: function(request, e){
					alert("코드=" + request.status + " 메세지=" + request.responseText + " 오류=" + e);
				}
			});
		}else{
			//형식 테스트 못넘긴 상황에서 중복체크했을때
			alert("아이디를 다시 입력해주세요");
			$("#user_id").focus();
		}
	});
	
	//별명 중복체크 및 형식체크
	let user_nickname_reg = /^[A-Za-z0-9가-힣]{2,10}$/;
	let isNicknameTestPassed = false;
	let isNicknameDupCheckPassed = false;
	$("#user_nickname").on("change", function(){
		//형식체크
		if(user_nickname_reg.test($("#user_nickname").val()) == true){
			$("#user_nickname_check_errmsg").css("display","none");
			isNicknameTestPassed = true;
		}else{
			$("#user_nickname_check_errmsg").css("display","block");
			isNicknameTestPassed = false;
		}
		//별명 입력 변경있으면 중복체크 false로 
		$("#user_nickname_pass_msg").css("display", "none");
		isNicknameDupCheckPassed = false;
	});
	
	$("#user_nickname_dup_check_btn").on("click", function(e){
		e.preventDefault();
		if(isNicknameTestPassed == true){
			$.ajax({
				url: "nicknamedupcheck",
				data:{'nickname': $("#user_nickname").val()},
				type: 'post',
				dataType: 'json',
				success: function(response){
					//중복 닉네임 없을 경우
					if(response.isUniqueNickname == "true"){
						$("#user_nickname_pass_msg").css("display", "block");
						$("#user_nickname_dup_errmsg").css("display", "none");
						isNicknameDupCheckPassed = true;
					//중복있을 경우
					}else{
						$("#user_nickname_pass_msg").css("display", "none");
						$("#user_nickname_dup_errmsg").css("display", "block");
						isNicknameDupCheckPassed = false;
					}
				},
				error: function(request, e){
					alert("코드=" + request.status + " 메세지=" + request.responseText + " 오류=" + e);
				}
			});
		}else{
			//형식 테스트 못넘긴 상황에서 중복체크했을때
			alert("별명을 다시 입력해주세요");
			$("#user_nickname").focus();
		}
		
	});
	
	//비밀번호 양식 체크
	let user_pw_reg = /[~!@#$%^*+=-?_]{1}/g; //이 이외의 특수문자 걸러내기
	let isPwPassed = false;
	user_pw.on("change",function(e){
		let spcl_num = user_pw.val().match(user_pw_reg) == null ? 0 : user_pw.val().match(user_pw_reg).length;
		let spclNumCheck = false;
		if(spcl_num < 2 && user_pw.val() != ""){
			user_pw_errmsg_spcl_num.css("display","block");
			spclNumCheck = false;
		}else if(user_pw.val() == ""){
			user_pw_errmsg_spcl_num.css("display","none");
			spclNumCheck = false;
		}else{
			user_pw_errmsg_spcl_num.css("display","none");
			spclNumCheck = true;
		}
		
		let pwNumCheck = false;
		if(user_pw.val().length < 8 && user_pw.val() != ""){
			user_pw_errmsg_pw_num.css("display","block");
			pwNumCheck = false;
		}else if(user_pw.val() == ""){
			user_pw_errmsg_pw_num.css("display","none");
			pwNumCheck = false;
		}else{
			user_pw_errmsg_pw_num.css("display","none");
			pwNumCheck = true;
		}
		
		if(spclNumCheck && pwNumCheck){
			isPwPassed = true;
		}else{
			isPwPassed = false;
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
	let isPwCheckPassed = false;
	user_pw_check.on("change",function(){
		if(user_pw_check.val() != user_pw.val()){
			user_pw_check_errmsg.css("display","block");
			isPwCheckPassed = false;
		}else{
			user_pw_check_errmsg.css("display","none");
			isPwCheckPassed = true;
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
	
	let isEmailPassed = false;
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
			isEmailPassed = false;
			return false;
		}else{
			user_email_id_errmsg.css("display","none");
			if (email_select.val() == "직접입력" && user_email_dir_reg.test(user_email_dir.val()) == false) {
				user_email_domain_errmsg.css("display","block");
				isEmailPassed = false;
				return false;
			}else{
				user_email_domain_errmsg.css("display","none");
				if(email_select.val() == "직접입력"){
					let email = user_email.val() + "@" + user_email_dir.val();
					$("#email").val(email);
					console.log(email);
				}else{
					let email = user_email.val() + "@" + email_select.val();
					$("#email").val(email);
					console.log(email);
				}
				return true;
			}
		}
	}
	
	var authCode = "";
	var authRequestEmail = "";
	
	$("#mail_auth_btn").on("click", function(e){
		e.preventDefault();
		if(emailCheck() == false){
			alert("이메일을 다시 입력해주세요");
		}else{
			$("#mail_send_msg").css("display","inline-block");
			$.ajax({
				url: "mailauth",
				data:{'email': $("#email").val()},
				type: 'post',
				dataType: 'json',
				success: function(response){
					if(response.isUniqueEmail == "true"){
						$("#mail_send_msg").css("display","none");
						authCode = response.authCode;
						$("#auth_code_input").css("display", "inline-block");
						$("#auth_code_check_btn").css("display", "inline-block");
						$("#mail_auth_btn").html("메일 재전송");
						authRequestEmail = $("#email").val();
					}else{
						alert("이미 존재하는 이메일입니다");
						$("#mail_send_msg").css("display","none");
					}
				},
				error: function(request, e){
					alert("코드=" + request.status + " 메세지=" + request.responseText + " 오류=" + e);
				}
			});
		}
	});
	
	$("#auth_code_check_btn").on("click", function(e){
		e.preventDefault();
		if($("#auth_code_input").val() == authCode){
			if(authRequestEmail == $("#email").val()){
				alert("인증되었습니다");
				isEmailPassed = true;
				
				$("#mail_auth_btn").css("display", "none");
				$("#auth_code_input").css("display", "none");
				$("#auth_code_check_btn").css("display", "none");
				$("#user_email_auth_msg").css("display", "block");
				
				user_email.attr("disabled", true);
				email_select.attr("disabled", true);
				user_email_dir.attr("disabled", true);
			}else{
				alert("인증요청한 이메일이 일치하지 않습니다");
				isEmailPassed = false;
			}
			
		}else{
			alert("잘못된 인증번호 입니다. 다시 확인 해주세요");
			isEmailPassed = false;
		}
	})
	
	let isAddressPassed = false;
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

	//회원가입 클릭시
	//양식에 적혀있는 것들을 재검증한 후 통과못하면 오류메세지 + 포커스
	function goBack(err_target, e, message){
		err_target.focus();
		e.preventDefault();
		if(message == null){
			alert("다시 입력해주세요");
		}else if(message == ""){
			
		}else{
			alert(message);
		}
		
	}
	btn_join.on("click", e =>{
		if(!isNamePassed){
			goBack($("#user_name"), e);
		}else if(!isBirthPassed){
			goBack($("#user_birth"), e);
		}else if(!isIdTestPassed){
			goBack($("#user_id"), e);
		}else if(!isIdDupCheckPassed){
			goBack($("#user_id"), e, "아이디 중복확인이 필요합니다");
			console.log("isIdDupCheckPassed: "+isIdDupCheckPassed)
		}else if(!isNicknameTestPassed){
			goBack($("#user_nickname"), e);
		}else if(!isNicknameDupCheckPassed){
			goBack($("#user_nickname"), e, "별명 중복확인이 필요합니다");
		}else if(!isPwPassed){
			goBack($("#user_pw"), e);
		}else if(!isPwCheckPassed){
			goBack($("#user_pw_check"), e);
		}else if(!emailCheck()){
			goBack($("#user_email"), e);
		}else if(!isEmailPassed){
			goBack($("#user_email"), e, "이메일 인증이 되지않았습니다");
		}else if(!isAddressPassed){
			goBack($("#postcode"), e);
		}else if($("#detailAddress").val() == ""){
			if(!confirm("상세주소가 작성되지 않았습니다 이대로 회원가입하시겠습니까?")){
				goBack($("#detailAddress"), e, "");
			}
		}
	})

	
});

</script>
<body>
<form action="welcome" method="post" id="sign_up_form">
	<table>
		<tr>
			<th>이름</th>
			<td>
				<input type="text" class="text" id="user_name" name="member_name" placeholder="성함을 입력해주세요.">
				<p style="display:none" id="user_name_errmsg">올바르지 않은 이름입니다</p>
			</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>
				<input type="date" id="user_birth" >
				<p style="display:none" id="user_birth_errmsg">올바르지 않은 날짜입니다</p>
			</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" id="user_id" name="member_id" placeholder="4~12글자 영문+숫자 조합">
				<button id="user_id_dup_check_btn">중복확인</button>
				<p id="user_id_pass_msg" style="display:none">사용가능한 아이디입니다</p>
				<p style="display:none" id="user_id_dup_errmsg">중복된 아이디입니다</p>
				<p style="display:none" id="user_id_check_errmsg">형식에 맞지않는 아이디입니다</p>
			</td>
		</tr>
		<tr>
			<th>별명</th>
			<td>
				<input type="text" id="user_nickname" name="nickname" placeholder="10글자이내 영문,한글,숫자를 입력해주세요" maxlength=10>
				<button id="user_nickname_dup_check_btn">중복확인</button>
				<p id="user_nickname_pass_msg" style="display:none">사용가능한 별명입니다</p>
				<p style="display:none" id="user_nickname_dup_errmsg">중복된 별명입니다</p>
				<p style="display:none" id="user_nickname_check_errmsg">형식에 맞지않는 별명입니다</p>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<input type="password" id="user_pw" name="password" placeholder="특수문자 2개 이상을 포함한 8~16자의 비밀번호를 입력해주세요" maxlength="16">
				<span>사용가능한 특수문자 ~ ! @ # $ % ^ * + = - ? _</span>
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
			<th>이메일</th>
			<td>
				<input type="text" class="text" id="user_email" placeholder="이메일을 입력해주세요" >
				@
				<select id="email_select">
					<option>naver.com</option>
					<option>gmail.com</option>
					<option>daum.net</option>
					<option>직접입력</option>
				</select>
				<input type="text" class="text" id="user_email_dir" placeholder="도메인을 입력해주세요" style="display:none" >
				<input type="hidden" id="email" name="email">
				<button id="mail_auth_btn">인증메일 전송</button>
				<span id="mail_send_msg" style="display:none">전송 중</span>
				<div>
					<input type="text" id="auth_code_input" style="display:none" placeholder="인증번호 6자리를 입력해주세요">
					<button id="auth_code_check_btn" style="display:none">인증</button>
				</div>
				<p id="user_email_auth_msg" style="display:none">인증되었습니다</p>
				<p class="error_message" id="user_email_id_errmsg" style="display:none">입력 양식이 올바르지 않습니다</p>
				<p class="error_message" id="user_email_domain_errmsg" style="display:none">도메인 입력 양식이 올바르지 않습니다</p>
			</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>
				남<input type="radio" name="gender" value="0" checked>
				여<input type="radio" name="gender" value="1">
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly>
				<input type="button" id="find_address" value="우편번호 찾기"><br>
				<input type="text" id="roadAddress" name="road_address" placeholder="도로명주소" readonly>
				<input type="text" id="jibunAddress" name="jibun_address" placeholder="지번주소" readonly>
				<input type="text" id="extraAddress" name="extra_address" placeholder="참고항목" readonly><br>
				<input type="text" id="detailAddress" name="detail_address" placeholder="상세주소">
			</td>
		</tr>
	</table>
	<div id="btn_join_wrap">
		<button id="btn_join">회원가입</button>
	</div>
</form>
</body>
</html>