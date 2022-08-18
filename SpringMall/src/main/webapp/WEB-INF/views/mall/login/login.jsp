<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/login/login.css?v">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

	document.addEventListener("DOMContentLoaded", function(){
		let form = document.loginForm;
		form.id.focus();
		// 로그인 버튼을 클릭했을때 유효성검사 (공백유무)
		let btn_login = document.getElementById("btn_login");
		btn_login.addEventListener("click", function(){
			if(!form.id.value){
				alert("아이디를 입력해주세요!");
				form.id.focus();
				return;
			}
			if(!form.password.value){
				alert("비밀번호를 입력해주세요!");
				form.password.focus();
				return;
			}
			form.submit();	
		})
		// keyup 이벤트. enter 키를 눌렀을때 submit. -> 현재는 테스트를 위해 password에 걸어놨지만 test 종료 후 id에 걸도록 한다
		let password = document.getElementById("password");
		password.addEventListener("keyup",function(e){
			if(e.keyCode == 13){
				form.submit();
			}
		})
		// 쿠키가 생성되어있을때 쿠키에 저장된 값인 아이디를 아이디 입력상자에 넣어준다.
		// 쿠키 확인 - 쿠키가 존재한다면
		if(document.cookie.length > 0){
			var search = "cookieId=";
			var idx = document.cookie.indexOf(search);
			if(idx != -1){ // cookieId 값이 존재
				idx += search.length;
				var end = document.cookie.indexOf(';', idx);
				if(end == -1){
					end = document.cookie.length;
				}
				form.id.value = document.cookie.substring(idx, end);
				form.chk.checked = true;
			}
		}
		// ****************cookieId=aaa1111;path=/;expires=
		// 로그인 상태 유지 체크박스를 체크했을때 -> 쿠키
		// http속성 : 연결상태를 유지하지않음
		// cookie, session : 연결상태를 유지함.
		// cookie : 연결정보를 클라이언트 쪽에 저장, session : 연결정보를 서버쪽에 저장
		// escape() 함수 : *,-,_,+,.,/ 를 제외한 모든 문자를 16진수로 변환하는 함수
		// 쉼표, 세미콜론 등과 같은 문자가 쿠키에서 사용되는 문자열과 충돌을 방지하기 위해서 사용
		let chk = document.getElementById("chk");
		chk.addEventListener("click", function(){
			let now = new Date(); // 오늘 날짜
			let name = "cookieId"; // 쿠키 이름
			let value = form.id.value; // 쿠키 값
			if(form.chk.checked == true){ // 체크했을때 -> 쿠키 생성, 쿠키 만료시간 설정
				now.setDate(now.getDate() + 7); // 만료시간 : 날짜를 지금부터 7일 후로 설정
			} else{ // 체크안했을때 -> 쿠키 삭제
				now.setDate(now.getDate() + 0); // 만료시간 : 지금으로 설정
			}
			// 쿠키 생성시에 필요한 정보 - 쿠키의 이름과 값, 위치, 만료시간
			document.cookie = 
				name + "=" + escape(value) + ";path=/;expires=" + now.toGMTString() + ";";
		})
	})
</script>
<main>
<div class="t_title">
	 LOGIN
</div>
<form action="memberLogin.do" method="post" name="loginForm">
	<div class="f_input">
		<div class="f_id">
			<input type="text" id="id" name="id" class="c_id" placeholder="아이디" size="55">
		</div>
		<div class="f_password">
			<input type="password" id="password" name="password" class="c_password" placeholder="비밀번호" size="55">
		</div>
		<div class="f_chk">
			<input type="checkbox" id="chk" class="c_chk" size=55>&emsp; <label for="chk">아이디 저장</label>
		</div>
		<div class="f_submit">
			<input type="button" id="btn_login" value="로그인">
		</div>
	</div>
	<div class="f_a">
		<a href="#">비밀번호 찾기</a>&emsp;|&emsp; <a href="#">아이디 찾기</a>&emsp;|&emsp; <a href="memberJoin.do">회원가입</a>
	</div>
</form>
</main>