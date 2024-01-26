<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<script>
$(document).ready(function() {
	
	//프로필 클릭
	$("#profile_detail").click(function() { 
		$(".profile").show();
		$(".account").hide();		
		$(".delevery").hide();		
	});
	
	//계정 클릭
	$("#account_detail").click(function() { 
		$(".account").show();
		$(".profile").hide();		
		$(".delevery").hide();		
	});

	//배송지 클릭
	$("#delivery_detail").click(function() {
		$(".delevery").show();
		$(".profile").hide();		
		$(".account").hide();
	});
	

	

    let memberSeq = ${loginMember.member_seq};
    let blockSaveEvent = false; // 이벤트를 차단할지 여부를 확인하는 플래그

	//프로필이미지 변경 클릭
	$("#img_change").click(function() {
		if ($("#img_change").val() === "변경") {
			$("#img_change").val("취소");
			$(".img_container").show();
		} else {
			$(".img_container").hide();
			$("#img_change").val("변경");			
		}		
	});
    
	//프로필 사진 - 파일 업로드 되면
	$("#img_upload").change(function() {		
		var file = $("#img_upload")[0].files[0];		
	    var formData = new FormData();		

	    formData.append("profileImg", file);  // formData 에 file을 추가, profileImg는 컨트롤러에서 받을 이름    
	    formData.append("member_seq", memberSeq);	 
	  	    
       $.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: "/profileimg_upload",
	        contentType: false,
	        processData: false,
	        data: formData,
	        success: function(response) { 
	    		console.log(filePath);
	    		var filePath = response.filePath;		
	    		$("#img_final").attr("src", filePath);	//사진 바로 보여주기	    		
	    		$(".img_container").hide();
	    		$("#img_change").val("변경");
	    		},
			error: function(error) {
			       console.log(error);
				}
	     });			
	});	
	
	//프로필 사진 - 삭제 버튼
	$("#img_del").click(function() {		
		if (confirm("프로필 사진을 삭제하면 기본 사진으로 대체됩니다.")){
		       $.ajax({
			        type: "POST",
			        url: "/profileimg_delete",
			        data: {"memberSeq" : memberSeq },
			        success: function(response) { 
			    		console.log(response);
			    			alert("프로필 사진이 삭제되었습니다.");
				    		$(".img_container").hide();
				    		$("#img_change").val("변경");
				    		$("#img_final").attr("src", "/memberimages/basic.png");	//기본사진
			    		},
					error: function(error) {
					       console.log(error);
						}
			     });	
			
			}		
	});
	
	
	
	//닉네임 변경 클릭
	$("#nick_change").click(function() {
		if ($("#nick_change").val() === "변경") {
			$("#nick_change").val("취소");
			$(".nick_container").show();
		} else {
			$(".nick_container").hide();
			$("#nick_change").val("변경");			
		}		
	});
		
	//닉네임 저장 클릭
	$("#nick_save").click(function() {
        if (blockSaveEvent) {
            event.preventDefault();
            event.stopPropagation();
            alert("입력하신 닉네임을 확인해주세요.");
            return false;
        } else {
           var nickname = $("#nick_upload").val();
	       $.ajax({
		        type: "POST",
		        url: "/nickname_change",
		        data: {
		        	"memberSeq" : memberSeq,
		        	"nickname" : nickname
		        },
		        success: function(response) { 
		    		console.log(response);
		    		$("#nick_final").html(nickname);
		    		$(".nick_container").hide();
		    		$("#nick_change").val("변경");
		    		},
				error: function(error) {
				       console.log(error);
					}
		     });
        }
	});	
	
	//닉네임 입력시 안내
	$("#nick_upload").keyup(function() {
		var nickname = $("#nick_upload").val();
		
		if((nickname === null || nickname.length < 2 || nickname.length > 20)) {
			$("#nick_warning").html("닉네임은 2글자부터 20글자까지 가능합니다.");	        
	        blockSaveEvent = true;	// 저장 버튼 중단
		} else {
			$("#nick_warning").html("");			
			blockSaveEvent = false // 저장 이벤트 초기화
		}
	})	
	
	
	//소개 변경 클릭
	$("#desc_change").click(function() {
		if ($("#desc_change").val() === "변경") {
			$("#desc_change").val("취소");
			$(".desc_container").show();
		} else {
			$(".desc_container").hide();
			$("#desc_change").val("변경");			
		}		
	});		
	
	//소개 저장 클릭
	$("#desc_save").click(function() {
		var description = $("#desc_upload").val();
	       $.ajax({
		        type: "POST",
		        url: "/description_change",
		        data: {
		        	"memberSeq" : memberSeq,
		        	"desc" : description
		        },
		        success: function(response) { 
		    		console.log(response);
		    		$("#desc_final").html(description);
		    		$(".desc_container").hide();
		    		$("#desc_change").val("변경");
		    		},
				error: function(error) {
				       console.log(error);
					}
		     });		
	})
	
	
	
	//url 변경 클릭
	$("#url_change").click(function() {
		if ($("#url_change").val() === "변경") {
			$("#url_change").val("취소");
			$(".url_container").show();
		} else {
			$(".url_container").hide();
			$("#url_change").val("변경");			
		}		
	});
	
	//url 저장 클릭
	$("#url_save").click(function() {
		
	});
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//메일 변경 클릭시
	$("#mail_change").click(function() {
		if ($("#mail_change").val() === "변경") {
			$("#mail_change").val("취소");
			$(".mail_container").show();
		} else {
			$(".mail_container").hide();
			$("#mail_change").val("변경");			
		}		
	})
	
	
	var authCode = "";	//코드
	var authRequestEmail = ""; //내가입력한이메일
	
	//인증메일 발송 클릭
	$("#mail_send").on("click", function(e){
			$.ajax({
				url: "mailauth",
				data:{'email': $("#mail_upload").val()},
				type: 'POST',
				dataType: 'json',
				success: function(response){
					if(response.isUniqueEmail == "true"){
						authCode = response.authCode;
						authRequestEmail = $("#mail_upload").val();
						$(".mail_send_result").html("메일이 발송되었습니다. 메일을 확인해주세요.")
					}else{
						alert("이미 존재하는 이메일입니다");
					}
				},
				error: function(request, e){
					alert("코드=" + request.status + " 메세지=" + request.responseText + " 오류=" + e);
				}
			});
	});

	
	//인증번호 확인 클릭
	$("#mail_save").on("click", function(e){
		if($("#mail_confirm").val() == authCode){
			if(authRequestEmail == $("#mail_upload").val()){
				alert("인증되었습니다");
				
			       $.ajax({
				        type: "POST",
				        url: "/email_change",
				        data: {
				        	"memberSeq" : memberSeq,
				        	"email" : authRequestEmail
				        },
				        success: function(response) { 
				    		console.log(response);
				    		$("#mail_final").html(authRequestEmail);
				    		$(".mail_container").hide();
				    		$("#nick_change").val("변경");
				    	},
						error: function(error) {
						       console.log(error);
						}
				     });	
			} else {
				alert("인증요청한 이메일이 일치하지 않습니다");
			}			
		} else {
			alert("잘못된 인증번호 입니다. 다시 확인 해주세요");
		}
	});
		

	
	
	//비번 변경 클릭
	$("#pw_change").click(function() {
		if ($("#pw_change").val() === "변경") {
			$("#pw_change").val("취소");
			$(".pw_container").show();
		} else {
			$(".pw_container").hide();
			$("#pw_change").val("변경");			
		}		
	})
	
	
	
	//새로운 비밀번호 특수문자 확인
	$("#pw_new1").keyup(function() {
	    let user_pw_reg = /[~!@#$%^*+=-?_]{1}/g;
	    let pwNew1 = $(this).val();

	    let checkChar = pwNew1.match(user_pw_reg);
	    if (!checkChar || checkChar.length < 2) {
	        $(".pw_new1_warning").html("특수문자 2개 이상을 포함해야 합니다.");        
	    } else if (pwNew1.length < 8 || pwNew1.length > 16) {
	    	$(".pw_new1_warning").html("8자리에서 16자리까지 입력해주세요.");
	    } else {
	        $(".pw_new1_warning").html(""); // 경고 메시지 지우기
	    }
	});
	
	
	//새로운 비밀번호 같은지 확인
	$("#pw_new2").keyup(function() {		
		if($("#pw_new1").val() !== $(this).val()) {
			$(".pw_new2_warning").html("비밀번호가 일치하지 않습니다.");
		} else {
			$(".pw_new2_warning").html("");
		}		
	});
		
		
	//비번 저장 클릭
	$("#pw_save").click(function(e) {
		var password = "${loginMember.password}";		

		if($("#pw_check").val() !== password) {		//현재 비밀번호가 일치하지 않을때			
			$(".pw_warning").html("비밀번호가 일치하지 않습니다.");
			$("#pw_check").keyup(function() {
			    $(".pw_warning").html("");
			});
		} else if ($(".pw_new1_warning").html() !== "") {
			e.preventDefault();
		} else if ($(".pw_new2_warning").html() !== "") {
			e.preventDefault();
		} else 	{
			newPw = $("#pw_new2").val();		       
			$.ajax({
			        type: "POST",
			        url: "/password_change",
			        data: {
			        	"memberSeq" : memberSeq,
			        	"newPw" : newPw
			        },
			        success: function(response) { 
			    		console.log(response);
			    		alert("비밀번호가 변경되었습니다.")
			    		$(".pw_container").hide();
			    		$("#pw_change").val("변경");
			    	},
					error: function(error) {
					       console.log(error);
					}
			     });	
		}	
	});
	

	//주소 추가 클릭
	$("#address_add").click(function() {
		if ($("#address_add").val() === "+ 추가") {
			$("#address_add").val("취소");
			$(".address_added").hide();
			$(".address_container").show();
		} else {
			$(".address_container").hide();
			$(".address_added").show();
			$("#address_add").val("+ 추가");			
		}		
	})
	
	//카카오 주소입력
	let isAddressPassed = false;
	$("#find_postcode").on("click", execDaumPostcode);
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
                document.getElementById("road_address").value = roadAddr;
                document.getElementById("jibun_address").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("extra_address").value = extraRoadAddr;
                } else {
                    document.getElementById("extra_address").value = '';
                }
            }
        }).open();
    }
	
	
	//연락처 입력
	$("#phone").keyup(function() {
		$(this).val( 
			$(this).val()
			.replace(/[^0-9]/g, "") //숫자제외입력불가
			.replace(/([0-9]{3})+([0-9]{4})+([0-9]{4})$/,"$1-$2-$3"));
	})	


	//주소 저장 클릭
	$("#address_save").click(function(e) {
		if($("#name").val() === "") {
			$("#name_result").html("수령자를 입력해주세요.");
			$("#name").keyup(function() {
				$("#name_result").html("");
			});			
		} else if ($("#phone").val().length < 13) {
			$("#phone_result").html("연락처를 확인해주세요.");
			$("#phone").keyup(function() {
				$("#phone_result").html("");
			})					
		} else if ($("#postcode").val() === "") {
			alert("우편번호 찾기 버튼을 눌러 주소를 입력해주세요.")
		} else if($("#detail_address").val() === "") {
			alert("상세 주소를 입력해주세요.")
		} else {	
			
        	var name = $("#name").val();
        	var phone = $("#phone").val();
        	var postcode = $("#postcode").val(); 
        	var road = $("#road_address").val(); 
        	var jibun = $("#jibun_address").val(); 
        	var extra = $("#extra_address").val(); 
        	var detail = $("#detail_address").val(); 
        	var defaultAddress = $("#default_address").prop("checked");
        	var requeste = $("#requeste").val();
			
			$.ajax({
		        type: "POST",
		        url: "/address_add",
		        data: {
		        	"memberSeq" : memberSeq,
		        	"name" : name, 
		        	"phone" : phone,
		        	"postcode" : postcode, 
		        	"road" : road, 
		        	"jibun" : jibun, 
		        	"extra" : extra, 
		        	"detail" : detail, 
		        	"defaultAddress" : defaultAddress,
		        	"requeste" : requeste		        	
		        },
		        success: function(response) { 
		    		console.log(response);
		    		$(".address_container").hide();
		    		$(".address_added").show();
		    		$("#address_add").val("+ 추가");		    		

		    	    var newAddressHtml = "<div class=\"addaddress\">";
		    	    newAddressHtml += "<div>" + name + "</div>";
		    	    newAddressHtml += "<div>" + phone + "</div>";
		    	    newAddressHtml += "<div>[" + postcode + "]</div>";
		    	    newAddressHtml += "<div>" + road + extra + "</div>";
		    	    newAddressHtml += "<div>" + detail + "</div>";
		    	    newAddressHtml += "<div> <input type=\"button\" value=\"삭제\" class=\"delete_address\" </div>";
		    	    newAddressHtml += "<hr></div>";

		    	    $(".address_added > div:eq(1)").append(newAddressHtml);
		    	    
		    	    $(".address_added > div:eq(1)").on("click", ".delete_address", function() {
		    	    	var deleteButton = $(this); // 클릭된 삭제 버튼
		    	    	if (confirm("해당 배송지를 삭제하시겠습니까?")){
		    	    		console.log("ajax 속 ajax 출발")
			    			$.ajax({
						        type: "POST",
						        url: "/address_add_delete",
						        data: {
						        	"memberSeq" : memberSeq,
						        	"name" : name, 
						        	"phone" : phone,
						        	"postcode" : postcode, 
						        	"road" : road, 
						        	"jibun" : jibun, 
						        	"extra" : extra, 
						        	"detail" : detail, 
						        },
						        success: function(response) { 
						    		console.log(response);
						    		alert("삭제되었습니다.")
						    		$(".addaddress").empty();
						    	},
								error: function(error) {
								       console.log(error);
								}
						     });//안ajax
		    	    	}//if confirm
		    	    })
		    	},//밖ajax의 success
				error: function(error) {
				       console.log(error);
				}
		     });//밖ajax			
		}//주소저장버튼의 else		
	})
	
	
	//주소 삭제
	$(".address_del").click(function() {
	    var name = $(this).data("name");
	    var phone = $(this).data("phone");
	    var postcode = $(this).data("postcode");
	    var road = $(this).data("road");
	    var detail = $(this).data("detail");
	    var count = $(this).data("for_delete");
	    
	    if (confirm("해당 주소를 삭제하시겠습니까?")) {
			$.ajax({
		        type: "POST",
		        url: "/address_delete",
		        data: {
		        	"memberSeq" : memberSeq,
		        	"name" : name, 
		        	"phone" : phone,
		        	"postcode" : postcode, 
		        	"road" : road, 
		        	"detail" : detail, 
		        },
		        success: function(response) { 
		    		alert("삭제되었습니다.")
		    		$(".for_delete" + count).remove();
		    	},
				error: function(error) {
				       console.log(error);
				}
		     });
	    }
	});
	
});
</script>

