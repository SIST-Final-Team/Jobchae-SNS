package com.spring.app.alarm.service.create;

import com.spring.app.alarm.domain.AlarmData;
import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.alarm.model.AlarmDAO;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.model.MemberDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class InsertCommentNoti implements InsertNotification {

    @Autowired
    MemberDAO memberDAO;
    @Autowired
    AlarmDAO alarmDAO;
    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Override
    public AlarmVO insertNotification(MemberVO memberVO, String TargetId, AlarmData alarmData) {
        AlarmVO alarmVO = new AlarmVO();
        MemberVO targetMember = memberDAO.getAlarmMemberInfoByMemberId(TargetId);

        // 알림 타입 설정
        alarmVO.setNotificationType(AlarmVO.NotificationType.COMMENT);
        // 알림을 받는 사람을 설정(댓글 받는 사람)
        alarmVO.setMemberId(TargetId);
        // 알림을 보내는 사람을 설정
        alarmVO.setTargetMemberId(memberVO.getMember_id());

        // 알림을 보내는 사람을 설정
        Map<String, String> targetMemberInfo = Map.of("member_id", memberVO.getMember_id(),
                "member_name", memberVO.getMember_name(),
                "member_profile", memberVO.getMember_profile());
        alarmVO.setTargetMember(targetMemberInfo);


        Map<String, String> MemberInfo = Map.of("member_id", targetMember.getMember_id(),
                "member_name", targetMember.getMember_name(),
                "member_profile", targetMember.getMember_profile());
        alarmVO.setMemberInfo(MemberInfo);

        alarmVO.setAlarmData(alarmData);

        AlarmVO result = alarmDAO.save(alarmVO);
        System.out.println("/user/"+TargetId+"/queue/alarm");

        //알림을 구독하고 있는 사용자에게 알림 전송
        messagingTemplate.convertAndSend("/topic/alarm/"+TargetId, result);
//        messagingTemplate.convertAndSend("/user/user001/queue/alarm", "test:test");

        return result;
    }

    @Override
    public AlarmVO.NotificationType NotificationType() {
        return AlarmVO.NotificationType.COMMENT;
    }
}
