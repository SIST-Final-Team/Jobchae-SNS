package com.spring.app.member.domain;


public class ReportVO {

	private int report_no; // 신고 일련번호
	private String fk_member_id; // 신고자 아이디
	private String fk_reported_member_id; // 신고당한 회원 아이디
	private String report_register_date; // 신고 등록일
	private int report_type; // 신고 유형 
	private String additional_explanation; // 추가 설명
 
	
	
	
	
	
	
	public int getReport_no() {
		return report_no;
	}

	public void setReport_no(int report_no) {
		this.report_no = report_no;
	}
	
	public String getFk_member_id() {
		return fk_member_id;
	}

	public void setFk_member_id(String fk_member_id) {
		this.fk_member_id = fk_member_id;
	}

	public String getFk_reported_member_id() {
		return fk_reported_member_id;
	}

	public void setFk_reported_member_id(String fk_reported_member_id) {
		this.fk_reported_member_id = fk_reported_member_id;
	}

	public String getReport_register_date() {
		return report_register_date;
	}

	public void setReport_register_date(String  report_register_date) {
		this.report_register_date = report_register_date;
	}

	public int getReport_type() {
		return report_type;
	}

	public void setReport_type(int report_type) {
		this.report_type = report_type;
	}

	public String getAdditional_explanation() {
		return additional_explanation;
	}

	public void setAdditional_explanation(String additional_explanation) {
		this.additional_explanation = additional_explanation;
	}







}
