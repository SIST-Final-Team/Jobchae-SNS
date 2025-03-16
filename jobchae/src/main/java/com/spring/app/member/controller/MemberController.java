package com.spring.app.member.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.FileManager;
import com.spring.app.config.DefaultImageNames;
import com.spring.app.history.domain.ProfileViewVO;
import com.spring.app.history.domain.ViewCountVO;
import com.spring.app.history.service.HistoryService;
import com.spring.app.member.domain.MemberCareerVO;
import com.spring.app.member.domain.MemberEducationVO;
import com.spring.app.member.domain.MemberSkillVO;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.service.MemberService;
import com.spring.app.search.domain.SearchBoardVO;
import com.spring.app.search.service.SearchService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.bind.annotation.PostMapping;


@Controller
@RequestMapping(value="/member/*")
public class MemberController {

	
	@Autowired
	MemberService service;
	
	@Autowired
	HistoryService historyService;
	
	@Autowired
	FileManager fileManager; // 파일 관련 클래스

	@Autowired
	SearchService searchService;
	
	
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
		MultipartFile attach_member_profile = membervo.getAttach_member_profile(); // 프로필사진
		
//		System.out.println("attach_member_profile => "+ attach_member_profile);
		
		// 나오는 결과값을 보고 디폴트 설정해주자
		// input 태그 name 이 vo 랑 같아야함
		
		// 프로필 사진 일단 기본이미지로 default
		if (!attach_member_profile.isEmpty()) { // 스프링은 빈파일 객체로 반환해줘서 null 이 아니다!
			
			// WAS 의 webapp 의 절대경로를 알아와야한다.
			HttpSession m_session = mrequest.getSession(); // 파일용 세션
			String root = m_session.getServletContext().getRealPath("/");

			String path = root + "resources" + File.separator + "files" + File.separator + "profile";
			
			String newProFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes_member_profile = null;
			// 첨부파일의 내용물을 담는 것
			
			try {
				bytes_member_profile = attach_member_profile.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				
				String origin_member_profile_Filename = attach_member_profile.getOriginalFilename();
//				System.out.println("origin_member_profile_Filename => "+ origin_member_profile_Filename);
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
			
		} else { // 들어온 프로필사진이 없을 때
			membervo.setMember_profile(DefaultImageNames.ProfileName);
			
		}//end of if (attach_member_profile != null) {}...
		
//		System.out.println("멤버_프로필사진 안넣었을 때 => "+membervo.getMember_profile());
		// 멤버_프로필사진 안넣었을 때 => null 근데 메퍼에 넣으면 터진다..?(해결 : 메퍼에 null 값의 파라미터로 insert 가 안된다!)
		
		// (백그라운드사진 파일은 기본파일명을 넣어주자)
		membervo.setMember_background_img(DefaultImageNames.BackgroundfileName);
		// 회원가입 시작 
		int n = service.memberRegister(membervo);
		
		if (n == 1) {
			mav.addObject("member_id", membervo.getMember_id());
			mav.addObject("member_passwd", membervo.getMember_passwd());
			mav.addObject("alert_choice", 0);
			
			mav.setViewName("common/after_autoLogin"); // 자동로그인
//			mav.setViewName("feed/board"); // jsp 파일
			// TODO 로그인 후 회원경력, 학력 넣어주는 페이지로 이동하도록 로그인 수정해야함, 그리고 거기서 자동로그인을 해줘야함
			
		} else {
			mav.addObject("message", "회원가입 실패");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("common/msg");
		}//end of if else (n == 1) {}...
		
		// 회원가입 후 경력과 학력을 넣어줄 예정

		return mav; 
		// TODO 나중에 회원 경력, 학력 페이지로 가게 만들고, 지금은 그냥 피드로 가자.
		
	}//end of public ModelAndView postMethodName(ModelAndView mav, MemberVO membervo) {}...
	
	
	
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
	
	
	
	
	// 휴면 해제 이동 메소드
	@GetMapping("memberReactivation")
	public ModelAndView memberReactivation(ModelAndView mav) {
		mav.setViewName("login/memberReactivation");
		return mav;
	}//end of public ModelAndView memberReactivation(ModelAndView mav) {}...
	
	
	// 휴면 해제 실행 메소드
	@PostMapping("memberReactivation")
	public ModelAndView emailCheckOk_memberReactivation(HttpServletRequest request, HttpServletResponse response, 
														ModelAndView mav, @RequestParam Map<String, String> paraMap) {
		// 여기까지 왔다면 이메일 인증여부 통과했으니 삭제
		HttpSession session = request.getSession();
		session.removeAttribute("emailCheckOk");
		
		// 쓰였던 정보들을 삭제시켜준다.
		session.removeAttribute("member_id");
		session.removeAttribute("member_email");
		session.removeAttribute("member_passwd");
		
		// 휴면 해제 실행 메소드
		mav = service.memberReactivation(mav, paraMap, request);
		
		return mav;
	}//end of public ModelAndView emailCheckOk_memberReactivation(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, @RequestParam Map<String, String> paraMap) {}...
	
	
	
