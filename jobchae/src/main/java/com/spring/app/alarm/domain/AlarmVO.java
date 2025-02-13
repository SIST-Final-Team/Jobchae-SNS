package com.spring.app.alarm.domain;


public class AlarmVO {

	int notification_no;//	 notification_no NUMBER NOT NULL, /* 알림 일련번호 */
	String fk_member_id;//	 fk_member_id VARCHAR2(20) NOT NULL, /* 회원 아이디 */
	int notification_type;//	 notification_type NUMBER(1) NOT NULL, /* 유형 , 댓글 알림:1, 채팅 알림:2, 팔로우 알림:3, 팔로워 게시물 알림: 4*/
	String notification_register_date;//	 notification_register_date DATE DEFAULT sysdate NOT NULL, /* 등록일자 , 기본값 sysdate */
	int notification_is_read;//	 notification_is_read NUMBER(1) DEFAULT 0 NOT NULL, /* 상태 , 기본값 0, 읽음:1, 읽지 않음: 0*/
//	 CONSTRAINT pk_tbl_noti_no PRIMARY KEY (notification_no),
//	 CONSTRAINT fk_tbl_noti_fk_member_id FOREIGN KEY (fk_member_id) REFERENCES tbl_member(member_id),
//	 CONSTRAINT ck_tbl_noti_type CHECK (notification_type in (1, 2, 3, 4)),
//	 CONSTRAINT ck_tbl_noti_is_read CHECK (notification_is_read in (0, 1))
	
}
