package com.kiku.springmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kiku.springmall.service.BlockDTO;
import com.kiku.springmall.service.MemberDTO;
import com.kiku.springmall.service.PageDTO;
import com.kiku.springmall.service.ProductDTO;
import com.kiku.springmall.service.ProductService;

@Controller
public class ShopController {
	
	@Autowired
	private ProductService productService;
	
	/* 본 프로젝트의 메인 페이지 View밖에 없다. 값은 없음*/
	@RequestMapping(value="/shopMain.do")
	public String shopMain() {
		return "shop.main";
	}
	
	/* shopHeader.jsp -> product의 카테고리별 상품 목록을 요청*/
	@RequestMapping(value="/shopList.do")
	public String shopList(ProductDTO dto, Model model, BlockDTO block) {
		dto.setSearchCondition("PRODUCT_CATEGORY"); // shopList는 카테고리별 리스트를 출력하기 때문에 searchCondition은 항상 PRODUCT_CATEGORY
		dto.setSearchKeyword(dto.getProductCategory()); // 검색을 위한 category 값을 setting
		
		int totalCount = productService.getProductCount(dto); // 페이징 처리를 위해 상품 개수 조회
		model.addAttribute("pageDTO", new PageDTO(block, totalCount)); // 페이징 처리
		System.out.println(dto);
		model.addAttribute("productList", productService.getProductList(dto, block)); // 상품 목록 조회
		
		return "shop.list"; // 카테고리별 상품 목록 페이지
	}
	
	/* shopList.jsp -> product의 상세 정보를 요청*/
	@RequestMapping(value="/shopDetail.do")
	public String shopDetail(ProductDTO dto, Model model, HttpSession session) {
		model.addAttribute("product", productService.getProduct(dto)); // 특정 상품의 정보 조회 요청
		return "shop.detail"; // 상품 상세 정보 페이지
	}
}
