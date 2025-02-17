package com.spring.app.board.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.model.BoardDAO;
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

	// 로그인된 사용자의 정보 얻어오기
	@Override
	public MemberVO getUserInfo(String login_userid) {
		MemberVO membervo = dao.getUserInfo(login_userid);
		return membervo;
	}
	
	// 피드 조회하기
	@Override
	public List<BoardVO> getAllBoards(String login_userid) {
		List<BoardVO> boardList = dao.getAllBoards(login_userid);
		return boardList;
	}
	
	// 글 삭제
	@Override
	public int deleteBoard(Map<String, String> paraMap) {
		int n = dao.deleteBoard(paraMap);
		return n;
	}

	// 글 수정
	@Override
	public int editBoard(Map<String, String> paraMap) {
		int n = dao.editBoard(paraMap);
		return n;
	}

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


	



	
}
