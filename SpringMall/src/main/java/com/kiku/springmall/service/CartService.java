package com.kiku.springmall.service;

import java.util.List;

public interface CartService {
	int insertCart(CartDTO dto); // member의 cart에 상품 추가
	int updateCart(CartDTO dto); // member의 cart에서 상품 수량 수정
	int deleteCart(CartDTO dto); // member의 cart에서 상품 삭제
	int deleteCartById(CartDTO dto); // member의 cart에서 모든 상품 삭제
	CartDTO getCart(CartDTO dto); // never used. 카트에 상품이 담겨있는지 확인할 때는 checkCart를 사용중 
	List<CartDTO> getCartList(CartDTO dto); // member의 cart에서 모든 상품 조회 
	int checkCart(CartDTO dto); // member의 cart에서 특정 상품이 존재하는지 조회
}
