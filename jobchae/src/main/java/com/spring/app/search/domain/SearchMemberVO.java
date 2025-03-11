package com.spring.app.search.domain;

import org.springframework.web.multipart.MultipartFile;

public class SearchMemberVO {
	
	private String member_id; 					/* 회원 아이디 */
	private String fk_region_no; 				/* 지역 일련번호 */
	private String member_name; 				/* 성명 */
	private String member_birth; 				/* 생년월일 */
	private String member_email; 				/* 이메일 */
	private String member_tel; 					/* 전화번호 */
	private String member_register_date; 		/* 가입일자 ,기본은 SYSDATE */
	private String member_is_company; 			/* 기업 여부 ,기본값 0 0:개인 1: 기업 */
	private String member_profile; 				/* 프로필 사진 */
	private String member_background_img; 		/* 프로필 배경 사진 */
	private String member_hire_status; 			/* 고용상태 , 이직/구직중 : 1, 채용중 : 2, 프리랜서 활동중 : 3 */
	
	//////////////////////////////////////////////
	/// join 해서 가져온 변수
	private String isFollow;              // 팔로우 여부
	private String skill_name;            // 보유기술명
	private String member_career_company; // 회사명
	private String school_name;			  // 학교명
	private String region_name;           // 지역명
	private String follower_count;        // 팔로워 수
	
	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getFk_region_no() {
		return fk_region_no;
	}

	public void setFk_region_no(String fk_region_no) {
		this.fk_region_no = fk_region_no;
	}
	
	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_birth() {
		return member_birth;
	}

	public void setMember_birth(String member_birth) {
		this.member_birth = member_birth;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	public String getMember_tel() {
		return member_tel;
	}

	public void setMember_tel(String member_tel) {
		this.member_tel = member_tel;
	}

	public String getMember_register_date() {
		return member_register_date;
	}

	public void setMember_register_date(String member_register_date) {
		this.member_register_date = member_register_date;
	}

	public String getMember_is_company() {
		return member_is_company;
	}

	public void setMember_is_company(String member_is_company) {
		this.member_is_company = member_is_company;
	}

	public String getMember_profile() {
		return member_profile;
	}

	public void setMember_profile(String member_profile) {
		this.member_profile = member_profile;
	}

	public String getMember_background_img() {
		return member_background_img;
	}

	public void setMember_background_img(String member_background_img) {
		this.member_background_img = member_background_img;
	}

	public String getMember_hire_status() {
		return member_hire_status;
	}

	public void setMember_hire_status(String member_hire_status) {
		this.member_hire_status = member_hire_status;
	}
	
	/////////////////////////////////////////////////

	public String getIsFollow() {
		return isFollow;
	}

	public void setIsFollow(String isFollow) {
		this.isFollow = isFollow;
	}

	public String getSkill_name() {
		return skill_name;
	}

	public void setSkill_name(String skill_name) {
		this.skill_name = skill_name;
	}

	public String getMember_career_company() {
		return member_career_company;
	}

	public void setMember_career_company(String member_career_company) {
		this.member_career_company = member_career_company;
	}

	public String getSchool_name() {
		return school_name;
	}

	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}

	public String getRegion_name() {
		return region_name;
	}

	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}

	public String getFollower_count() {
		return follower_count;
	}

	public void setFollower_count(String follower_count) {
		this.follower_count = follower_count;
	}

}// end of class...