	// 비밀번호 변경 페이지 이동
	@GetMapping("passwdUpdate")
	public ModelAndView passwdUpdate(ModelAndView mav) {
		mav.setViewName("login/passwdUpdate");
		return mav;
	}//end of public ModelAndView passwdUpdate(ModelAndView mav) {}...
	
	
	// 비밀번호 변경 메소드
	@PostMapping("passwdUpdate")
	public ModelAndView emailCheckOk_passwdUpdate(HttpServletRequest request, HttpServletResponse response, 
												  ModelAndView mav, @RequestParam Map<String, String> paraMap) {
		// 여기까지 왔다면 이메일 인증여부 통과했으니 삭제
		HttpSession session = request.getSession();
		session.removeAttribute("emailCheckOk");
				
		mav = service.passwdUpdate(mav, request, paraMap);
		return mav;
	}// end of public ModelAndView passwdUpdate(ModelAndView mav) {}...
	
	
	
	// 비밀번호 찾기 페이지 이동
	@GetMapping("passwdFind")
	public ModelAndView passwdFind(ModelAndView mav) {
		mav.setViewName("login/passwdFind");
		return mav;
	}//end of public ModelAndView passwdFind(ModelAndView mav) {}...
	
	
	// 비밀번호 찾기를 통해 비밀번호 변경으로 페이지 이동
	@PostMapping("passwdFind")
	public ModelAndView passwdFind(ModelAndView mav, @RequestParam Map<String, String> paraMap) {
		
		mav.addObject("member_id", paraMap.get("member_id"));
		mav.addObject("member_email", paraMap.get("member_email"));
		mav.addObject("is_passwdFind", paraMap.get("is_passwdFind")); // 구별할 수 있는 값
		
		mav.setViewName("login/passwdUpdate");
		return mav;
	}// end of public ModelAndView passwdFind(ModelAndView mav) {}...
	
	
	
	// 아이디 찾기 페이지 이동 
	@GetMapping("idFind")
	public ModelAndView idFind(ModelAndView mav) {
		mav.setViewName("login/idFind");
		return mav;
	}//end of public ModelAndView idFind(ModelAndView mav) {}...
	
	
	// 아이디 찾기 메소드
	@PostMapping("idFind")
	public ModelAndView emailCheckOk_idFind(HttpServletRequest request, HttpServletResponse response,
											ModelAndView mav, @RequestParam Map<String, String> paraMap) {
		// 여기까지 왔다면 이메일 인증여부 통과했으니 삭제
		HttpSession session = request.getSession();
		session.removeAttribute("emailCheckOk");
		
		mav = service.idFind(mav, request, paraMap);
		return mav;
	}//end of public ModelAndView idFind(ModelAndView mav) {}...
	
	
	
	// 로그아웃
	@GetMapping("logout")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession(); // 세션불러오기
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String goBackURL = (String)session.getAttribute("goBackURL"); // 돌아갈 url
		
		if (goBackURL != null && loginuser != null) { // url 이랑 로그인 되어있으면
			mav.setViewName("redirect:" + goBackURL);
			session.invalidate(); // 세션 완전 삭제
		
		} else { // 돌아갈 곳 없으면 그냥 삭제
			mav.setViewName("redirect:/member/login"); // 원래는 메인페이지로 가야한다. 만드자. TODO
			session.invalidate(); // 세션 완전 삭제
		} // end of if...
		
