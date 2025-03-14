package com.spring.app.alarm.domain;

import java.util.Date;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.spring.app.member.domain.MemberVO;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Getter
@Setter
@ToString
@Document(collection = "notification")
public class AlarmVO {

	public static enum NotificationType{
		COMMENT, CHAT, FOLLOW, FOLLOWER_POST, LIKE
	}
	
	@Id
	private String notificationNo;//	 notification_no NUMBER NOT NULL, /* 알림 일련번호 */
	
	@NotBlank
	private String memberId;//	 fk_member_id VARCHAR2(20) NOT NULL, /* 회원 아이디 */

	@NotNull
	private Map<String, String> MemberInfo;

	private String targetMemberId;

	private Map<String, String> TargetMember;

	private String notificationContent;

	
	@NotNull
	private NotificationType notificationType;//	 notification_type NUMBER(1) NOT NULL, /* 유형 , 댓글 알림:1, 채팅 알림:2, 팔로우 알림:3, 팔로워 게시물 알림: 4*/
	
	@NotNull
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Date notificationRegisterDate = new Date();//	 notification_register_date DATE DEFAULT sysdate NOT NULL, /* 등록일자 , 기본값 sysdate */


	// -1: 삭제상태, 0: 읽지 않음, 1: 알림 확인 상태, 2:읽음
	@NotNull
	@Min(value = -1, message = "notification_is_read must be greater than -1")
	@Max(value = 2, message = "notification_is_read must be less than 2")
	private int notificationIsRead = 0;//	 notification_is_read
	

	private String targetURL;

}
