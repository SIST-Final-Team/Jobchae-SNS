package com.spring.app.alarm.domain;

import jakarta.validation.constraints.NotNull;

public class AlarmVO {

	@NotNull
	Long notification_no;//	 notification_no NUMBER NOT NULL, /* 알림 일련번호 */
	
	@NotNull
	String fk_member_id;//	 fk_member_id VARCHAR2(20) NOT NULL, /* 회원 아이디 */
	
	@NotNull
	int notification_type;//	 notification_type NUMBER(1) NOT NULL, /* 유형 , 댓글 알림:1, 채팅 알림:2, 팔로우 알림:3, 팔로워 게시물 알림: 4*/
	
	@NotNull
	String notification_register_date;//	 notification_register_date DATE DEFAULT sysdate NOT NULL, /* 등록일자 , 기본값 sysdate */
	
	@NotNull
	int notification_is_read;//	 notification_is_read NUMBER(1) DEFAULT 0 NOT NULL, /* 상태 , 기본값 0, 읽음:1, 읽지 않음: 0*/
//	 CONSTRAINT pk_tbl_noti_no PRIMARY KEY (notification_no),
//	 CONSTRAINT fk_tbl_noti_fk_member_id FOREIGN KEY (fk_member_id) REFERENCES tbl_member(member_id),
//	 CONSTRAINT ck_tbl_noti_type CHECK (notification_type in (1, 2, 3, 4)),
//	 CONSTRAINT ck_tbl_noti_is_read CHECK (notification_is_read in (0, 1))

	public Long getNotification_no() {
		return notification_no;
	}

	public void setNotification_no(Long notification_no) {
		this.notification_no = notification_no;
	}

	public String getFk_member_id() {
		return fk_member_id;
	}

	public void setFk_member_id(String fk_member_id) {
		this.fk_member_id = fk_member_id;
	}

	public int getNotification_type() {
		return notification_type;
	}

	public void setNotification_type(int notification_type) {
		this.notification_type = notification_type;
	}

	public String getNotification_register_date() {
		return notification_register_date;
	}

	public void setNotification_register_date(String notification_register_date) {
		this.notification_register_date = notification_register_date;
	}

	public int getNotification_is_read() {
		return notification_is_read;
	}

	public void setNotification_is_read(int notification_is_read) {
		this.notification_is_read = notification_is_read;
	}
	
	@Override
	public String toString() {
	
		
		return "AlarmVO{" + "notification_no=" + notification_no + ", fk_member_id='" + fk_member_id + '\''
				+ ", notification_type=" + notification_type + ", notification_register_date='"
				+ notification_register_date + '\'' + ", notification_is_read=" + notification_is_read + '}';
	}
}
