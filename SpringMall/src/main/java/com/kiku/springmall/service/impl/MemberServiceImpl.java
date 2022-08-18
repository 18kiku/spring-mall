package com.kiku.springmall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kiku.springmall.service.CartDTO;
import com.kiku.springmall.service.MemberDTO;
import com.kiku.springmall.service.MemberService;

@Service
@Transactional
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private CartDAO cartDAO;

	/* member 테이블에 해당 멤버가 존재하는지 조회 후, 그 member의 정보를 가져온다. id, password 필요*/
	@Transactional(readOnly = true)
	@Override
	public MemberDTO login(MemberDTO dto) {
		return memberDAO.login(dto);
	}

	/* 로그인을 시도한 member가 admin인지 조회. 현재 미구현*/
	@Transactional(readOnly = true)
	@Override
	public int isAdmin(MemberDTO dto) {
		return memberDAO.isAdmin(dto);
	}

	/* member 테이블에 새로운 멤버 추가*/
	@Override
	public void insertMember(MemberDTO dto) {
		memberDAO.insertMember(dto);
	}

	/* member 테이블에서 해당 member의 정보 수정*/
	@Override
	public void updateMember(MemberDTO dto) {
		memberDAO.updateMember(dto);
	}

	/* member 테이블에서 해당 member 삭제*/
	@Override
	public void deleteMember(MemberDTO dto) {
		CartDTO cart = new CartDTO();
		cart.setOrderer_id(dto.getId());
		cartDAO.deleteCartById(cart);
		
		memberDAO.deleteMember(dto);
	}

	/* member 테이블에서 특정 멤버의 정보를 조회한다, id필요(login()과 다른점)*/
	@Transactional(readOnly = true)
	@Override
	public MemberDTO getMember(MemberDTO dto) {
		return memberDAO.getMember(dto);
	}

	/* member 테이블에서 모든 멤버의 정보를 조회한다*/
	@Transactional(readOnly = true)
	@Override
	public List<MemberDTO> getMemberList(MemberDTO dto) {
		return memberDAO.getMemberList(dto);
	}




}
