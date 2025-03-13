<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/header/header.jsp" />

<%--<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/feed/board.css" />--%>
    <div class="max-w-6xl mx-auto flex flex-col lg:flex-row">
      <!-- Left Sidebar -->
      <div class="w-full lg:w-1/4 p-4">
        <div class="bg-white rounded-lg shadow mb-4 overflow-hidden">
          <div class="bg-gray-300 h-16"></div>
          <div class="p-4 text-center border-b border-gray-200">
            <div class="relative inline-block">
              <img
                src="/api/placeholder/60/60"
                alt="Profile"
                class="w-16 h-16 rounded-full border-4 border-white -mt-10 mx-auto"
              />
            </div>
            <h2 class="text-lg font-bold mt-2">연규영</h2>
            <p class="text-sm text-gray-600">프로그래머를 희망합니다</p>
            <p class="text-sm text-gray-500">대한민국</p>
          </div>
          <div class="p-3">
            <button
              class="flex items-center justify-center w-full py-1.5 border border-gray-300 rounded text-sm font-medium text-gray-700 hover:bg-gray-50"
            >
              <i class="fas fa-plus mr-2"></i> 경력
            </button>
          </div>
        </div>

        <div class="bg-white rounded-lg shadow">
          <div class="p-4">
            <h3 class="font-medium mb-2">알림 관리</h3>
            <a href="#" class="text-blue-600 text-sm font-medium">설정 보기</a>
          </div>
        </div>
      </div>

      <!-- Main Content -->
      <div class="w-full lg:w-2/4 p-4">
        <!-- Filter Pills -->
        <div class="bg-white rounded-lg shadow mb-4 p-3">
          <div class="flex space-x-2 overflow-x-auto pb-2">
            <button
              class="button-selected"
            >
              전체
            </button>
            <button
              class="button-gray"
            >
              채용공고
            </button>
            <button
              class="button-gray"
            >
              나의 업데이트
            </button>
            <button
              class="button-gray"
            >
              태그
            </button>
          </div>
        </div>

        <!-- Notification Item 1 -->
        <div class="bg-white rounded-lg shadow mb-4 overflow-hidden">
          <div class="border-b border-gray-100 p-4 flex">
            <div class="flex-shrink-0 mr-3">
              <div
                class="bg-blue-50 w-10 h-10 rounded flex items-center justify-center"
              >
                <i class="fas fa-chart-bar text-blue-500"></i>
              </div>
            </div>
            <div class="flex-grow">
              <p class="text-sm">
                회원님의 업데이트 노출수가 지난 주 14회였습니다. 분석 보기
              </p>
              <p class="text-xs text-gray-500 mt-1">2시간</p>
            </div>
            <div class="flex-shrink-0">
              <button class="text-gray-500 hover:text-gray-700">
                <i class="fas fa-ellipsis-h"></i>
              </button>
            </div>
          </div>
        </div>

        <!-- Notification Item 2 - NAVER
        <div class="bg-white rounded-lg shadow mb-4 overflow-hidden">
          <div class="border-b border-gray-100 p-4 flex">
            <div class="flex-shrink-0 mr-3">
              <img
                src="/api/placeholder/40/40"
                alt="NAVER"
                class="w-10 h-10 rounded"
              />
            </div>
            <div class="flex-grow">
              <p class="text-sm">
                <span class="font-bold">NAVER Corp</span>에서 동영상을 올림:
                NAVER Careers | 2025 팀네이버 신입 공채 지원서 접수 마감까지
                D-7⏰ 지원서 접수 마감까지 D-7! Be the Navigator! 커리어의 시작,
                팀네이버에서 ✓ 팀네이버 ...
              </p>
              <p class="text-xs text-gray-500 mt-1">1일</p>
            </div>
            <div class="flex-shrink-0">
              <button class="text-gray-500 hover:text-gray-700">
                <i class="fas fa-ellipsis-h"></i>
              </button>
            </div>
          </div>
        </div>
        -->
        <!-- Notification Item 3 - NVIDIA -->
        <!-- <div class="bg-white rounded-lg shadow mb-4 overflow-hidden">
          <div class="border-b border-gray-100 p-4 flex">
            <div class="flex-shrink-0 mr-3">
              <img
                src="/api/placeholder/40/40"
                alt="NVIDIA"
                class="w-10 h-10 rounded"
              />
            </div>
            <div class="flex-grow">
              <p class="text-sm">
                <span class="font-bold">NVIDIA AI</span>에 대해 자세히 알아보고
                블로우헬만 다른 페이지를 발견해 보세요.
              </p>
              <p class="text-xs text-gray-500 mt-1">2일</p>
            </div>
            <div class="flex-shrink-0">
              <button class="text-gray-500 hover:text-gray-700">
                <i class="fas fa-ellipsis-h"></i>
              </button>
            </div>
          </div>
        </div> -->

        <!-- Notification Item 4 - Intel -->
        <!-- <div class="bg-white rounded-lg shadow mb-4 overflow-hidden">
          <div class="border-b border-gray-100 p-4 flex">
            <div class="flex-shrink-0 mr-3">
              <img
                src="/api/placeholder/40/40"
                alt="Intel"
                class="w-10 h-10 rounded"
              />
            </div>
            <div class="flex-grow">
              <p class="text-sm">
                <span class="font-bold">Intel</span>의 트렌딩 업데이트: Our
                employees are incredibly hardworking, resilient and innovative.
                Today, we acknowledge their dedication and everything they do
                for Intel - thanks to yo...
              </p>
              <p class="text-xs text-gray-500 mt-1">2일</p>
            </div>
            <div class="flex-shrink-0">
              <button class="text-gray-500 hover:text-gray-700">
                <i class="fas fa-ellipsis-h"></i>
              </button>
            </div>
          </div>
        </div> -->

        <!-- Notification Item 5 - Intel AI -->
        <!-- <div class="bg-white rounded-lg shadow mb-4 overflow-hidden">
          <div class="border-b border-gray-100 p-4 flex">
            <div class="flex-shrink-0 mr-3">
              <img
                src="/api/placeholder/40/40"
                alt="Intel"
                class="w-10 h-10 rounded"
              />
            </div>
            <div class="flex-grow">
              <p class="text-sm">
                <span class="font-bold">Intel</span>의 트렌딩 업데이트: #AI is
                transforming the PC as we know it. How is #IntelCoreUltra
                helping to build the #AI ecosystem while driving PC industry
                innovation? 💻 Learn more in our...
              </p>
              <div class="flex items-center text-xs text-gray-500 mt-2">
                <span>반응 58</span>
                <span class="mx-2">•</span>
                <span>댓글 5</span>
              </div>
              <p class="text-xs text-gray-500 mt-1">3일</p>
            </div>
            <div class="flex-shrink-0">
              <button class="text-gray-500 hover:text-gray-700">
                <i class="fas fa-ellipsis-h"></i>
              </button>
            </div>
          </div>
        </div> -->

        <!-- Notification Item 6 - Connection -->
        <!-- <div class="bg-white rounded-lg shadow mb-4 overflow-hidden">
          <div class="border-b border-gray-100 p-4 flex">
            <div class="flex-shrink-0 mr-3">
              <img
                src="/api/placeholder/40/40"
                alt="Zikrulla"
                class="w-10 h-10 rounded-full"
              />
            </div>
            <div class="flex-grow">
              <p class="text-sm">
                <span class="font-bold">Zikrulla Rakhmatov</span> 님을 아세요?
                1촌 신청을 보내보세요.
              </p>
              <p class="text-xs text-gray-600 mt-1">AI Engineer</p>
              <p class="text-xs text-gray-500 mt-1">3일</p>
            </div>
            <div class="flex-shrink-0">
              <button class="text-gray-500 hover:text-gray-700">
                <i class="fas fa-ellipsis-h"></i>
              </button>
            </div>
          </div>
        </div> -->

        <!-- Notification Item 7 - OpenAI -->
        <!-- <div class="bg-white rounded-lg shadow mb-4 overflow-hidden">
          <div class="border-b border-gray-100 p-4 flex">
            <div class="flex-shrink-0 mr-3">
              <img
                src="/api/placeholder/40/40"
                alt="OpenAI"
                class="w-10 h-10 rounded"
              />
            </div>
            <div class="flex-grow">
              <p class="text-sm">
                <span class="font-bold">OpenAI</span>의 인기 게시물에 댓글을
                남겨 페이지 도달 범위 넓히기: Great day to be a Plus and Team
                user! GPT-4.5 is now rolled out to all Plus and Team users.
              </p>
              <div class="flex items-center text-xs text-gray-500 mt-2">
                <span>반응 4,283</span>
                <span class="mx-2">•</span>
                <span>댓글 547</span>
              </div>
              <p class="text-xs text-gray-500 mt-1">3일</p>
            </div>
            <div class="flex-shrink-0">
              <button class="text-gray-500 hover:text-gray-700">
                <i class="fas fa-ellipsis-h"></i>
              </button>
            </div>
          </div>
        </div> -->
      </div>

      <!-- Right Sidebar -->
      <div class="w-full lg:w-1/4 p-4">
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
            <a href="#" class="mr-4 mb-2 hover:underline"
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
  </body>
</html>
