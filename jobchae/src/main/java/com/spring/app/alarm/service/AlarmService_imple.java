package com.spring.app.alarm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.alarm.model.AlarmDAO;
import com.spring.app.alarm.model.AlarmMapper;
import com.spring.app.member.domain.MemberVO;

@Service
public class AlarmService_imple implements AlarmService{

	
	AlarmDAO alarmDAO;
	
	AlarmMapper alarmMapper;
	
	
	public AlarmService_imple(AlarmDAO alarmDAO, AlarmMapper alarmMapper) {
		this.alarmDAO = alarmDAO;
		this.alarmMapper = alarmMapper;
	}
	
//	알람 삽입
	@Override
	public int insertAlarm(MemberVO member, AlarmVO alarm) {
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("member", member);
		paraMap.put("alarm", alarm);
		
		int result = alarmMapper.insertAlarm(paraMap);
		
		return result;
	}

//	알림 시퀀스 번호 추출
//	@Override
//	public int selectSeq() {
//		
//		int result = alarmMapper.selectSeqNum();
//		return result;
//	}

//	알림 삭제(업데이트)
	@Override
	public int deleteAlarm(MemberVO member, Long seq) {
		//TODO 나중에 좀더 자세히 수정
		int result = alarmMapper.deleteAlarm(member.getMember_id(), seq);

		return result;
	}

	@Override
	public List<AlarmVO> selectAlarmList(MemberVO member) {
		//TODO 나중에 더 할것이 있는지  조회
		
		List<AlarmVO> alarmList = alarmMapper.selectAlarmList(member.getMember_id());
		return alarmList;
	}

	@Override
	public int updateAlarmRead(MemberVO member, Long seq) {
		
		int result = alarmMapper.updateAlarmRead(member.getMember_id(), seq);

		return result;
	}

}
