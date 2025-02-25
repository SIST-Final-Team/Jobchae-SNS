package com.spring.app.alarm.model;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.spring.app.alarm.domain.AlarmVO;


public interface AlarmDAO extends MongoRepository<AlarmVO, String>{

}
