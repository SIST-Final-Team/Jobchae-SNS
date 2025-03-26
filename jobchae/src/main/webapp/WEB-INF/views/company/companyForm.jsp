<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<jsp:include page="/WEB-INF/views/header/header.jsp" />
    <script src="https://cdn.tailwindcss.com"></script>
    <div class="max-w-6xl mx-auto md:flex text-sm">
      <div id="FormDiv" class="md:w-1/2 p-4">
        <div id="registeForm">
          *필수
          <form
            action="<%= ctxPath%>/api/company/registerCompany"
            method="post"
            class="bg-white border-2 rounded-xl p-4 mt-3"
          >
            <label for="companyName">이름* :</label><br />
            <input
              type="text"
              id="companyName"
              name="companyName"
              required
              placeholder="단체 이름을 입력하세요"
            /><br /><br />
            <label for="companyWebsite">Website :</label><br />
            <input
              type="text"
              id="companyWebsite"
              name="companyWebsite"
              placeholder="http://www.example.com"
            /><br /><br />
            <label for="industryName">업계* :</label><br />
            <input
              list="options"
              id="industryName"
              name="industryName"
              placeholder="Software"
            />
            <datalist id="options"></datalist><br /><br />
            <label for="companySize">단체 규모* :</label><br />
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
              <option value="10">10000+</option></select
            ><br /><br />
            <label for="companyType">단체 종류* :</label><br />
            <select id="companyType" name="companyType">
              <option value="1">종류 선택</option>
              <option value="2">Private</option>
              <option value="3">Government</option>
              <option value="4">Nonprofit</option>
              <option value="5">Educational</option>
              <option value="6">Self-Employed</option>
              <option value="7">Partnership</option>
              <option value="8">Sole Proprietorship</option></select
            ><br /><br />
            <label for="companyExplain">Company Explain :</label><br />
            <textarea
              id="companyExplain"
              name="companyExplain"
              maxlength="120"
            ></textarea
            ><br /><br />
            <label for="logo">Logo :</label><br />
            <input type="file" id="logo" name="logo" /><br /><br />
            <!-- 제출 버튼 -->
            <button type="submit">페이지 만들기</button>
          </form>
        </div>
      </div>
      <div class="md:w-1/2 p-4">
        <div class="p4 border-2 mt-8 rounded-xl overflow-hidden">
          <div class="p-4">페이지 미리보기</div>
          <div class="bg-stone-400 p-4">미리보기 내용</div>
        </div>
      </div>
    </div>
  </body>
</html>
