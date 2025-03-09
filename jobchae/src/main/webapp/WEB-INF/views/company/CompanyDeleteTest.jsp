<%-- Created by IntelliJ IDEA. User: dltns Date: 25. 3. 7. Time: 오후 3:40 To
change this template use File | Settings | File Templates. --%> <%@ page
contentType="text/html;charset=UTF-8" language="java" %> <% String ctxPath =
request.getContextPath(); %>
<html>
  <head>
    <title>Company DeleteTest</title>
  </head>
  <body>
    <h1>CompanyDelete</h1>

    <p>당신의 현재 id</p>
    <p id="member_id"></p>
    <p>당신의 회사 번호</p>
    <p id="companyNo"></p>

    <form id="deleteFrom">
      <button type="submit">삭제</button>
    </form>

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
        const memberIdPara = document.getElementById("member_id");
        const companyNoPara = document.getElementById("companyNo");

        memberIdPara.textContent = jsonData["member"]["member_id"];
        companyNoPara.textContent = jsonData["companyNo"];
      }

      fetchCompanyInfo();

      const form = document.getElementById("deleteFrom");
    </script>
  </body>
</html>
