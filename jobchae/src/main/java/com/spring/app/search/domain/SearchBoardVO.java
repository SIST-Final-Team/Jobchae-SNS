package com.spring.app.search.domain;

import java.util.List;

import com.spring.app.file.domain.FileVO;

public class SearchBoardVO {

	private String board_no; 				/* 게시물 일련번호 */
	private String fk_member_id; 			/* 회원 아이디 */
	private String board_content; 			/* 내용 */
	private String board_visibility; 		/* 공개상태 */
	private String board_comment_allowed; 	/* 댓글허용 */
	private String board_register_date; 	/* 등록일자 */
	private String board_parent_no; 		/* 부모글번호 */
	private String board_group_no; 			/* 그룹일련번호 */
	private String board_depth; 			/* 깊이 */
	private String board_is_delete; 		/* 삭제여부 */
	
	///////////////////////////////////////////////////////////
	// select용
	private String member_id;      // 회원 아이디
	private String member_name;	   // 회원명
	private String member_profile; // 회원 프로필
	private List<FileVO> fileList; // 첨부 파일 목록
	
	///////////////////////////////////////////////////////////
	// 검색 전용
	private String reactionStatusList; // 반응 목록
	private String followerCount;  // 팔로워 수
	private String isFollow;       // 팔로우 여부
	private String commentCount;   // 댓글 수
	private String reactionCount;  // 반응 수
	private String embedCount;     // 퍼가기 수

    public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	
	public String getMember_profile() {
		return member_profile;
	}

	public void setMember_profile(String member_profile) {
		this.member_profile = member_profile;
	}

	public List<FileVO> getFileList() {
		return fileList;
	}

	public void setFileList(List<FileVO> fileList) {
		this.fileList = fileList;
	}
	///////////////////////////////////////////////////////////

	
	
	public String getBoard_no() {
		return board_no;
	}

	public void setBoard_no(String board_no) {
		this.board_no = board_no;
	}

	public String getFk_member_id() {
		return fk_member_id;
	}

	public void setFk_member_id(String fk_member_id) {
		this.fk_member_id = fk_member_id;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public String getBoard_visibility() {
		return board_visibility;
	}

	public void setBoard_visibility(String board_visibility) {
		this.board_visibility = board_visibility;
	}

	public String getBoard_comment_allowed() {
		return board_comment_allowed;
	}

	public void setBoard_comment_allowed(String board_comment_allowed) {
		this.board_comment_allowed = board_comment_allowed;
	}

	public String getBoard_register_date() {
		return board_register_date;
	}

	public void setBoard_register_date(String board_register_date) {
		this.board_register_date = board_register_date;
	}

	public String getBoard_parent_no() {
		return board_parent_no;
	}

	public void setBoard_parent_no(String board_parent_no) {
		this.board_parent_no = board_parent_no;
	}

	public String getBoard_group_no() {
		return board_group_no;
	}

	public void setBoard_group_no(String board_group_no) {
		this.board_group_no = board_group_no;
	}

	public String getBoard_depth() {
		return board_depth;
	}

	public void setBoard_depth(String board_depth) {
		this.board_depth = board_depth;
	}

	public String getBoard_is_delete() {
		return board_is_delete;
	}

	public void setBoard_is_delete(String board_is_delete) {
		this.board_is_delete = board_is_delete;
	}

	public String getIsFollow() {
		return isFollow;
	}

	public void setIsFollow(String isFollow) {
		this.isFollow = isFollow;
	}

	public String getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}

	public String getReactionCount() {
		return reactionCount;
	}

	public void setReactionCount(String reactionCount) {
		this.reactionCount = reactionCount;
	}

	public String getEmbedCount() {
		return embedCount;
	}

	public void setEmbedCount(String embedCount) {
		this.embedCount = embedCount;
	}

	public String getReactionStatusList() {
		return reactionStatusList;
	}

	public void setReactionStatusList(String reactionStatusList) {
		this.reactionStatusList = reactionStatusList;
	}

	public String getFollowerCount() {
		return followerCount;
	}

	public void setFollowerCount(String followerCount) {
		this.followerCount = followerCount;
	}

}
