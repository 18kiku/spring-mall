<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/shop/shopList.css?vzz">
<script>
	$(document).ready(function(){
		/* 주문하기 버튼 */
		$(".btn_order").on("click",function(e){
			e.preventDefault();
			
			let orderer_id = $("input[name='orderList[0].orderer_id']").val();
			let order_amount = Math.floor($(".input_sale_price").val());
			
			if(!orderer_id){
				alert('로그인을 해주세요');
				location = 'memberLogin.do';
				return;
			}
			$(".orderForm").find("input[name='orderList[0].order_amount']").val(order_amount);
			$(".orderForm").submit();
		})
	})
</script>
<main>
<div class="d_category2">
	 CATEGORY : <span>${productList[0].category_name }</span>
</div>
<div class="products">
	<c:forEach var="product" items="${productList }">
	<div class="d_category3">
		<div class="c_product">
			<div class="c_p1">
				<img alt="product_image" src="${pageContext.request.contextPath}/resources/img/${product.product_image }">
			</div>
			<div class="c_p2">
				<span title="${product.product_name }">${product.product_name }</span><br>
			</div>
			<div class="c_p3">
				<span title="${product.product_brand }">${product.product_brand }</span>
			</div>
			<div class="c_p4">
				<span><fmt:formatNumber value="${product.product_price - (product.product_price*product.discount_rate/100) }" pattern="#,###,###원"/></span>
				<input type="hidden" class="input_sale_price" value="${product.product_price - (product.product_price*product.discount_rate/100) }">
			</div>
		</div>
		<div class="c_product2">
			<div class="c_p5">
				<a href="#" class="btn_order">구매</a>
			</div>
			<div class="c_p6">
				<a href="shopDetail.do?product_id=${product.product_id }">상세</a>
			</div>
		</div>
		<!-- 주문 form -->
			<form action="orderCheck.do?orderer_id=${sessionScope.member.id}" method="get" class="orderForm">
				<input type="hidden" name="orderList[0].orderer_id" value="${sessionScope.member.id }">
				<input type="hidden" name="orderList[0].product_id" value="${product.product_id }">
				<input type="hidden" name="orderList[0].order_quantity" value="1">
				<input type="hidden" name="orderList[0].order_amount" value="">
			</form>
	</div>
	</c:forEach>
</div>
<div class="clearfix"></div>
<div class="paging">
	<!-- 첫 페이지 -->
	<c:if test="${pageDTO.prev }">
		<a href="shopList.do?product_category=${productList[0].product_category }&pageNum=1" class="p_box p_box_bold">prev</a>
	</c:if>
	<!-- 이전 페이지 -->
	<c:if test="${pageDTO.prev }">
		<c:set var="pageNum" value="${param.pageNum-10 }"/>	
		<a href="shopList.do?product_category=${productList[0].product_category }&pageNum=${pageNum }" class="p_box p_box_bold">next</a>
	</c:if>
	
	<!-- 페이지 번호 -->
	<c:forEach var="pageNum" varStatus="s" begin="${pageDTO.startPage }" end="${pageDTO.endPage }">
		<c:if test="${param.pageNum == pageNum }">
			<a href="shopList.do?product_category=${productList[0].product_category }&pageNum=${pageNum }" class="p_box_choice">${pageNum }</a>
		</c:if>
		<c:if test="${param.pageNum != pageNum }">
			<a href="shopList.do?product_category=${productList[0].product_category }&pageNum=${pageNum }" class="p_box">${pageNum }</a>
		</c:if>
	</c:forEach>
	
	<!-- 다음 페이지 -->
	<c:if test="${pageDTO.next }">
	<c:set var="pageNum" value="${param.pageNum+10 }"/>
		<c:if test="${pageNum > pageDTO.pageCount }">
			<c:set var="pageNum" value="${pageDTO.pageCount-1 }"/>
		</c:if>
		<a href="shopList.do?product_category=${productList[0].product_category }&pageNum=${pageNum }" class="p_box p_box_bold">next</a>
	</c:if>
	<!-- 마지막 페이지 -->
	<c:if test="${pageDTO.prev }">
	<c:set var="pageNum" value="${pageDTO.pageCount }"/>
		<a href="shopList.do?product_category=${productList[0].product_category }&pageNum=${pageNum-1 }" class="p_box p_box_bold">prev</a>
	</c:if>
</div>
</main>