package com.spring.app.member.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO_imple implements MemberDAO {

	
	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;

	
	
	
	
	
	
	// 아이디 중복체크
	@Override
	public boolean idDuplicateCheck(String member_id) {
		
		boolean isExists = false;
		
		int n = sqlsession.selectOne("member.idDuplicateCheck", member_id);
		
		if (n == 1) {
			isExists = true; // 발견은 true, 새로운 아이디면 false
		}
		
		return isExists;
	}//end of public boolean idDuplicateCheck(String member_id) {}...






	// 이메일 중복체크
	@Override
	public boolean emailCheck(String member_email) {
		
		boolean isExists = false;
		
		int n = sqlsession.selectOne("member.emailCheck", member_email);
		
		if (n == 1) {
			isExists = true; // 발견은 true, 새로운 아이디면 false
		}
		return isExists;
	}//end of public boolean emailCheck(String member_email) {}...
	
	
	
	
	
	
	
	
}//end of class...

