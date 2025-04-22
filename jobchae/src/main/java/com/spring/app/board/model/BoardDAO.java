package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.comment.domain.CommentVO;
import com.spring.app.file.domain.FileVO;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.reaction.domain.ReactionVO;

@Mapper
public interface BoardDAO {

	// 파일첨부가 없는 글쓰기
	int add(Map<String, String> paraMap);
	
	// 파일첨부가 있는 글쓰기
	int addWithFile(Map<String, String> paraMap2);
	
	// 로그인된 사용자의 정보 얻어오기
	MemberVO getUserInfo(String login_userid);

	// 피드 조회하기
	List<BoardVO> getAllBoards(Map<String, String> paraMap);

	// 글 삭제
	int deleteBoard(Map<String, String> paraMap);
	
	// 글 삭제시 파일도 같이 삭제
	int deleteFile(Map<String, String> paraMap);

	// 글 수정
	//int editBoard(Map<String, String> paraMap);

	// 게시물 반응
	int reactionBoard(Map<String, String> paraMap);

	// 글 허용범위
	int updateBoardVisibility(Map<String, String> paraMap);

	// 반응 조회하기
	List<ReactionVO> getAllReaction(String login_userid);

	// 게시물 반응 삭제
	int deleteReactionBoard(Map<String, String> paraMap);

	// 게시물 반응 조회
	ReactionVO selectReaction(Map<String, String> paraMap);

	// 이미 반응 누른 경우, 유니크키 때문에 update 처리 
	int updateReactionBoard(Map<String, String> paraMap);
	
	// 각 피드별 파일 존재여부 검사
	List<FileVO> getFiles(String board_no);

	// 피드별 반응 개수 조회하기
	List<Map<String, String>> getReactionCount();

	// 팔로워 수 구하기
	int getFollowerCount(String following_id);

	// 게시물 반응 개수 조회하기
	Map<String, String> getReactionCounts(String reaction_target_no);

	// 게시물 반응별 유저 조회하기
	List<MemberVO> getReactionMembers(Map<String, String> paraMap);
	
	// 게시글 북마크 추가하기
	int addBookmarkBoard(Map<String, String> paraMap);

	// 게시글 북마크 조회하기
	int selectBookmarkBoard(Map<String, String> paraMap);

	// 게시글 북마크 삭제하기
	int deleteBookmarkBoard(Map<String, String> paraMap);

	// 댓글 등록하기
	int addComment(Map<String, String> paraMap);

	// 댓글 조회하기
	List<CommentVO> getAllComments(String board_no);

	// 댓글 수 구하기
	int getCommentCount(String board_no);

	// 댓글 삭제하기
	int deleteComment(Map<String, String> paraMap);

	// 댓글 수정하기
	int editComment(Map<String, String> paraMap);

	// 관심없음 등록하기
	int ignoredBoard(Map<String, String> paraMap);

	// 대댓글 등록하기
	int addCommentReply(Map<String, String> paraMap);

	// 파일 조회하기
	List<FileVO> selectFileList(Map<String, String> paraMap);
	List<FileVO> selectFileList2(String board_no);

	// 게시글 수정
	int editBoard(Map<String, String> paraMap);

	// 게시글 수정 (첨부파일 삭제)
	int deleteFiles(List<String> deleteFileList);

	// 파일 첨수 (수정)
	int editBoardWithFiles(Map<String, String> paraMap);

	// 반응 많은 순 상위 1~3개 추출하기
	Map<String, String> getTopReactionsForBoard(String board_no);

	// 답글 조회하기
	List<CommentVO> getRelplyComments(String comment_no);

	// 댓글에 대한 답글 수 구하기
	int getReplyCount(String comment_no);

	// 부모 댓글 삭제시 자식 댓글도 삭제
	int deleteReplyComment(Map<String, String> paraMap);
	
	// 게시물번호로 게시물 조회
	BoardVO findOneBoardByBoardNo(String board_no);

	// 피드 하나만 띄우기
	BoardVO boardOneSelect(String board_no);

	// 최신 반응 개수 가져오기
	int getReactionCount2(String reaction_target_no);


}
