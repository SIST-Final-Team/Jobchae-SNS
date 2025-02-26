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
    <h1>Alarm Page</h1>
    <ul id="alarmList"></ul>
    <script>
      const userId = "user001";

      function addAlarms(jsonData) {
        const alarmList = document.getElementById("#alarmList");
        jsonData.forEach((alarm) => {
          const li = document.createElement("li");
          li.textContent = alarm["message"];
          alarmList.appendChild(li);
        });
      }
    </script>
  </body>
</html>
