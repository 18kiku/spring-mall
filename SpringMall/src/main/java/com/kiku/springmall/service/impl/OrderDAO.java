package com.kiku.springmall.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kiku.springmall.service.BlockDTO;
import com.kiku.springmall.service.OrderDTO;

@Repository
public class OrderDAO {

	@Autowired
	private SqlSession sqlSession;
	
	/* orders 테이블 -> insert 작업 (dto 내에서 필요한 값 : order_id, order_date를 제외한 모든 컬럼)*/
	public int insertOrder(OrderDTO dto) {
		System.out.println("===> OrderDAO insertOrder");
		System.out.println(dto);
		return sqlSession.insert("OrderDAO.insertOrder", dto);
	}

	/* orders 테이블, product 테이블 join -> selectList 작업 (dto 내에서 필요한 값 : #{order_id})*/
	public List<OrderDTO> getOrder(OrderDTO dto) {
		System.out.println("===> OrderDAO getOrder");
		return sqlSession.selectList("OrderDAO.getOrder", dto);
	}

	/* orders 테이블 -> selectList 작업 (dto 내에서 필요한 값 : #{order.orderer_id}, #{block.pageNum}, #{block.amount})*/
	public List<OrderDTO> getOrderList(OrderDTO dto, BlockDTO block) {
		System.out.println("===> OrderDAO getOrderList");
		
		Map<String, Object> pagingMap = new HashMap<String, Object>(); // 페이징 처리를 위해 order 객체 뿐만 아니라 block 객체도 같이 넣어줘야 하기 때문에 HashMap 타입으로 값을 넣어준다
		pagingMap.put("order", dto); 
		pagingMap.put("block", block);
		System.out.println(pagingMap);
		return sqlSession.selectList("OrderDAO.getOrderList", pagingMap);
	}

	/* orders 테이블 -> selectOne 작업 (dto 내에서 필요한 값 : #{orderer_id})*/
	public int getOrderCount(OrderDTO dto) {
		System.out.println("===> OrderDAO getOrderCount");
		return sqlSession.selectOne("OrderDAO.getOrderCount", dto);
	}

}
