package com.spring.app.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.mail.GoogleMail;
import com.spring.app.common.FileManager;
import com.spring.app.common.mail.FuncMail;
import com.spring.app.common.security.RandomEmailCode;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
@RequestMapping(value="/member/*")
public class MemberController {

	
	@Autowired
	MemberService service;
	
	@Autowired
	FuncMail funcMail; // 이메일 인증 관련 클래스
	
	@Autowired
	FileManager filemanager; // 파일 관련 클래스
	
	
	// 회원가입 폼 페이지 요청
	@GetMapping("memberRegister")
	public ModelAndView memberRegister(ModelAndView mav) {
		
		mav.setViewName("member/memberRegister"); // view 단 페이지
		
		return mav;
		
	}//end of public ModelAndView memberRegister(ModelAndView mav) {}...
	
	
	
	// 회원가입 
	@PostMapping("emailCheckOk_memberRegister")
	public MemberVO memberRegister(HttpServletRequest request, HttpServletResponse response, 
									MemberVO membervo,
								   MultipartHttpServletRequest mrequest) {
		// 파일은 mrequest 로, membervo 는 회원정보 받아준다.
		
		// 여기까지 왔다면 이메일 인증여부 통과했으니 삭제
		HttpSession session = request.getSession(); 
		session.removeAttribute("emailCheckOk");
		
		
		
		
		
		
		return membervo;
		
	}//end of public ModelAndView postMethodName(ModelAndView mav, MemberVO membervo) {}...
	
	
	
	
	
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
	
	
	
	
	
	
	
	
	
	
	
	// 정확한 지역명을 검색한 후 찾아주는 메소드
	@GetMapping("regionKeyWordSearch")
	@ResponseBody
	public Map<String, String> regionKeyWordSearch(@RequestParam String member_region) {
		
		 Map<String, String> regionMap = service.regionKeyWordSearch(member_region);
		
//		System.out.println("번호 => "+regionMap.get("no"));
//		System.out.println("검색어 => "+regionMap.get("word"));
		
		if (regionMap == null) {
			regionMap = new HashMap<>(); // []
			regionMap.put("isNull", "1"); // 확인용 정크값, js 에서 걸러주는 역할
		}
		
		return regionMap;
		
	}//end of public Map<String, String> getMethodName(@RequestParam String member_region) {}...
	
	
	
	
	
	
	// === 로그인 페이지 켜는 메소드
	@GetMapping("login")
	public ModelAndView login(ModelAndView mav) {
		
		mav.setViewName("login/login");
		return mav;
	}//end of public ModelAndView login(ModelAndView mav) {}...
	
	
	
	
	
	
	
	// 로그인 하는 메소드
	@PostMapping("login")
	public ModelAndView login(ModelAndView mav, HttpServletRequest request, @RequestParam Map<String, String> paraMap) {
		
		// === 클라이언트의 IP 주소를 알아오는 것 === //
		// /myspring/src/main/webapp/JSP 파일을 실행시켰을 때 IP 주소가 제대로 출력되기위한 방법.txt 참조할 것!!!
		String clientip = request.getRemoteAddr();
		paraMap.put("clientip", clientip);
		
		mav = service.login(mav, request, paraMap);
		
		return mav;
	}//end of public Map<String, String> login(@RequestParam Map<String, String> paraMap) {}...
	
	
	
	
	// 회원 탈퇴
//	@GetMapping("")
//	public String getMethodName(@RequestParam String param) {
//		return new String();
//	}//end of 
	
	
	
	
	
	
	

	
	
	
	
	
	// =========================== 김규빈 =========================== //
	@GetMapping("profile")
	public ModelAndView profile(ModelAndView mav) {
		
		mav.setViewName("/member/profile");
		
		return mav;
	}// end of public ModelAndView profile(ModelAndView mav)----------

	// 테스트용
	@GetMapping("profile/more/{memberId}")
	public ModelAndView profileMore(ModelAndView mav, @PathVariable String memberId) {
		
		mav.addObject("memberId", memberId);
		
		mav.setViewName("/member/profileMore");
		
		return mav;
	}// end of public ModelAndView profile(ModelAndView mav)----------

	@GetMapping("profile/member-career/{memberId}")
	public ModelAndView profileMemberCareer(ModelAndView mav, @PathVariable String memberId) {
		
		mav.addObject("memberId", memberId);
		
		mav.setViewName("/member/profileMemberCareer");
		
		return mav;
	}// end of public ModelAndView profileMemberCareer(ModelAndView mav)------

	@GetMapping("profile/member-education/{memberId}")
	public ModelAndView profileMemberEducation(ModelAndView mav, @PathVariable String memberId) {
		
		mav.addObject("memberId", memberId);
		
		mav.setViewName("/member/profileMemberEducation");
		
		return mav;
	}// end of public ModelAndView profileMemberEducation(ModelAndView mav)------

	@GetMapping("profile/member-skill/{memberId}")
	public ModelAndView profileMemberSkill(ModelAndView mav, @PathVariable String memberId) {
		
		mav.addObject("memberId", memberId);
		
		mav.setViewName("/member/profileMemberSkill");
		
		return mav;
	}// end of public ModelAndView profileMemberSkill(ModelAndView mav)------
	
	
	
}//end of class...



























