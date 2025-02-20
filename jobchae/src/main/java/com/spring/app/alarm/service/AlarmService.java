package com.spring.app.alarm.service;

import java.util.List;

import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.member.domain.MemberVO;

public interface AlarmService {

	//알림 삽입
	public int insertAlarm(MemberVO member, AlarmVO alarm);
	
	//알림 seq 조회
	//selectKey로 필요가 없어졌음
//	public int selectSeq();
	
	//알림 삭제(업데이트)
	public int deleteAlarm(MemberVO member, Long seq);
	
	//알림 조회
	public List<AlarmVO> selectAlarmList(MemberVO member);
	
	//알림 읽음 처리
	public int updateAlarmRead(MemberVO member, Long seq);
}
