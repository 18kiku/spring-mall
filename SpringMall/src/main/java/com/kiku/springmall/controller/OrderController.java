package com.kiku.springmall.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kiku.springmall.service.BlockDTO;
import com.kiku.springmall.service.CartDTO;
import com.kiku.springmall.service.CartService;
import com.kiku.springmall.service.MemberDTO;
import com.kiku.springmall.service.OrderDTO;
import com.kiku.springmall.service.OrderService;
import com.kiku.springmall.service.PageDTO;
import com.kiku.springmall.service.ProductDTO;
import com.kiku.springmall.service.ProductService;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private CartService CartService;
	
	/* cartList.jsp, shopList.jsp, shopDetail.jsp -> 
	 * 주문 전 상품, 가격, 배송 정보 확인 페이지 요청*/
	@GetMapping("/orderCheck.do")
	public String checkOrder(OrderDTO dto, Model model, HttpSession session){
		MemberDTO member = (MemberDTO)session.getAttribute("member"); // login check
		if(member == null) {
			return "login"; // login 상태가 아니라면 login 페이지로 이동
		}
		
		List<OrderDTO> orderList = new ArrayList<OrderDTO>();
		ProductDTO product = null;
		for(OrderDTO order : dto.getOrderList()) { // 이전 페이지에서 OrderDTO.orderList에 모든 주문 정보를 담아왔음. 상품별 주문정보 삽입을 위한 for문
			product = new ProductDTO();
			product.setProduct_id(order.getProduct_id()); // orders 테이블에는 상품 정보가 없기 때문에 미리 삽입
			order.setProduct_image(productService.getProduct(product).getProduct_image());
			order.setProduct_name(productService.getProduct(product).getProduct_name());
			order.setProduct_price(productService.getProduct(product).getProduct_price());
			order.setDiscount_rate(productService.getProduct(product).getDiscount_rate());
			orderList.add(order); // 주문 정보를 리스트에 추가
		
		}
		model.addAttribute("orderList", orderList);
		return "order.check";
	}
	
	// 트랜잭션처리 결제가실패하면 롤백
	/* orderCheck.jsp -> payment 수행이 완료되면 이곳으로 온다. orderer의 카트에서 결제한 상품을 삭제하고, 결제한 상품 목록을 보여준다.*/
	@RequestMapping("/orderInsert.do")
	public String insertOrder(OrderDTO dto, Model model, HttpSession session) {
		MemberDTO member = (MemberDTO)session.getAttribute("member"); // login check
		if(member == null) {
			return "login"; // login 상태가 아니라면 login 페이지로 이동한다
		}
		
		for(OrderDTO order : dto.getOrderList()) { // 결제한 상품의 리스트가 담긴 리스트를 for문을 수행한다. 카트에서 각 상품을 삭제한다
			orderService.insertOrder(order);
			CartDTO cart = new CartDTO();
			cart.setOrderer_id(order.getOrderer_id());
			cart.setProduct_id(order.getProduct_id());
			CartService.deleteCart(cart); // 주문 완료 후 장바구니 삭제
		}
		
		List<OrderDTO> orderList = orderService.getOrder(dto); // order_id로 주문한 상품의 리스트를 조회한다
		model.addAttribute("orderList", orderList);
		
		return "order.list"; // 방금 결제한 상품 목록 페이지
	}

	/* shopHeader.jsp -> member가 주문한 상품의 목록을 조회한다 */
	@RequestMapping("/orderList.do")
	public String orderList(OrderDTO dto, BlockDTO block, Model model, HttpSession session) {
		MemberDTO member = (MemberDTO)session.getAttribute("member"); // login check
		if(member == null) {
			return "login"; // login 상태가 아니라면 login 페이지로 이동한다. **********그런데 이걸 aop로 한번에 모아서 처리할 수 있지 않을까? 찾아보자
		}
		
		dto.setOrderer_id(member.getId()); // 주문자 id 입력
		int totalCount = orderService.getOrderCount(dto); // 페이징 처리를 위해 상품 개수 조회
		model.addAttribute("pageDTO", new PageDTO(block, totalCount)); // 페이징 처리
		model.addAttribute("orderList", orderService.getOrderList(dto, block)); // 상품 목록 조회
		
		return "order.list"; // 상품 목록 페이지
	}
	
}
