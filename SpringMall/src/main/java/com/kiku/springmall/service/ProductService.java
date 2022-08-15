package com.kiku.springmall.service;

import java.util.List;

public interface ProductService {
	void insertProduct(ProductDTO dto); // 상품 추가
	void updateProduct(ProductDTO dto); // 상품 업데이트
	void deleteProduct(ProductDTO dto); // 상품 삭제
	int getProductCount(ProductDTO dto); // 상품 수 조회
	ProductDTO getProduct(ProductDTO dto); // 상품 상세 정보 조회
	List<ProductDTO> getProductList(ProductDTO dto, BlockDTO block); // 상품 목록 조회
}
