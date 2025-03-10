<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Company Update</title>
  </head>
  <body>
    <h1>Company Update Test</h1>
    <form
      id="companyForm"
      action="<%= ctxPath%>/api/company/updateCompany"
      method="post"
    >
      <input type="hidden" id="companyNo" name="companyNo" />
      <input type="hidden" id="memberId" name="memberId" />

      <label for="companyName">Name :</label>
      <input
        type="text"
        id="companyName"
        name="companyName"
        required
        placeholder="단체 이름을 입력하세요"
      />
      <br />
      <label for="companyWebsite">Website :</label>
      <input
        type="text"
        id="companyWebsite"
        name="companyWebsite"
        placeholder="http://www.example.com"
      />
      <br />
      <label for="industryName">Industry :</label>
      <input
        list="options"
        id="industryName"
        name="industryName"
        placeholder="Software"
      />
      <datalist id="options"></datalist>
      <br />
      <label for="companySize">Company Size :</label>
      <select id="companySize" name="companySize">
        <option value="1">규모 선택</option>
        <option value="2">0-1</option>
        <option value="3">2-10</option>
        <option value="4">11-50</option>
        <option value="5">51-200</option>
        <option value="6">201-500</option>
        <option value="7">501-1000</option>
        <option value="8">1001-5000</option>
        <option value="9">5001-10000</option>
        <option value="10">10000+</option>
      </select>
      <br />
      <label for="companyType">Company Type :</label>
      <select id="companyType" name="companyType">
        <option value="1">종류 선택</option>
        <option value="2">Private</option>
        <option value="3">Government</option>
        <option value="4">Nonprofit</option>
        <option value="5">Educational</option>
        <option value="6">Self-Employed</option>
        <option value="7">Partnership</option>
        <option value="8">Sole Proprietorship</option>
      </select>
      <br />
      <label for="companyExplain">Company Explain :</label>
      <textarea
        id="companyExplain"
        name="companyExplain"
        maxlength="120"
      ></textarea>
      <br />
      <label for="logo">Logo :</label>
      <input type="file" id="logo" name="logo" />
      <div id="currentLogo"></div>
      <br />
      <input type="hidden" id="fkMemberId" name="fkMemberId" />
      <button type="submit">Update</button>
      &nbsp;
      <button type="reset">Reset</button>
    </form>

    <script>
      const companyNo = window.location.pathname.split("/").pop();

      // 산업 목록 가져오기
      async function fetchIndustryList() {
        const response = await fetch(`<%= ctxPath%>/api/industry/list`);
        const jsonData = await response.json();
        let html = "";
        jsonData.forEach((item) => {
          html += `<option value="\${item.industryName}">\${item.industryNo}</option>`;
        });
        document.getElementById("options").innerHTML = html;
      }

      // 회사 정보 가져오기
      async function fetchCompanyInfo() {
        try {
          // 회사 정보 가져오기
          const response = await fetch(
            `<%= ctxPath%>/api/company/dashboard/\${companyNo}`
          );
          const companyData = await response.json();

          // 폼 필드에 데이터 채우기
          document.getElementById("companyNo").value = companyData.companyNo;
          document.getElementById("memberId").value =
            companyData.member.member_id;
          document.getElementById("companyName").value =
            companyData.companyName;
          document.getElementById("companyWebsite").value =
            companyData.companyWebsite || "";
          document.getElementById("fkMemberId").value =
            companyData.member.member_id;
          // 산업 정보 설정
          const industryField = document.getElementById("industryName");
          if (companyData.industry) {
            industryField.value = companyData.industry.industryNo;
          }

          // 회사 크기 및 타입 설정
          if (companyData.companySize) {
            document.getElementById("companySize").value =
              companyData.companySize;
          }

          if (companyData.companyType) {
            document.getElementById("companyType").value =
              companyData.companyType;
          }

          // 회사 설명 설정
          document.getElementById("companyExplain").value =
            companyData.companyExplain || "";

          // 로고 정보 표시
          if (companyData.companyLogo) {
            const logoDiv = document.getElementById("currentLogo");
            logoDiv.innerHTML = `<p>현재 로고: ${companyData.companyLogo}</p>
                                <img src="<%= ctxPath%>/resources/images/company/${companyData.companyLogo}" 
                                     alt="회사 로고" style="max-width:200px; max-height:100px;" />`;
          }
        } catch (error) {
          console.error("회사 정보를 가져오는 중 오류 발생:", error);
          alert("회사 정보를 불러오는데 실패했습니다.");
        }
      }

      const form = document.getElementById("companyForm");
      async function submitForm(event) {
        event.preventDefault();

        const formData = new FormData(form);

        try {
          const response = await fetch(
            `<%= ctxPath%>/api/company/updateCompany`,
            {
              method: "PUT",
              body: formData,
            }
          );
          const jsonData = await response.json();
          console.log("Response JSON Data:", jsonData);

          if (response.status === 200) {
            alert("회사 정보가 성공적으로 업데이트되었습니다.");
            window.location.href = `<%= ctxPath%>/company/dashboard/\${companyNo}`;
          } else {
            alert("회사 정보 업데이트에 실패했습니다.");
          }
        } catch (error) {
          console.error("회사 정보 업데이트 중 오류 발생:", error);
          alert("회사 정보 업데이트에 실패했습니다.");
        }
      }

      form.addEventListener("submit", submitForm);

      // 초기화 함수 실행
      async function initialize() {
        await fetchIndustryList();
        await fetchCompanyInfo();
      }

      initialize();
    </script>
  </body>
</html>
