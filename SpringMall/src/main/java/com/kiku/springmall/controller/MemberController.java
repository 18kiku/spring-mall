package com.kiku.springmall.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kiku.springmall.service.MemberDTO;
import com.kiku.springmall.service.MemberService;

@Controller
@SessionAttributes
public class MemberController {

	@Autowired
	private MemberService memberService;

	/* 로그인 페이지 이동. (작업 x)*/
	@GetMapping(value = "/memberLogin.do")
	public String login() {
		System.out.println("=> MemberController - login(get)");
		return "login";
	}

	// ***********************int로 고치고 반환값에따라 아이디가 존재하지 않습니다, 등 경고창 띄우기
	/* 로그인 처리. session 생성 (key: member, value : member)*/
	@PostMapping(value = "/memberLogin.do")
	public String login(MemberDTO dto, HttpSession session, HttpServletRequest request) {
		System.out.println("=> MemberController - login(post)");
		
		MemberDTO member = memberService.login(dto); // memberService에게 login 작업 요청
		if (member != null) {
			session.setAttribute("member", member);
			System.out.println("login 성공! Member ID : " + member.getId());
			return "redirect:shopMain.do";
		} else {
			return "login";
		}
	}

	/* shopHeader.jsp -> 로그아웃. session 삭제*/
	@RequestMapping(value = "/memberLogout.do")
	public String logout(HttpSession session) {
		System.out.println("=> MemberController - 로그아웃 처리");
		session.invalidate();
		return "redirect:shopMain.do";
	}

	// ######################
	// 회원가입, 수정, 삭제, 상세확인
	/* shopHeader.jsp ->  member 추가 페이지로 이동. (작업 x)*/
	@GetMapping("/memberJoin.do")
	public String insertMember() {
		System.out.println("=> MemberController - insertMember");
		return "memberJoin";
	}

	/* memberJoin.jsp -> 회원가입 시 member 중에서 동일한 id가 있는지 조회*/
	@ResponseBody
	@RequestMapping("/memberCheck.do")
	public int checkMember(@RequestParam("id") String id) {
		int cnt = 0; // memberJoin.jsp에서 ajax를 사용했음. 결과 코드 번호를 받아서 처리하기 위한 cnt 값. member 중에서 동일한 id가 있는지 조회 결과를 저장. 0은 사용 가능, 1은 사용 불가
		
		MemberDTO dto = new MemberDTO();
		dto.setId(id); // 회원가입을 시도하려는 id를 저장
		if (memberService.getMember(dto) == null) { // member중에서 해당 아이디가 없을 경우 
			cnt = 0; // 사용 가능 코드 번호 반환
		} else { // member 중에서 해당 id가 있을 경우
			cnt = 1; // 사용 불가 코드 번호 반환
		}
		
		return cnt; // ajax에게 코드 번호 반환
	}

	/* member 테이블에 member 추가 페이지로 이동. (작업 o)*/
	@PostMapping("/memberJoin.do")
	public String insertMember(MemberDTO dto) {
		System.out.println("=> MemberController - 회원등록 처리(DB)");
		memberService.insertMember(dto); // memberService에게 memberJoin.jsp에서 받은 dto로 멤버 추가 작업 요청
		return "login"; // 완료 후 로그인 페이지로 이동
	}

	/* memberInfo.jsp -> member 수정*/
	@RequestMapping("/memberUpdate.do")
	public String updateMember(@ModelAttribute("member") MemberDTO dto, Model model, HttpSession session) {
		System.out.println("=> MemberController - 회원정보 업데이트");
		
		memberService.updateMember(dto); // **********업데이트가 완료됐다고 alert 띄우기 -> ajax사용으로 변경 @ResponseBody 추가
		session.setAttribute("member", memberService.getMember(dto));
		
		return "memberInfo";
	}

	/* memberInfo.jsp -> member 삭제*/
	@RequestMapping("/memberDelete.do")
	public String deleteMember(MemberDTO dto) {
		System.out.println("=> MemberController - 회원탈퇴"); // ******************transaction 처리 필요. cart까지 삭제해야함
		memberService.deleteMember(dto); // memberService에게 delete 작업 요청
		return "login";
	}

	/* shopHeader.jsp -> member 정보 확인 */
	@RequestMapping("/memberInfo.do")
	public String getMember(MemberDTO dto, Model model, HttpSession session) {
		System.out.println("=> MemberController - 회원정보확인");
		
		MemberDTO member = (MemberDTO)session.getAttribute("member"); // 멤버 정보 조회를 위해 session에 담긴 member(로그인 시 session에 member 정보를 담고 있기로 했음)를 저장
		if (member != null) {
			model.addAttribute("member", memberService.getMember(member)); // memberService에게 접속중인 멤버의 정보 조회 작업 요청
		} else {
			return "login"; // login 중이 아닐시 login 페이지로 이동
		}

		return "memberInfo";
	}

}
