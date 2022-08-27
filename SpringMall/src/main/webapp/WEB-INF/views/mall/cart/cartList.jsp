<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/cart/cartList.css?v">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
    $(document).ready(function () { /* 종합 정보 섹션 정보 삽입 */
        setTotalInfo();
        /* 체크여부에따른 종합 정보 변화  */
        $(".checkbox_individual_cart").on("change", function () { /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
            setTotalInfo($(".td_cart_list"));
        });
        /* 체크박스 전체 선택 */
        $(".input_all_check").on("click", function () { /* 체크박스 체크/해제 */
            if ($(".input_all_check").is(":checked")) {
                $(".checkbox_individual_cart").prop("checked", true);
            } else {
                $(".checkbox_individual_cart").prop("checked", false);
            }
            $(".checkbox_individual_cart").on("click", function () {
                let totalCheckbox = $(".checkbox_individual_cart").length;
                let checked = $(".checkbox_individual_cart:checked").length;
                if (totalCheckbox != checked) {
                    $(".input_all_check").prop("checked", false);
                } else {
                    $(".input_all_check").prop("checked", true);
                }
            })
            /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
            setTotalInfo($(".td_cart_list"));
        });
        /* 수량버튼 */
        $(".btn_plus").on("click", function () {
            let quantity = $(this)
                .parent("div")
                .find("input")
                .val();
            $(this)
                .parent("div")
                .find("input")
                .val(++ quantity);
        });
        $(".btn_minus").on("click", function () {
            let quantity = $(this)
                .parent("div")
                .find("input")
                .val();
            if (quantity > 1) {
                $(this)
                    .parent("div")
                    .find("input")
                    .val(-- quantity);
            }
        });
        let updateForm = {
            ordererId: '${member.id}',
            productId: '',
            orderQuantity: ''
        }
        /* 수량 수정 버튼 */
        $(".btn_quantity_modify").on("click", function () {
            updateForm.productId = $(this).data("productId");
            updateForm.orderQuantity = $(this)
                .parent("td")
                .find("input")
                .val();
            $.ajax({
                url: 'cartUpdate.do',
                type: 'POST',
                data: updateForm,
                success: function (message) {
                    if (message == 0) {
                        alert("수량을 변경하지 못하였습니다.");
                    } else if (message == 1) {
                        alert("수량을 변경했습니다.");
                        location = "cartList.do";
                    } else if (message == 2) {
                        alert("???????????");
                    } else if (message == 10917) {
                        alert("로그인을 해주세요.");
                        location = "memberLogin.do";
                    }
                },
                error: function (message) {
                    alert('오류');
                }
            })
        });
        let deleteForm = {
            ordererId: '${member.id}',
            cartId: ''
        }
        /* 장바구니 개별 삭제 버튼 */
        $(".btn_delete").on("click", function (e) {
            deleteForm.cartId = $(this).data("cartId");
            $.ajax({
                url: 'cartDelete.do',
                type: 'POST',
                data: deleteForm,
                success: function (message) {
                    if (message == 0) {
                        alert("삭제에 실패했습니다.");
                    } else if (message > 0 && message < 10917) {
                        alert("삭제되었습니다.");
                        location = 'cartList.do';
                    } else if (message == 10917) {
                        alert("로그인을 해주세요.");
                        location = "memberLogin.do";
                    }
                },
                error: function (message) {
                    alert('오류');
                }
            })
        });
        /* 장바구니 전체 삭제 버튼 */
        $(".input_all_delete").on("click", function (e) {
            $.ajax({
                url: 'cartDeleteById.do',
                type: 'POST',
                data: {
                    ordererId: $(this).data("ordererId")
                },
                success: function (message) {
                    if (message == 0) {
                        alert("삭제에 실패했습니다.");
                    } else if (message > 0 && message < 10917) {
                        alert("모두 삭제되었습니다.");
                        location = 'cartList.do';
                    } else if (message == 10917) {
                        alert("로그인을 해주세요.");
                        location = "memberLogin.do";
                    }
                },
                error: function (message) {
                    alert('오류');
                }
            })
        });
        /* 주문 페이지 이동 */
        $(".btn_order").on("click", function () {
            let formContents = '';
            let orderNumber = 0;
            $(".td_cart_list").each(function (index, element) {
                if ($(element).find(".checkbox_individual_cart").is(":checked") === true) {
                    let productId = $(element).find(".input_individual_product_id").val();
                    let orderQuantity = $(element).find(".input_individual_order_quantity").val();
                    let orderAmount = $(element).find(".input_individual_totalPrice").val();
                    let productId_input = "<input name='orderList[" + orderNumber + "].productId' type='hidden' value='" + productId + "'>";
                    formContents += productId_input;
                    let orderQuantity_input = "<input name='orderList[" + orderNumber + "].orderQuantity' type='hidden' value='" + orderQuantity + "'>";
                    formContents += orderQuantity_input;
                    let orderAmount_input = "<input name='orderList[" + orderNumber + "].orderAmount' type='hidden' value='" + orderAmount + "'>";
                    formContents += orderAmount_input;
                    orderNumber += 1;
                }
            });
            $(".orderForm").html(formContents);
            $(".orderForm").submit();
        });
    });
    /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
    function setTotalInfo() {
        let totalPrice = 0; // 총 가격
        let totalCount = 0; // 총 갯수
        let totalKind = 0; // 총 종류
        let deliveryPrice = 0; // 배송비
        let finalTotalPrice = 0; // 최종 가격(총 가격 + 배송비)
        $(".td_cart_list").each(function (index, element) {
            if ($(element).find(".checkbox_individual_cart").is(":checked") === true) {
                // 체크여부
                // 총 가격
                totalPrice += parseInt($(element).find(".input_individual_totalPrice").val());
                // 총 갯수
                totalCount += parseInt($(element).find(".input_individual_order_quantity").val());
                console.log(totalPrice);
                // 총 종류
                totalKind += 1;
            }
        });
        /* 배송비 결정 */
        if (totalPrice >= 30000) {
            deliveryPrice = 0;
        } else if (totalPrice == 0) {
            deliveryPrice = 0;
        } else {
            deliveryPrice = 3000;
        } finalTotalPrice = totalPrice + deliveryPrice;
        /* ※ 세자리 컴마 Javscript Number 객체의 toLocaleString() */
        // 총 가격
        $(".span_totalPrice").text(totalPrice.toLocaleString());
        // 총 갯수
        $(".span_totalCount").text(totalCount);
        // 총 종류
        $(".span_totalKind").text(totalKind);
        // 배송비
        $(".delivery_price").text(deliveryPrice);
        // 최종 가격(총 가격 + 배송비)
        $(".span_finalTotalPrice").text(finalTotalPrice.toLocaleString());
    }
