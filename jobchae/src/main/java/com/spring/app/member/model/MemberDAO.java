package com.spring.app.member.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.member.domain.MemberVO;

@Mapper
public interface MemberDAO {

	
	// 아이디 중복체크
	String idDuplicateCheck(String member_id);

	// 이메일 중복체크
	String emailCheck(String member_email);

	// 지역 검색 시 자동 완성 해주는 메소드
	List<Map<String, String>> regionSearchShow(String member_region);

	// 정확한 지역명을 검색한 후 찾아주는 메소드
	Map<String, String> regionKeyWordSearch(String member_region);

	// 입력한 아이디와 비밀번호로 회원 정보 가져오는 메소드
	MemberVO getLoginMember(Map<String, String> paraMap);

	// 로그인 기록 추가
	void insert_tbl_login(Map<String, String> paraMap);
	
	
	
	
	
	
	
}//end of interface...
