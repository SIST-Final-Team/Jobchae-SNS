package com.spring.app.search.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.app.config.AES256_Configuration;
import com.spring.app.history.service.HistoryService;
import com.spring.app.recruit.domain.RecruitVO;
import com.spring.app.search.domain.SearchBoardVO;
import com.spring.app.search.domain.SearchCompanyVO;
import com.spring.app.search.domain.SearchMemberVO;
import com.spring.app.search.model.SearchDAO;

@Service
public class SearchService_imple implements SearchService {
	
	@Autowired
	SearchDAO dao;

	@Autowired
	HistoryService historyService;

	@Override
	public List<SearchBoardVO> searchBoardByContent(Map<String, String> paraMap) {
		List<SearchBoardVO> searchBoardVOList = dao.searchBoardByContent(paraMap);
		
		// 로그인한 경우
		if(paraMap.get("login_member_id") != null) {
		// 글 검색 노출수 증가
			for(SearchBoardVO searchBoardVO : searchBoardVOList) {
				// 본인이 아닌 경우 증가
				if(!paraMap.get("login_member_id").equals(searchBoardVO.getMember_id())) {
					historyService.increaseViewCount(searchBoardVO.getBoard_no(), "board", "1");
				}
			}
		}

		return searchBoardVOList;
	}

	@Override
	public int totalSearchBoardByContent(Map<String, String> paraMap) {
		return dao.totalSearchBoardByContent(paraMap);
	}

	// 회원 검색결과 가져오기
	@Override
	public List<SearchMemberVO> searchMemberByName(Map<String, Object> paraMap) {
		List<SearchMemberVO> searchMemberVOList = dao.searchMemberByName(paraMap);
		
		// 로그인한 경우
		if(paraMap.get("login_member_id") != null) {
			// 프로필 검색 노출수 증가
			for(SearchMemberVO searchMemberVO : searchMemberVOList) {
				// 본인이 아닌 경우 증가
				if(!paraMap.get("login_member_id").equals(searchMemberVO.getMember_id())) {
					historyService.increaseViewCount(searchMemberVO.getMember_id(), "profile", "1");
				}
			}
		}

		return searchMemberVOList;
	}

	@Override
	public List<SearchCompanyVO> searchCompanyByName(Map<String, Object> paraMap) {
		List<SearchCompanyVO> searchCompanyVOList = dao.searchCompanyByName(paraMap);

		// 로그인한 경우
		if(paraMap.get("login_member_id") != null) {
			// 회사 검색 노출수 증가
			for(SearchCompanyVO searchCompanyVO : searchCompanyVOList) {
				// 본인이 아닌 경우 증가
				if(!paraMap.get("login_member_id").equals(searchCompanyVO.getFk_member_id())) {
					historyService.increaseViewCount(searchCompanyVO.getCompany_no(), "company", "1");
				}
			}
		}

		return searchCompanyVOList;
	}

	@Override
	public List<Map<String, String>> getSkillListBySkillNo(List<String> skill_noList) {
		return dao.getSkillListBySkillNo(skill_noList);
	}

	@Override
	public List<Map<String, String>> getCompanyListByCompanyNo(List<String> company_noList) {
		return dao.getCompanyListByCompanyNo(company_noList);
	}

	@Override
	public List<Map<String, String>> getRegionListByRegionNo(List<String> region_noList) {
		return dao.getRegionListByRegionNo(region_noList);
	}

	@Override
	public List<Map<String, String>> getIndustryListByIndustryNo(List<String> industry_noList) {
		return dao.getIndustryListByIndustryNo(industry_noList);
	}

	@Override
	public List<String> getBoardNoByMemberId(String member_id) {
		return dao.getBoardNoByMemberId(member_id);
	}

	@Override
	public List<RecruitVO> searchRecruit(Map<String, Object> params) {
		return dao.searchRecruit(params);
	}
	

}
