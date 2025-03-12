package com.spring.app.search.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.search.domain.SearchBoardVO;
import com.spring.app.search.model.SearchDAO;

@Service
public class SearchService_imple implements SearchService {
	
	@Autowired
	SearchDAO dao;

	@Override
	public List<SearchBoardVO> searchBoardByContent(Map<String, String> paraMap) {
		return dao.searchBoardByContent(paraMap);
	}
	
	

}
