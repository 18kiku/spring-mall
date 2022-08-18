<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
@import url('https://fonts.googleapis.com/css2?family=Dongle&family=Hi+Melody&family=Jua&family=Zen+Loop&display=swap');
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/common/shopHeader.css?v">
<header>
<%-- 상단 --%>
<div class="t_box1">
	<%-- 구역1 (상단좌측): 로그인, 회원가입, 고객센터 --%>
	<c:if test="${sessionScope.member==null }">
		<a href="memberLogin.do"><span>로그인</span></a>&ensp;|&ensp; 
		<a href="memberJoin.do"><span>회원가입</span></a> &ensp;|&ensp; 
		<a href="#"><span>고객센터</span></a>
	</c:if>
	<c:if test="${sessionScope.member !=null }">
		<a href="memberInfo.do">${sessionScope.member.name }님</a>&ensp;|&ensp;
		<a href="memberLogout.do">로그아웃</a>&ensp;|&ensp; 
		<a href="#"><span>고객센터</span></a>
	</c:if>
	
</div>
<div class="t_box2">
	<%-- 구역2 (상단우측): 회원정보, 구매정보, 장바구니정보 --%>
	<c:if test="${sessionScope.member !=null }">
	<a href="memberInfo.do">
	<img alt="user-white" src="<spring:url value='/resources/img/user-white.png'/>" width="35" title="회원정보" class="t_box2_img1"> </a>
	<a href="orderList.do?orderer_id=${sessionScope.member.id }">
	<img alt="buy-white" src="<spring:url value='/resources/img/buy-white.png'/>" width="35" title="구매정보" class="t_box2_img2"> </a>
	<a href="cartList.do">
	<img alt="cart-white" src="<spring:url value='/resources/img/cart-white.png'/>" width="35" title="장바구니정보" class="t_box2_img3"> </a>
	</c:if>
	<c:if test="${sessionScope.member==null }">
	<a href="memberLogin.do">
	<img alt="user-white" src="<spring:url value='/resources/img/user-white.png'/>" width="35" title="회원정보" class="t_box2_img1"> </a>
	<a href="memberLogin.do">
	<img alt="buy-white" src="<spring:url value='/resources/img/buy-white.png'/>" width="35" title="구매정보" class="t_box2_img2"> </a>
	<a href="memberLogin.do">
	<img alt="cart-white" src="<spring:url value='/resources/img/cart-white.png'/>" width="35" title="장바구니정보" class="t_box2_img3"> </a>
	</c:if>
</div>
<div class="t_box3">
	<%-- 구역3 (중단): 타이틀, 검색 --%>
	<div class="m_title">
		<a href="shopMain.do">Shopping Mall</a>
	</div>
	<div class="s_title">
		18KIKU
	</div>
</div>
<%-- 하단 --%>
<div class="t_box4">
	<%-- 구역4 (하단): 메인메뉴(하위메뉴) --%>
	<div class="hover">
		<div class="m_menu1 main">
			<a href="#">MENU</a>
		</div>
		<div class="s_menu1 sub">
			<div>
				<a href="shopList.do?product_category=111">SUBMENU</a>
			</div>
			<div>
				<a href="shopList.do?product_category=121">SUBMENU</a>
			</div>
			<div>
				<a href="shopList.do?product_category=131">SUBMENU</a>
			</div>
		</div>
	</div>
	<div class="hover">
		<div class="m_menu2 main">
			<a href="#">MENU</a>
		</div>
		<div class="s_menu2 sub">
			<div>
				<a href="shopList.do?product_category=211">SUBMENU</a>
			</div>
			<div>
				<a href="shopList.do?product_category=221">SUBMENU</a>
			</div>
			<div>
				<a href="shopList.do?product_category=231">SUBMENU</a>
			</div>
			<div>
				<a href="shopList.do?product_category=241">SUBMENU</a>
			</div>
		</div>
	</div>
	<div class="hover">
		<div class="m_menu3 main">
			<a href="#">MENU</a>
		</div>
		<div class="s_menu3 sub">
			<div>
				<a href="shopList.do?product_category=300">SUBMENU</a>
			</div>
		</div>
	</div>
	<div class="hover">
		<div class="m_menu4 main">
			<a href="#">MENU</a>
		</div>
		<div class="s_menu4 sub">
			<div>
				<a href="shopList.do?product_category=411">SUBMENU</a>
			</div>
			<div>
				<a href="shopList.do?product_category=421">SUBMENU</a>
			</div>
		</div>
	</div>
	<div class="hover">
		<div class="m_menu5 main">
			<a href="#">MENU</a>
		</div>
		<div class="s_menu5 sub">
			<div>
				<a href="shopList.do?product_category=500">SUBMENU</a>
			</div>
			<div>
				<a href="shopList.do?product_category=500">SUBMENU</a>
			</div>
		</div>
	</div>
	<div class="hover">
		<div class="m_menu6 main">
			<a href="#">MENU</a>
		</div>
		<div class="s_menu6 sub">
			<div>
				<a href="shopList.do?product_category=600">SUBMENU</a>
			</div>
			<div>
				<a href="shopList.do?product_category=600">SUBMENU</a>
			</div>
			
		</div>
	</div>
</div>
<div class="top_end"></div>
<hr class="end_line">
</header>