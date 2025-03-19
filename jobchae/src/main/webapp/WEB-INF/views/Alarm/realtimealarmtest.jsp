<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Alarm Page</title>
  </head>
  <body>
    <h1>RealTime Alarm Page</h1>
    <ul id="alarmList"></ul>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script>
      // 웹소켓을 통해 특정 사용자에게 알림을 받기 위한 사용자 ID
      const userId = "user001";
      // STOMP 프로토콜 통신을 위한 객체 (웹소켓 클라이언트)
      let stompClient = null;

      // 웹소켓 연결을 설정하고, 알림 구독을 시작하는 함수
      function connect() {
        // SockJS를 사용하여 서버와의 웹소켓 연결 생성
        const socket = new SockJS("/jobchae/ws?user-id="+userId);
        // STOMP 클라이언트를 생성
        stompClient = Stomp.over(socket);
        const headers = {
          'user-id':  userId // 'token'은 실제 토큰 값으로 대체해야 함
        };
        // 서버에 연결 요청, 연결이 성공하면 콜백 실행
        stompClient.connect(headers, function (frame) {
          console.log("Connected: " + frame);
          // 사용자별 알림 토픽 구독 및 수신 시, 메시지를 파싱 후 알림 추가
          // stompClient.subscribe("/user/"+userId+"/queue/alarm", function (alarm) {
          stompClient.subscribe("/topic/alarm/"+userId, function (alarm) {
            console.log(alarm);
            const jsonData = JSON.parse(alarm.body);
            console.log(jsonData);
            addAlarm(jsonData);
          });
        });
      }

      // 단일 알림 객체를 li로 추가하는 함수
      function addAlarm(alarm) {
        const alarmList = document.getElementById("alarmList");
        const li = document.createElement("li");
        li.textContent = alarm.notificationNo;
        alarmList.appendChild(li);
      }
      //connect() 호출하여 웹소켓 연결 시작
      connect();
    </script>
  </body>
</html>
