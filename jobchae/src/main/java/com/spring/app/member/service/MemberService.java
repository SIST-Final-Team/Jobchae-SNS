package com.spring.app.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;

public interface MemberService {

	
	
	
	
	
	
	
	
	
	
	
	// 아이디 충복체크
	boolean idDuplicateCheck(String member_id);

	// 이메일 중복확인 및 인증메일 발송
	boolean emailCheck(String member_email);

	// 지역 검색 시 자동 완성 해주는 메소드 
	List<Map<String, String>> regionSearchShow(String region_name);

	// 로그인하는 메소드
	ModelAndView login(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap);

	
	
	
	
}//end of interface...
