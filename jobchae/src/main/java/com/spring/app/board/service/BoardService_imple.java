package com.spring.app.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.model.BoardDAO;
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

	

	


	



	
}
