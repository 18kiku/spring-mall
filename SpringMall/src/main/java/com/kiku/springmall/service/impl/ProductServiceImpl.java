package com.kiku.springmall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kiku.springmall.service.BlockDTO;
import com.kiku.springmall.service.ProductDTO;
import com.kiku.springmall.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired
	private ProductDAO productDAO;

	
	/* 상품 추가*/
	@Override
	public void insertProduct(ProductDTO dto) {
		productDAO.insertProduct(dto);
	}

	/* 상품 업데이트*/
	@Override
	public void updateProduct(ProductDTO dto) {
		productDAO.updateProduct(dto);
	}

	/* 상품 삭제*/
	@Override
	public void deleteProduct(ProductDTO dto) {
		productDAO.deleteProduct(dto);
	}

	/* 상품 수 조회*/
	@Transactional(readOnly = true)
	@Override
	public int getProductCount(ProductDTO dto) {
		return productDAO.getProductCount(dto);
	}

	/* 상품 상세 정보 조회*/
	@Transactional(readOnly = true)
	@Override
	public ProductDTO getProduct(ProductDTO dto) {
		return productDAO.getProduct(dto);
	}

	/* 상품 목록 조회*/
	@Transactional(readOnly = true)
	@Override
	public List<ProductDTO> getProductList(ProductDTO dto, BlockDTO block) {
		return productDAO.getProductList(dto, block);
		
	}

}
