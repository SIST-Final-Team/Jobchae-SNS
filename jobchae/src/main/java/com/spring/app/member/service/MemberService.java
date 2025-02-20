package com.spring.app.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;

public interface MemberService {

	// === 이준영 시작 === //
	
	// 아이디 충복체크
	boolean idDuplicateCheck(String member_id);

	// 이메일 중복확인 및 인증메일 발송
	boolean emailCheck(String member_email);

	// 지역 검색 시 자동 완성 해주는 메소드 
	List<Map<String, String>> regionSearchShow(String region_name);

	// 로그인하는 메소드
	ModelAndView login(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap);

	// === 이준영 끝 === //
	
	
	// === 김규빈 시작 === //

	// 회원 경력 등록, 수정, 삭제
	int addMemberCareer(Map<String, String> paraMap);
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