</script>
<main>
<div class="wrapper">
	<div class="wrap">
		<div class="content_area">
			<div class="content_subject"><span>장바구니</span></div>
			<!-- 장바구니 리스트 -->
			<div class="content_middle_section"></div>
			<!-- cartList -->
			<div class="content_totalCount_section">
				
				<!-- 체크박스 전체 여부 -->
				<div class="div_all_input">
					<span class="span_all_check"><input type="checkbox" class="input_all_check input_size_20" checked="checked">전체선택</span>
					<input type="button" class="input_all_delete" data-orderer-id="${member.id }" value="전체 삭제">
				</div>			
				<div class="clearfix"></div>
				
				<table class="table_subject">
					<caption>표 제목 부분</caption>
					<tbody>

						<tr>
							<th class="td_width_1"></th>
							<th class="td_width_2"></th>
							<th class="td_width_3">상품명</th>
							<th class="td_width_4">가격</th>
							<th class="td_width_4">수량</th>
							<th class="td_width_4">합계</th>
							<th class="td_width_4">삭제</th>
						</tr>
					</tbody>
				</table>
				<table class="table_cart">
					<caption>표 내용 부분</caption>
					<tbody>
						<c:forEach items="${cartList}" var="cart">
							<tr>
								<td class="td_width_1 td_cart_list">
									<input type="checkbox" class="checkbox_individual_cart input_size_20" checked="checked">
									<input type="hidden" class="input_individual_product_price" value="${cart.productPrice}">
									<input type="hidden" class="input_individual_order_amount" value="${cart.salePrice}">
									<input type="hidden" class="input_individual_order_quantity" value="${cart.orderQuantity}">
									<input type="hidden" class="input_individual_totalPrice" value="${cart.totalPrice}">
									<input type="hidden" class="input_individual_product_id" value="${cart.productId}">								
								</td>
								<td class="td_width_2">
									<div>
										<img alt="product_image" src="${pageContext.request.contextPath}/resources/img/${cart.productImage }" width="60" height="60">
									</div>								
								</td>
								<td class="td_width_3">${cart.productName}</td>
								<td class="td_width_4 td_price">
									<div class="list_price">정가 : <fmt:formatNumber value="${cart.productPrice}" pattern="#,### 원" /></div><br>
									판매가 : <span class="red_color"><fmt:formatNumber value="${cart.salePrice}" pattern="#,### 원" /></span>
								</td>
								<td class="td_width_4 table_text_align_center">
									<div class="table_text_align_center div_quantity">
										<input type="text" value="${cart.orderQuantity}" class="input_quantity">	
										<button class="btn_quantity btn_plus">+</button>
										<button class="btn_quantity btn_minus">-</button>
									</div>
									<input type="button" class="btn_quantity_modify" data-product-id="${cart.productId}" value="변경">
								</td>
								<td class="td_width_4 table_text_align_center">
									<fmt:formatNumber value="${cart.totalPrice}" pattern="#,### 원" />
								</td>
								<td class="td_width_4 table_text_align_center">
									<input type="button" class="btn_delete" data-cart-id="${cart.cartId}" value="삭제">
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<table class="list_table">
				</table>
			</div>
			<!-- 가격 종합 -->
			<div class="content_total_section">
				<div class="total_wrap">
					<table>
						<tr>
							<td>
								<table>
									<tr>
										<td>총 상품 가격</td>
										<td>
											<span class="span_totalPrice">70000</span> 원
										</td>
									</tr>
									<tr>
										<td>배송비</td>
										<td>
											<span class="delivery_price">3000</span>원
										</td>
									</tr>									
									<tr>
										<td>총 주문 상품수</td>
										<td><span class="span_totalKind"></span>종 <span class="span_totalCount"></span>개</td>
									</tr>
								</table>
							</td>
							<td>
								<table>
									<tr>
										<td></td>
										<td></td>
									</tr>
								</table>							
							</td>
						</tr>
					</table>
					<div class="div_boundary">구분선</div>
					<table>
						<tr>
							<td>
								<table>
									<tbody>
										<tr>
											<td>
												<strong>총 결제 예상 금액</strong>
											</td>
											<td>
												<span class="span_finalTotalPrice">70000</span> 원
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 구매 버튼 영역 -->
			<div class="content_btn_section">
				<a class="btn_order">주문하기</a>
			</div>
			
			<!-- 주문 form -->
			<form action="orderCheck.do?ordererId=${member.id}" method="get" class="orderForm">

			</form>
		</div>
		<div class="paging">
			<!-- 첫 페이지 -->
			<c:if test="${pageDTO.prev }">
				<a href="cartList.do?pageNum=1" class="p_box p_box_bold"><<</a>
			</c:if>
			<!-- 이전 페이지 -->
			<c:if test="${pageDTO.prev }">
				<c:set var="pageNum" value="${param.pageNum-10 }"/>	
				<a href="cartList.do?pageNum=${pageNum }" class="p_box p_box_bold"><</a>
			</c:if>
			
			<!-- 페이지 번호 -->
			<c:forEach var="pageNum" varStatus="s" begin="${pageDTO.startPage }" end="${pageDTO.endPage }">
				<c:if test="${param.pageNum == pageNum }">
					<a href="cartList.do?pageNum=${pageNum }" class="p_box_choice">${pageNum }</a>
				</c:if>
				<c:if test="${param.pageNum != pageNum }">
					<a href="cartList.do?pageNum=${pageNum }" class="p_box">${pageNum }</a>
				</c:if>
			</c:forEach>
			
			<!-- 다음 페이지 -->
			<c:if test="${pageDTO.next }">
			<c:set var="pageNum" value="${param.pageNum+10 }"/>
				<c:if test="${pageNum > pageDTO.pageCount }">
					<c:set var="pageNum" value="${pageDTO.pageCount-1 }"/>
				</c:if>
				<a href="cartList.do?pageNum=${pageNum }" class="p_box p_box_bold">></a>
			</c:if>
			<!-- 마지막 페이지 -->
			<c:if test="${pageDTO.prev }">
			<c:set var="pageNum" value="${pageDTO.pageCount }"/>
				<a href="cartList.do?pageNum=${pageNum-1 }" class="p_box p_box_bold">>></a>
			</c:if>
		</div>
	</div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->
</main>