		return mav;
	}//end of public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {}...
	
	
	
	
	@GetMapping("memberDisable")
	public ModelAndView requiredLogin_memberDisable(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
//		String member_id = loginuser.getMember_id();
//		System.out.println("확인용!!!!!!!!!!!member_id => "+ member_id);
		mav.setViewName("member/memberDisable");
		return mav;
	}
	
	
	
	// 회원탈퇴 메소드(로그인을 해야지 탈퇴도 가능함)
	@PostMapping("memberDisable")
	public ModelAndView requiredLogin_memberDisable(HttpServletRequest request, HttpServletResponse response, 
													ModelAndView mav, @RequestParam Map<String, String> paraMap) {
		mav = service.memberDisable(mav, request, paraMap);
		return mav;
	}//end of public ModelAndView memberDelete(ModelAndView mav, @RequestParam Map<String, String> paraMap) {}...
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// =========================== 이준영 끝 =========================== //
	
	
	
	
	
	
	
	
	

	
	
	
	
	
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

		if(memberVO == null) {
			mav.addObject("message", "비공개 프로필 또는 탈퇴한 회원입니다.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("common/msg");
			return mav;
		}

		// 로그인 했고, 자기 자신의 프로필 조회가 아니라면
		if(loginuser != null && !loginuser.getMember_id().equals(memberId)) {
			// 프로필 조회 기록 및 조회수 증가
			ProfileViewVO profileViewVO = new ProfileViewVO();

			profileViewVO.setMemberId(loginuser.getMember_id());
			profileViewVO.setProfileViewMemberId(memberId);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			profileViewVO.setProfileViewRegisterDate(sdf.format(new Date()));

			historyService.saveProfileView(profileViewVO);
		}

		paraMap.put("size", "3");
		
		List<MemberCareerVO> memberCareerVOList = service.getMemberCareerListByMemberId(paraMap);          // 회원 경력
		List<MemberEducationVO> memberEducationVOList = service.getMemberEducationListByMemberId(paraMap); // 회원 학력
		List<MemberSkillVO> memberSkillVOList = service.getMemberSkillListByMemberId(paraMap);             // 회원 보유스킬

		int followerCount = service.getFollowerCount(memberId); // 팔로워 수

		Map<String, String> searchBoardParaMap = new HashMap<>();
		searchBoardParaMap.put("authorMemberId", memberId);
		searchBoardParaMap.put("searchWord", "");
		searchBoardParaMap.put("start", "1");
		searchBoardParaMap.put("end", "3");

		List<SearchBoardVO> searchBoardVOList = searchService.searchBoardByContent(searchBoardParaMap); // 작성글 목록

		Map<String, String> viewCountSummary = historyService.findViewCountSummaryByMemberId(memberId); // 조회수 통계

		mav.addObject("memberVO", memberVO);							 // 회원 정보
		mav.addObject("memberCareerVOList", memberCareerVOList);		 // 회원 경력
		mav.addObject("memberEducationVOList", memberEducationVOList); // 회원 학력
		mav.addObject("memberSkillVOList", memberSkillVOList);		 // 회원 보유스킬
		mav.addObject("followerCount", followerCount);                 // 팔로워 수
		mav.addObject("searchBoardVOList", searchBoardVOList);         // 작성글 목록
		mav.addObject("viewCountSummary", viewCountSummary);           // 조회수 통계

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
	
	@PostMapping("memberUpdate")
	public ModelAndView updateMember(HttpServletRequest request, ModelAndView mav, MemberVO memberVO) {

		int n = service.updateMember(memberVO);

		if(n == 1) {

			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			if(!"".equals(memberVO.getMember_name())) {
				loginuser.setMember_name(memberVO.getMember_name());
			}
			if(!"".equals(memberVO.getMember_birth())) {
				loginuser.setMember_birth(memberVO.getMember_birth());
			}
			if(!"".equals(memberVO.getMember_email())) {
				loginuser.setMember_email(memberVO.getMember_email());
			}
			if(!"".equals(memberVO.getMember_tel())) {
				loginuser.setMember_tel(memberVO.getMember_tel());
			}
			if(!"".equals(memberVO.getFk_region_no())) {
				loginuser.setFk_region_no(memberVO.getFk_region_no());
			}
			if(!"".equals(memberVO.getRegion_name())) {
				loginuser.setRegion_name(memberVO.getRegion_name());
			}

			mav.setViewName("redirect:/member/profile/"+memberVO.getMember_id());
		}
		else {
			mav.addObject("message", "회원정보 수정을 실패했습니다.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("common/msg");
		}

		return mav;
	}
	
	// =========================== 김규빈 끝 =========================== //
	

	// =========================== 이진호 시작 =========================== //

	@GetMapping("reportPage")
	public ModelAndView reportPage(ModelAndView mav) {
		mav.setViewName("member/reportPage"); // view 단 페이지
		return mav;
	}

	@GetMapping("personalConnection")
	public ModelAndView personalConee(ModelAndView mav) {
	    mav.setViewName("member/personalConnection"); // view 단 페이지
		return mav;
	}

	@GetMapping("personalConnection/{memberId}")
	public ModelAndView profile(@PathVariable String memberId, ModelAndView mav) {
		// 멤버 정보를 가져오기 위한 파라미터
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("member_id", memberId);

		// 멤버 정보 가져오기
		MemberVO memberVO = service.getMember(paraMap); 
		
		if (memberVO == null) {
			mav.addObject("message", "비공개 프로필 또는 탈퇴한 회원입니다.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("common/msg");
			return mav;
		}

		// 프로필 화면에 전달할 데이터
		mav.addObject("memberVO", memberVO); // MemberVO 객체를 뷰로 전달

		mav.setViewName("member/personalConnection");
		return mav;
	}
	
}//end of class...



























