package com.spring.app.chatting.repository;

import com.spring.app.chatting.domain.ChatRoomReadStatus;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ChatRoomReadStatusRepository extends MongoRepository<ChatRoomReadStatus, String> {




}
