package com.spring.app.alarm.service;

import java.lang.reflect.Member;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

import com.spring.app.alarm.domain.AlarmData;
import com.spring.app.alarm.service.create.InsertNotification;
import com.spring.app.member.model.MemberDAO;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;

import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.alarm.model.AlarmDAO;
import com.spring.app.member.domain.MemberVO;

@Service
public class AlarmService_imple implements AlarmService{

	@Autowired
	MemberDAO memberDAO;

	@Autowired
	AlarmDAO alarmDAO;
	@Autowired
	Validator validator;

	private static final Logger logger = LoggerFactory.getLogger(AlarmService_imple.class);

	Map<AlarmVO.NotificationType, InsertNotification> insertNotificationMap;

	// 생성자 주입
	@Autowired
	public AlarmService_imple(List<InsertNotification> sender) {
		this.insertNotificationMap = sender.stream().collect(Collectors.toMap(InsertNotification::NotificationType, Function.identity()));
	}
	
//	알람 삽입 테스트용
	@Override
	public AlarmVO insertAlarm2(MemberVO member, AlarmVO.NotificationType type) {

		//알림 객체 생성
		AlarmVO alarm = new AlarmVO();
		alarm.setMemberId(member.getMember_id());
		alarm.setNotificationType(type);

		//오류 검증 코드 시작-------------------------------------
		Set<ConstraintViolation<AlarmVO>> violations = validator.validate(alarm);
		if(!violations.isEmpty()) {
			//오류가 있으면 콘솔에 출력
			for(ConstraintViolation<AlarmVO> violation : violations) {
				System.out.println(violation.getPropertyPath() +":" +violation.getMessage());
			}
			throw new IllegalArgumentException("알림 입력 오류");
		}

		AlarmVO result = alarmDAO.save(alarm);
		
		return result;
	}

	//알림 삽입
	@Override
	public AlarmVO insertAlarm(MemberVO member, String targetId, AlarmVO.NotificationType type,AlarmData alarmData) {
		InsertNotification sender = insertNotificationMap.get(type);

		if(sender == null) {
			throw new IllegalArgumentException("알림 타입이 존재하지 않습니다.");
		}
		AlarmVO alarmVO = sender.insertNotification(member, targetId, alarmData);

		return alarmVO;
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
	public AlarmVO deleteAlarm(MemberVO member, String notification_no) {
		//TODO 나중에 좀더 자세히 수정
		AlarmVO existAlarm = alarmDAO.findById(notification_no).orElse(null);
		if(existAlarm == null) {
			throw new IllegalArgumentException("알림이 존재하지 않습니다.");
		}
		existAlarm.setNotificationIsRead(-1);
		AlarmVO result = alarmDAO.save(existAlarm);

		return result;
	}

	//알림 조회
	@Override
	public Map<String, Object> selectAlarmList(MemberVO member, int pageNumber) {
		//TODO 나중에 더 할것이 있는지  조회
		//한 페이지에 보여줄 알림 수
		final int pageSize = 10;
		//페이징 처리
		Pageable pageAble = PageRequest.of(pageNumber, pageSize);
		logger.info("memberId : " + member.getMember_id());

		//알림 리스트 조회
		Slice<AlarmVO> alarmList = alarmDAO.findByMemberIdOrderByNotificationRegisterDateDesc(member.getMember_id(), pageAble);
		logger.info("alarmList: " + alarmList);
		//다음 페이지가 있는지 확인
		boolean hasNext = alarmList.hasNext();
		//값을 저장
		List<AlarmVO> list = alarmList.getContent();
		List <AlarmVO> result = updateAlarmRead(list);

		//알림이 존재하면 상태를 변경
		if(!list.isEmpty()) {
			//알림의 상태를 확인만 한 상태로 변경
			if(result != null) {
				logger.info("알림 상태 변경 성공");
			}
			else {
				//알림 상태 변경이 안되면 예외 발생
				throw new RuntimeException("알림 상태 변경 실패");
			}
		}


//		//알림의 프로필을 최신으로 변경
		result.forEach(alarm ->{
			MemberVO targetMember = memberDAO.getAlarmMemberInfoByMemberId(alarm.getTargetMemberId());
			String targetMemberProfile = targetMember.getMember_profile();
			Map<String, String> targetMemberInfo = Map.of("member_id", targetMember.getMember_id(),
					"member_name", targetMember.getMember_name(),
					"member_profile", targetMemberProfile);
			alarm.setTargetMember(targetMemberInfo);
		});

		Map<String, Object> resultMap = Map.of("hasNext", hasNext, "list", result);
		return resultMap;
	}

	//알림 읽음 처리
	@Override
	public AlarmVO updateAlarmRead(MemberVO member, String notification_no) {

		//TODO 나중에 좀더 자세히 수정
		AlarmVO existAlarm = alarmDAO.findById(notification_no).orElse(null);
		if(existAlarm == null) {
			throw new IllegalArgumentException("알림이 존재하지 않습니다.");
		}
		existAlarm.setNotificationIsRead(2);
		AlarmVO result = alarmDAO.save(existAlarm);
		logger.info("상태는 "+result.getNotificationIsRead() + "ID는 " + result.getNotificationNo());

		return result;
	}

	//알림 읽음 처리
	@Override
	public List<AlarmVO> updateAlarmRead(List<AlarmVO> alarmList) {

		//알림의 상태를 확인만 한 상태로 변경
		alarmList.forEach(alarm -> {
			//알림이 읽지 않은 상태라면
			if(alarm.getNotificationIsRead() == 0) {
				alarm.setNotificationIsRead(1);
			}
		});
		List<AlarmVO> result = null;
		try {
			result = alarmDAO.saveAll(alarmList);
		}
		catch (Exception e) {
			throw new RuntimeException("알림 상태 변경 실패");
		}
		//TODO 나중에 좀더 자세히 수정
        return result;
	}

	@Override
	public int selectUnreadAlarmCount(MemberVO member) {

		int result = alarmDAO.countByMemberIdAndNotificationIsRead(member.getMember_id(), 0);

		logger.info("읽지않은 알림 개수 : " + result);

		return result;
	}

}
