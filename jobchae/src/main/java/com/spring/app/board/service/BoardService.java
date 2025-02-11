package com.spring.app.board.service;

import java.util.Map;

public interface BoardService {

	// 파일첨부가 없는 글쓰기
	int add(Map<String, String> paraMap);

}
