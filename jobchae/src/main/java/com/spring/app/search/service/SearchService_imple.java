package com.spring.app.search.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.search.domain.SearchBoardVO;
import com.spring.app.search.domain.SearchCompanyVO;
import com.spring.app.search.domain.SearchMemberVO;
import com.spring.app.search.model.SearchDAO;

@Service
public class SearchService_imple implements SearchService {
	
	@Autowired
	SearchDAO dao;

	@Override
	public List<SearchBoardVO> searchBoardByContent(Map<String, String> paraMap) {
		return dao.searchBoardByContent(paraMap);
	}

	@Override
	public List<SearchMemberVO> searchMemberByName(Map<String, Object> paraMap) {
		return dao.searchMemberByName(paraMap);
	}

	@Override
	public List<SearchCompanyVO> searchCompanyByName(Map<String, Object> paraMap) {
		return dao.searchCompanyByName(paraMap);
	}
	
	

}