<body>

<h1>설정</h1>

<div>
	<div id="profile_detail" style="cursor:pointer;">프로필</div>
	<div id="account_detail" style="cursor:pointer;">계정</div>
	<div id="delivery_detail" style="cursor:pointer;">배송지</div>
</div>
<hr>
<p>

<div>


	<div class="profile">
		<div>
			<div>프로필 사진</div>
			<div><img src="${loginMember.profile_img }" id="img_final"></div>
			<div><input type="button" value="변경" id="img_change"></div>
			<div style="display: none;" class="img_container">
				<div><input type="file" value="이미지업로드"  id="img_upload"></div>
				<div><input type="button" value="삭제" id="img_del" ></div>
			</div>
		</div>
		<hr>
		<div>
			<div>닉네임</div>
			<div id="nick_final">${loginMember.nickname }</div>
			<div><input type="button" value="변경" id="nick_change"></div>
			<div style="display: none;" class="nick_container">
				<div><input type="text" value="${loginMember.nickname }"  id="nick_upload"></div>
				<div id="nick_warning"></div>
				<div><input type="button" value="저장" id="nick_save" ></div>
			</div>
		</div>
		<hr>
		
		<div>
			<div>자기소개</div>
	        <c:if test="${not empty loginMember.description}">
	            <div id="desc_final">${loginMember.description}</div>
	        </c:if>
	        <c:if test="${empty loginMember.description}">
	            <div>등록된 자기소개가 없습니다.</div>
	        </c:if>
	        <div><input type="button" value="변경" id="desc_change"></div>
			<div style="display: none;" class="desc_container">
				<div><textarea id="desc_upload" >${loginMember.description }</textarea></div>
				<div><input type="button" value="저장" id="desc_save" ></div>
			</div>
		</div>
		<hr>
		
		<div>
			<div>사용자 이름(URL)</div>
				<c:if test="${not empty loginMember.member_url}">
					<div>
						<span>${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}/user_profile/</span><span>${loginMember.member_url}</span>
					</div>
				</c:if>
			<div><input type="button" value="변경" id="url_change"></div>
			<div style="display: none;" class="url_container">
				<div><input type="text" value="${loginMember.member_url }"  placeholder="6자리 이상의 영문으로 작성해주세요." id="url_upload"></div>
				<div>사용자 이름은 회원님의 프로필 주소로 활용됩니다. 예) multiforce/user_profile/사용자이름</div>
				<div id="url_warning"></div>
				<div><input type="button" value="저장" id="url_save" ></div>
			</div>			
		</div>		
		<hr>

	</div>
	
	
	<div class="account" style="display: none;">
		<div>
			<div>이메일</div>
			<div id="mail_final">${loginMember.email }</div>
			<div><input type="button" value="변경" id="mail_change"></div>
			<div style="display: none;" class="mail_container">
				<div><input type="text" value="${loginMember.email }"  id="mail_upload"></div>
				<div class="mail_send_result"></div>
				<div><input type="button" value="인증메일 전송" id="mail_send" ></div>
				<div><input type="text"  placeholder="인증번호 입력"  id="mail_confirm"></div>
				<div><input type="button" value="인증번호 확인" id="mail_save" ></div>
			</div>
			<hr>
		</div>
			
		<div>
			<div>비밀번호</div>
			<div><input type="button" value="변경" id="pw_change"></div>
			<div style="display: none;" class="pw_container">
				<div>현재 비밀번호</div>
				<div><input type="password" id="pw_check"></div>
				<div class="pw_warning"></div>
				<br>
				<div>변경할 비밀번호</div>				
				<div><input type="password"  placeholder="변경할 비밀번호"  id="pw_new1"></div>
				<div class="pw_new1_warning"></div>
				<div><input type="password"  placeholder="변경할 비밀번호 확인"  id="pw_new2"></div>
				<div class="pw_new2_warning"></div>
				<div>특수문자 2개 이상 포함 필수 ~ ! @ # $ % ^ * + = - ? _</div>
				<div><input type="button" value="저장" id="pw_save" ></div>
			</div>
			<hr>
		</div>	
	</div>


	<div class="delevery" style="display: none;">
		<div class="address_added">
		    <div>등록된 배송지</div>
		    <div>
		        <c:choose>
		            <c:when test="${not empty delivery}">
		                <c:forEach var="delivery" items="${delivery}" varStatus="vs">
		                    <div class="for_delete${vs.count}" >
		                        <div>${delivery.name}</div>
								<c:if test="${delivery.default_address}">
								    <div style="color: red;">기본배송지</div>
								</c:if>
		                        <div>${delivery.phone}</div>
		                        <div>[${delivery.postcode}] ${delivery.road_address} ${delivery.extra_address}</div>
		                        <div>${delivery.detail_address}</div>
		                        <input type="button" value="삭제" class="address_del"
	                                   data-name="${delivery.name}"
						               data-phone="${delivery.phone}"
						               data-postcode="${delivery.postcode}"
						               data-road="${delivery.road_address}"
						               data-detail="${delivery.detail_address}"
						               data-for_delete="${vs.count }">
		                        <hr>                
		                    </div>
		                </c:forEach>
		            </c:when>
		            <c:otherwise>
		                <div>배송지를 등록해주세요.</div>
		            </c:otherwise>
		        </c:choose>       
		    </div>
		</div>
		<div><input type="button" value="+ 추가" id="address_add"></div>		
		
		<div style="display: none;" class="address_container">
			<div>새로운 배송지 입력</div>
			<div>수령자 : <input type="text" id="name"></div>
			<div id="name_result"></div>
			<div>연락처 : <input type="text" id="phone" maxlength="13" placeholder="숫자만 입력해주세요."></div>
			<div id="phone_result"></div>
			<div><input type="button" id="find_postcode" value="우편번호 찾기"></div>
			<div><input type="text" id="postcode" readonly placeholder="우편번호 찾기 클릭"></div>
			<div><input type="text" id="road_address" readonly placeholder="우편번호 찾기 클릭"></div>
			<div><input type="text" id="jibun_address" readonly placeholder="우편번호 찾기 클릭"></div>
			<div><input type="text" id="extra_address" readonly placeholder="우편번호 찾기 클릭"></div>
			<div><input type="text" id="detail_address"></div>
			<div>배송 요청사항 : <input type="text" id="requeste"></div>
			<div><input type="checkbox" id="default_address" checked>기본주소로 저장</div>
			<div><input type="button" id="address_save" value="저장"></div>
		</div>
				
	</div>
	
	
</div>


</body>
</html>