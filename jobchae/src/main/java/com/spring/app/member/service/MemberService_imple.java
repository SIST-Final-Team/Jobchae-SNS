package com.spring.app.member.service;

import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.CoreMatchers.is;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.common.FileManager;
import com.spring.app.common.security.Sha256;
import com.spring.app.common.mail.GoogleMail;
import com.spring.app.common.security.RandomEmailCode;
import com.spring.app.member.domain.MemberCareerVO;
import com.spring.app.member.domain.MemberEducationVO;
import com.spring.app.member.domain.MemberSkillVO;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.domain.ReportVO;
import com.spring.app.member.model.MemberDAO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class MemberService_imple implements MemberService {

	@Autowired
	MemberDAO dao;

	// 양방향 암호화 자동 객체 선언
	@Autowired
	private AES256 aes;
	
	@Autowired
	private FileManager filemanager;
	
	@Autowired
    private ServletContext servletContext;
	
	

	
	// === 이준영 시작 === //
	
	// 아이디 중복체크
	@Override
	public boolean idDuplicateCheck(String member_id) {
		
		boolean isExists = false;
		
		String selected_member_id = dao.idDuplicateCheck(member_id);
		
		if (selected_member_id != null) {
			isExists = true; // 발견은 true, 새로운 아이디면 false
		}
		
		return isExists;
		
	}//end of public boolean idDuplicateCheck(String member_id) {}...




	
	
	// 이메일 중복확인 및 인증메일 발송
	@Override
	public boolean emailCheck(String member_email) {
		// 입력한 이메일이 존재하는지 확인
		boolean isExists = false;
		
		String selected_member_email = dao.emailCheck(member_email);
		
		if (selected_member_email != null) {
			isExists = true; // 발견은 true, 새로운 아이디면 false
		}
		
		return isExists;
	}//end of public boolean emailCheck_Send(String member_email) {}...





	
	// 지역 검색 시 자동 완성 해주는 메소드
	@Override
	public List<Map<String, String>> regionSearchShow(String region_name) {

		List<Map<String, String>> regionList = dao.regionSearchShow(region_name); 
		
		return regionList;
		
	}//end of public List<String> regionSearchShow(String member_region) {}...


	
	
	
	// 회원가입 메소드
	@Override
	public int memberRegister(MemberVO membervo) {
		
		// 암호화
		try {
			membervo.setMember_passwd(Sha256.encrypt(membervo.getMember_passwd())); // 단방향
			membervo.setMember_email(aes.encrypt(membervo.getMember_email())); 		// 양방향
			membervo.setMember_tel(aes.encrypt(membervo.getMember_tel())); 			// 양방향

		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		//
		int n = dao.memberRegister(membervo);
		
		if(n == 1) {
			insertMemberSetting(membervo.getMember_id()); // 회원가입시 회원설정 추가하기
		}
		
		return n;
		
	}//end of public int memberRegister(MemberVO membervo) {}...
	
	// 회원가입시 회원설정 추가하기
	@Override
	public int insertMemberSetting(String member_id) {
		return dao.insertMemberSetting(member_id);
	}// end of public int insertMemberSetting(String member_id) {}...




	
	
	
	// 로그인 처리하기
	@Override
	public ModelAndView login(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap) {

		// 자동 로그인 시 암호화를 넘어가는 목적, 없으면(null) 이면 넘거갈꺼다.
		if (!"1".equals(paraMap.get("alert_choice")) && !"0".equals(paraMap.get("alert_choice"))) {
//			System.out.println("이거 나오면 암호화 과정 거치는거다!");
			paraMap.put("member_passwd", Sha256.encrypt(paraMap.get("member_passwd"))); // 비밀번호를 암호화 시키기
		}
		
		// 로그인 정보 가져오기
		MemberVO loginuser = dao.getLoginMember(paraMap);

		if (loginuser != null) { // 검색 성공

			HttpSession session = request.getSession();
			// 메모리에 생성되어져 있는 session 을 불러온다.
			
			if (loginuser.getMember_idle().equals("1")) {
				// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정
				// 스프링 스케줄러로 1년이 지나면 자동으로 idle 이 1이 되도록 설정!
				
				// 휴면계정 해제 페이지로!
				String message = "로그인을 한지 1년이 지나서 휴면상태로 되었습니다.\\n관리자에게 문의 바랍니다.";
				String loc = request.getContextPath() + "/member/memberReactivation";
				
				String email = "";
				try { // 이메일 복호화
					email = aes.decrypt(loginuser.getMember_email());
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				}
				// 세션에 로그인한 멤버의 아이디와 이메일, 비밀번호 넣어주기
				session.setAttribute("member_id", loginuser.getMember_id());
				session.setAttribute("member_email", email);
				session.setAttribute("member_passwd", loginuser.getMember_passwd());
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("common/msg");
				
			} else { // 휴면이 아닌 경우

				try {
					String email = aes.decrypt(loginuser.getMember_email()); // 이메일 복호화
					String tel = aes.decrypt(loginuser.getMember_tel()); // 휴대폰 복호화

					loginuser.setMember_email(email);
					loginuser.setMember_tel(tel);

				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				} // end of try catch..

				
				if (loginuser.getPasswdchangegap() >= 3) {
					// 비밀번호가 변경된지 3개월 이상인 경우
					loginuser.setRequirePasswdChange(true);
				}
				
				// ============================================================== //
				// 로그인 세션 저장 시작
				session.setAttribute("loginuser", loginuser);
				// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.

				// 로그인 기록 추가
				dao.insert_tbl_login(paraMap);

				if (loginuser.isRequirePasswdChange() == true) { // 암호를 마지막으로 변경한 것이 3개월이 경과한 경우
					String message = "비밀번호를 변경하신지 3개월이 지났습니다.\\n암호를 변경하시는 것을 추천합니다.";
					String loc = request.getContextPath() + "/member/passwdUpdate"; // get 방식으로 전달해야함
					// 비밀번호 변경 페이지로
					mav.addObject("message", message);
					mav.addObject("loc", loc);
					mav.setViewName("common/msg");
					
				} else { // 암호를 마지막으로 변경한 것이 3개월 이내인 경우 여기까지 오면 진짜 로그인 완료

					// 로그인을 해야만 접근할 수 있는 페이지에 로그인을 하지 않은 상태에서 접근을 시도한 경우
					// "먼저 로그인을 하세요!!" 라는 메시지를 받고서 사용자가 로그인을 성공했다라면
					// 화면에 보여주는 페이지는 시작페이지로 가는 것이 아니라
					// 조금전 사용자가 시도하였던 로그인을 해야만 접근할 수 있는 페이지로 가기 위한 것이다.
					String goBackURL = (String) session.getAttribute("goBackURL");
					
					if (goBackURL != null) {
						mav.setViewName("redirect:" + goBackURL);
						session.removeAttribute("goBackURL"); // 세션에서 반드시 제거해주어야 한다.
					} else {
						mav.setViewName("redirect:/board/feed"); // 보드페이지로 이동
//						mav.setViewName("redirect:/member/~~~~"); 
						// TODO 원래는 회원 경력, 학력 넣어주는 페이지로 이동시키자
					}//

				}//end of if else (loginuser.isRequirePwdChange() == true) {}...
				
			}//end of if else (loginuser.getMember_idle() == "1") {}...
		
		} else { // 검색 실패(로그인 실패)
			
			String message = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("common/msg");
			
		}//end of if (loginuser != null) {}...
		

		return mav;
	
	}// end of public ModelAndView login(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap) {}...

	
	
	// 회원 휴면을 자동으로 지정해주는 스케줄러
	@Override
	public void deactivateMember_idle() {
		
		dao.deactivateMember_idle();
	}//end of public void deactivateMember_idle() {}...
	
	
	
	// 휴면 해제 실행 메소드
	@Override
	public ModelAndView memberReactivation(ModelAndView mav, Map<String, String> paraMap, HttpServletRequest request) {
		
		int n = dao.memberReactivation(paraMap.get("member_id"));
		
		if (n == 1) {
			mav.addObject("member_id", paraMap.get("member_id"));
			mav.addObject("member_passwd", paraMap.get("member_passwd"));
			mav.addObject("alert_choice", 1);
			// 자동로그인으로
			mav.setViewName("common/after_autoLogin");
			return mav;
		
		} else { // 휴면 해제 실패시 오류 처리
			String message = "오류가 발생하여 로그인 화면으로 돌아갑니다.";
			String loc = request.getContextPath() + "/member/login"; 
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("common/msg");
			
			return mav;
		}//
		
	}//end of public ModelAndView memberReactivation(Map<String, String> paraMap) {}...
	
	
	
	// 비밀번호 변경 메소드
	@Override
//	@Transactional(value = "transactionManager_jobchae", // 수동 커밋 설정
//				   propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, 
//				   rollbackFor= {Throwable.class})
	public ModelAndView passwdUpdate(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap) {
			
		// 기존 비밀번호랑 새 비밀번호가 다른지 확인
		// 비밀번호 암호화 해서 넣어주자 
		String new_member_passwd = Sha256.encrypt(paraMap.get("new_member_passwd"));
		// 비밀번호 중복 확인
		String reslut = dao.passwdExist(new_member_passwd);
		String loc = "";
		if (reslut != null) { // 비밀번호가 일치하면(존재하면)
			
			String message = "비밀번호가 기존 비밀번호와 일치합니다! 새로운 비밀번호를 입력해주세요.";
			mav.addObject("message", message);
			
			// 비밀번호 찾기 기능을 통해 온 경우 값이 존재해야한다.
			if ("is_passwdFind".equals(paraMap.get("is_passwdFind"))) {
				loc = request.getContextPath() + "/member/login"; // 로그인 화면으로
				mav.addObject("loc", loc);
				mav.setViewName("common/msg");
				return mav;
			} else {
				// 그냥 비밀번호 변경을 하려고 온 경우
				loc = "javascript:history.back()"; // 전 화면(비밀번호 변경)으로
				mav.addObject("loc", loc);
				mav.setViewName("common/msg");
				return mav;
			}
		}//end of if (reslut != null) {}...
		
		
		// 암호화한 비밀번호를 다시 맵에 넣어주자
		paraMap.put("new_member_passwd", new_member_passwd);
		// 비밀번호가 일치하지 않는 새 비밀번호인 경우 비밀번호 변경
		int n = dao.passwdUpdate(paraMap);
		
		if (n == 1) { // 모두 성공 시
			String message = "비밀번호가 변경됐습니다! 다시 로그인해주세요.";
			loc = request.getContextPath() + "/member/login"; // 로그인 화면으로
			mav.addObject("message", message);
			
		} else { // 실패 시 
			String message = "오류가 발생하여 로그인 화면으로 돌아갑니다.;";
			mav.addObject("message", message);
			
			if ("is_passwdFind".equals(paraMap.get("is_passwdFind"))) { // 비밀번호 찾기인 경우
				loc = request.getContextPath() + "/member/login"; 
				
			} else { // 그냥 비밀번호 변경을 하려고 온 경우
				loc = "javascript:history.back()"; // 전 화면(비밀번호 변경)으로
			}//end of if ("is_passwdFind".equals(paraMap.get("is_passwdFind"))) {}...
			
		}//end of if else (n == 1) {}...
		
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}// end of public ModelAndView passwdUpdate(ModelAndView mav, Map<String, String> paraMap) {}...
	
	
	
	// 아이디 찾기 메소드
	@Override
	public ModelAndView idFind(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap) {
		
		// 이메일 암호화해서 다시 넣어준다.
		try {
			paraMap.put("member_email", aes.encrypt(paraMap.get("member_email")));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		String member_id = dao.idFind(paraMap);
		
		if (member_id != null) {// 검색 성공 시 
			mav.addObject("member_id", member_id);
			mav.addObject("member_name", paraMap.get("member_name"));
			mav.setViewName("login/idFindEnd");
			
		} else { // 검색 실패 시
			String message = "해당 성명과 이메일로 가입된 계정이 없습니다. 다시 시도해주십시오.";
			String loc = request.getContextPath() + "/member/login"; 
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
		}//

		return mav;
		
	}//end of public ModelAndView idFind(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap) {}...
	
	
	
	
	// 회원이 존재하는지 검사하는 메소드
	@Override
	public boolean isExistMember(Map<String, String> paraMap) {
		
		boolean isExists = false;
		// 비밀번호 암호화해서 넣어줌
		paraMap.put("member_passwd", Sha256.encrypt(paraMap.get("member_passwd")));
		
		String member = dao.isExistMember(paraMap);
		
		if (member != null) { // 회원이름이 있음
			isExists = true;
		}
		return isExists; // 있으면 true, 없으면 false
	}//end of public boolean isExistMember(Map<String, String> paraMap) {}...
	
	
	
	// 회원 탈퇴 메소드
	@Override
	@Transactional(value = "transactionManager_jobchae", propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public ModelAndView memberDisable(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap) {
		
		int n = dao.memberDisable(paraMap);
		
		if (n == 1) { // 성공하면
			// 회원 탈퇴 시간 넣어주기 (관리자가 탈퇴한 회원을 되살릴 때 시간은 삭제해야한다.)
			int m = dao.memberDisableDate();
			
			if (m == 1) {
				mav.setViewName("member/aftermemberDisable"); // 탈퇴 최종페이지 이동
			}
			
		} else { // 실패하면
			String message = "오류가 발생하여 로그인 화면으로 돌아갑니다.";
			String loc = request.getContextPath() + "/member/login"; 
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
		}
		
		return mav;
	}//end of public ModelAndView memberDisable(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap) {}...
	
	
	
	// => FK_TBL_LOGIN_ FK_MEMBER_ID 이란 이름의 제약조건 때문에 멤버 삭제 불가능.
	// 제약조건들을 다 delete cascade 해줘야함. 너무 많아서 기능을 잠궈두겠다!!!!
	// 탈퇴된 회원 한달 뒤 자동삭제 스캐줄러 4시 시작
	@Override
	public void memberDelete() {
		
		// 디비에 없는 파일은 한달에 한번 한꺼번에 삭제하자!
		String root = servletContext.getRealPath("/");
        String path = root + "resources" + File.separator + "files" + File.separator + "profile";

        System.out.println("파일 경로: " + path);
        // 파일 처리 로직 추가
		
		// 탈퇴한 회원 파일명을 리스트로 가져오기 검색
		List<Map<String, String>> disableFileList = dao.disableFileList();
		
		// 검색 성공 시
		if (disableFileList.size() > 0) {
			for (Map<String, String> map : disableFileList) {
				// 가져온 프로필이 기본이미지이면 삭제하지말고 넘겨라
				String member_profile = map.get("member_profile");
				String member_background_img = map.get("member_background_img");
				
				try {
					if (!"default/profile.png".equals(member_profile)) {
						filemanager.doProfileDelete(member_profile, path);
					}
					if (!"default/background_img.jpg".equals(member_background_img)) {
						filemanager.doBackgroundfileDelete(member_background_img, path);
					}//
				} catch (Exception e) {
					e.printStackTrace();
				}//
			}//end of for (Map<String, String> map : disableFileList) {}...
		}//end of if (disableFileList.size() > 0) {}...
		
		// 회원 데이터 삭제
		dao.memberDelete();
		
	}// end of public void memberDelete() {}...
	
	
	
	


	
	
	// === 이준영 끝 === //
	
	
	

	// === 김규빈 시작 === //
	
	// 자동완성을 위한 직종 목록 조회 및 검색
	@Override
	public List<Map<String, String>> getJobListForAutocomplete(Map<String, String> paraMap) {
		
		if(paraMap.get("size") == null || paraMap.get("sizePerPage").isBlank()) {
			paraMap.put("size", "8");
		}
		
		return dao.getJobListForAutocomplete(paraMap);
	}

	// 자동완성을 위한 회사 목록 조회 및 검색
	@Override
	public List<Map<String, String>> getCompanyListForAutocomplete(Map<String, String> paraMap) {

		if(paraMap.get("size") == null || paraMap.get("sizePerPage").isBlank()) {
			paraMap.put("size", "8");
		}
		
		return dao.getCompanyListForAutocomplete(paraMap);
	}

	// 자동완성을 위한 전공 목록 조회 및 검색
	@Override
	public List<Map<String, String>> getMajorListForAutocomplete(Map<String, String> paraMap) {

		if(paraMap.get("size") == null || paraMap.get("sizePerPage").isBlank()) {
			paraMap.put("size", "8");
		}
		
		return dao.getMajorListForAutocomplete(paraMap);
	}

	// 자동완성을 위한 직종 목록 조회 및 검색
	@Override
	public List<Map<String, String>> getSchoolListForAutocomplete(Map<String, String> paraMap) {
		
		if(paraMap.get("size") == null || paraMap.get("sizePerPage").isBlank()) {
			paraMap.put("size", "8");
		}
		
		return dao.getSchoolListForAutocomplete(paraMap);
	}

	// 자동완성을 위한 보유기술 목록 조회 및 검색
	@Override
	public List<Map<String, String>> getSkillListForAutocomplete(Map<String, String> paraMap) {
		
		if(paraMap.get("size") == null || paraMap.get("sizePerPage").isBlank()) {
			paraMap.put("size", "8");
		}
		
		return dao.getSkillListForAutocomplete(paraMap);
	}

	// 회원 한 명의 정보 조회
	@Override
	public MemberVO getMember(Map<String, String> paraMap) {
		return dao.getMember(paraMap);
	}

	// 회원 경력 1개 조회
	@Override
	public MemberCareerVO getMemberCareer(Map<String, String> paraMap) {
		return dao.getMemberCareer(paraMap);
	}

	// 한 회원의 경력 모두 조회
	@Override
	public List<MemberCareerVO> getMemberCareerListByMemberId(Map<String, String> paraMap) {
		return dao.getMemberCareerListByMemberId(paraMap);
	}
	
	// 회원 경력 등록
	@Override
	public int addMemberCareer(MemberCareerVO memberCareerVO) {
		return dao.insertMemberCareer(memberCareerVO);
	}
	
	// 회원 경력 수정
	@Override
	public int updateMemberCareer(MemberCareerVO memberCareerVO) {
		return dao.updateMemberCareer(memberCareerVO);
	}

	// 회원 경력 삭제
	@Override
	public int deleteMemberCareer(Map<String, String> paraMap) {
		return dao.deleteMemberCareer(paraMap);
	}

	// 회원 학력 1개 조회
	@Override
	public MemberEducationVO getMemberEducation(Map<String, String> paraMap) {
		return dao.getMemberEducation(paraMap);
	}

	// 한 회원의 학력 모두 조회
	@Override
	public List<MemberEducationVO> getMemberEducationListByMemberId(Map<String, String> paraMap) {
		return dao.getMemberEducationListByMemberId(paraMap);
	}
	
	// 회원 학력 등록
	@Override
	public int addMemberEducation(MemberEducationVO memberEducationVO) {
		return dao.insertMemberEducation(memberEducationVO);
	}
	
	// 회원 학력 수정
	@Override
	public int updateMemberEducation(MemberEducationVO memberEducationVO) {
		return dao.updateMemberEducation(memberEducationVO);
	}

	// 회원 학력 삭제
	@Override
	public int deleteMemberEducation(Map<String, String> paraMap) {
		return dao.deleteMemberEducation(paraMap);
	}

	// 회원 보유기술 1개 조회
	@Override
	public MemberSkillVO getMemberSkill(Map<String, String> paraMap) {
		return dao.getMemberSkill(paraMap);
	}

	// 한 회원의 보유기술 모두 조회
	@Override
	public List<MemberSkillVO> getMemberSkillListByMemberId(Map<String, String> paraMap) {
		return dao.getMemberSkillListByMemberId(paraMap);
	}
	
	// 회원 보유기술 등록
	@Override
	public int addMemberSkill(MemberSkillVO memberSkillVO) {
		return dao.insertMemberSkill(memberSkillVO);
	}

	// 회원 보유기술 삭제
	@Override
	public int deleteMemberSkill(Map<String, String> paraMap) {
		return dao.deleteMemberSkill(paraMap);
	}

	// 회원 프로필 배경 수정
	@Override
	public int updateMemberBackgroundImg(MemberVO memberVO) {
		return dao.updateMemberBackgroundImg(memberVO);
	}

	// 회원 프로필 사진 수정
	@Override
	public int updateMemberProfile(MemberVO memberVO) {
		return dao.updateMemberProfile(memberVO);
	}

	// 한 회원의 팔로워 수 가져오는 메소드
	public int getFollowerCount(String member_id) {
		return dao.getFollowerCount(member_id);
	}

	// 회원 정보 수정
	@Override
	public int updateMember(MemberVO memberVO) {
		
		// 암호화
		try {
			if(!"".equals(memberVO.getMember_passwd())){
				memberVO.setMember_passwd(Sha256.encrypt(memberVO.getMember_passwd())); // 단방향
			}
			if(!"".equals(memberVO.getMember_passwd())){
				memberVO.setMember_email(aes.encrypt(memberVO.getMember_email())); 		// 양방향
			}
			if(!"".equals(memberVO.getMember_passwd())){
				memberVO.setMember_tel(aes.encrypt(memberVO.getMember_tel())); 			// 양방향
			}
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}

		int n = dao.updateMember(memberVO);
		
		// 복호화
		try {
			memberVO.setMember_email(aes.decrypt(memberVO.getMember_email())); 		// 양방향
			memberVO.setMember_tel(aes.decrypt(memberVO.getMember_tel())); 			// 양방향
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}

		return n;
	}

	// 회원의 이름, 프로필 이미지 목록 조회
	@Override
	public List<MemberVO> getMemberListByMemberId(List<String> memberIdList) {
		return dao.getMemberListByMemberId(memberIdList);
	}



















	






	











	





	





	






	

	
	
	// === 김규빈 끝 === //
	
	
	
	
	
	
	
	
	
	
	
	

	// === 이진호 시작 === //
	

	@Override
	public boolean createReport(ReportVO report) {
		
	        try {
	            // 신고 정보를 DB에 저장
	            dao.createReport(report);
	            return true;  // 성공적으로 신고가 처리됨
	            
	        } catch (Exception e) {
	        	
	            e.printStackTrace();  // 예외 발생 시 로그 출력
	            
	            return false;  // 신고 실패
	        }
	}




}//end of class..

















