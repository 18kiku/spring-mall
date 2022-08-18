package com.kiku.springmall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kiku.springmall.service.CartDTO;
import com.kiku.springmall.service.CartService;

@Service
@Transactional
public class CartServiceImpl implements CartService{

	@Autowired
	private CartDAO cartDAO;
	
	/* member의 cart에 상품 추가*/
	@Override
	public int insertCart(CartDTO dto) {
		return cartDAO.insertCart(dto);
	}

	/* member의 cart에서 상품 수량 수정*/
	@Override
	public int updateCart(CartDTO dto) {
		return cartDAO.updateCart(dto);
	}

	/* member의 cart에서 상품 삭제*/
	@Override
	public int deleteCart(CartDTO dto) {
		return cartDAO.deleteCart(dto);
	}

	/* member의 cart에서  모든 상품 삭제*/
	@Override
	public int deleteCartById(CartDTO dto) {
		return cartDAO.deleteCartById(dto);
	}

	/* never used. 카트에 상품이 담겨있는지 확인할 때는 checkCart를 사용중 */
	@Transactional(readOnly = true)
	@Override
	public CartDTO getCart(CartDTO dto) {
		return cartDAO.getCart(dto);
	}

	/* member의 cart에서 모든 상품 조회 */
	@Transactional(readOnly = true)
	@Override
	public List<CartDTO> getCartList(CartDTO dto) {
		return cartDAO.getCartList(dto);
	}

	/* member의 cart에서 특정 상품이 존재하는지 조회*/
	@Transactional(readOnly = true)
	@Override
	public int checkCart(CartDTO dto) {
		return cartDAO.checkCart(dto);
	}


}
