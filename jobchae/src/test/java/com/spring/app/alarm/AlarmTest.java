package com.spring.app.alarm;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;

import java.util.List;

import org.apache.commons.logging.Log;
import org.junit.jupiter.api.ClassOrderer.OrderAnnotation;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestClassOrder;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.alarm.model.AlarmMapper;
import com.spring.app.alarm.service.AlarmService;
import com.spring.app.member.domain.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class AlarmTest {

	@Autowired
	AlarmService alarmService;
	
	@Autowired
	AlarmMapper alarmMapper;
	
	MemberVO user001 = new MemberVO();
	AlarmVO alarm = new AlarmVO();
	//seq 생성
//	@Test
//	@Order(1)
//	void selectSeq() {
//		seqNum = alarmService.selectSeq();
//		
//	}
	
	
	//알림 삽입
	@Test
	@Order(1)
	void insertAlarm() {
		
		user001.setMember_id("user001");
		
		alarmService.insertAlarm(user001, alarm);
		
		assertNotEquals(0, alarm.getNotification_no());
		
	}
	
	//알림 제거
	@Test
	@Order(2)
	void deleteAlarm() {

		assertNotEquals(0, alarm.getNotification_no());
		assertEquals("user001", user001.getMember_id());
		assertEquals(1,alarmService.deleteAlarm(user001, alarm.getNotification_no()));
		
	}
	
	//알림 조회
	@Test
	@Order(3)
	void selectAlarmList() {
		
		List<AlarmVO> alarmList = null;
		alarmList = alarmService.selectAlarmList(user001);
		assertNotEquals(null, alarmList);
		log.info(alarmList.stream().limit(5).toList().toString());
		
	}
	
	//읽음 처리
	@Test
	@Order(4)
	void updateRead() {
		assertNotEquals(0, alarm.getNotification_no());
		assertEquals("user001", user001.getMember_id());
		assertEquals(1,alarmService.updateAlarmRead(user001, alarm.getNotification_no()));
	}

}
