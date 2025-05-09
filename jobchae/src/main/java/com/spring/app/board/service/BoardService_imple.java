package com.spring.app.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.model.BoardDAO;
import com.spring.app.comment.domain.CommentVO;
import com.spring.app.file.domain.FileVO;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.reaction.domain.ReactionVO;

@Service
public class BoardService_imple implements BoardService {

	@Autowired
	BoardDAO dao;

	// 파일첨부가 없는 글쓰기
	@Override
	public int add(Map<String, String> paraMap) {
		int n = dao.add(paraMap);
		return n;
	}
	
	// 파일첨부가 있는 글쓰기
	@Override
	public int addWithFile(Map<String, String> paraMap2) {
		int n = dao.addWithFile(paraMap2);
		return n;
	}
	
	// 로그인된 사용자의 정보 얻어오기
	@Override
	public MemberVO getUserInfo(String login_userid) {
		MemberVO membervo = dao.getUserInfo(login_userid);
		return membervo;
	}
	
	// 피드 조회하기
	@Override
	public List<BoardVO> getAllBoards(Map<String, String> paraMap) {
		List<BoardVO> boardList = dao.getAllBoards(paraMap);
		return boardList;
	}
	
	// 글 삭제
	@Override
	public int deleteBoard(Map<String, String> paraMap) {
		int n = dao.deleteBoard(paraMap);
		return n;
	}
	
	// 글 삭제시 파일도 같이 삭제
	@Override
	public int deleteFile(Map<String, String> paraMap) {
		int n = dao.deleteFile(paraMap);
		return n;
	}
	
	// 글 수정
	//@Override
	//public int editBoard(Map<String, String> paraMap) {
	//	int n = dao.editBoard(paraMap);
	//	return n;
	//}

	// 게시물 반응
	@Override
	public int reactionBoard(Map<String, String> paraMap) {
		int n = dao.reactionBoard(paraMap);
		return n;
	}

	// 글 허용범위
	@Override
	public int updateBoardVisibility(Map<String, String> paraMap) {
		int n = dao.updateBoardVisibility(paraMap);
		return n;
	}

	// 반응 조회하기
	@Override
	public List<ReactionVO> getAllReaction(String login_userid) {
		List<ReactionVO> reactionList = dao.getAllReaction(login_userid);
		return reactionList;
	}

	// 게시물 반응 삭제
	@Override
	public int deleteReactionBoard(Map<String, String> paraMap) {
		int n = dao.deleteReactionBoard(paraMap);
		return n;
	}

	// 게시물 반응 조회
	@Override
	public ReactionVO selectReaction(Map<String, String> paraMap) {
		ReactionVO reactionvo = dao.selectReaction(paraMap);
		return reactionvo;
	}

	// 이미 반응 누른 경우, 유니크키 때문에 update 처리 
	@Override
	public int updateReactionBoard(Map<String, String> paraMap) {
		int n = dao.updateReactionBoard(paraMap);
		return n;
	}

	// 각 피드별 파일 존재여부 검사
	@Override
	public List<FileVO> getFiles(String board_no) {
		List<FileVO> filevoList = dao.getFiles(board_no);
		return filevoList;
	}

	// 피드별 반응 개수 조회하기
	@Override
	public List<Map<String, String>> getReactionCount() {
		List<Map<String, String>> reactionCountList = dao.getReactionCount();
		return reactionCountList;
	}

	// 팔로워 수 구하기
	@Override
	public int getFollowerCount(String following_id) {
		int n = dao.getFollowerCount(following_id);
		return n;
	}

	// 게시물 반응 개수 조회하기
	@Override
	public Map<String, String> getReactionCounts(String reaction_target_no) {
		return dao.getReactionCounts(reaction_target_no);
	}

	// 게시물 반응별 유저 조회하기
	@Override
	public List<MemberVO> getReactionMembers(Map<String, String> paraMap) {
		List<MemberVO> reaction_membervoList = dao.getReactionMembers(paraMap);
		return reaction_membervoList;
	}

