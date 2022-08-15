package com.kiku.springmall.service;

import java.util.List;

public interface OrderService {
	int insertOrder(OrderDTO dto); // 주문 추가
	List<OrderDTO> getOrder(OrderDTO dto); // 주문 목록 조회(주문 id에 따라)
	List<OrderDTO> getOrderList(OrderDTO dto, BlockDTO block); // 주문 목록 조회(주문자 id에 따라)
	int getOrderCount(OrderDTO dto); // 주문 수 조회
}
