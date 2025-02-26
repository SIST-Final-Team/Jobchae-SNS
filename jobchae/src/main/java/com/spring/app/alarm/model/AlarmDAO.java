package com.spring.app.alarm.model;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.mongodb.repository.MongoRepository;

import com.spring.app.alarm.domain.AlarmVO;

import java.util.List;


public interface AlarmDAO extends MongoRepository<AlarmVO, String>{
	Slice<AlarmVO> findByMemberId(String memberId, Pageable pageAble);
}
