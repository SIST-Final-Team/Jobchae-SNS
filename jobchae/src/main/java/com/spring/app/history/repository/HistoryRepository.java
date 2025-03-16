package com.spring.app.history.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.spring.app.history.domain.SearchHistoryVO;

@Repository
public interface HistoryRepository extends MongoRepository<SearchHistoryVO, String>{

}
