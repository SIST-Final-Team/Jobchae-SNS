package com.spring.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.common.mail.GoogleMail;
import com.spring.app.common.security.RandomEmailCode;
import com.spring.app.member.model.MemberDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class MemberService_imple implements MemberService {

	@Autowired
	MemberDAO dao;

	
	
	
	// 아이디 중복체크
	@Override
	public boolean idDuplicateCheck(String member_id) {
		
		boolean isExists = dao.idDuplicateCheck(member_id);
		
		return isExists;
		
	}//end of public boolean idDuplicateCheck(String member_id) {}...




	
	
	// 이메일 중복확인 및 인증메일 발송
	@Override
	public boolean emailCheck(String member_email) {
		// 입력한 이메일이 존재하는지 확인
		boolean isExists = dao.emailCheck(member_email);
		return isExists;
	}//end of public boolean emailCheck_Send(String member_email) {}...
	
	
	
	
	
	
}//end of class..

















