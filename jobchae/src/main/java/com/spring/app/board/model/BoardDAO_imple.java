package com.spring.app.board.model;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

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
	
}
