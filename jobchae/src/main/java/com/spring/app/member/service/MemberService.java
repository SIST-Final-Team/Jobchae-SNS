package com.spring.app.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.domain.MemberCareerVO;
import com.spring.app.member.domain.MemberEducationVO;
import com.spring.app.member.domain.MemberSkillVO;

import jakarta.servlet.http.HttpServletRequest;

public interface MemberService {

	// === 이준영 시작 === //
	
	// 아이디 충복체크
	boolean idDuplicateCheck(String member_id);

	// 이메일 중복확인 및 인증메일 발송
	boolean emailCheck(String member_email);
	
	// 회원가입
	int memberRegister(MemberVO membervo);
	
	// 지역 검색 시 자동 완성 해주는 메소드 
	List<Map<String, String>> regionSearchShow(String region_name);

	// 로그인하는 메소드
	ModelAndView login(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap);

	// === 이준영 끝 === //
	
	
	// === 김규빈 시작 === //
	
	// 자동완성을 위한 직종 목록 조회 및 검색
	List<Map<String, String>> getJobListForAutocomplete(Map<String, String> paraMap);
	
	// 자동완성을 위한 회사 목록 조회 및 검색
	List<Map<String, String>> getCompanyListForAutocomplete(Map<String, String> paraMap);
	
	// 자동완성을 위한 전공 목록 조회 및 검색
	List<Map<String, String>> getMajorListForAutocomplete(Map<String, String> paraMap);

	// 자동완성을 위한 학교 목록 조회 및 검색
	List<Map<String, String>> getSchoolListForAutocomplete(Map<String, String> params);

	// 자동완성을 위한 보유기술 목록 조회 및 검색
	List<Map<String, String>> getSkillListForAutocomplete(Map<String, String> params);

	// 회원 경력 1개 조회
	MemberCareerVO getMemberCareer(Map<String, String> paraMap);
	
	// 한 회원의 경력 모두 조회
	List<MemberCareerVO> getMemberCareerListByMemberId(Map<String, String> paraMap);
	
	// 회원 경력 등록, 수정, 삭제
	int addMemberCareer(MemberCareerVO memberCareerVO);
	int updateMemberCareer(MemberCareerVO memberCareerVO);
	int deleteMemberCareer(Map<String, String> paraMap);

	// 회원 학력 1개 조회
	MemberEducationVO getMemberEducation(Map<String, String> paraMap);
	
	// 한 회원의 학력 모두 조회
	List<MemberEducationVO> getMemberEducationListByMemberId(Map<String, String> paraMap);

	// 회원 학력 등록, 수정, 삭제
	int addMemberEducation(MemberEducationVO memberEducationVO);
	int updateMemberEducation(MemberEducationVO memberEducationVO);
	int deleteMemberEducation(Map<String, String> paraMap);

	// 회원 보유기술 1개 조회
	MemberSkillVO getMemberSkill(Map<String, String> paraMap);
	
	// 한 회원의 보유기술 모두 조회
	List<MemberSkillVO> getMemberSkillListByMemberId(Map<String, String> paraMap);

	// 회원 보유기술 등록, 삭제
	int addMemberSkill(MemberSkillVO memberSkillVO);
	int deleteMemberSkill(Map<String, String> paraMap);


	// === 김규빈 끝 === //
	
	
}//end of interface...
