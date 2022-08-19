package com.kiku.springmall.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kiku.springmall.service.BlockDTO;
import com.kiku.springmall.service.PageDTO;
import com.kiku.springmall.service.ProductDTO;
import com.kiku.springmall.service.ProductService;
import com.kiku.springmall.util.Util;

@Controller
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	private static final String UPLOAD_PATH = "C:\\spring_images\\mall\\"; // file upload path
	
	/* productList.jsp -> product 테이블에 상품 추가 요청 */
	@GetMapping(value="/productInsert.do")
	public String insertProduct() {
		return "management/product/productInsert"; // 상품 추가 페이지로 이동
	}
	
	/* productInsert.jsp -> 상품 추가 처리, form의 인코딩타입은 multipart -> MultipartHttpServletRequest로 file 요청 처리*/
	@PostMapping(value="/productInsert.do")
	public String insertProduct(ProductDTO dto, MultipartHttpServletRequest request) {
		if(request.getFiles("productImages").isEmpty()) {
			File fileCheck = new File(UPLOAD_PATH); // 패스 체크
			if(!fileCheck.exists()) fileCheck.mkdirs(); // 폴더가 없다면 생성
			
			List<MultipartFile> productImages = request.getFiles("productImages");
			dto.setProductImage(String.join(",", Util.saveFile(productImages)));			
		} else {
			dto.setProductImage(/* UPLOAD_PATH + */ "no-image.jpg");
		}
		if(!request.getFiles("productDetails").isEmpty()) {
			File fileCheck = new File(UPLOAD_PATH); // 패스 체크
			if(!fileCheck.exists()) fileCheck.mkdirs(); // 폴더가 없다면 생성
			
			List<MultipartFile> productDetails = request.getFiles("productDetails"); // file 타입의 input태그에 multiple 속성을 주었기 때문에 List로 값을 받는다
			dto.setProductDetail(String.join(",", Util.saveFile(productDetails))); // Util 클래스의 saveFile메서드 사용, 
																					//String 클래스의 join메서드로 리스트를 문자열로 변환 후 property에 저장
		} else {
			dto.setProductDetail(/* UPLOAD_PATH + */ "no-detail.jpg"); // 파일을 추가하지 않았다면 product 테이블의 product_detail의 default값을 property에 저장 
		}
		
		productService.insertProduct(dto); // product 추가 처리
		
		return "redirect:productList.do?pageNum=1"; // product 추가 후 productList의 첫 페이지로 이동
	}
		
	/* productDetail.jsp -> 상품 추가 처리, form의 인코딩타입은 multipart -> MultipartHttpServletRequest로 file 요청 처리 
	 * insertProduct 메소드와 동일하니 해당 메소드의 주석 참조*/
	@RequestMapping(value="/productUpdate.do")
	public String updateProduct(@ModelAttribute("product")ProductDTO dto, MultipartHttpServletRequest request) {
		if(dto.getProductImage()!= null) {
			File fileCheck = new File(UPLOAD_PATH); // 패스 체크
			if(!fileCheck.exists()) fileCheck.mkdirs(); // 폴더가 없다면 생성
			
			List<MultipartFile> productImages = request.getFiles("productImages");
			dto.setProductImage(String.join(",", Util.saveFile(productImages)));
		} else {
			dto.setProductImage(request.getParameter("no_image"));
		}
		
		if(dto.getProductDetail()!= null) {
			File fileCheck = new File(UPLOAD_PATH);
			if(!fileCheck.exists()) fileCheck.mkdirs();
			
			List<MultipartFile> productDetails = request.getFiles("productDetails"); // file 관련 설명은 insert메소드 참조
			dto.setProductDetail(String.join(",", Util.saveFile(productDetails)));
		} else {
			dto.setProductDetail(request.getParameter("no_detail"));
		}
		
		productService.updateProduct(dto);
		
		return "redirect:productList.do?pageNum=" + request.getParameter("pageNum");
	}
	
	/* productList.jsp, productDetail.jsp -> product 테이블에서 상품 삭제*/
	@RequestMapping(value="/productDelete.do")
	public String deleteProduct(ProductDTO dto, BlockDTO block) {
		productService.deleteProduct(dto); // 상품 삭제 처리
		return "redirect:productList.do?pageNum=" + block.getPageNum(); // 삭제 후 해당 페이지로 이동(상품의 삭제를 확인하기 위함)
	}
	
	/* productList.jsp -> 상품의 상세 정보 조회*/
	@RequestMapping(value="/productDetail.do")
	public String getProduct(ProductDTO dto, Model model) {
		model.addAttribute("product", productService.getProduct(dto));
		return "management/product/productDetail";
	}
	
	/* 검색을 위한 Map 생성, productList에서 사용*/
	@ModelAttribute("conditionMap")
	public Map<String, String> searchConditionMap(){
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("NAME", "PRODUCT_NAME");
		conditionMap.put("CATEGORY", "PRODUCT_CATEGORY");
		return conditionMap;
	}
	
	/* 상품 목록 조회, 검색 기능*/
	@RequestMapping(value="/productList.do")
	public String getProductList(ProductDTO dto, BlockDTO block, Model model, HttpServletRequest request){
		if(dto.getSearchCondition() == null) dto.setSearchCondition("PRODUCT_CATEGORY"); // 검색의 default는 PRODUCT_CATEGORY
		if(dto.getSearchKeyword() == null) dto.setSearchKeyword(""); // DB 처리 시null 입력 방지를 위한 빈 문자열
		
		/* productList페이징 처리 오류 수정을 위한 시도 -> 실패..
		if(request.getParameter("searchKeyword") == null) {
			dto.setSearchKeyword(""); // null 값을 insert하지 않기 위해 빈 문자열 setting
		} else {
			dto.setSearchKeyword(request.getParameter("searchKeyword"));
		}
		model.addAttribute("searchKeword", dto.getSearchKeyword()); // 검색 시 페이징 유지를 위한 searchKeword parameter 전달
		*/
		
		int totalCount = productService.getProductCount(dto); // 페이징 처리를 위한 상품 수 조회
		model.addAttribute("pageDTO", new PageDTO(block, totalCount)); // 페이징 처리
		model.addAttribute("productList", productService.getProductList(dto, block)); // 상품 목록 조회 처리
		return "management/product/productList"; // 상품 목록 페이지
	}
}
