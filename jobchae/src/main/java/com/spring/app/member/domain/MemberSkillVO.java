package com.spring.app.member.domain;

public class MemberSkillVO {
	private String member_skill_no; /* 회원 보유기술 일련번호 */
	private String fk_member_id; 	/* 회원 아이디 */
	private String fk_skill_no; 	/* 보유기술 일련번호 */

	private String skill_name; 		/* 보유기술명 */

	public String getMember_skill_no() {
		return member_skill_no;
	}

	public void setMember_skill_no(String member_skill_no) {
		this.member_skill_no = member_skill_no;
	}

	public String getFk_member_id() {
		return fk_member_id;
	}

	public void setFk_member_id(String fk_member_id) {
		this.fk_member_id = fk_member_id;
	}

	public String getFk_skill_no() {
		return fk_skill_no;
	}

	public void setFk_skill_no(String fk_skill_no) {
		this.fk_skill_no = fk_skill_no;
	}

	public String getSkill_name() {
		return skill_name;
	}

	public void setSkill_name(String skill_name) {
		this.skill_name = skill_name;
	}
}
