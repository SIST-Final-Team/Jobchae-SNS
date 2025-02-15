package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.member.domain.MemberVO;

public interface BoardDAO {

	// 파일첨부가 없는 글쓰기
	int add(Map<String, String> paraMap);
	
	// 로그인된 사용자의 정보 얻어오기
	MemberVO getUserInfo(String login_userid);

	// 피드 조회하기
	List<BoardVO> getAllBoards(String login_userid);

	// 글 삭제
	int deleteBoard(Map<String, String> paraMap);

	// 글 수정
	int editBoard(Map<String, String> paraMap);

	// 게시물 반응
	int reactionBoard(Map<String, String> paraMap);



}
