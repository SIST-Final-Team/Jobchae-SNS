package com.spring.app.board.domain;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.spring.app.comment.domain.CommentVO;
import com.spring.app.file.domain.FileVO;

public class BoardVO {

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

	
	
	
	private MultipartFile attach;			/* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드 (jsp에서 name='attach') */
	
	///////////////////////////////////////////////////////////
	// select용
	private String member_id;
	private String member_name;	
	private String member_profile;
	public String getMember_profile() {
		return member_profile;
	}

	public void setMember_profile(String member_profile) {
		this.member_profile = member_profile;
	}

	private List<FileVO> fileList;
	private String countFollow;
	private String countComment;
	
	private Map<String, String> topReactionList;
	private List<CommentVO> commentvoList;

	public List<CommentVO> getCommentvoList() {
		return commentvoList;
	}

	public void setCommentvoList(List<CommentVO> commentvoList) {
		this.commentvoList = commentvoList;
	}

	public Map<String, String> getTopReactionList() {
		return topReactionList;
	}

	public void setTopReactionList(Map<String, String> topReactionList) {
		this.topReactionList = topReactionList;
	}

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
	public List<FileVO> getFileList() {
		return fileList;
	}

	public void setFileList(List<FileVO> fileList) {
		this.fileList = fileList;
	}
	
	public String getCountFollow() {
		return countFollow;
	}

	public void setCountFollow(String countFollow) {
		this.countFollow = countFollow;
	}
	
	public String getCountComment() {
		return countComment;
	}

	public void setCountComment(String countComment) {
		this.countComment = countComment;
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
	
	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

}
