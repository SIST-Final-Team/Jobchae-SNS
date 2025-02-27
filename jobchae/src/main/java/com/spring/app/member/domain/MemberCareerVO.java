package com.spring.app.member.domain;

public class MemberCareerVO {
	private String member_career_no; 			/* 회원 경력 일련번호 */
	private String fk_member_id; 				/* 회원 아이디 */
	private String fk_region_no; 				/* 지역 일련번호 */
	private String fk_job_no; 					/* 직종 일련번호 */
	private String member_career_is_current; 	/* 현재 재직여부 */
	private String member_career_company; 		/* 회사/단체 */
	private String member_career_type; 			/* 고용형태 */
	private String member_career_startdate; 	/* 시작일 */
	private String member_career_enddate; 		/* 종료일 */
	private String member_career_explain; 		/* 설명 */
	
	private String region_name;					/* 지역명 */
	private String job_name;					/* 직종명 */

	public String getMember_career_no() {
		return member_career_no;
	}

	public void setMember_career_no(String member_career_no) {
		this.member_career_no = member_career_no;
	}

	public String getFk_member_id() {
		return fk_member_id;
	}

	public void setFk_member_id(String fk_member_id) {
		this.fk_member_id = fk_member_id;
	}

	public String getFk_region_no() {
		return fk_region_no;
	}

	public void setFk_region_no(String fk_region_no) {
		this.fk_region_no = fk_region_no;
	}

	public String getFk_job_no() {
		return fk_job_no;
	}

	public void setFk_job_no(String fk_job_no) {
		this.fk_job_no = fk_job_no;
	}

	public String getMember_career_is_current() {
		return member_career_is_current;
	}

	public void setMember_career_is_current(String member_career_is_current) {
		this.member_career_is_current = member_career_is_current;
	}

	public String getMember_career_company() {
		return member_career_company;
	}

	public void setMember_career_company(String member_career_company) {
		this.member_career_company = member_career_company;
	}

	public String getMember_career_type() {
		return member_career_type;
	}

	public void setMember_career_type(String member_career_type) {
		this.member_career_type = member_career_type;
	}

	public String getMember_career_startdate() {
		return member_career_startdate;
	}

	public void setMember_career_startdate(String member_career_startdate) {
		this.member_career_startdate = member_career_startdate;
	}

	public String getMember_career_enddate() {
		return member_career_enddate;
	}

	public void setMember_career_enddate(String member_career_enddate) {
		this.member_career_enddate = member_career_enddate;
	}

	public String getMember_career_explain() {
		return member_career_explain;
	}

	public void setMember_career_explain(String member_career_explain) {
		this.member_career_explain = member_career_explain;
	}

	public String getRegion_name() {
		return region_name;
	}

	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}

	public String getJob_name() {
		return job_name;
	}

	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
}
