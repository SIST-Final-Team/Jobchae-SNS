package com.spring.app.alarm.service;

import java.util.List;
import java.util.Map;

import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.member.domain.MemberVO;

public interface AlarmService {

	//알림 삽입
	public AlarmVO insertAlarm(MemberVO member, AlarmVO.NotificationType type);
	
	//알림 seq 조회
	//selectKey로 필요가 없어졌음
//	public int selectSeq();
	
	//알림 삭제(업데이트)
	public AlarmVO deleteAlarm(MemberVO member, String notification_no);
	
	//알림 조회
	public Map<String, Object> selectAlarmList(MemberVO member, int pageNumber);
	
	//알림 읽음 처리
	public AlarmVO updateAlarmRead(MemberVO member, String notification_no);

	//알림 읽음 처리
	public boolean updateAlarmRead(List<AlarmVO> alarmList);
}
