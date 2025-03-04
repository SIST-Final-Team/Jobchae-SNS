<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Alarm Page</title>
    <link rel="stylesheet" href="styles.css" />
  </head>
  <body>
    <h1>RealTimeAlarm Page</h1>
    <ul id="alarmList"></ul>

    <script>
      let pageNumber = 0;

      async function getAlarms() {
        const response = await fetch(
          `http://localhost/jobchae/api/alarm/selectAlarmList/\${pageNumber}`
        );
        const jsonData = await response.json();
        console.log(jsonData);
        const alarmList = jsonData["list"];
        addAlarms(alarmList);
      }

      // 새 알림 객체 하나를 li로 추가하는 함수
      function addAlarm(alarm) {
        const alarmList = document.getElementById("alarmList");
        const li = document.createElement("li");
        li.textContent = alarm.notificationNo; // 필요한 속성 이름 사용
        alarmList.appendChild(li);
      }

      // 여러 알림 객체를 각각 addAlarm으로 추가
      function addAlarms(jsonData) {
        jsonData.forEach((alarm) => {
          addAlarm(alarm);
        });
      }

      getAlarms();
    </script>
  </body>
</html>
