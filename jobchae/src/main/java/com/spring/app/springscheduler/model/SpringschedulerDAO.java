package com.spring.app.springscheduler.model;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SpringschedulerDAO {

	// 회원 휴면을 자동으로 지정해주는 스케줄러
	int schedulerUpdateIdle();

}
