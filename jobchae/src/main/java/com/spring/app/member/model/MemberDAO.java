package com.spring.app.member.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.app.member.domain.MemberCareerVO;
import com.spring.app.member.domain.MemberEducationVO;
import com.spring.app.member.domain.MemberSkillVO;
import com.spring.app.member.domain.MemberVO;

@Repository
@Mapper
public interface MemberDAO {

	// === 이준영 시작 === //
	
	// 아이디 중복체크
	String idDuplicateCheck(String member_id);

	// 이메일 중복체크
	String emailCheck(String member_email);

	// 지역 검색 시 자동 완성 해주는 메소드
	List<Map<String, String>> regionSearchShow(String region_name);

	// 회원가입
	int memberRegister(MemberVO membervo);
	
	// 입력한 아이디와 비밀번호로 회원 정보 가져오는 메소드
	MemberVO getLoginMember(Map<String, String> paraMap);

	// 로그인 기록 추가
	void insert_tbl_login(Map<String, String> paraMap);
	
	// 회원 휴면을 자동으로 지정해주는 스케줄러
	void deactivateMember_idle();

	// === 이준영 끝 === //
	
	

	// === 김규빈 시작 === //

	// 자동완성을 위한 직종 목록 조회 및 검색
	List<Map<String, String>> getJobListForAutocomplete(Map<String, String> paraMap);
	// 자동완성을 위한 회사 목록 조회 및 검색
	List<Map<String, String>> getCompanyListForAutocomplete(Map<String, String> paraMap);
	// 자동완성을 위한 전공 목록 조회 및 검색
	List<Map<String, String>> getMajorListForAutocomplete(Map<String, String> paraMap);
	// 자동완성을 위한 학교 목록 조회 및 검색
	List<Map<String, String>> getSchoolListForAutocomplete(Map<String, String> paraMap);
	// 자동완성을 위한 보유기술 목록 조회 및 검색
	List<Map<String, String>> getSkillListForAutocomplete(Map<String, String> paraMap);

	/**
	 * 회원 경력 1개 조회
	 * @param paraMap member_career_no: 회원 경력 일련번호, login_member_id: 로그인한 회원 아이디
	 * @return
	 */
	MemberCareerVO getMemberCareer(Map<String, String> paraMap);
	
	/**
	 * 한 회원의 경력 모두 조회
	 * @param login_member_id: 로그인한 회원 아이디, member_id: 조회대상 회원 아이디
	 * @return
	 */
	List<MemberCareerVO> getMemberCareerListByMemberId(Map<String, String> paraMap);
	
	// 회원 경력 등록, 수정, 삭제
	int insertMemberCareer(MemberCareerVO memberCareerVO);
	int updateMemberCareer(MemberCareerVO memberCareerVO);
	int deleteMemberCareer(Map<String, String> paraMap);


	/**
	 * 회원 학력 1개 조회
	 * @param paraMap member_education_no: 회원 학력 일련번호, login_member_id: 로그인한 회원 아이디
	 * @return
	 */
	MemberEducationVO getMemberEducation(Map<String, String> paraMap);
	
	/**
	 * 한 회원의 학력 모두 조회
	 * @param login_member_id: 로그인한 회원 아이디, member_id: 조회대상 회원 아이디
	 * @return
	 */
	List<MemberEducationVO> getMemberEducationListByMemberId(Map<String, String> paraMap);
	
	// 회원 학력 등록, 수정, 삭제
	int insertMemberEducation(MemberEducationVO memberEducationVO);
	int updateMemberEducation(MemberEducationVO memberEducationVO);
	int deleteMemberEducation(Map<String, String> paraMap);


	/**
	 * 회원 보유기술 1개 조회
	 * @param paraMap member_skill_no: 회원 보유기술 일련번호, login_member_id: 로그인한 회원 아이디
	 * @return
	 */
	MemberSkillVO getMemberSkill(Map<String, String> paraMap);
	
	/**
	 * 한 회원의 보유기술 모두 조회
	 * @param login_member_id: 로그인한 회원 아이디, member_id: 조회대상 회원 아이디
	 * @return
	 */
	List<MemberSkillVO> getMemberSkillListByMemberId(Map<String, String> paraMap);
	
	// 회원 보유기술 등록, 삭제
	int insertMemberSkill(MemberSkillVO memberSkillVO) throws DataAccessException;
	int deleteMemberSkill(Map<String, String> paraMap);

	


	// === 김규빈 끝 === //
	
}//end of interface...
