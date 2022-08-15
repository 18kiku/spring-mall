package com.kiku.springmall.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kiku.springmall.service.MemberDTO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	/* member 테이블 -> select 작업. (dto 내에서 필요한 값 : #{id}, #{password})*/
	public MemberDTO login(MemberDTO dto) {
		System.out.println("===> MemberDAO login");
		return sqlSession.selectOne("MemberDAO.login", dto);
	}

	/* */
	public int isAdmin(MemberDTO dto) {
		System.out.println("===> MemberDAO isAdmin");
		return sqlSession.selectOne("MemberDAO.isAdmin", dto);
	}

	/* member 테이블 -> insert 작업. (dto 내에서 필요한 값 : reg_date를 제외한 모든 컬럼)*/
	public void insertMember(MemberDTO dto) {
		System.out.println("===> MemberDAO insertMember");
		sqlSession.insert("MemberDAO.insertMember", dto);
	}

	/* member 테이블 -> update 작업. (dto 내에서 필요한 값 : reg_date를 제외한 모든 컬럼)*/
	public void updateMember(MemberDTO dto) {
		System.out.println("===> MemberDAO updateMember");
		sqlSession.update("MemberDAO.updateMember", dto);
	}

	/* member 테이블 -> delete 작업. (dto 내에서 필요한 값 : #{id}, #{password})*/
	public void deleteMember(MemberDTO dto) {
		System.out.println("===> MemberDAO deleteMember");
		sqlSession.delete("MemberDAO.deleteMember", dto);
	}

	/* member 테이블 -> selectOne 작업. (dto 내에서 필요한 값 : #{id})*/
	public MemberDTO getMember(MemberDTO dto) {
		System.out.println("===> MemberDAO getMember");
		return sqlSession.selectOne("MemberDAO.getMember", dto);
	}

	/* member 테이블 -> selectList 작업. (dto 내에서 필요한 값 : 없음)*/
	public List<MemberDTO> getMemberList(MemberDTO dto) {
		System.out.println("===> MemberDAO getMemberList");
		return sqlSession.selectList("MemberDAO.getMemberList", dto);
	}

}
