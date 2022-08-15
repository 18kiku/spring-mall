<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/management/managementLogin.css" />
</head>
<body>
<div id="container">
	<div class="t_title">
		Management LOGIN
	</div>
	<form action="managementLogin.do" method="post" name="loginForm">
		<div class="f_input">
			<div class="f_id">
				<input type="text" id="id" name="id" class="c_id" placeholder="아이디" size="55">
			</div>
			<div class="f_pwd">
				<input type="password" id="password" name="password" class="c_pwd" placeholder="비밀번호" size="55">
			</div>
			<div class="f_submit">
				<input type="submit" id="btn_login" value="로그인">
			</div>
		</div>
	</form>
</div>
</body>
</html>