package com.spring.app.alarm.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.member.domain.MemberVO;

@Mapper
public interface AlarmMapper {

	public int insertAlarm(Map<String, Object> paraMap);

//	public int selectSeqNum();

	public int deleteAlarm(@Param("member") String member, @Param("seqNum") Long seq);
	
	public List<AlarmVO> selectAlarmList(String member_id);

	public int updateAlarmRead(@Param("member") String member, @Param("seqNum") Long seq);
}
