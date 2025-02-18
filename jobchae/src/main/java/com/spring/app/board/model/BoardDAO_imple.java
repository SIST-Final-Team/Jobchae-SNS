package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.reaction.domain.ReactionVO;

@Repository
public class BoardDAO_imple implements BoardDAO {
	
	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;

	// 파일첨부가 없는 글쓰기
	@Override
	public int add(Map<String, String> paraMap) {
		int n = sqlsession.insert("board.add", paraMap);
		return n;
	}

	// 로그인된 사용자의 정보 얻어오기
	@Override
	public MemberVO getUserInfo(String login_userid) {
		MemberVO membervo = sqlsession.selectOne("board.getUserInfo", login_userid);
		return membervo;
	}
		
	// 피드 조회하기
	@Override
	public List<BoardVO> getAllBoards(String login_userid) {
		List<BoardVO> boardList = sqlsession.selectList("board.getAllBoards", login_userid);
		return boardList;
	}

	// 글 삭제
	@Override
	public int deleteBoard(Map<String, String> paraMap) {
		int n = sqlsession.delete("board.deleteBoard", paraMap);
		return n;
	}

	// 글 수정
	@Override
	public int editBoard(Map<String, String> paraMap) {
		int n = sqlsession.update("board.editBoard", paraMap);
		return n;
	}

	// 게시물 반응
	@Override
	public int reactionBoard(Map<String, String> paraMap) {
		int n = sqlsession.insert("board.reactionBoard", paraMap);
		return n;
	}

	// 글 허용범위
	@Override
	public int updateBoardVisibility(Map<String, String> paraMap) {
		int n = sqlsession.update("board.updateBoardVisibility", paraMap);
		return n;
	}

	// 반응 조회하기
	@Override
	public List<ReactionVO> getAllReaction(String login_userid) {
		List<ReactionVO> reactionList = sqlsession.selectList("board.getAllReaction", login_userid);
		return reactionList;
	}

	// 게시물 반응 삭제
	@Override
	public int deleteReactionBoard(Map<String, String> paraMap) {
		int n = sqlsession.delete("board.deleteReactionBoard", paraMap);
		return n;
	}

	// 게시물 반응 조회
	@Override
	public ReactionVO selectReaction(Map<String, String> paraMap) {
		ReactionVO reactionvo = sqlsession.selectOne("board.selectReaction", paraMap);
		return reactionvo;
	}

	// 이미 반응 누른 경우, 유니크키 때문에 update 처리 
	@Override
	public int updateReactionBoard(Map<String, String> paraMap) {
		int n = sqlsession.update("board.updateReactionBoard", paraMap);
		return n;
	}

	
}
