package com.spring.app.alarm.model;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.mongodb.repository.MongoRepository;

import com.spring.app.alarm.domain.AlarmVO;

import java.util.List;


public interface AlarmDAO extends MongoRepository<AlarmVO, String>{
	Slice<AlarmVO> findByMemberIdOrderByNotificationRegisterDateDesc(String memberId, Pageable pageAble);

	int countByMemberIdAndNotificationIsRead(String memberId, int i);

	Slice<AlarmVO> findByMemberIdAndNotificationTypeOrderByNotificationRegisterDateDesc(String memberId,  AlarmVO.NotificationType type, Pageable pageAble);
}
