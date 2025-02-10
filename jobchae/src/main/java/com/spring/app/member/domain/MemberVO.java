package com.spring.app.member.domain;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MemberVO {

//	  member_id VARCHAR2(20) NOT NULL, /* 회원 아이디 */
//    fk_region_no NUMBER, /* 지역 일련번호 */
//    fk_member_career_no NUMBER, /* 현재 경력 */
//    fk_member_education_no NUMBER, /* 현재 학력 */
//    member_passwd VARCHAR2(200) NOT NULL, /* 비밀번호 */
//    member_name NVARCHAR2(100) NOT NULL, /* 성명 */
//    member_birth DATE NOT NULL, /* 생년월일 */
//    member_email VARCHAR2(200) NOT NULL, /* 이메일 */
//    member_tel VARCHAR2(200) NOT NULL, /* 전화번호 */
//    member_register_date DATE DEFAULT sysdate NOT NULL, /* 가입일자 ,기본은 SYSDATE*/
//    member_passwdupdate_date DATE, /* 비밀번호 변경일자,NULL 이면 가입일자를 참조 */
//    member_status NUMBER(1) DEFAULT 1 NOT NULL, /* 가입상태 ,default 1,  정상: 1, 탈퇴: 2, 정지:3*/
//    member_is_company NUMBER(1) DEFAULT 0 NOT NULL, /* 기업 여부 ,기본값 0 0:개인 1: 기업*/
//    member_idle NUMBER(1) DEFAULT 0 NOT NULL, /* 휴면상태 ,기본값 0, 0: 정상 1: 휴면*/
//    member_profile NVARCHAR2(200), /* 프로필 사진 */
//    member_background_img NVARCHAR2(200), /* 프로필 배경 사진 */
//    member_hire_status NUMBER(1), /* 고용상태 , 이직/구직중 : 1, 채용중 : 2, 프리랜서 활동중 : 3*/
	
	String member_id; 					/* 회원 아이디 */
	String fk_region_no; 				/* 지역 일련번호 */
	String fk_member_career_no ; 		/* 현재 경력 */
	String fk_member_education_no; 		/* 현재 학력 */
	String member_passwd; 				/* 비밀번호 */
	String member_name; 				/* 성명 */
	String member_birth; 				/* 생년월일 */
	String member_email; 				/* 이메일 */
	String member_tel; 					/* 전화번호 */
	String member_register_date; 		/* 가입일자 ,기본은 SYSDATE */
	String member_passwdupdate_date; 	/* 비밀번호 변경일자,NULL 이면 가입일자를 참조 */
	String member_status; 				/* 가입상태 ,default 1,  정상: 1, 탈퇴: 2, 정지:3 */
	String member_is_company; 			/* 기업 여부 ,기본값 0 0:개인 1: 기업 */
	String member_idle; 				/* 휴면상태 ,기본값 0, 0: 정상 1: 휴면 (마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정) */
	String member_profile; 				/* 프로필 사진 */
	String member_background_img; 		/* 프로필 배경 사진 */
	String member_hire_status; 			/* 고용상태 , 이직/구직중 : 1, 채용중 : 2, 프리랜서 활동중 : 3 */
  						
	
	private int pwdchangegap; 
		// select 용. 지금으로 부터 마지막으로 암호를 변경한지가 몇개월인지 알려주는 개월수(3개월 동안 암호를 변경 안 했을시 암호를 변경하라는 메시지를 보여주기 위함)
	private int lastlogingap; 
		// select 용. 지금으로 부터 마지막으로 로그인한지가 몇개월인지 알려주는 개월수(12개월 동안 로그인을 안 했을 경우 해당 로그인 계정을 비활성화 시키려고 함)

	//////////////////////////////////////////////////////////////



	public int getPwdchangegap() {
		return pwdchangegap;
	}

	public void setPwdchangegap(int pwdchangegap) {
		this.pwdchangegap = pwdchangegap;
	}

	public int getLastlogingap() {
		return lastlogingap;
	}

	public void setLastlogingap(int lastlogingap) {
		this.lastlogingap = lastlogingap;
	}

	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false

	///////////////////////////////////////////////////////////////

	// === 먼저 답변글쓰기는 일반회원은 불가하고 직원(관리파트)들만 답변글쓰기가 가능하도록 하기 위해서
	// 먼저 오라클에서 tbl_member 테이블에 gradelevel 이라는 컬럼을 추가해야 한다.
	private int gradelevel; // 등급레벨

	//////////////////////////////////////////////////////

	
	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

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

	public String getFk_member_career_no() {
		return fk_member_career_no;
	}

	public void setFk_member_career_no(String fk_member_career_no) {
		this.fk_member_career_no = fk_member_career_no;
	}

	public String getFk_member_education_no() {
		return fk_member_education_no;
	}

	public void setFk_member_education_no(String fk_member_education_no) {
		this.fk_member_education_no = fk_member_education_no;
	}

	public String getMember_passwd() {
		return member_passwd;
	}

	public void setMember_passwd(String member_passwd) {
		this.member_passwd = member_passwd;
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

	public String getMember_passwdupdate_date() {
		return member_passwdupdate_date;
	}

	public void setMember_passwdupdate_date(String member_passwdupdate_date) {
		this.member_passwdupdate_date = member_passwdupdate_date;
	}

	public String getMember_status() {
		return member_status;
	}

	public void setMember_status(String member_status) {
		this.member_status = member_status;
	}

	public String getMember_is_company() {
		return member_is_company;
	}

	public void setMember_is_company(String member_is_company) {
		this.member_is_company = member_is_company;
	}

	public String getMember_idle() {
		return member_idle;
	}

	public void setMember_idle(String member_idle) {
		this.member_idle = member_idle;
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

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}

	public int getGradelevel() {
		return gradelevel;
	}

	public void setGradelevel(int gradelevel) {
		this.gradelevel = gradelevel;
	}

	////////////////////////////////////////////////

	public int getAge() { // 만나이 구하기

		int age = 0;

		// 회원의 올해생일이 현재날짜 보다 이전이라면
		// 만나이 = 현재년도 - 회원의 태어난년도

		// 회원의 올해생일이 현재날짜 보다 이후이라면
		// 만나이 = 현재년도 - 회원의 태어난년도 - 1

		Date now = new Date(); // 현재시각
		SimpleDateFormat sdfmt = new SimpleDateFormat("yyyyMMdd");
		String str_now = sdfmt.format(now); // "20231018"

		// 회원의 올해생일(문자열 타입)
		String str_now_birthday = str_now.substring(0, 4) + member_birth.substring(5, 7) + member_birth.substring(8);
		// System.out.println("회원의 올해생일(문자열 타입) : " + str_now_birthday);
		// 회원의 올해생일(문자열 타입) : 20231020

		// 회원의 태어난년도
		int birth_year = Integer.parseInt(member_birth.substring(0, 4));

		// 현재년도
		int now_year = Integer.parseInt(str_now.substring(0, 4));

		try {
			Date now_birthday = sdfmt.parse(str_now_birthday); // 회원의 올해생일(연월일) 날짜 타입
			now = sdfmt.parse(str_now); // 오늘날짜(연월일) 날짜타입

			if (now_birthday.before(now)) {
				// 회원의 올해생일이 현재날짜 보다 이전이라면
				// System.out.println("~~~~ 생일 지남");
				age = now_year - birth_year;
				// 나이 = 현재년도 - 회원의 태어난년도
			} else {
				// 회원의 올해생일이 현재날짜 보다 이후이라면
				// System.out.println("~~~~ 생일 아직 지나지 않음");
				age = now_year - birth_year - 1;
				// 나이 = 현재년도 - 회원의 태어난년도 - 1
			}

		} catch (ParseException e) {
			e.printStackTrace();
		}

		return age;

	}//end of public int getAge() {}...

}// end of class...
