package com.kiku.springmall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kiku.springmall.service.BlockDTO;
import com.kiku.springmall.service.OrderDTO;
import com.kiku.springmall.service.OrderService;

@Service
@Transactional
public class OrderServiceImpl implements OrderService{

	@Autowired
	private OrderDAO orderDAO;
	
	/* 주문 추가*/
	@Override
	public int insertOrder(OrderDTO dto) {
		System.out.println("==> OrderServiceImpl - insertOrder()");
		return orderDAO.insertOrder(dto);
	}

	/* 주문 목록 조회(주문 id에 따라)*/
	@Transactional(readOnly = true)
	@Override
	public List<OrderDTO> getOrder(OrderDTO dto) {
		System.out.println("==> OrderServiceImpl - getOrder()");
		return orderDAO.getOrder(dto);
	}

	/* 주문 목록 조회(주문자 id에 따라)*/
	@Transactional(readOnly = true)
	@Override
	public List<OrderDTO> getOrderList(OrderDTO dto, BlockDTO block) {
		System.out.println("==> OrderServiceImpl - getOrderList()");
		return orderDAO.getOrderList(dto, block);
	}

	/* 주문 수 조회*/
	@Transactional(readOnly = true)
	@Override
	public int getOrderCount(OrderDTO dto) {
		System.out.println("==> OrderServiceImpl - getOrderCount()");
		return orderDAO.getOrderCount(dto);
	}

}
