package com.spring.app.member.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.common.security.Sha256;
import com.spring.app.common.mail.GoogleMail;
import com.spring.app.common.security.RandomEmailCode;
import com.spring.app.member.domain.MemberCareerVO;
import com.spring.app.member.domain.MemberEducationVO;
import com.spring.app.member.domain.MemberSkillVO;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.model.MemberDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class MemberService_imple implements MemberService {

	@Autowired
	MemberDAO dao;

	// 양방향 암호화 자동 객체 선언
	@Autowired
	private AES256 aes;
	
	

	
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


	
	
	
	// 회원가입
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
		return n;
		
	}//end of public int memberRegister(MemberVO membervo) {}...





	
	
	
	// 로그인 처리하기
	@Override
	public ModelAndView login(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap) {

		paraMap.put("member_passwd", Sha256.encrypt(paraMap.get("member_passwd"))); // 비밀번호를 암호화 시키기

		// 로그인 정보 가져오기
		MemberVO loginuser = dao.getLoginMember(paraMap);

		if (loginuser != null) { // 검색 성공

			if (loginuser.getMember_idle() == "1") {
				// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정

				// 스프링 스케줄러로 1년이 지나면 자동으로 idle 이 1이 되도록 설정!
				
				
				// 휴면계정 해제 페이지로!
				String message = "로그인을 한지 1년이 지나서 휴면상태로 되었습니다.\\n관리자에게 문의 바랍니다.";
				String loc = request.getContextPath() + "/index";
				// 원래는 위와 같이 index 이 아니라 휴면의 계정을 풀어주는 페이지로 잡아주어야 한다.

				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");
				
				
			} else { // 휴면이 아닌 경우

				try {
					String email = aes.decrypt(loginuser.getMember_email()); // 이메일 복호화
					String tel = aes.decrypt(loginuser.getMember_tel()); // 휴대폰 복호화

					loginuser.setMember_email(email);
					loginuser.setMember_tel(tel);

				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				} // end of try catch..

				
				if (loginuser.getPwdchangegap() >= 3) {
					// 비밀번호가 변경된지 3개월 이상인 경우
					loginuser.setRequirePwdChange(true);
				}
				
				// ============================================================== //
				// 로그인 세션 저장 시작
				HttpSession session = request.getSession();
				// 메모리에 생성되어져 있는 session 을 불러온다.

				session.setAttribute("loginuser", loginuser);
				// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.

				// 로그인 기록 추가
				dao.insert_tbl_login(paraMap);

				if (loginuser.isRequirePwdChange() == true) { // 암호를 마지막으로 변경한 것이 3개월이 경과한 경우
					String message = "비밀번호를 변경하신지 3개월이 지났습니다.\\n암호를 변경하시는 것을 추천합니다.";
					String loc = request.getContextPath() + "/index";
					// 비밀번호 변경 페이지로

					mav.addObject("message", message);
					mav.addObject("loc", loc);

					mav.setViewName("msg");
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
						mav.setViewName("redirect:/board/feed"); // 시작페이지로 이동
					}//

				}//end of if else (loginuser.isRequirePwdChange() == true) {}...
				
			}//end of if else (loginuser.getMember_idle() == "1") {}...
		
		} else { // 검색 실패(로그인 실패)
			
			String message = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
			
		}//end of if (loginuser != null) {}...
		

		return mav;
	
	}// end of public ModelAndView login(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap) {}...

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

	
	
	// === 김규빈 끝 === //
}//end of class..

















