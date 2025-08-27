package com.spring.app.chatting.domain;

public enum ChatType {

    // 메시지 타입 여부
    ENTER,  // 입장 메시지
    TALK,   // 사용자 메시지
    LEAVE,  // 퇴장 메시지
    LOGOUT; // 로그아웃 메시지
}
