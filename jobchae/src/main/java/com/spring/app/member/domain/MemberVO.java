package com.spring.app.member.domain;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.spring.app.file.domain.FileVO;

public class MemberVO {

//	  member_id VARCHAR2(20) NOT NULL, 						/* 회원 아이디 */
//	  fk_region_no NUMBER, 									/* 지역 일련번호 */
//	  fk_member_career_no NUMBER, 							/* 현재 경력 */
//	  fk_member_education_no NUMBER, 						/* 현재 학력 */
//	  member_passwd VARCHAR2(200) NOT NULL, 				/* 비밀번호 */
//	  member_name NVARCHAR2(100) NOT NULL, 					/* 성명 */
//	  member_birth DATE NOT NULL, 							/* 생년월일 */
//	  member_email VARCHAR2(200) NOT NULL, 					/* 이메일 */
//	  member_tel VARCHAR2(200) NOT NULL, 					/* 전화번호 */
//	  member_register_date DATE DEFAULT sysdate NOT NULL, 	/* 가입일자 ,기본은 SYSDATE*/
//	  member_passwdupdate_date DATE, 						/* 비밀번호 변경일자,NULL 이면 가입일자를 참조 */
//	  member_status NUMBER(1) DEFAULT 1 NOT NULL, 			/* 가입상태 ,default 1,  정상: 1, 탈퇴: 2, 정지:3*/
//	  member_is_company NUMBER(1) DEFAULT 0 NOT NULL, 		/* 기업 여부 ,기본값 0 0:개인 1: 기업*/
//	  member_idle NUMBER(1) DEFAULT 0 NOT NULL, 			/* 휴면상태 ,기본값 0, 0: 정상 1: 휴면*/
//	  member_profile NVARCHAR2(200), 						/* 프로필 사진 */
//	  member_background_img NVARCHAR2(200), 				/* 프로필 배경 사진 */
//	  member_hire_status NUMBER(1), 						/* 고용상태 , 이직/구직중 : 1, 채용중 : 2, 프리랜서 활동중 : 3*/
	
	private String member_id; 					/* 회원 아이디 */
	private String fk_region_no; 				/* 지역 일련번호 */
	private String member_passwd; 				/* 비밀번호 */
	private String member_name; 				/* 성명 */
	private String member_birth; 				/* 생년월일 */
	private String member_email; 				/* 이메일 */
	private String member_tel; 					/* 전화번호 */
	private String member_register_date; 		/* 가입일자 ,기본은 SYSDATE */
	private String member_passwdupdate_date; 	/* 비밀번호 변경일자,NULL 이면 가입일자를 참조 */
	private String member_status; 				/* 가입상태 ,default 1,  정상: 1, 탈퇴: 2, 정지:3 */
	private String member_is_company; 			/* 기업 여부 ,기본값 0 0:개인 1: 기업 */
	private String member_idle; 				/* 휴면상태 ,기본값 0, 0: 정상, 1: 휴면 (마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정) */
	private String member_profile; 				/* 프로필 사진 */
	private String member_background_img; 		/* 프로필 배경 사진 */
	private String member_hire_status; 			/* 고용상태 , 이직/구직중 : 1, 채용중 : 2, 프리랜서 활동중 : 3 */
  						
	
	private int passwdchangegap; 
		// select 용. 지금으로 부터 마지막으로 암호를 변경한지가 몇개월인지 알려주는 개월수(3개월 동안 암호를 변경 안 했을시 암호를 변경하라는 메시지를 보여주기 위함)
	private int lastlogingap; 
		// select 용. 지금으로 부터 마지막으로 로그인한지가 몇개월인지 알려주는 개월수(12개월 동안 로그인을 안 했을 경우 해당 로그인 계정을 비활성화 시키려고 함)

	private boolean requirePasswdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
	
	// 파일을 첨부하도록 VO 수정하기
	private MultipartFile attach_member_profile;
	private MultipartFile attach_member_background_img;
//		form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
//		진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
//		조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.  
//		/myspring/src/main/webapp/WEB-INF/views/mycontent1/board/add.jsp 파일에서 
//		input type="file"인 name 의 이름(attach)과 동일해야만 파일첨부가 가능해진다.
	
	
	//////////////////////////////////////////////
	/// join 해서 가져온 변수
	private String member_career_company; // 회사명
	private String school_name;			  // 학교명
	private String region_name;           // 지역명
	
	
	
	
	//////////////////////////////////////////////////////////////

	
	public String getRegion_name() {
		return region_name;
	}

	public void setRegion_name(String region_name) {
		this.region_name = region_name;
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





	public MultipartFile getAttach_member_profile() {
		return attach_member_profile;
	}

	public void setAttach_member_profile(MultipartFile attach_member_profile) {
		this.attach_member_profile = attach_member_profile;
	}

	public MultipartFile getAttach_member_background_img() {
		return attach_member_background_img;
	}

	public void setAttach_member_background_img(MultipartFile attach_member_background_img) {
		this.attach_member_background_img = attach_member_background_img;
	}

	public int getPasswdchangegap() {
		return passwdchangegap;
	}

	public void setPasswdchangegap(int passwdchangegap) {
		this.passwdchangegap = passwdchangegap;
	}

	public int getLastlogingap() {
		return lastlogingap;
	}

	public void setLastlogingap(int lastlogingap) {
		this.lastlogingap = lastlogingap;
	}

	

	///////////////////////////////////////////////////////////////

	

	//////////////////////////////////////////////////////

	

	public String getMember_id() {
		return member_id;
	}

	public boolean isRequirePasswdChange() {
		return requirePasswdChange;
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

	public void setRequirePasswdChange(boolean requirePasswdChange) {
		this.requirePasswdChange = requirePasswdChange;
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
