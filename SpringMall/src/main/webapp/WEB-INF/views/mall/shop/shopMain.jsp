<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/shop/shopMain.css?v">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">

<script>
	$(document).ready(function() {
		$('.slider').bxSlider({
			autoControls : true,
			stopAutoOnclick : true,
			auto : true,
			autoHover : true,
			speed : 2000,
			pause : 3000,
			slideWidth : 1200,
			slideHeight : 400,
			maxSlides : 1,
			minSlides : 1,
			moveSlides : 1,
			slideMargin : 20,
			touchEnabled : false
		});
	});
</script>

<main>
<article class="main_img">
<div class="slider">
	<img alt="main2" src="<spring:url value='/resources/img/main2.jpg'/>"> <img alt="main3" src="<spring:url value='/resources/img/main3.jpg'/>">
</div>
</article>
</main>

