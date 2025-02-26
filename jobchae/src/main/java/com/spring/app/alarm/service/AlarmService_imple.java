package com.spring.app.alarm.service;

import java.util.List;
import java.util.Set;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;

import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.alarm.model.AlarmDAO;
import com.spring.app.alarm.model.AlarmMapper;
import com.spring.app.member.domain.MemberVO;

@Service
public class AlarmService_imple implements AlarmService{

	@Autowired
	AlarmDAO alarmDAO;
	@Autowired
	Validator validator;
	
	
//	알람 삽입
	@Override
	public AlarmVO insertAlarm(MemberVO member, AlarmVO.NotificationType type) {

		AlarmVO alarm = new AlarmVO();
		alarm.setMemberId(member.getMember_id());
		alarm.setNotificationType(type);

		//오류 검증 코드 시작-------------------------------------
		Set<ConstraintViolation<AlarmVO>> violations = validator.validate(alarm);
		if(!violations.isEmpty()) {
			for(ConstraintViolation<AlarmVO> violation : violations) {
				System.out.println(violation.getPropertyPath() +":" +violation.getMessage());
			}
			throw new IllegalArgumentException("알림 입력 오류");
		}

		AlarmVO result = alarmDAO.save(alarm);
		
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
	public AlarmVO deleteAlarm(MemberVO member, Long seq) {
		//TODO 나중에 좀더 자세히 수정
//		AlarmVO result = alarmMapper

		return null;
	}

	@Override
	public List<AlarmVO> selectAlarmList(MemberVO member, int pageNumber) {
		//TODO 나중에 더 할것이 있는지  조회
		final int pageSize = 10;
		Pageable pageAble = PageRequest.of(pageNumber, pageSize);
		Slice<AlarmVO> alarmList = alarmDAO.findByMemberId(member.getMember_id(), pageAble);
		boolean hasNext = alarmList.hasNext();
		List<AlarmVO> list = null;
		if(hasNext) {
			list = alarmList.getContent();
		}
		return list;
	}

	@Override
	public AlarmVO updateAlarmRead(MemberVO member, Long seq) {

//		AlarmVO result = alarmMapper.updateAlarmRead(member.getMember_id(), seq);

		return null;
	}

}
