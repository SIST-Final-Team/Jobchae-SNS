package com.spring.app.member.model;

//import org.apache.ibatis.annotations.Mapper;

//@Mapper
public interface MemberDAO {

	
	// 아이디 중복체크
	boolean idDuplicateCheck(String member_id);

	// 이메일 중복체크
	boolean emailCheck(String member_email);
	
	
	
	
	
	
	
}//end of interface...
