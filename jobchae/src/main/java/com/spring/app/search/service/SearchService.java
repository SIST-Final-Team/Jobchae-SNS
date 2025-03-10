package com.spring.app.search.service;

import java.util.List;
import java.util.Map;

import com.spring.app.search.domain.SearchBoardVO;

public interface SearchService {
	
	/**
	 * 게시물 검색 결과 가져오기
	 * @param paraMap
	 * searchWord: 검색어,
	 * login_member_id:로그인 한 유저,
	 * board_register_date: 작성일 범위,
	 * searchFileType: 첨부 파일 확장자,
	 * start: 시작 번호, end: 끝 번호
	 * @return
	 */
	List<SearchBoardVO> searchBoardByContent(Map<String, String> paraMap);
}
