<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/order/orderList.css?v">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<main>
<div class="wrapper">
	<div class="wrap">
		<div class="content_area">
			<div class="content_subject"><span>주문 리스트</span></div>
			<!-- 주문 리스트 -->
			<div class="content_middle_section"></div>
			<!-- orderList -->
			<div class="content_totalCount_section">
				<table class="table_subject">
					<caption>표 제목 부분</caption>
					<tbody>
						<tr>
							<th class="td_width_1 table_text_align_center">주문번호</th>
							<th class="td_width_2 table_text_align_center"></th>
							<th class="td_width_3 table_text_align_center">상품정보</th>
							<th class="td_width_4 table_text_align_center">가격</th>
							<th class="td_width_5 table_text_align_center">수량</th>
							<th class="td_width_6 table_text_align_center">합계</th>
							<th class="td_width_7 table_text_align_center">결제일</th>
							<th class="td_width_8 table_text_align_center">상태</th>
						</tr>
					</tbody>
				</table>
				<table class="table_list">
					<caption>표 내용 부분</caption>
					<tbody>
						<c:if test="${orderList[0] == null }">
							<td colspan="8" class="center">주문 목록이 없습니다.</td>
						</c:if>
						<c:if test="${orderList[0] != null }">
							<c:forEach items="${orderList}" var="order" varStatus="status">
								<tr>
									<td class="td_width_1 td_order_list">
										${order.orderId }						
									</td>
									<td class="td_width_2">
										<div>
											<img alt="product_image" src="${pageContext.request.contextPath}/resources/img/${order.productImage }" width="60" height="60">
										</div>								
									</td>
									<td class="td_width_3">${order.productName}</td>
									<td class="td_width_4 td_price">
										<div class="list_price">정가 : <fmt:formatNumber value="${order.productPrice}" pattern="#,### 원" /></div><br>
										판매가 : <span class="red_color"><fmt:formatNumber value="${order.salePrice}" pattern="#,### 원" /></span>
									</td>
									<td class="td_width_5 table_text_align_center">
										<div class="table_text_align_center div_quantity">
											<span>${order.orderQuantity}</span>
										</div>
									</td>
									<td class="td_width_6 table_text_align_center">
										<fmt:formatNumber value="${order.orderAmount}" pattern="#,### 원" />
									</td>
									<td class="td_width_7 table_text_align_center">
										<fmt:formatDate value="${order.orderDate}" pattern="yy-mm-dd" />
									</td>
									<td class="td_width_8 table_text_align_center">
										${order.deliveryState }
									</td>
								</tr>
							</c:forEach>
						</c:if>
						
					</tbody>
				</table>
			</div>
		</div>
		<div class="paging">
			<!-- 첫 페이지 -->
			<c:if test="${pageDTO.prev }">
				<a href="orderList.do?pageNum=1" class="p_box p_box_bold"><<</a>
			</c:if>
			<!-- 이전 페이지 -->
			<c:if test="${pageDTO.prev }">
				<c:set var="pageNum" value="${param.pageNum-10 }"/>	
				<a href="orderList.do?pageNum=${pageNum }" class="p_box p_box_bold"><</a>
			</c:if>
			
			<!-- 페이지 번호 -->
			<c:forEach var="pageNum" varStatus="s" begin="${pageDTO.startPage }" end="${pageDTO.endPage }">
				<c:if test="${param.pageNum == pageNum }">
					<a href="orderList.do?pageNum=${pageNum }" class="p_box_choice">${pageNum }</a>
				</c:if>
				<c:if test="${param.pageNum != pageNum }">
					<a href="orderList.do?pageNum=${pageNum }" class="p_box">${pageNum }</a>
				</c:if>
			</c:forEach>
			
			<!-- 다음 페이지 -->
			<c:if test="${pageDTO.next }">
			<c:set var="pageNum" value="${param.pageNum+10 }"/>
				<c:if test="${pageNum > pageDTO.pageCount }">
					<c:set var="pageNum" value="${pageDTO.pageCount-1 }"/>
				</c:if>
				<a href="orderList.do?pageNum=${pageNum }" class="p_box p_box_bold">></a>
			</c:if>
			<!-- 마지막 페이지 -->
			<c:if test="${pageDTO.prev }">
			<c:set var="pageNum" value="${pageDTO.pageCount }"/>
				<a href="orderList.do?pageNum=${pageNum-1 }" class="p_box p_box_bold">>></a>
			</c:if>
		</div>
	</div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->
</main>