package com.spring.app.board.model;

import java.util.Map;

public interface BoardDAO {

	// 파일첨부가 없는 글쓰기
	int add(Map<String, String> paraMap);

}
