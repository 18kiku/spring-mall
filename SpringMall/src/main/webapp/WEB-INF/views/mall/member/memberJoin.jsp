<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/member/memberJoin.css">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>


<script>
	// ajax 사용. 중복체크
	function memberCheck(){
		let id = $("#id").val();
		
		$.ajax({
			url: 'memberCheck.do',
			type:'post',
			data:{id:id},
			success:function(cnt){
				if(cnt == 1){
					$('#chk_id').text('사용중인 아이디입니다.');
				} else if (cnt == 0){
					$('#chk_id').text('사용가능한 아이디입니다.');
				}
			},
			error:function(){
				alert("에러");
			}
		})
	}
	document.addEventListener("DOMContentLoaded", function(){
		let form = document.joinForm;
				
		// 비밀번호 - password
		// 비밀번호 유효성 검사 - 4글자 이상 입력하도록
		let chk_password = document.getElementById("chk_password");
		form.password.addEventListener("keyup", function(){
			if(form.password.value.length < 4){
				chk_password.innerText = "비밀번호는 4글자 이상이어야합니다.";
				chk_password.style.color = "red";
			} else{
				chk_password.innerText = "사용 가능한 비밀번호입니다.";
				chk_password.style.color = "blue";
			}
		})
		// 비밀번호 확인 - password2
		// 비밀번호와 비밀번호 확인의 내용이 동일한지 유무를 판단.
		let chk_password2 = document.getElementById("chk_password2");
		form.password2.addEventListener("keyup", function(){
			if(form.password.value == form.password2.value){
				chk_password2.innerText = "비밀번호가 일치합니다."
				chk_password2.style.color = "blue";
			} else{
				chk_password2.innerText = "비밀번호가 일치하지 않습니다."
				chk_password2.style.color = "red";
			}
		})
		// 이메일 검사 함수
		let isEmail = function(value){
			return (value.indexOf('@')>2) && (value.split('@')[1].indexOf('.')>2);
		}
		
		// 이메일 확인
		// 1. '@'문자를 포함하고 있는지의 여부 -> 아이디가 3글자 이상인지 판별
		// 2. '@'문자 다음에 '.'을 포함하고 있는지의 여부 -> 도메인도 3글자 이상인지 판별
		let chk_email = document.getElementById("chk_email");
		form.email.addEventListener("keyup", function(event){
			let value = form.email.value;
			if(isEmail(value)){
				chk_email.innerText = "이메일 형식이 맞습니다. " + value;
				chk_email.style.color="blue";
			} else{
				chk_email.innerText = "이메일 형식이 아닙니다. " + value;
				chk_email.style.color="red";
			}
		})
		
		// 주소찾기 버튼 - 다음 라이브러리 활용
		let btn_address = document.getElementById("btn_address");
		btn_address.addEventListener("click", function(){
			new daum.Postcode({
				oncomplete:function(data){
					form.address.value = data.address;
					form.postcode.value = data.zonecode;
				}
			}).open();
		})
		
		// 회원가입 페이지의 전체 내용 입력 유무에 따른 유효성 검사와 페이지 이동 처리
		let btn_insert = document.getElementById("btn_insert");
		btn_insert.addEventListener("click", function(){
			if(form.id.value.length == 0){
				alert(`아이디를 입력하고, 아이디 중복체크를 해주세요.`);
				form.id.focus();
				return;
			}
			if(form.password.value.length == 0){
				alert(`비밀번호를 입력해주세요.`);
				form.password.focus();
				return;
			}
			if(form.password2.value.length == 0){
				alert(`비밀번호를 확인해주세요.`);
				form.password2.focus();
				return;
			}
			if(form.password.value != form.password2.value){
				alert("비밀번호가 일치하지 않습니다.");
				form.password2.focus();
				return;
			}
			if(form.birth.value.length == 0){
				alert(`생년월일을 입력해주세요.`);
				form.birth.focus();
				return;
			}
			if(form.gender.value.length == 0){
				alert(`성별을 입력해주세요.`);
				form.gender.focus();
				return;
			}
			if(form.name.value.length == 0){
				alert(`이름을 입력해주세요.`);
				form.name.focus();
				return;
			}
			if(form.email.value.length == 0){
				alert(`이메일을 입력해주세요.`);
				form.email.focus();
				return;
			}
			if(form.tel.value.length == 0){
				alert(`전화번호를 입력해주세요.`);
				form.tel.focus();
				return;
			}
			if(form.address.value.length == 0){
				alert(`주소를 입력해주세요.`);
				form.address.focus();
				return;
			}
			if(form.address_detail.value.length == 0){
				alert(`상세주소를 입력해주세요.`);
				form.address_detail.focus();
				return;
			}
			form.submit();
		})
		let btn_cancel = document.getElementById("btn_cancel");
		btn_cancel.addEventListener("click", function(){
			location = "shopMain.do";
		})
	})
</script>
<main>
<div class="t_title">
	회원가입
</div>
<form action="memberJoin.do" method="post" name="joinForm">
	<table>
	<tr>
		<th>
			아이디
		</th>
		<td>
			<input type="text" name="id" id="id">
			<input type="button" value="ID 중복 체크" id="btn_chk_id" onclick="memberCheck()"><br>
			<span id=chk_id></span>
		</td>
	</tr>
	<tr>
		<th>
			비밀번호
		</th>
		<td>
			<input type="password" name="password" size=15><br>
			<span id="chk_password"></span>
		</td>
	</tr>
	<tr>
		<th>
			비밀번호 확인
		</th>
		<td>
			<input type="password" name="password2" id="" size=15><br>
			<span id="chk_password2"></span>
		</td>
	</tr>
	<tr>
		<th>
			이름
		</th>
		<td>
			<input type="text" name="name" id="name" size=15>
		</td>
	</tr>
	<tr>
		<th>
			생년월일
		</th>
		<td>
			<input type="text" name="birth" id="birth" size=15>
		</td>
	</tr>
	<tr>
		<th>
			성별
		</th>
		<td>
			<input type="text" name="gender" id="gender" size=15>
		</td>
	</tr>
	<tr>
		<th>
			이메일
		</th>
		<td>
			<input type="email" name="email" id="email" size=30><br>
			<span id="chk_email"></span>
		</td>
	</tr>
	<tr>
		<th>
			전화번호
		</th>
		<td>
			<input type="tel" name="tel" id="tel">
		</td>
	</tr>
	<tr class="addr_row">
		<th>
			주소
		</th>
		<td>
			<input type="button" value="주소찾기" id="btn_address"><br>
			<input type="text" name="address" id="address" size=49><br>
			<input type="text" name="address_detail" id="address_detail" size=49>
			<input type="hidden" name="postcode" id="postcode">
		</td>
	</tr>
	</table>
	<div class="btns">
		<input type="button" value="회원가입" id="btn_insert">&emsp;&emsp; <input type="button" value="취소" id="btn_cancel">
	</div>
</form>
</main>