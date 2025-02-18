package com.spring.app.alarm.model;

import com.spring.app.member.domain.MemberVO;

public interface AlarmDAO {

	public int insertAlarm(MemberVO member);
	
	public int selectSeqNum();
	
	public int deleteAlarm(MemberVO member, int seqNum);

}
