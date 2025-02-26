package com.spring.app.alarm.domain;

import java.util.Date;

import jakarta.validation.constraints.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "notification")
public class AlarmVO {

	public static enum NotificationType{
		COMMENT, CHAT, FOLLOW, FOLLOWER_POST
	}
	
	@Id
	private String notificationNo;//	 notification_no NUMBER NOT NULL, /* 알림 일련번호 */
	
	@NotBlank
	private String memberId;//	 fk_member_id VARCHAR2(20) NOT NULL, /* 회원 아이디 */
	
	@NotNull
	private NotificationType notificationType;//	 notification_type NUMBER(1) NOT NULL, /* 유형 , 댓글 알림:1, 채팅 알림:2, 팔로우 알림:3, 팔로워 게시물 알림: 4*/
	
	@NotBlank
	private Date notification_registerDate = new Date();//	 notification_register_date DATE DEFAULT sysdate NOT NULL, /* 등록일자 , 기본값 sysdate */
	
	@NotBlank
	@Min(value = -1, message = "notification_is_read must be greater than -1")
	@Max(value = 1, message = "notification_is_read must be less than 1")
	private int notificationIsRead = 0;//	 notification_is_read
	

	private String targetURL;

	public String getNotificationNo() {
		return notificationNo;
	}

	public void setNotificationNo(String notificationNo) {
		this.notificationNo = notificationNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public NotificationType getNotificationType() {
		return notificationType;
	}

	public void setNotificationType(NotificationType notificationType) {
		this.notificationType = notificationType;
	}

	public Date getNotification_registerDate() {
		return notification_registerDate;
	}

	public void setNotification_registerDate(Date notification_registerDate) {
		this.notification_registerDate = notification_registerDate;
	}

	public int getNotificationIsRead() {
		return notificationIsRead;
	}

	public void setNotificationIsRead(int notificationIsRead) {
		this.notificationIsRead = notificationIsRead;
	}

	public String getTargetURL() {
		return targetURL;
	}

	public void setTargetURL(String targetURL) {
		this.targetURL = targetURL;
	}
}
