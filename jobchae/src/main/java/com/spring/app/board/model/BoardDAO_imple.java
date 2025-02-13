package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.member.domain.MemberVO;

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
	public int delete(String board_no) {
		int n = sqlsession.delete("board.delete", board_no);
		return n;
	}

	// 글 수정
	@Override
	public BoardVO editSearch(String board_no) {
		BoardVO boardvo = sqlsession.selectOne("board.editSearch", board_no);
		return boardvo;
	}

	
}
