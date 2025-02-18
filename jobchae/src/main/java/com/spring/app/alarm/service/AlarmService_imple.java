package com.spring.app.alarm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.alarm.model.AlarmDAO;
import com.spring.app.member.domain.MemberVO;

@Service
public class AlarmService_imple implements AlarmService{

	@Autowired
	AlarmDAO alarmDAO;
	
	@Override
	public int insertAlarm(MemberVO member) {
		
		int result = alarmDAO.insertAlarm(member);
		
		return result;
	}

}
