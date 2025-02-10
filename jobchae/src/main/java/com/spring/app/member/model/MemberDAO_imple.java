package com.spring.app.member.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

public class MemberDAO_imple implements MemberDAO {

	
	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	
	
	
	
	
	
	
	
}//end of class...

