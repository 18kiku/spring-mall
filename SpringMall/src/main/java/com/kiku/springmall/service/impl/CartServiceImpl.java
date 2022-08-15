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
		System.out.println("==> CartServiceImpl - insertCart()");
		return cartDAO.insertCart(dto);
	}

	/* member의 cart에서 상품 수량 수정*/
	@Override
	public int updateCart(CartDTO dto) {
		System.out.println("==> CartServiceImpl - updateCart()");
		return cartDAO.updateCart(dto);
	}

	/* member의 cart에서 상품 삭제*/
	@Override
	public int deleteCart(CartDTO dto) {
		System.out.println("==> CartServiceImpl - deleteCart()");
		return cartDAO.deleteCart(dto);
	}

	/* member의 cart에서  모든 상품 삭제*/
	@Override
	public int deleteCartAll(CartDTO dto) {
		System.out.println("==> CartServiceImpl - deleteCartAll()");
		return cartDAO.deleteCartAll(dto);
	}

	/* never used. 카트에 상품이 담겨있는지 확인할 때는 checkCart를 사용중 */
	@Transactional(readOnly = true)
	@Override
	public CartDTO getCart(CartDTO dto) {
		System.out.println("==> CartServiceImpl - getCart()");
		return cartDAO.getCart(dto);
	}

	/* member의 cart에서 모든 상품 조회 */
	@Transactional(readOnly = true)
	@Override
	public List<CartDTO> getCartList(CartDTO dto) {
		System.out.println("==> CartServiceImpl - getCartList()");
		return cartDAO.getCartList(dto);
	}

	/* member의 cart에서 특정 상품이 존재하는지 조회*/
	@Transactional(readOnly = true)
	@Override
	public int checkCart(CartDTO dto) {
		System.out.println("==> CartServiceImpl - checkCart()");
		return cartDAO.checkCart(dto);
	}


}
