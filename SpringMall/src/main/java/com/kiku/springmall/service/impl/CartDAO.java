package com.kiku.springmall.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kiku.springmall.service.CartDTO;

@Repository
public class CartDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	/* cart 테이블 -> insert 작업. (dto 내에서 필요한 값 : order_id를 제외한 모든 컬럼)*/
	public int insertCart(CartDTO dto) {
		return sqlSession.insert("CartDAO.insertCart", dto);
	}

	/* cart 테이블 -> update 작업. (dto 내에서 필요한 값 : #{order_quantity}, #{orderer_id}, #{product_id})*/
	public int updateCart(CartDTO dto) {
		return sqlSession.update("CartDAO.updateCart", dto);
	}

	/* cart 테이블 -> delete 작업 . (dto 내에서 필요한 값 : #{orderer_id}, #{product_id})*/
	public int deleteCart(CartDTO dto) {
		return sqlSession.delete("CartDAO.deleteCart", dto);
	}

	/* cart 테이블 -> delete 작업. (dto 내에서 필요한 값 : #{orderer_id})*/
	public int deleteCartById(CartDTO dto) {
		return sqlSession.delete("CartDAO.deleteCartById", dto);
	}

	/* never used*/
	public CartDTO getCart(CartDTO dto) {
		return sqlSession.selectOne("CartDAO.getCart", dto);
	}

	/* cart 테이블, product 테이블 join-> selectList 작업. (dto 내에서 필요한 값 : #{orderer_id})*/
	public List<CartDTO> getCartList(CartDTO dto) {
		return sqlSession.selectList("CartDAO.getCartList", dto);
	}

	/* cart 테이블. selectOne 작업. (dto 내에서 필요한 값 : #{orderer_id}, #{product_id})*/
	public int checkCart(CartDTO dto) {
		return sqlSession.selectOne("CartDAO.checkCart", dto);
	}
}
