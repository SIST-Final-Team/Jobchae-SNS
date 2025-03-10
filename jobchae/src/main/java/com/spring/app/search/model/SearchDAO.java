package com.spring.app.search.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.search.domain.SearchBoardVO;

@Mapper
public interface SearchDAO {
	
	/**
	 * 게시물 검색 결과 가져오기
	 * @param paraMap
	 * searchWord: 검색어,
	 * login_member_id: 로그인 한 유저 id,
	 * board_register_date: 작성일 범위(현재로부터 n일 전),
	 * searchFileType: 첨부 파일 타입(image, video),
	 * start: 시작 번호, end: 끝 번호
	 * @return
	 */
	List<SearchBoardVO> searchBoardByContent(Map<String, String> paraMap);
	
}
