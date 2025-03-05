package com.spring.app.member.controller;

import java.io.File;
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
import com.spring.app.file.domain.FileVO;
import com.spring.app.member.domain.MemberCareerVO;
import com.spring.app.member.domain.MemberEducationVO;
import com.spring.app.member.domain.MemberSkillVO;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
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
	FileManager fileManager; // 파일 관련 클래스
	
	
	// 회원가입 폼 페이지 요청
	@GetMapping("memberRegister")
	public ModelAndView memberRegister(ModelAndView mav) {
		
		mav.setViewName("member/memberRegister"); // view 단 페이지
		
		return mav;
		
	}//end of public ModelAndView memberRegister(ModelAndView mav) {}...
	
	
	// 회원가입 
	@PostMapping("memberRegister")
	public ModelAndView emailCheckOk_memberRegister(HttpServletRequest request, HttpServletResponse response,
									   ModelAndView mav, MemberVO membervo,
									   MultipartHttpServletRequest mrequest) {
		// 파일은 mrequest 로, membervo 는 회원정보 받아준다.
		
		// 여기까지 왔다면 이메일 인증여부 통과했으니 삭제
		HttpSession session = request.getSession(); 
		session.removeAttribute("emailCheckOk");
		
		
		// 파일부터 넣어주기
		MultipartFile attach_member_profile = membervo.getAttach_member_profile();
		// 
		
		System.out.println("attach_member_profile => "+ attach_member_profile);
		
		// 나오는 결과값을 보고 디폴트 설정해주자
		// input 태그 name 이 vo 랑 같아야함
		
		// 프로필 사진 일단 기본이미지로 default
		if (!attach_member_profile.isEmpty()) { // 스프링은 빈파일 객체로 반환해줘서 null 이 아니다!
			
			// WAS 의 webapp 의 절대경로를 알아와야한다.
			HttpSession m_session = mrequest.getSession(); // 파일용 세션
			String root = m_session.getServletContext().getRealPath("/");

			String path = root + "resources" + File.separator + "files";
			
			
			String newProFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명

			byte[] bytes_member_profile = null;
			// 첨부파일의 내용물을 담는 것

			try {
				bytes_member_profile = attach_member_profile.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				
				String origin_member_profile_Filename = attach_member_profile.getOriginalFilename();
				System.out.println("origin_member_profile_Filename => "+ origin_member_profile_Filename);
				// 첨부파일명의 파일명(예:강아지.png)을 읽어오는 것
				// 백그라운드 이미지는 null 로 처리
				
				// 파일 확장자!
				String fileExt = origin_member_profile_Filename.substring(origin_member_profile_Filename.lastIndexOf(".")); 
				System.out.println("fileExt => "+fileExt);
				// 백엔드에서 한번 더 사진파일로 걸러주자
				if (!".jpg".equals(fileExt) && !".png".equals(fileExt) && !".webp".equals(fileExt) && !".jpeg".equals(fileExt)) {
					mav.addObject("message", "사진 파일만 등록할 수 있습니다.");
					mav.addObject("loc", "javascript:history.back()");
					mav.setViewName("common/msg");
					return mav;
				}//end of if (fileExt != ".jpg" || fileExt != ".png" || fileExt != ".webp") {}...
				
				// 첨부되어진 파일을 업로드 하는 것이다.

				// MemberVO membervo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기
				newProFileName = fileManager.doFileUpload(bytes_member_profile, origin_member_profile_Filename, path);
				membervo.setMember_profile(newProFileName);

			} catch (Exception e) {
				e.printStackTrace();
			} // end of try catch...
			
		}//end of if (attach_member_profile != null) {}...
		
		System.out.println("멤버_프로필사진 안넣었을 때 => "+membervo.getMember_profile());
		// 멤버_프로필사진 안넣었을 때 => null 근데 메퍼에 넣으면 터진다..?(해결 : 메퍼에 null 값의 파라미터로 insert 가 안된다!)
		
		// 회원가입 시작
		int n = service.memberRegister(membervo);
		
		if (n == 1) {
//			mav.addObject("member_id", membervo.getMember_id());
//			mav.addObject("member_passwd", membervo.getMember_passwd());
//			mav.setViewName("common/memberRegister_after_autoLogin"); // 자동로그인
			mav.setViewName("feed/board"); // jsp 파일
			// TODO 로그인 후 회원경력, 학력 넣어주는 페이지로 이동하도록 로그인 수정해야함
			
		} else {
			mav.addObject("message", "회원가입 실패");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("common/msg");
		}//end of if else (n == 1) {}...
		
		// 회원가입 후 경력과 학력을 넣어줄 예정

		return mav; 
		// TODO 나중에 회원 경력, 학력 페이지로 가게 만들고, 지금은 그냥 피드로 가자.
		
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
	
	
	
	
	
	
	
	
	
//	// 직종 자동검색 메소드
//	@GetMapping("job/search")
//	@ResponseBody
//	public List<Map<String, String>> jobSearch(@RequestParam String job_name) {
//		
//		List<Map<String, String>> jobList = service.jobSearch(job_name);
//		
//		return jobList;
//	}//end of public String jobSearch(@RequestParam String job_name) {}...
	
	
	
	
	

	
	
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
	@GetMapping("profile/{memberId}")
	public ModelAndView profile(HttpServletRequest request, ModelAndView mav, @PathVariable String memberId) {
		
		mav.addObject("memberId", memberId);
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("member_id", memberId);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		if(loginuser != null) {
			paraMap.put("login_member_id", loginuser.getMember_id());
		}
		else {
			paraMap.put("login_member_id", " ");
		}

		MemberVO memberVO = service.getMember(paraMap);	// 회원 정보

		paraMap.put("size", "3");
		
		List<MemberCareerVO> memberCareerVOList = service.getMemberCareerListByMemberId(paraMap);          // 회원 경력
		List<MemberEducationVO> memberEducationVOList = service.getMemberEducationListByMemberId(paraMap); // 회원 학력
		List<MemberSkillVO> memberSkillVOList = service.getMemberSkillListByMemberId(paraMap);             // 회원 보유스킬

		mav.addObject("memberVO", memberVO);							 // 회원 정보
		mav.addObject("memberCareerVOList", memberCareerVOList);		 // 회원 경력
		mav.addObject("memberEducationVOList", memberEducationVOList); // 회원 학력
		mav.addObject("memberSkillVOList", memberSkillVOList);		 // 회원 보유스킬
		
		mav.setViewName("/member/profile");
		
		return mav;
	}// end of public ModelAndView profile(ModelAndView mav)----------

	// 테스트용
	// @GetMapping("profile/more/{memberId}")
	// public ModelAndView profileMore(ModelAndView mav, @PathVariable String memberId) {
		
	// 	mav.addObject("memberId", memberId);
		
	// 	mav.setViewName("/member/profileMore");
		
	// 	return mav;
	// }// end of public ModelAndView profileMore(ModelAndView mav)----------

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



























