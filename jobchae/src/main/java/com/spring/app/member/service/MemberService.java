package com.spring.app.member.service;


public interface MemberService {

	
	
	
	
	
	
	
	
	
	
	
	// 아이디 충복체크
	boolean idDuplicateCheck(String member_id);

	// 이메일 중복확인 및 인증메일 발송
	boolean emailCheck(String member_email);

	
	
	
	
}//end of interface...