	// 게시글 북마크 추가하기
	@Override
	public int addBookmarkBoard(Map<String, String> paraMap) {
		int n = dao.addBookmarkBoard(paraMap);
		return n;
	}

	// 게시글 북마크 조회하기
	@Override
	public boolean selectBookmarkBoard(Map<String, String> paraMap) {
		int n = dao.selectBookmarkBoard(paraMap);
		return n > 0;
	}

	// 게시글 북마크 삭제하기
	@Override
	public int deleteBookmarkBoard(Map<String, String> paraMap) {
		int n = dao.deleteBookmarkBoard(paraMap);
		return n;
	}

	// 댓글 등록하기
	@Override
	public int addComment(Map<String, String> paraMap) {
		int n = dao.addComment(paraMap);
		return n;
	}

	// 댓글 조회하기
	@Override
	public List<CommentVO> getAllComments(String board_no) {
		List<CommentVO> commentvoList = dao.getAllComments(board_no);
		return commentvoList;
	}

	// 댓글 수 구하기
	@Override
	public int getCommentCount(String board_no) {
		int n = dao.getCommentCount(board_no);
		return n;
	}

	// 댓글 삭제하기
	@Override
	public int deleteComment(Map<String, String> paraMap) {
		int n = dao.deleteComment(paraMap);
		return n;
	}

	// 댓글 수정하기
	@Override
	public int editComment(Map<String, String> paraMap) {
		int n = dao.editComment(paraMap);
		return n;
	}

	// 관심없음 등록하기
	@Override
	public int ignoredBoard(Map<String, String> paraMap) {
		int n = dao.ignoredBoard(paraMap);
		return n;
	}

	// 대댓글 등록하기
	@Override
	public int addCommentReply(Map<String, String> paraMap) {
		int n = dao.addCommentReply(paraMap);
		return n;
	}

	// 파일 조회하기
	@Override
	public List<FileVO> selectFileList(Map<String, String> paraMap) {
		List<FileVO> filevoList = dao.selectFileList(paraMap);
		return filevoList;
	}

	// 게시글 수정
	@Override
	public int editBoard(Map<String, String> paraMap) {
		int n = dao.editBoard(paraMap);
		return n;
	}

	
	@Override
	public List<FileVO> selectFileList2(String board_no) {
		List<FileVO> filevoList = dao.selectFileList2(board_no);
		return filevoList;
	}

	// 게시글 수정 (첨부파일 삭제)
	@Override
	public int deleteFiles(List<String> deleteFileList) {
		int n = dao.deleteFiles(deleteFileList);
		return n;
	}

	// 파일 첨수 (수정)
	@Override
	public int editBoardWithFiles(Map<String, String> paraMap) {
		int n = dao.editBoardWithFiles(paraMap);
		return n;
	}

	// 반응 많은 순 상위 1~3개 추출하기
	@Override
	public Map<String, String> getTopReactionsForBoard(String board_no) {
		Map<String, String> topReactionsList = dao.getTopReactionsForBoard(board_no);
		return topReactionsList;
	}

	// 답글 조회하기
	@Override
	public List<CommentVO> getRelplyComments(String comment_no) {
		List<CommentVO> replyCommentsList = dao.getRelplyComments(comment_no);
		return replyCommentsList;
	}

	// 댓글에 대한 답글 수 구하기
	@Override
	public int getReplyCount(String comment_no) {
		int n = dao.getReplyCount(comment_no);
		return n;
	}

	// 부모 댓글 삭제시 자식 댓글도 삭제
	@Override
	public int deleteReplyComment(Map<String, String> paraMap) {
		int n = dao.deleteReplyComment(paraMap);
		return n;
	}

	// 피드 하나만 띄우기
	@Override
	public BoardVO boardOneSelect(String board_no) {
		BoardVO boardvo = dao.boardOneSelect(board_no);
		return boardvo;
	}

	// 최신 반응 개수 가져오기
	@Override
	public int getReactionCount2(String reaction_target_no) {
		int n = dao.getReactionCount2(reaction_target_no);
		return n;
	}
	

	

	


	



	
}
