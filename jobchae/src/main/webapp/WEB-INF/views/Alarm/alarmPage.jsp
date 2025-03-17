<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<jsp:include page="/WEB-INF/views/header/header.jsp" />

<style>
  /* summary 요소 자체의 기본 마커 숨기기 */
  details > summary {
    list-style: none;
  }
</style>
<%--<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/feed/board.css" />--%>
    <div class="max-w-6xl mx-auto flex flex-col lg:flex-row">
      <!-- Left Sidebar -->
      <div class="w-full lg:w-1/4 p-4">
        <div class="left-side col-span-3 hidden md:block h-full relative">
          <div class="border-normal sticky top-20">

            <div class="h-20 relative" style="background-image: url('<%= ctxPath%>/resources/files/profile/${sessionScope.loginuser.member_background_img}'); background-size: cover; background-position: center;"></div>

            <div class="flex flex-col items-center p-4 -mt-10">
              <img src="${pageContext.request.contextPath}/resources/files/profile/${sessionScope.loginuser.member_profile}" alt="프로필 이미지" class="w-20 h-20 rounded-full border-2 border-white relative">
              <h2 class="text-lg font-semibold mt-2">${sessionScope.loginuser.member_name}</h2>
            </div>

          </div>
        </div>
      </div>

      <!-- Main Content -->
      <div class="w-full lg:w-2/4 p-4">
        <!-- Filter Pills -->
        <div class="bg-white rounded-lg shadow mb-4 p-3">
          <div class="flex space-x-2 overflow-x-auto pb-2">
            <button
              class="button-selected filterButton"
              data-type = "all"
            >
              전체
            </button>
            <button
              class="button-gray filterButton"
              data-type = "comment"
            >
              댓글
            </button>
            <button
              class="button-gray filterButton"
              data-type = "like"
            >
              좋아요
            </button>
            <button
              class="button-gray filterButton"
              data-type = "followPost"
            >
              팔로워 게시물
            </button>
          </div>
        </div>

        <!-- Notification Item 1 -->
        <div id="alarmLists"></div>
      </div>

      <!-- Right Sidebar -->
      <div
              id="rightSideDiv"
              class="w-full lg:w-1/4 p-4 lg:sticky top-0 static h-fit"
      >
        <!-- Ad Section -->
        <div class="bg-white rounded-lg shadow mb-4 overflow-hidden">
          <img
                  src="/api/placeholder/300/150"
                  alt="LinkedIn Ad"
                  class="w-full h-auto"
          />
          <div class="p-4">
            <h3 class="font-bold text-lg">See who's hiring on LinkedIn.</h3>
          </div>
        </div>

        <!-- Footer Links -->
        <div class="px-4">
          <div class="flex flex-wrap text-xs text-gray-500 mb-2">
            <a href="#" class="mr-4 mb-2 hover:underline">회사소개</a>
            <a href="#" class="mr-4 mb-2 hover:underline">접근성</a>
            <a href="#" class="mr-4 mb-2 hover:underline">고객센터</a>
          </div>
          <div class="flex flex-wrap text-xs text-gray-500 mb-2">
            <a href="#" class="mr-4 mb-2 hover:underline">개인정보와 약관</a>
            <span class="mr-4 mb-2">•</span>
            <a href="#" class="mr-4 mb-2 hover:underline">Ad Choices</a>
          </div>
          <div class="flex flex-wrap text-xs text-gray-500 mb-2">
            <a href="#" class="mr-4 mb-2 hover:underline">광고</a>
            <span class="mr-4 mb-2">•</span>
            <a href="#" class="mr-4 mb-2 hover:underline">비즈니스 서비스</a>
            <span class="mr-4 mb-2">•</span>
          </div>
          <div class="flex flex-wrap text-xs text-gray-500 mb-2">
            <a href="#" class="w-mr-4 mb-2 hover:underline"
            >LinkedIn 앱 다운로드</a
            >
            <a href="#" class="mr-4 mb-2 hover:underline">더 보기</a>
          </div>

          <div class="flex items-center mt-4 text-xs text-gray-500">
            <span class="font-bold text-blue-600">LinkedIn</span>
            <span class="ml-1">LinkedIn Corporation © 2025년</span>
          </div>
        </div>
      </div>
    </div>
  <script src="${pageContext.request.contextPath}/js/alarm/alarmMainDesign.js"></script>
  <script src="${pageContext.request.contextPath}/js/alarm/alarmMain.js"></script>
</body>
</html>

