<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="<%=ctxPath%>/css/tailwind.css" />
    <%-- Optional JavaScript --%>
      <script
      type="text/javascript"
      src="<%=ctxPath%>/js/jquery-3.7.1.min.js"
    ></script>
    <script
      type="text/javascript"
      src="<%=ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js"
    ></script>

    <script
      type="text/javascript"
      src="<%=ctxPath%>/js/main-header/header.js"
    ></script>

    <%-- 검색 --%>
    
    <script
      type="text/javascript"
    >
      let ctxPathForSearch = "<%=ctxPath%>";
    </script>
    <script
      type="text/javascript"
      src="<%=ctxPath%>/js/main-header/search.js"
    ></script>
  </head>
  <body class="bg-stone-100">
    <nav
      class="w-full h-15 bg-white border-b-1 border-gray-300 sticky top-0 flex justify-center z-999"
    >
      <div class="h-full text-center flex">
        <!-- 로고 -->
        <div class="h-full flex-1 text-left md:mr-8 lg:mr-0">
          <a href="" class="h-full w-20">
            <img
              src="${pageContext.request.contextPath}/images/LinkedIn_icon.svg"
              class="h-3/4 mt-1.5 object-contain"
          /></a>
        </div>
        <!-- 검색상자 -->
        <div id="searchBox" class="h-9 ml-4 mt-2 h-full text-left hidden lg:block lg:w-70! xl:w-[24rem]! xl:mr-33">
          <div id="searchInput" class="flex rounded-sm h-3/4">
            <div id="SearchIconDiv" class="h-full flex items-center! justify-center"><i class="fa-solid fa-magnifying-glass"></i></div>
            <div id="SearchInputDiv" class="h-full flex items-center!">
            <form name="searchForm">
              <input
                type="text"
                name="searchWord"
                placeholder="검색"
                class="h-full"
                value="${requestScope.searchWord}"
                autocomplete="off"
              />
            </form>
            </div>
          </div>
          <div id="SearchResultBox" class="hidden rounded-md">
            <!-- 검색 메뉴 -->
            <div id="searchBoxMenu" class="flex text-sm SearchBoxDropDown mt-2">
              <div class="SearchBoxDropDown w-15/20 text-base font-bold">
                최근
              </div>
              <div class="SearchBoxDropDown w-5/20 text-base">
                <button
                  id="SearchBoxSeeAll"
                  class="SearchBoxDropDown font-bold rounded-md hover:bg-gray-200 pl-3 pr-3"
                >
                  모두 보기
                </button>
              </div>
            </div>
            <!-- 페이지 검색결과 -->
            <div
              id="searchBoxMenuRecentPage"
              class="SearchBoxDropDown mt-2"
            ></div>
            <!-- 페이지 검색 결과 끝 -->

            <!-- 최근 검색 키워드 -->
            <div id="searchBoxMenuRecent" class="SearchBoxDropDown mt-2"></div>
            <!-- 최근 검색 키워드 끝 -->
          </div>
        </div>
        <!-- 홈 -->
        <div
          class="h-full w-25 flex-none text-center opacity-50 hover:opacity-100"
        >
          <a href="" class="text-sm"
            ><img
              src="${pageContext.request.contextPath}/images/house-solid.svg"
              class="h-2/5 m-auto mt-1.5 ml-auto justify-end"
            />홈</a
          >
        </div>

        <!-- 인맥 -->
        <div
          class="h-full w-25 flex-none text-center opacity-50 hover:opacity-100"
        >
          <a href="" class="text-sm"
            ><img
              src="${pageContext.request.contextPath}/images/user-group-solid.svg"
              class="h-2/5 m-auto mt-1.5"
            />인맥</a
          >
        </div>
        <!-- 채용공고 -->
        <div
          class="h-full w-25 flex-none text-center opacity-50 hover:opacity-100"
        >
          <a href="" class="text-sm"
            ><img
              src="${pageContext.request.contextPath}/images/briefcase-solid.svg"
              class="h-2/5 m-auto mt-1.5"
            />채용공고</a
          >
        </div>
        <!-- 메시지 -->
        <div
          class="h-full w-25 flex-none text-center opacity-50 hover:opacity-100"
        >
          <a href="" class="text-sm"
            ><img
              src="${pageContext.request.contextPath}/images/comment-dots-solid.svg"
              class="h-2/5 m-auto mt-1.5"
            />메시지</a
          >
        </div>
        <!-- 알림 -->
        <div
          class="h-full w-25 flex-none text-center opacity-50 hover:opacity-100"
        >
          <a href="" class="text-sm">
            <img
              src="${pageContext.request.contextPath}/images/bell-solid.svg"
              class="h-2/5 m-auto mt-1.5"
            />알림
          </a>
        </div>
        <!-- 마이페이지 -->
        <div
          id="headerProfileIcon"
          class="h-full w-20 flex-none text-center border-r-1 border-gray-300 text-sm opacity-50 hover:opacity-100"
        >
          <img
            src="${pageContext.request.contextPath}/images/no_profile_image.png"
            class="h-2/5 m-auto mt-1.5 round-full"
          />나▼
          <div
                  id="headerProfile"
                  class="bg-white border-1 text-left rounded opacity-100 w-40 hidden"
          >
            <ul>
              <li class="border-b-1 border-gray-300">
                <div class="grid grid-cols-3 grid-rows-2">
                  <div class="row-span-2">로고로고로고</div>
                  <div id="headerProfileId" class="col-span-2">이름</div>
                  <div id="headerProfileExplane" class="col-span-2">설명</div>
                </div>
              </li>
              <li class="border-b-1 border-gray-300">
                <span class="text-2xl font-semibold mb-4">계정</span>
                <ul>
                  <li>개인정보 설정</li>
                  <li>고객센터</li>
                  <li>언어</li>
                </ul>
              </li>
              <li class="border-b-1 border-gray-300">
                <span class="text-2xl font-semibold mb-4">관리</span>
                <ul>
                  <li>글&활동</li>
                  <li>회사:<span>회사이름</span></li>
                  <li>채용공고 계정</li>
                </ul>
              </li>
              <li class="border-b-1 border-gray-300">
                <a href="<%= ctxPath%>/member/logout">로그아웃</a>
              </li>
            </ul>
          </div>
        </div>
        <!-- 비즈니스 -->
        <div
          class="h-full w-25 flex-none text-center ml-2 text-sm opacity-50 hover:opacity-100"
        >
          <img
            src="${pageContext.request.contextPath}/images/grid-3x3-gap-fill-svgrepo-com.svg"
            class="h-2/5 m-auto mt-1.5"
          />비즈니스용▼
        </div>
      </div>
    </nav>
    <div
      id="clickBlackout"
      class="w-screen h-screen fixed z-100"
      style="display: none"
    ></div>
  </body>
</html>
