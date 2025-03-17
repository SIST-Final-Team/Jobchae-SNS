package com.spring.app.comment.domain;

import java.util.List;

public class CommentVO {

	private String comment_no;
	private String fk_board_no;
	private String fk_member_id;
	private String comment_content;
	private String comment_parent_no;
	private String comment_group_no;
	private String comment_depth;
	private String comment_register_date;

	
	// select용
	private String member_name;
	private String member_profile;
	public String getMember_profile() {
		return member_profile;
	}

	public void setMember_profile(String member_profile) {
		this.member_profile = member_profile;
	}

	private List<CommentVO> replyCommentsList;
	private String replyCount;
	
	
	public String getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(String replyCount) {
		this.replyCount = replyCount;
	}

	public String getMember_name() {
		return member_name;
	}
	
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	
	

	
	
	
	
	
	
	public List<CommentVO> getReplyCommentsList() {
		return replyCommentsList;
	}

	public void setReplyCommentsList(List<CommentVO> replyCommentsList) {
		this.replyCommentsList = replyCommentsList;
	}

	public String getComment_no() {
		return comment_no;
	}

	public void setComment_no(String comment_no) {
		this.comment_no = comment_no;
	}

	public String getFk_board_no() {
		return fk_board_no;
	}

	public void setFk_board_no(String fk_board_no) {
		this.fk_board_no = fk_board_no;
	}

	public String getFk_member_id() {
		return fk_member_id;
	}

	public void setFk_member_id(String fk_member_id) {
		this.fk_member_id = fk_member_id;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public String getComment_parent_no() {
		return comment_parent_no;
	}

	public void setComment_parent_no(String comment_parent_no) {
		this.comment_parent_no = comment_parent_no;
	}

	public String getComment_group_no() {
		return comment_group_no;
	}

	public void setComment_group_no(String comment_group_no) {
		this.comment_group_no = comment_group_no;
	}

	public String getComment_depth() {
		return comment_depth;
	}

	public void setComment_depth(String comment_depth) {
		this.comment_depth = comment_depth;
	}

	public String getComment_register_date() {
		return comment_register_date;
	}

	public void setComment_register_date(String comment_register_date) {
		this.comment_register_date = comment_register_date;
	}

}
