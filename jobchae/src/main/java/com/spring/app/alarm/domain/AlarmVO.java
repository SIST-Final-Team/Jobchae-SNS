package com.spring.app.alarm.domain;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "alarm")
public class AlarmVO {

	
	@Id
	private String notification_no;//	 notification_no NUMBER NOT NULL, /* 알림 일련번호 */
	
	private String member_id;//	 fk_member_id VARCHAR2(20) NOT NULL, /* 회원 아이디 */
	
	private int notification_type;//	 notification_type NUMBER(1) NOT NULL, /* 유형 , 댓글 알림:1, 채팅 알림:2, 팔로우 알림:3, 팔로워 게시물 알림: 4*/
	
	private Date notification_register_date;//	 notification_register_date DATE DEFAULT sysdate NOT NULL, /* 등록일자 , 기본값 sysdate */
	
	private boolean notification_is_read;//	 notification_is_read 
}
