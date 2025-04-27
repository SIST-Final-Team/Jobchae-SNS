<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<jsp:include page="/WEB-INF/views/header/header.jsp" />
    <script src="https://cdn.tailwindcss.com"></script>
    <div class="max-w-7xl mx-auto md:flex text-lg">
      <div id="FormDiv" class="md:w-1/2 p-4">
        <div id="registeForm">
          *필수
          <form
            action="<%= ctxPath%>/api/company/registerCompany"
            method="post"
            class="bg-white border-2 rounded-xl p-4 mt-3"
            enctype="multipart/form-data"
          >
            <label for="companyName">이름* :</label><br />
            <input
              type="text"
              id="companyName"
              name="companyName"
              required
              placeholder="단체 이름을 입력하세요"
              class="w-full h-10 border border-black rounded p-3"
            /><br /><br />
            <label for="companyWebsite">Website :</label><br />
            <input
              type="text"
              id="companyWebsite"
              name="companyWebsite"
              placeholder="http://www.example.com"
              class="w-full h-10 border border-black rounded p-3"
            /><br /><br />
            <label for="industryName">업계* :</label><br />
<%--            <input--%>
<%--              list="options"--%>
<%--              id="industryName"--%>
<%--              name="industryName"--%>
<%--              placeholder="Software"--%>
<%--            />--%>
            <%-- 드롭다운의 표시를 가리기 위함--%>
            <style>
              details {
                list-style: none;
              }
              details > summary {
                list-style: none;
              }
              details > summary::-webkit-details-marker {
                display: none;
              }

              summary {
                outline: none;
              }
            </style>
            <!-- 업계 영역 -->
            <div id="industryDiv" class="relative mb-5">
              <input id="industryName" name="industryName" type="text" class="w-full h-10 border border-black rounded p-3">
              <!-- 선택 리스트 영역 -->
              <div id="listDiv" class="absolute border border-gray-600 bg-white w-full rounded hidden">
                <ul id="optionList" class="max-h-100 overflow-auto">
                  <li class="industryList border hover:bg-gray-200 h-10 leading-10 pl-2">1</li>
                  <li class="border hover:bg-gray-200 h-10 leading-10 pl-2">2</li>
                  <li class="border hover:bg-gray-200 h-10 leading-10 pl-2">3</li>
                  <li class="border hover:bg-gray-200 h-10 leading-10 pl-2">4</li>
                  <li class="border hover:bg-gray-200 h-10 leading-10 pl-2">5</li>
                  <li class="border hover:bg-gray-200 h-10 leading-10 pl-2">6</li>
                  <li class="border hover:bg-gray-200 h-10 leading-10 pl-2">7</li>
                  <li class="border hover:bg-gray-200 h-10 leading-10 pl-2">8</li>
                  <li class="border hover:bg-gray-200 h-10 leading-10 pl-2">9</li>
                  <li class="border hover:bg-gray-200 h-10 leading-10 pl-2">10</li>
                  <li class="border hover:bg-gray-200 h-10 leading-10 pl-2">11</li>
                </ul>
              </div>
            </div>

            <!-- 회사 규모 영역 -->
            <label for="companySize">단체 규모* :</label><br />
            <select id="companySize" name="companySize" class="w-full h-10 border border-black rounded p-1">
              <option value="0">규모 선택</option>
              <option value="1">0-1</option>
              <option value="2">2-10</option>
              <option value="3">11-50</option>
              <option value="4">51-200</option>
              <option value="5">201-500</option>
              <option value="6">501-1000</option>
              <option value="7">1001-5000</option>
              <option value="8">5001-10000</option>
              <option value="9">10000+</option></select
            ><br /><br />
            <label for="companyType">단체 종류* :</label><br />
            <select id="companyType" name="companyType" class="w-full h-10 border border-black rounded p-1">
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
              class = "w-full h-32 border-2 border-gray-300 rounded-lg p-2"
              placeholder="회사의 설명을 간단히 적어주세요"
            ></textarea
            ><br /><br />
            <div class="max-w-md mx-auto bg-whit p-6 rounded-lg shadow-md">
              <!-- 1. 로고 라벨 -->
              <label class="block text-sm font-medium text-gray-700 mb-1">
                로고
              </label>

              <!-- 2. 파일 업로드 및 미리보기 영역 컨테이너 -->
              <div class="file-uploader-container">
                <!-- 2a. 초기 파일 선택 영역 (Label 역할) -->
                <label
                        for="logo-upload"
                        id="upload-area"
                        class="flex flex-col items-center justify-center w-full h-20 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100 p-4 text-center"
                >
                  <div class="flex items-center justify-center gap-2">
                    <!-- flex-col 제거하고 gap-2 추가 -->
                    <!-- 아이콘 -->
                    <svg
                            class="w-6 h-6 text-gray-400"
                            fill="none"
                            stroke="currentColor"
                            viewBox="0 0 24 24"
                            xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              stroke-width="2"
                              d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                      ></path>
                    </svg>
                    <!-- 텍스트 -->
                    <div class="text-center">
                      <span class="text-lg font-semibold text-gray-600"
                      >파일 선택</span
                      >
                      <p class="text-sm text-gray-500">업로드해서 미리보기</p>
                    </div>
                  </div>
                </label>

                <!-- 2b. 파일 선택 후 보여줄 미리보기 영역 (처음엔 hidden) -->
                <div
                        id="preview-area"
                        class="hidden flex items-center w-full p-3 border border-gray-300 rounded-lg bg-white shadow-sm mt-4"
                >
                  <!-- 썸네일 이미지 -->
                  <img
                          id="thumbnail-preview"
                          src="#"
                          alt="미리보기"
                          class="w-16 h-16 object-cover rounded mr-3 flex-shrink-0"
                  />
                  <!-- 파일 정보 -->
                  <div class="file-info flex-grow overflow-hidden mr-2">
                    <span
                            id="file-name"
                            class="block text-sm font-medium text-gray-900 truncate"
                    >파일이름.jpg</span
                    >
                    <span id="file-size" class="block text-xs text-gray-500"
                    >00KB</span
                    >
                  </div>
                  <!-- 삭제 버튼 -->
                  <button
                          type="button"
                          id="delete-button"
                          class="ml-auto text-gray-400 hover:text-gray-600 cursor-pointer text-2xl p-1 focus:outline-none flex-shrink-0"
                  >
                    ×
                    <!-- HTML 엔티티 '×' 사용 -->
                  </button>
                </div>

                <!-- 2c. 숨겨진 실제 파일 입력 필드 -->
                <input
                        name="company_logo"
                        id="logo-upload"
                        type="file"
                        class="hidden"
                        accept="image/jpeg, image/png"
                        enc
                />
              </div>

              <!-- 3. 안내 문구 -->
              <p class="mt-2 text-xs text-gray-500">
                300 x 300픽셀 권장. 지원되는 형식은 JPG, JPEG, PNG입니다.
              </p>
            </div>
            <!-- <label for="logo">Logo :</label><br />
            <input type="file" id="logo" name="logo" /><br /><br /> -->
            <!-- 제출 버튼 -->
            <button type="submit">페이지 만들기</button>
          </form>
        </div>
      </div>

      <!-- 페이지 미리보기 영역 -->
      <div class="md:w-1/2 p-4">
        <div class="p4 border-2 mt-8 rounded-xl overflow-hidden">
          <div class="p-4">페이지 미리보기</div>
          <div class="bg-stone-400 p-4">미리보기 내용</div>
        </div>
      </div>
    </div>
</body>

<script>const contextPath = "<%= ctxPath%>";</script>
<script src="${pageContext.request.contextPath}/js/company/companyForm.js"></script>
</html>
