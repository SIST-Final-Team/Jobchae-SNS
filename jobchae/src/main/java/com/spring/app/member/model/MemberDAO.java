package com.spring.app.member.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.member.domain.MemberVO;

@Mapper
public interface MemberDAO {

	// === 이준영 시작 === //
	
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

	// === 이준영 끝 === //
	
	

	// === 김규빈 시작 === //

	// 회원 경력 등록, 수정, 삭제
	int insertMemberCareer(Map<String, String> paraMap);
	int updateMemberCareer(Map<String, String> paraMap);
	int deleteMemberCareer(Map<String, String> paraMap);

	// 자동완성을 위한 직종 목록 조회 및 검색
	List<Map<String, String>> getJobListForAutocomplete(Map<String, String> paraMap);
	// 자동완성을 위한 회사 목록 조회 및 검색
	List<Map<String, String>> getCompanyListForAutocomplete(Map<String, String> paraMap);
	// 자동완성을 위한 전공 목록 조회 및 검색
	List<Map<String, String>> getMajorListForAutocomplete(Map<String, String> paraMap);

	// === 김규빈 끝 === //
	
}//end of interface...
