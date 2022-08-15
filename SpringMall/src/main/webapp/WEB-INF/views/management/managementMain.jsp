<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Management</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/management/managementMain.css" />
</head>
<body>
<div class="container">
	<div class="m_title">
		<a href="#">Management</a>
	</div>
	<div class="s_title">
		관리자 페이지
	</div>
	<span class="admin"><%-- ${admin } --%>님</span>
	<div class="c_logout">
		<a href="managementLogout.do">로그아웃</a>
	</div>
	<table>
	<tr class="title_row">
		<th>
			상품 관리
		</th>
	</tr>
	<tr class="a_row">
		<th>
			<a href="productInsert.do">상품 등록</a>
		</th>
	</tr>
	<tr class="a_row">
		<th>
			<a href="productList.do">상품 목록(수정/삭제)</a>
		</th>
	</tr>
	<tr class="title_row">
		<th>
			주문 관리
		</th>
	</tr>
	<tr class="a_row">
		<th>
			<a href="">주문 목록(수정/삭제)</a>
		</th>
	</tr>
	<tr class="title_row">
		<th>
			회원 관리
		</th>
	</tr>
	<tr class="a_row">
		<th>
			<a href="">회원 목록(수정/삭제)</a>
		</th>
	</tr>
	</table>
</div>
</body>
</html>