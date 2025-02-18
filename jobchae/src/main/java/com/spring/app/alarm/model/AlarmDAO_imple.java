package com.spring.app.alarm.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.member.domain.MemberVO;

@Repository
public class AlarmDAO_imple implements AlarmDAO {

	@Autowired
	@Qualifier("sqlsession")
	SqlSessionTemplate sqlsession;
	
//	알람 입력
	@Override
	public int insertAlarm(MemberVO member) {
		
		int result = sqlsession.insert("alarm.insertAlarm",member.getMember_id());
		return result;
	}

//	시퀀스 번호 추출
	@Override
	public int selectSeqNum() {
		
		int seqNum = sqlsession.selectOne("alarm.selectAlarmSeq");
		return seqNum;
	}

//	알람 삭제
	@Override
	public int deleteAlarm(MemberVO member, int seqNum) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	

}
