package com.spring.app.alarm.controller;

import com.spring.app.alarm.domain.AlarmVO;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class AlarmWebSocketController {

    // 클라이언트가 /app/alarm로 메시지를 보내면 /topic/alarm로 메시지를 보낸다.
    @MessageMapping("/alarm")
    @SendTo("/topic/alarm")
    public AlarmVO send(AlarmVO alarm) throws Exception {
        return alarm;
    }

//    //팔로워들에게 알림을 보내는 컨트롤러
//    @MessageMapping("/follower/{member_id}")
//    @SendTo("/topic/follower/{member_id}")
//    public AlarmVO send(AlarmVO alarm, String member_id) throws Exception {
//        return alarm;
//    }


}
