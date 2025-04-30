<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<jsp:include page="/WEB-INF/views/header/header.jsp" />
<style>
  /* 추가적인 커스텀 스타일 (필요한 경우) */
  body {
    background-color: #f4f2ee; /* LinkedIn 배경색과 유사하게 설정 */
  }
  .card {
    background-color: white;
    border-radius: 0.5rem; /* rounded-lg */
    border: 1px solid #e0e0e0; /* 테두리 추가 */
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1),
      0 1px 2px 0 rgba(0, 0, 0, 0.06); /* 그림자 효과 */
    overflow: hidden; /* 내부 요소가 카드를 벗어나지 않도록 */
  }
</style>
<div class="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-5 gap-6 mt-6">
  <!-- 사이드바 -->
  <div class="md:col-span-1 space-y-6 text-lg">
    <div class="card">
      <div class="relative mb-10">
        <div class="w-full h-25">
          <img
            src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg"
            alt="LinkedIn 배경 이미지"
            class="w-full h-full"
          />
        </div>
        <div
          class="absolute -bottom-7 left-4 w-16 h-16 border-2 border-gray-300 rounded-lg"
        >
          <img
            src="<%= ctxPath%>/images/no_company_logo.JPG"
            alt="프로필 이미지"
          />
        </div>
      </div>
      <h2 class="font-semibold pl-4">쌍용 파이널 테스트</h2>
      <button class="text-sm text-blue-600 hover:underline pl-4">
        회원 모드로 보기
      </button>
      <ul class="mt-5">
        <li
              class="menuList py-2 font-semibold text-gray-700 hover:bg-gray-100 rounded px-2 cursor-pointer"
              data-url="dashboard"
            >
              대시보드
            </li>
            <li
              class="menuList py-2 text-gray-700 hover:bg-gray-100 rounded px-2 cursor-pointer"
              data-url="post"
            >
              페이지 게시물
            </li>
            <li
              class="menuList py-2 text-gray-700 hover:bg-gray-100 rounded px-2 cursor-pointer"
              data-url="analytics"
            >
              분석
            </li>
            <li
              class="menuList py-2 text-gray-700 hover:bg-gray-100 rounded px-2 cursor-pointer"
              data-url="feed"
            >
              피드
            </li>
            <li
              class="menuList py-2 text-gray-700 hover:bg-gray-100 rounded px-2 cursor-pointer"
              data-url="activity"
            >
              활동
            </li>
            <li
              class="menuList py-2 text-gray-700 hover:bg-gray-100 rounded px-2 cursor-pointer"
              data-url="message"
            >
              수신함
            </li>
            <li
              class="menuList py-2 text-gray-700 hover:bg-gray-100 rounded px-2 cursor-pointer"
              data-url="pageContent"
            >
              페이지 내용 변경
            </li>
            <li
              class="menuList py-2 text-gray-700 hover:bg-gray-100 rounded px-2 cursor-pointer"
              data-url="hiring"
            >
              채용 공고
            </li>
            <li
              class="menuList py-2 text-gray-700 hover:bg-gray-100 rounded px-2 cursor-pointer"
              data-url="premium"
            >
              프리미엄 페이지 사용
            </li>
            <li
              class="menuList py-2 text-gray-700 hover:bg-gray-100 rounded px-2 cursor-pointer"
              data-url="advertisement"
            >
              광고
            </li>
            <li
              class="menuList py-2 text-gray-700 hover:bg-gray-100 rounded px-2 cursor-pointer"
              data-url="setting"
            >
              설정
            </li>
      </ul>
    </div>
  </div>
  <!-- 메인 -->
  <div class="md:col-span-4 space-y-6">
    <div class="card p-4 space-y-3">
      <h2 class="text-lg font-semibold text-gray-800">오늘의 작업</h2>
      <p class="text-sm text-gray-600">
        이러한 작업을 정기적으로 완료하는 페이지는 4배 더 빠르게 성장합니다.
      </p>
      <div class="border rounded-lg p-3 flex justify-between items-center">
        <div>
          <h3 class="font-semibold text-gray-700">웹사이트 URL 추가</h3>
          <p class="text-sm text-gray-500">
            URL을 추가하여 더 많은 페이지 방문자를 웹사이트로 유도하세요.
          </p>
        </div>
        <button class="text-gray-400 hover:text-gray-600">
          <i class="fas fa-times"></i>
        </button>
      </div>
      <div class="border rounded-lg p-3 flex justify-between items-center">
        <div>
          <h3 class="font-semibold text-gray-700">업무 설명 추가</h3>
          <p class="text-sm text-gray-500">
            검색 결과에서 페이지가 발견되도록 간단한 설명을 추가하세요.
          </p>
        </div>
        <button class="text-gray-400 hover:text-gray-600">
          <i class="fas fa-times"></i>
        </button>
      </div>
      <button
        class="mt-2 w-full bg-blue-600 text-white py-2 rounded-full hover:bg-blue-700 transition duration-150 font-semibold"
      >
        + 만들기
      </button>
    </div>

    <div class="card p-4">
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-lg font-semibold text-gray-800">
          최근 게시물 관리
        </h2>
        <div class="flex items-center space-x-2 text-gray-500">
          <button class="hover:text-gray-700">
            <i class="fas fa-chevron-left"></i>
          </button>
          <button class="hover:text-gray-700">
            <i class="fas fa-chevron-right"></i>
          </button>
        </div>
      </div>
      <p class="text-sm text-gray-600 mb-4">
        페이지의 콘텐츠를 관리하고 스폰서하여 도달 범위를 넓히세요.
        <a href="#" class="text-blue-600 hover:underline">자세히 보기</a>
      </p>

      <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <div class="border rounded-lg overflow-hidden">
          <div class="p-3">
            <p class="text-xs text-gray-500 mb-1">
              스폰서 업데이트로 노출 수 77,000회 더 늘리세요.
            </p>
            <button
              class="bg-blue-100 text-blue-700 text-xs font-semibold px-2 py-1 rounded-full hover:bg-blue-200"
            >
              스폰서
            </button>
          </div>
          <div class="bg-gray-100 p-3">
            <div class="flex items-center mb-2">
              <div class="w-8 h-8 bg-gray-400 rounded-full mr-2"></div>
              <span class="font-semibold text-sm">쌍용 파이널 테스트</span>
            </div>
            <p class="text-sm mb-2">게시물 테스트</p>
            <img
              src="https://placehold.co/300x150/e2e8f0/94a3b8?text=[%EC%9D%B4%EB%AF%B8%EC%A7%80]"
              alt="게시물 이미지"
              class="w-full h-32 object-cover rounded"
            />
          </div>
          <div class="p-3 flex justify-between text-xs text-gray-500">
            <span><i class="far fa-thumbs-up"></i> 0</span>
            <span><i class="far fa-comment"></i> 0</span>
          </div>
        </div>
        <div class="border rounded-lg overflow-hidden">
          <div class="p-3">
            <p class="text-xs text-gray-500 mb-1">
              스폰서 업데이트로 노출 수 77,000회 더 늘리세요.
            </p>
            <button
              class="bg-blue-100 text-blue-700 text-xs font-semibold px-2 py-1 rounded-full hover:bg-blue-200"
            >
              스폰서
            </button>
          </div>
          <div class="bg-gray-100 p-3">
            <div class="flex items-center mb-2">
              <div class="w-8 h-8 bg-gray-400 rounded-full mr-2"></div>
              <span class="font-semibold text-sm">쌍용 파이널 테스트</span>
            </div>
            <p class="text-sm mb-2">테스트 입니다</p>
          </div>
          <div class="p-3 flex justify-between text-xs text-gray-500">
            <span><i class="far fa-thumbs-up"></i> 0</span>
            <span><i class="far fa-comment"></i> 0</span>
          </div>
        </div>
      </div>
      <button
        class="mt-4 text-blue-600 hover:underline text-sm font-semibold w-full text-center py-2"
      >
        모두 표시
      </button>
    </div>

    <div class="card p-4">
      <h2 class="text-lg font-semibold text-gray-800 mb-4">실적 파악</h2>
      <p class="text-sm text-gray-600 mb-4">
        지난 7일 활동을 활용하여 페이지를 최적화하세요.
      </p>
      <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 text-center">
        <div>
          <p class="text-2xl font-bold text-blue-600">7</p>
          <p class="text-sm text-gray-600">검색 결과 노출</p>
          <p class="text-xs text-green-600">+38% 지난 7일</p>
        </div>
        <div>
          <p class="text-2xl font-bold text-blue-600">0</p>
          <p class="text-sm text-gray-600">새 팔로워</p>
          <p class="text-xs text-gray-500">-</p>
        </div>
        <div>
          <p class="text-2xl font-bold text-blue-600">11</p>
          <p class="text-sm text-gray-600">게시물 노출</p>
          <p class="text-xs text-red-600">-91.5% 지난 7일</p>
        </div>
        <div>
          <p class="text-2xl font-bold text-blue-600">2</p>
          <p class="text-sm text-gray-600">페이지 방문자</p>
          <p class="text-xs text-gray-500">-</p>
        </div>
      </div>
    </div>

    <div class="card p-4">
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-lg font-semibold text-gray-800">대화 참여</h2>
        <div class="flex items-center space-x-2 text-gray-500">
          <button class="hover:text-gray-700">
            <i class="fas fa-chevron-left"></i>
          </button>
          <button class="hover:text-gray-700">
            <i class="fas fa-chevron-right"></i>
          </button>
        </div>
      </div>
      <p class="text-sm text-gray-600 mb-4">
        최근 대화에 참여하여 브랜드 인지도와 커뮤니티를 구축하세요.
      </p>
      <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div class="border rounded-lg overflow-hidden">
          <div class="p-3">
            <div class="flex items-center mb-2">
              <div
                class="w-8 h-8 bg-green-500 rounded-sm mr-2 flex items-center justify-center text-white font-bold"
              >
                N
              </div>
              <span class="font-semibold text-sm">NVIDIA AI</span>
            </div>
            <p class="text-sm mb-2">
              Register for the NVIDIA Agent Toolkit Hackathon
              <a href="#" class="text-blue-600 hover:underline">더보기</a>
            </p>
            <img
              src="https://placehold.co/300x150/dbeafe/3b82f6?text=[%ED%94%BC%EB%93%9C+%EC%9D%B4%EB%AF%B8%EC%A7%80+1]"
              alt="피드 이미지 1"
              class="w-full h-32 object-cover rounded"
            />
          </div>
          <div
            class="p-3 flex justify-between text-xs text-gray-500 border-t"
          >
            <span><i class="far fa-thumbs-up"></i> 0</span>
            <span><i class="far fa-comment"></i> 0</span>
          </div>
        </div>
        <div class="border rounded-lg overflow-hidden">
          <div class="p-3">
            <div class="flex items-center mb-2">
              <div
                class="w-8 h-8 bg-green-500 rounded-sm mr-2 flex items-center justify-center text-white font-bold"
              >
                N
              </div>
              <span class="font-semibold text-sm">NVIDIA AI</span>
            </div>
            <p class="text-sm mb-2">
              Kaggle Grandmaster Pro Tips: Learn how Chris Deotte won 1st
              place in Kaggle's Playground Backpack Price...
              <a href="#" class="text-blue-600 hover:underline">더보기</a>
            </p>
            <img
              src="https://placehold.co/300x150/d1fae5/10b981?text=[%ED%94%BC%EB%93%9C+%EC%9D%B4%EB%AF%B8%EC%A7%80+2]"
              alt="피드 이미지 2"
              class="w-full h-32 object-cover rounded"
            />
          </div>
          <div
            class="p-3 flex justify-between text-xs text-gray-500 border-t"
          >
            <span><i class="far fa-thumbs-up"></i> 0</span>
            <span><i class="far fa-comment"></i> 0</span>
          </div>
        </div>
        <div class="border rounded-lg overflow-hidden">
          <div class="p-3">
            <div class="flex items-center mb-2">
              <div
                class="w-8 h-8 bg-green-500 rounded-sm mr-2 flex items-center justify-center text-white font-bold"
              >
                N
              </div>
              <span class="font-semibold text-sm">NVIDIA AI</span>
            </div>
            <p class="text-sm mb-2">
              Protein misfolding is often implicated in disease due to
              the...
              <a href="#" class="text-blue-600 hover:underline">더보기</a>
            </p>
          </div>
          <div
            class="p-3 flex justify-between text-xs text-gray-500 border-t"
          >
            <span><i class="far fa-thumbs-up"></i> 0</span>
            <span><i class="far fa-comment"></i> 0</span>
          </div>
        </div>
      </div>
      <button
        class="mt-4 text-blue-600 hover:underline text-sm font-semibold w-full text-center py-2"
      >
        피드 표시
      </button>
    </div>
  </div>
</div>
<script>const contextPath = "<%= ctxPath%>";</script>
<script src = "<%= ctxPath%>/js/company/companyHomeRouter.js"></script>
</body>
</html>