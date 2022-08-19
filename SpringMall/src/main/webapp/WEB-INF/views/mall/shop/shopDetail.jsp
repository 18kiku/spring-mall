<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>       

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/shop/shopDetail.css?v">
<script>
    $(document).ready(function () { 
        
        // 수량 버튼 조작
        let quantity = $(".input_quantity").val();
        $(".btn_plus").on("click", function () {
            $(".input_quantity").val(++ quantity);
        });
        $(".btn_minus").on("click", function () {
            if (quantity > 1) {
                $(".input_quantity").val(-- quantity);
            }
        });
        let cartForm = {
        		ordererId: '${member.id}',
        		productId: '${product.productId}',
        		orderQuantity: ''
        }
        // 장바구니 추가 버튼
        $(".btn_cart").on("click", function (e) {
        	cartForm.orderQuantity = $(".input_quantity").val();
            $.ajax({
                url: 'cartInsert.do',
                type: 'POST',
                data: cartForm,
                success: function (message) {
                	if (message == 0) {
                        alert("장바구니에 추가하지 못하였습니다.");
                    } else if (message == 1) {
                        if(confirm("장바구니에 추가되었습니다.\n장바구니로 이동하시겠습니까?")){
                        	location = "cartList.do";
                        }
                    } else if (message == 2) {
                    	if(confirm("장바구니에 추가되었습니다.(상품개수를 업데이트했습니다.)\n장바구니로 이동하시겠습니까?")){
                        	location = "cartList.do";
                        }
                    } else if (message == 10917) {
                        alert("로그인을 해주세요.");
                        location = "memberLogin.do";
                    }
                },
                error: function(message){
                	alert('오류');
                }
            })
        });
        /* 구매 버튼 */
        $(".btn_order").on("click", function () {
        	let ordererId = $("input[name='orderList[0].ordererId']").val();
        	let orderQuantity = $(".input_quantity").val();
			let orderAmount = $(".input_discount_price").val() * $(".input_quantity").val();
			
			if(!orderer_id){
				alert('로그인을 해주세요');
				location = 'memberLogin.do';
				return;
			}
			$(".orderForm").find("input[name='orderList[0].orderQuantity']").val(orderQuantity);
			$(".orderForm").find("input[name='orderList[0].orderAmount']").val(orderAmount);
			$(".orderForm").submit();
			
        });
    });
    
    
</script>
<main>
<div class="wrapper">
	<div class="wrap">
		<div class="content_area">
			<div class="content_top">
				<div class="dt_left_area">
					<div class="image_wrap">
						<img alt="product_image" src="${pageContext.request.contextPath}/resources/img/${product.productImage }">
					</div>				
				</div>
				<div class="dt_right_area">
					<div class="title">
						<h1>
							${product.productName}
						</h1>
					</div>
					<div class="line"></div>
					<div class="brand">
						 <span>
						 	브랜드 | ${product.productBrand} 
						 </span>
					</div>
					<div class="line"></div>
					<div class="color">
						 <span>
						 	색상 | &emsp;${product.productColor} 
						 </span>
					</div>
					<div class="line"></div>
					<div class="size">
						 <span>
						 	사이즈 | ${product.productSize} 
						 </span>
					</div>
					<div class="line"></div>
					<div class="price">
						<div class="list_price">정가 : <fmt:formatNumber value="${product.productPrice}" pattern="#,### 원" /></div>
						<div class="discount_price">
							판매가 : <span class="number_discount_price"><fmt:formatNumber value="${product.productPrice - (product.productPrice*product.discountRate/100)}" pattern="#,### 원" /></span>
							<input type="hidden" class="input_discount_price" value="${product.productPrice - (product.productPrice*product.discountRate/100)}"> 
							[<fmt:formatNumber value="${product.discountRate}" pattern="###" />% 
							<fmt:formatNumber value="${product.productPrice*product.discountRate}" pattern="#,### 원" /> 할인]
						</div>						
					</div>			
					<div class="line">
					</div>	
					<div class="button">						
						<div class="btn_quantity">
							주문수량 | 
							<input type="number" class="input_quantity" value="1">
							<span>
								<input type="button" class="btn_plus" value="+">
								<input type="button" class="btn_minus" value="-">
							</span>
						</div>
						<div class="space_vertical"></div>
						<div class="button_set">
							<input type="button" class="btn_cart" value="add in cart">
							<input type="button" class="btn_order" value="order">
						</div>
					</div>
				</div>
			</div>
			<div class="line">
			</div>				
			<div class="content_middle">
				<h3>상품 상세 정보</h3>
				<div class="product_detail">
					<img alt="product_detail" src="${pageContext.request.contextPath}/resources/img/${product.productDetail }">
				</div>
			</div>
			<!-- 주문 form -->
			<form action="orderCheck.do?orderer_id=${sessionScope.member.id}" method="get" class="orderForm">
				<input type="hidden" name="orderList[0].ordererId" value="${sessionScope.member.id }">
				<input type="hidden" name="orderList[0].productId" value="${product.productId }">
				<input type="hidden" name="orderList[0].orderQuantity" value="">
				<input type="hidden" name="orderList[0].orderAmount" value="">
			</form>
		</div>
	</div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->
</main>