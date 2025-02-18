package com.spring.app;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.spring.app.alarm.service.AlarmService;
import com.spring.app.member.domain.MemberVO;

@SpringBootTest
class JobchaeApplicationTests {

	@Autowired
	AlarmService alarmService;
	
	int seqNum= 0;

	@Test
	@Order(1)
	void selectSeq() {
		
	}
	
	@Test
	@Order(2)
	void insertAlarm() {
		
		
		MemberVO user001 = new MemberVO();
		user001.setMember_id("user001");
		
		assertEquals(1,alarmService.insertAlarm(user001));
		
	}
	@Test
	@Order(3)
	void deleteAlarm() {
		
	};

}
