package com.spring.app.member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.mail.GoogleMail;
import com.spring.app.common.mail.FuncMail;
import com.spring.app.common.security.RandomEmailCode;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
@RequestMapping(value="/member/*")
public class MemberController {

	
	@Autowired
	MemberService service;
	
	@Autowired
	FuncMail funcMail; // 이메일 인증 관련 클래스
	
	
	// 회원가입 폼 페이지 요청
	@GetMapping("memberRegister")
	public ModelAndView memberRegister(ModelAndView mav) {
		
		mav.setViewName("member/memberRegister"); // view 단 페이지
		
		return mav;
		
	}//end of public ModelAndView memberRegister(ModelAndView mav) {}...
	
	
	
	// 회원가입 
//	@PostMapping("emailCheckOk_메소드이름")
//	public ModelAndView memberRegister(HttpServletRequest request, HttpServletResponse response, 
//									   ModelAndView mav, @RequestParam Map<String, String> paraMap) {
//		
//		// 여기까지 왔다면 이메일 인증여부 통과했으니 삭제
//		session.removeAttribute("emailCheckOk"); 
//		
//		// 주소는 member_address 로 String 으로 가져와서 번호(지역번호 seq)로 바꿔준다.
//		
//		return mav;
//		
//	}//end of public ModelAndView postMethodName(ModelAndView mav, MemberVO membervo) {}...
	
	
	// 아이디 중복체크
	@PostMapping("idDuplicateCheck")
	@ResponseBody
	public Map<String, Boolean> idDuplicateCheck(@RequestParam String member_id) {
		
		boolean isExists = service.idDuplicateCheck(member_id);
		
		Map<String, Boolean> id_checkMap = new HashMap<>();
		id_checkMap.put("isExists", isExists);
		
		return id_checkMap;
		
	}//end of public String postMethodName(@RequestBody String entity) {}...
	
	
	
	
	
	// 이메일 중복확인 및 인증메일 발송
	@PostMapping("emailCheck_Send")
	@ResponseBody
	public Map<String, Boolean> emailCheck_Send(HttpServletRequest request, @RequestParam String member_email) {
		
		Map<String, Boolean> email_check_SendMap = new HashMap<>();
		
		// 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
		boolean sendMailSuccess = false;
		
		// 이메일 중복 검사
		boolean isExists = service.emailCheck(member_email);
		
		if (!isExists) { // 이메일 중복이 없으면
			
			// 인증 이메일을 발송한다!
			sendMailSuccess = funcMail.sendMail(request, member_email);
			// 여기까지 했다. 이메일 보내는 메소드를 완성하고 그걸 위에 오토와이어드로 선언, 사용하면 끝!
			
		}//end of if (!isExists) {}...
		
		// 이메일 중복여부 넣어주자
		email_check_SendMap.put("isExists", isExists);
		// 이메일 발송여부도 넣어주자
		email_check_SendMap.put("sendMailSuccess", sendMailSuccess);
		
		return email_check_SendMap;
		
	}//end of public String postMethodName(@RequestBody String entity) {}...
	
	
	
	
	
	// 이메일 인증 번호 받아서 확인해주는 메소드
	@PostMapping("emailAuth")
	@ResponseBody
	public Map<String, Boolean> emailAuth(HttpServletRequest request, @RequestParam String email_auth_text) {
		
		Map<String, Boolean> email_AuthMap = new HashMap<>(); // 보내줄 맵 선언
		
		// 이메일 인증번호를 비교해서 확인해주는 메소드
		boolean isExists = funcMail.emailAuth(request, email_auth_text); // 인증번호가 맞으면 true, 아니면 false
		
		email_AuthMap.put("isExists", isExists); // 넣어준다.
		
		return email_AuthMap;
		
	}//end of public Map<String, Boolean> emailAuth(@RequestParam String email_auth_text) {}...
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 로그인 폼 페이지 요청
//	@GetMapping("login")
//	public ModelAndView login(ModelAndView mav) {
//		mav.setViewName(" /login/loginform"); // view 단 페이지
//		//
//		return mav;
//
//	}// end of public String getMethodName() {}...
	
	
	
	
	
	
	
	
	
	
	
}//end of class...



























