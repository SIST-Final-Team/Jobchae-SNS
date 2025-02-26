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
      function addAlarms(jsonData) {
        const alarmList = document.getElementById("alarmList");
        jsonData.forEach((alarm) => {
          const li = document.createElement("li");
          li.textContent = alarm.message; // JSON 데이터의 'message' 속성을 사용
          alarmList.appendChild(li);
        });
      }
    </script>
  </body>
</html>
