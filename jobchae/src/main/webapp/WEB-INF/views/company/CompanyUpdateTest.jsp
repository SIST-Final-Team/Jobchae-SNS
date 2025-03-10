<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Company Update</title>
  </head>
  <body>
    <h1>Company Info Test</h1>
    <ul id="companyList">
      <li id="companyNo"></li>
      <li id="member"></li>
      <li id="industry"></li>
      <li id="companyName"></li>
      <li id="companyWebsite"></li>
      <li id="companySize"></li>
      <li id="companyType"></li>
      <li id="companyLogo"></li>
      <li id="companyExplain"></li>
      <li id="companyRegisterDate"></li>
    </ul>
    <script>
      const companyNo = window.location.pathname.split("/").pop();

      //비동기 함수로 회사 정보를 가져오는 함수
      async function fetchCompanyInfo() {
        //fetch API를 사용하여 서버에 GET 요청
        const response = await fetch(
          `<%= ctxPath%>/api/company/dashboard/\${companyNo}`
        );
        //서버로부터 받은 JSON 데이터를 파싱
        const jsonData = await response.json();
        // console.log(jsonData);

        //회사 정보를 화면에 출력
        const liList = Array.from(
          document.getElementById("companyList").getElementsByTagName("li")
        );

        liList.forEach((li) => {
          if(li["id"] == "member") {
            li.textContent = jsonData["member"]["member_id"];
          }
          else if(li["id"] == "industry") {
            li.textContent = jsonData["industry"]["industryName"];
          }
          else {
            li.textContent = jsonData[li["id"]];
          }

          if (li == "") {
            li.textContent = "null";
          }
        });
      }

      fetchCompanyInfo();
    </script>
  </body>
</html>
