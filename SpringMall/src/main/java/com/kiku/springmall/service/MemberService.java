package com.kiku.springmall.service;

import java.util.List;

public interface MemberService {
	MemberDTO login(MemberDTO dto); // member 테이블에 해당 멤버가 존재하는지 조회 후, 그 member의 정보를 가져온다. id, password 필요
	int isAdmin(MemberDTO dto); // 로그인을 시도한 member가 admin인지 조회. 현재 미구현
	void insertMember(MemberDTO dto); // member 테이블에 새로운 멤버 추가
	void updateMember(MemberDTO dto); // member 테이블에서 해당 member의 정보 수정
	void deleteMember(MemberDTO dto); // member 테이블에서 해당 member 삭제
	MemberDTO getMember(MemberDTO dto); // member 테이블에서 특정 멤버의 정보를 조회한다, id필요(login()과 다른점)
	List<MemberDTO> getMemberList(MemberDTO dto); // member 테이블에서 모든 멤버의 정보를 조회한다
}
