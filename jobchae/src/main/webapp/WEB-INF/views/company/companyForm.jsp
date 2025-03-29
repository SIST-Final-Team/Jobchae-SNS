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
            <input id="industryName" type="text" class="border w-full">
            <details id = "option">
              <summary></summary>
              <ol>
                <li>1</li>
                <li>2</li>
                <li>3</li>
              </ol>
            </details>
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
      <div class="md:w-1/2 p-4">
        <div class="p4 border-2 mt-8 rounded-xl overflow-hidden">
          <div class="p-4">페이지 미리보기</div>
          <div class="bg-stone-400 p-4">미리보기 내용</div>
        </div>
      </div>
    </div>
</body>

<script>
  const fileInput = document.getElementById("logo-upload");
  const uploadArea = document.getElementById("upload-area");
  const previewArea = document.getElementById("preview-area");
  const thumbnailPreview = document.getElementById("thumbnail-preview");
  const fileNameSpan = document.getElementById("file-name");
  const fileSizeSpan = document.getElementById("file-size");
  const deleteButton = document.getElementById("delete-button");

  // 파일 입력(input) 값이 변경되었을 때 실행될 함수
  fileInput.addEventListener("change", function (event) {
    const file = event.target.files[0]; // 선택된 파일 가져오기

    if (file) {
      // 파일이 선택되었다면
      // 파일 정보 읽기
      const reader = new FileReader();

      reader.onload = function (e) {
        // 썸네일 이미지 설정
        thumbnailPreview.src = e.target.result;

        // 파일 이름 설정
        fileNameSpan.textContent = file.name;

        // 파일 크기 설정 (KB 단위, 소수점 1자리)
        const fileSizeKB = (file.size / 1024).toFixed(1);
        fileSizeSpan.textContent = `${fileSizeKB}KB`;

        // 영역 전환: 초기 영역 숨기고 미리보기 영역 보여주기
        uploadArea.classList.add("hidden"); // Tailwind hidden 클래스 추가
        previewArea.classList.remove("hidden"); // Tailwind hidden 클래스 제거
        previewArea.classList.add("flex"); // display: flex 활성화 (Tailwind)
      };

      // 파일을 읽어서 Data URL 형태로 변환
      reader.readAsDataURL(file);
    }
  });

  // 삭제 버튼(X) 클릭 시 실행될 함수
  deleteButton.addEventListener("click", function () {
    // 파일 입력 필드 값 초기화
    fileInput.value = null;

    // 썸네일 이미지 초기화 (선택 사항)
    thumbnailPreview.src = "#"; // 빈 값 또는 기본 이미지 경로

    // 영역 전환: 미리보기 영역 숨기고 초기 영역 보여주기
    previewArea.classList.add("hidden"); // Tailwind hidden 클래스 추가
    previewArea.classList.remove("flex"); // display: flex 비활성화
    uploadArea.classList.remove("hidden"); // Tailwind hidden 클래스 제거
  });

  //업종 키입력시 업종 리스트 보여주기
    const industryOptions = document.getElementById("option");
    const industryName = document.getElementById("industryName");
    //업종 리스트 보여주기

    industryName.addEventListener("change", function (e) {

    })
</script>
</html>
