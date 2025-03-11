package com.spring.app.search.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.search.domain.SearchBoardVO;
import com.spring.app.search.domain.SearchCompanyVO;
import com.spring.app.search.domain.SearchMemberVO;

@Mapper
public interface SearchDAO {
	
	/**
	 * 게시물 검색 결과 가져오기
	 * @param paraMap
	 * searchWord: 검색어,
	 * login_member_id: 로그인 한 유저 id,
	 * searchDate: 작성일 범위(현재로부터 n일 전),
	 * searchContentType: 첨부 파일 타입(image, video),
	 * start: 시작 번호, end: 끝 번호
	 * @return
	 */
	List<SearchBoardVO> searchBoardByContent(Map<String, String> paraMap);
	
	/**
	 * 회원 검색 결과 가져오기
	 * @param paraMap
	 * searchWord: 검색어,
	 * login_member_id: 로그인 한 유저 id,
	 * arr_fk_skill_no: 보유기술 일련번호 배열
	 * arr_fk_company_no: 회사 일련번호 배열
	 * arr_fk_region_no: 지역 일련번호 배열
	 * start: 시작 번호, end: 끝 번호
	 * @return
	 */
	List<SearchMemberVO> searchMemberByName(Map<String, Object> paraMap);
	
	/**
	 * 기업 검색 결과 가져오기
	 * @param paraMap
	 * searchWord: 검색어,
	 * login_member_id: 로그인 한 유저 id,
	 * arr_fk_industry_no: 업종 배열
	 * arr_company_size: 회사 규모 배열
	 * start: 시작 번호, end: 끝 번호
	 * @return
	 */
	List<SearchCompanyVO> searchCompanyByName(Map<String, Object> paraMap);
	
}
