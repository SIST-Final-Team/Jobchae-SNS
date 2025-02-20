package com.spring.app.reaction.domain;

public class ReactionVO {

	private String reaction_no; 			/* 게시물반응 일련번호 */
	private String fk_member_id; 			/* 회원 아이디 */
	private String reaction_target_no; 		/* 타겟 일련번호 */
	private String reaction_target_type; 	/* 타겟 유형 */
	private String reaction_status; 		/* 반응 */
	private String reaction_register_date;	/* 등록일자 */
	
	public String getReaction_no() {
		return reaction_no;
	}
	public void setReaction_no(String reaction_no) {
		this.reaction_no = reaction_no;
	}
	public String getFk_member_id() {
		return fk_member_id;
	}
	public void setFk_member_id(String fk_member_id) {
		this.fk_member_id = fk_member_id;
	}
	public String getReaction_target_no() {
		return reaction_target_no;
	}
	public void setReaction_target_no(String reaction_target_no) {
		this.reaction_target_no = reaction_target_no;
	}
	public String getReaction_target_type() {
		return reaction_target_type;
	}
	public void setReaction_target_type(String reaction_target_type) {
		this.reaction_target_type = reaction_target_type;
	}
	public String getReaction_status() {
		return reaction_status;
	}
	public void setReaction_status(String reaction_status) {
		this.reaction_status = reaction_status;
	}
	public String getReaction_register_date() {
		return reaction_register_date;
	}
	public void setReaction_register_date(String reaction_register_date) {
		this.reaction_register_date = reaction_register_date;
	} 	
	
}
