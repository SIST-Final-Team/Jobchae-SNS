package com.spring.app.board.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.model.BoardDAO;

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
	
}
