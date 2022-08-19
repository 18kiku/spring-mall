package com.kiku.springmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kiku.springmall.service.CartDTO;
import com.kiku.springmall.service.CartService;
import com.kiku.springmall.service.MemberDTO;

@Controller
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	/* member가 cart안의 상품 리스트를 조회 요청*/
	@RequestMapping(value="/cartList.do")
	public String cartList(Model model, HttpSession session) {
		MemberDTO member = (MemberDTO)session.getAttribute("member"); // cart는 login 상태여야 하기 때문에 member 체크
		if(member != null) {
			CartDTO cart = new CartDTO();
			cart.setOrdererId(member.getId()); // login 상태라면 member의 id값 추가
			model.addAttribute("cartList", cartService.getCartList(cart)); // service에게 cartList 요청 
			for(CartDTO c: cartService.getCartList(cart)) {
				System.out.println("카트 => " + c);
			}
			return "cart.list";
		}
		
		return "login"; // login 페이지
	}

	/* shopList.jsp, shopDetail.jsp -> member가 cart에 특정 상품 추가 요청*/
	@ResponseBody
	@RequestMapping(value="/cartInsert.do")
	public int insertCart(CartDTO dto, Model model, HttpSession session) {
		MemberDTO member = (MemberDTO)session.getAttribute("member"); // login 체크
		int message = 10917; // cartList.jsp에서 ajax를 사용했음. 결과 코드 번호를 받아서 처리하기 위한 message 값. login 상태가 아니라면 login 페이지로 보내는 코드 번호
		if(member != null) {
			if(cartService.checkCart(dto) == 0) { // 카트에 해당 상품이 없을 경우
				int result = cartService.insertCart(dto); // insert 작업 수행 후 반환된 행 개수
				if(result == 0) { 
					message = 0; // insert 실패 코드 번호
				} else {
					message = 1; // insert 성공 코드 번호. insertCart는 한 행씩 추가하기 때문에 반환값 1
				}
			} else { // 카트에 해당 상품이 있을 경우
				int result = cartService.updateCart(dto); // update 작업 수행 후 반환된 행 개수
				
				if(result == 0) { 
					message = 0; // update 실패
				} else {
					message = 2; // update 성공
				}
			}
		}
		
		return message; // ajax로 결과 코드 번호 반환
	}
	
	/* cartList.jsp -> member가 cart안의 특정 상품 수량 수정 요청*/
	@ResponseBody
	@RequestMapping(value="/cartUpdate.do")
	public int updateCart(CartDTO dto, HttpSession session) {
		System.out.println("업데이트 " + dto);
		MemberDTO member = (MemberDTO)session.getAttribute("member"); // login 체크
		if(member == null) {
			return 10917; // login 페이지로 보내는 코드 번호
		}
		
		return cartService.updateCart(dto); // update 작업이 완료된 행 개수 반환
	}

	/* cartList.jsp -> member가 cart안의 특정 상품 삭제 요청*/
	@ResponseBody
	@RequestMapping(value="/cartDelete.do")
	public int deleteCart(CartDTO dto, HttpSession session) {
		System.out.println("딜리트 " + dto);
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		if(member == null) {
			return 10917; // login 페이지로 보내는 코드 번호
		}
		
		return cartService.deleteCart(dto); // delete 작업이 완료된 행 개수 반환
	}
	
	@ResponseBody
	@RequestMapping(value="/cartDeleteById.do")
	public int deleteCartById(CartDTO dto, HttpSession session) {
		System.out.println("딜리트 " + dto);
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		if(member == null) {
			return 10917; // login 페이지로 보내는 코드 번호
		}
		
		return cartService.deleteCartById(dto); // delete 작업이 완료된 행 개수 반환
	}
	
}
