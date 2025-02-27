package com.spring.app.member.domain;

public class MemberEducationVO {
	private String member_education_no; 		/* 회원 학력 일련번호 */
	private String fk_member_id; 				/* 회원 아이디 */
	private String fk_school_no; 				/* 학교 일련번호 */
	private String fk_major_no; 				/* 전공 일련번호 */
	private String member_education_degree; 	/* 학위 */
	private String member_education_startdate; 	/* 입학일 */
	private String member_education_endate; 	/* 졸업일 */
	private String member_education_grade; 		/* 학점 */
	private String member_education_explain; 	/* 설명 */

	private String school_name; 				/* 학교명 */
	private String major_name; 					/* 전공명 */
	
	public String getMember_education_no() {
		return member_education_no;
	}

	public void setMember_education_no(String member_education_no) {
		this.member_education_no = member_education_no;
	}

	public String getFk_member_id() {
		return fk_member_id;
	}

	public void setFk_member_id(String fk_member_id) {
		this.fk_member_id = fk_member_id;
	}

	public String getFk_school_no() {
		return fk_school_no;
	}

	public void setFk_school_no(String fk_school_no) {
		this.fk_school_no = fk_school_no;
	}

	public String getFk_major_no() {
		return fk_major_no;
	}

	public void setFk_major_no(String fk_major_no) {
		this.fk_major_no = fk_major_no;
	}

	public String getMember_education_degree() {
		return member_education_degree;
	}

	public void setMember_education_degree(String member_education_degree) {
		this.member_education_degree = member_education_degree;
	}

	public String getMember_education_startdate() {
		return member_education_startdate;
	}

	public void setMember_education_startdate(String member_education_startdate) {
		this.member_education_startdate = member_education_startdate;
	}

	public String getMember_education_endate() {
		return member_education_endate;
	}

	public void setMember_education_endate(String member_education_endate) {
		this.member_education_endate = member_education_endate;
	}

	public String getMember_education_grade() {
		return member_education_grade;
	}

	public void setMember_education_grade(String member_education_grade) {
		this.member_education_grade = member_education_grade;
	}

	public String getMember_education_explain() {
		return member_education_explain;
	}

	public void setMember_education_explain(String member_education_explain) {
		this.member_education_explain = member_education_explain;
	}

	public String getSchool_name() {
		return school_name;
	}

	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}

	public String getMajor_name() {
		return major_name;
	}

	public void setMajor_name(String major_name) {
		this.major_name = major_name;
	}
}
