<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<!-- TailWind Script -->
<script src="https://unpkg.com/@tailwindcss/browser@4"></script>
<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.23/dist/full.min.css" rel="stylesheet" type="text/css" />

<head>

   <title>내 인맥</title>

  <style type="text/tailwindcss">
    .border-normal {
        @apply border-1 border-gray-300 rounded-lg bg-white;
    }

    .button-gray:not(.button-selected) {
        @apply border-1 rounded-full border-gray-400 px-3 py-0.5 font-bold text-gray-700;
        @apply hover:bg-gray-100 hover:inset-ring-1 hover:inset-ring-gray-400 transition-all duration-200;
        @apply hover:cursor-pointer;
    }
    .button-orange:not(.button-selected) {
        @apply border-1 rounded-full border-orange-500 px-3 py-0.5 font-bold text-orange-500;
        @apply hover:bg-gray-100 hover:inset-ring-1 hover:inset-ring-orange-500 transition-all duration-200;
        @apply hover:cursor-pointer;
    }
    .button-selected {
        @apply border-1 border-orange-400 rounded-full px-3 py-0.5 font-bold text-white bg-orange-400;
        @apply hover:bg-orange-500 hover:border-orange-500 transition-all duration-200;
        @apply hover:cursor-pointer;
    }
      
    .btn-transparent {
        @apply px-4 py-1 rounded-full;
    }

    .btn-transparent:hover {
        @apply bg-gray-100 cursor-pointer;
    }
  
    .btn-bold {
        @apply px-4 py-1 font-bold rounded-sm;
    }

    .btn-bold:hover {
        @apply bg-gray-100 cursor-pointer;
    }
  </style>
  <script>
    const buttons = document.querySelectorAll(".tab-btn");

    buttons.forEach((button) => {
      button.addEventListener("click", function () {
        buttons.forEach((btn) => btn.classList.remove("border-green-800", "text-green-700"));
        this.classList.add("border-green-800", "text-green-700");
      });
    });

    document.addEventListener("DOMContentLoaded", function () {
      const modal = document.getElementById("default-modal");
      const openBtn = document.querySelector("[data-modal-toggle='default-modal']");
      const closeBtns = document.querySelectorAll("[data-modal-hide='default-modal']");

      // 모달 열기
      openBtn.addEventListener("click", function () {
        modal.classList.remove("hidden");
        modal.classList.add("flex"); // 중앙 정렬을 위해 flex 추가
      });

      // 모달 닫기 (X 버튼 & 바깥 클릭)
      closeBtns.forEach((btn) => {
        btn.addEventListener("click", function () {
          modal.classList.add("hidden");
          modal.classList.remove("flex");
        });
      });

      // 바깥 영역 클릭 시 닫기
      modal.addEventListener("click", function (event) {
        if (event.target === modal) {
          modal.classList.add("hidden");
          modal.classList.remove("flex");
        }
      });
    });

    document.addEventListener("DOMContentLoaded", function () {
      const modalButton = document.querySelector("[data-modal-target='default-modal']");
      const modal = document.getElementById("default-modal");
      const loadingSpinner = document.getElementById("loading-spinner");
      const modalContent = document.getElementById("modal-content");

      modalButton.addEventListener("click", function () {
        // 모달을 보이게 설정 (초기 상태에서 hidden 제거하고 flex로 표시)
        modal.classList.remove("hidden");
        modal.classList.add("flex");

        // 로딩 스피너 보이기
        loadingSpinner.classList.remove("hidden");

        // 콘텐츠 숨기기
        modalContent.classList.add("hidden");

        // 1초 후에 콘텐츠 표시하고 로딩 스피너 숨기기
        setTimeout(() => {
          loadingSpinner.classList.add("hidden");
          modalContent.classList.remove("hidden");
        }, 1000); // 1초 후에 모달 콘텐츠 표시
      });

      // 모달을 닫는 버튼에 클릭 이벤트 추가
      document.querySelectorAll("[data-modal-hide='default-modal']").forEach(button => {
        button.addEventListener("click", function () {
          modal.classList.add("hidden");
          modal.classList.remove("flex");
        });
      });
    });
  </script>
  
  

<script>

  // 세션에서 로그인한 사용자 아이디를 가져옴
  const followerId = '${sessionScope.userId}';  // 현재 로그인한 사용자 아이디
  const followingId = '${sessionScope.followingId}';  ///

  function toggleFollow() {
    const followBtn = document.getElementById("followBtn");
    
    // 팔로우 상태일 때
    if (followBtn.innerText === "팔로우") {
      // 팔로우 API 요청
      fetch(`/follow/toggle?follower_id=${followerId}&following_id=${followingId}`, {
        method: 'POST'
      }).then(response => {
        if (response.ok) {
          // 버튼 텍스트 변경
          followBtn.innerHTML = '<i class="fa-solid fa-minus"></i> 언팔로우';
        }
      });
    } else {  // 언팔로우 상태일 때
      // 언팔로우 API 요청
      fetch(`/follow/toggle?follower_id=${followerId}&following_id=${followingId}`, {
        method: 'POST'
      }).then(response => {
        if (response.ok) {
          // 버튼 텍스트 변경
          followBtn.innerHTML = '<i class="fa-solid fa-plus"></i> 팔로우';
        }
      });
    }
  }
  
</script>




</head>

<body>

  <header class="mb-[50px]">
    <h1>헤더 영역</h1> <!-- 미리 만들었음 -->
  </header>

    <!-- 모달 시작 -->
  <div id="default-modal" tabindex="-1" aria-hidden="true"
    class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full bg-black bg-opacity-80">
    <div class="relative p-4 w-full  max-w-4xl max-h-full">
      <!-- Modal content -->
      <div class="relative bg-white rounded-lg shadow-sm dark:bg-gray-700">
        <!-- Modal header -->
        <div
          class="flex items-center justify-between p-4 md:p-5 border-b rounded-t dark:border-gray-600 border-gray-200">
          <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
            LinkedIn 탑스토리
          </h3>
          <button type="button"
            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
            data-modal-hide="default-modal">
            <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
            </svg>
            <span class="sr-only">Close modal</span>
          </button>
        </div>
        <!-- Modal body -->
        <div id="modal-content" class="p-4 md:p-5 space-y-4 hidden">
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">


        <!-- 모달창 카드 선택 안 -->
          
        <!-- 탑스토리 -->
        <div class="px-2 py-4">

          <div class="mx-auto px-2 grid grid-cols-3 gap-4 mt-5">
            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="w-18 rounded-full -mt-12 ml-4">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">연규영</h2>
                <p>백엔드 개발자</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="w-18 rounded-full -mt-12 ml-4">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">이진호</h2>
                <p>백수</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="w-18 rounded-full -mt-12 ml-4">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">김규빈</h2>
                <p>데이터 엔지니어</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="w-18 rounded-full -mt-12 ml-4">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">박채은</h2>
                <p>데이터 엔지니어</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="w-18 rounded-full -mt-12 ml-4">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">김진성</h2>
                <p>AI 엔지니어</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-24! w-full object-cover" />
              </figure>
              <div class="avatar">
                <div class="w-18 rounded-full -mt-12 ml-4">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">조원재</h2>
                <p>데이터 분석가</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Loading spinner -->
        <div id="loading-spinner" class="hidden ml-[315px]">
          <div class="flex items-center justify-center w-56 h-56 rounded-lg dark:bg-gray-800 dark:border-gray-700">
            <div role="status">
              <svg aria-hidden="true" class="w-8 h-8 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600"
                viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path
                  d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                  fill="currentColor" />
                <path
                  d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                  fill="currentFill" />
              </svg>
              <span class="sr-only">Loading...</span>
            </div>  
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- 모달 종료 -->

  <div class="bg-[#F4F2EE]"> <!--min-h-screen-->
    <div class="container mx-auto max-w-[1140px] grid grid-cols-14 gap-6 pt-5">

      <!-- 사이드바 -->
      <aside class="col-span-4" aria-label="Sidebar">
        <div class="px-3 py-4 overflow-y-auto border-normal sticky top-20">
          <ul class="space-y-2">
            <h2 class="text-l g font-bold! mb-4">인맥 관리</h2>
            <div class="divider mx-0! my-2!"></div>
            <li>
              <a href="#"
                class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                <svg
                  class="w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                  fill="currentColor" viewBox="0 0 20 20" xmlns="w3.org/2000/svg">
                  <path d="M2 10a8 8 0 018-8v8h8a8 8 0 11-16 0z"></path>
                  <path d="M12 2.252A8.014 8.014 0 0117.748 8H12V2.252z"></path>
                </svg>
                <span class="ml-3">맞팔로우</span>
              </a>
            </li>
            <li>
              <a href="#" target="_blank"
                class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                <svg
                  class="flex-shrink-0 w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                  fill="currentColor" viewBox="0 0 20 20" xmlns="w3.org/2000/svg">
                  <path
                    d="M5 3a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2V5a2 2 0 00-2-2H5zM5 11a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2v-2a2 2 0 00-2-2H5zM11 5a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V5zM11 13a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z">
                  </path>
                </svg>
                <span class="flex-1 ml-3 whitespace-nowrap">팔로우중 및 팔로우</span>
              </a>
            </li>
            <li>
              <a href="#" target="_blank"
                class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                <svg
                  class="flex-shrink-0 w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                  fill="currentColor" viewBox="0 0 20 20" xmlns="w3.org/2000/svg">
                  <path
                    d="M8.707 7.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l2-2a1 1 0 00-1.414-1.414L11 7.586V3a1 1 0 10-2 0v4.586l-.293-.293z">
                  </path>
                  <path
                    d="M3 5a2 2 0 012-2h1a1 1 0 010 2H5v7h2l1 2h4l1-2h2V5h-1a1 1 0 110-2h1a2 2 0 012 2v10a2 2 0 01-2 2H5a2 2 0 01-2-2V5z">
                  </path>
                </svg>
                <span class="flex-1 ml-3 whitespace-nowrap">그룹</span>
              </a>
            </li>
            <li>
              <a href="#"
                class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                <svg
                  class="flex-shrink-0 w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                  fill="currentColor" viewBox="0 0 20 20" xmlns="w3.org/2000/svg">
                  <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd">
                  </path>
                </svg>
                <span class="flex-1 ml-3 whitespace-nowrap">이벤트</span>
              </a>
            </li>
            <li>
              <a href="#"
                class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                <svg
                  class="flex-shrink-0 w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                  fill="currentColor" viewBox="0 0 20 20" xmlns="w3.org/2000/svg">
                  <path fill-rule="evenodd"
                    d="M10 2a4 4 0 00-4 4v1H5a1 1 0 00-.994.89l-1 9A1 1 0 004 18h12a1 1 0 00.994-1.11l-1-9A1 1 0 0015 7h-1V6a4 4 0 00-4-4zm2 5V6a2 2 0 10-4 0v1h4zm-6 3a1 1 0 112 0 1 1 0 01-2 0zm7-1a1 1 0 100 2 1 1 0 000-2z"
                    clip-rule="evenodd"></path>
                </svg>
                <span class="flex-1 ml-3 whitespace-nowrap">페이지</span>
              </a>
            </li>
            <li>
              <a href="#"
                class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                <svg
                  class="flex-shrink-0 w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                  fill="currentColor" viewBox="0 0 20 20" xmlns="w3.org/2000/svg">
                  <path fill-rule="evenodd"
                    d="M3 3a1 1 0 00-1 1v12a1 1 0 102 0V4a1 1 0 00-1-1zm7-1a1 1 0 011 1v12a1 1 0 01-2 0V3a1 1 0 011-1z"
                    clip-rule="evenodd"></path>
                </svg>
                <span class="flex-1 ml-3 whitespace-nowrap">추천</span>
              </a>
            </li>
          </ul>
        </div>
      </aside>

      <!-- 메인 컨테이너 -->
      <div class="col-span-10 space-y-4">
        <div class="p-2 border-normal flex items-center">
          <span class="flex-1 pl-2">대기 중인 1촌 신청 없음</span>
          <button type="button" class="btn-bold px-2!">
            관리
          </button>
        </div>

        <div class="px-4 border border-gray-300 rounded-lg pt-4 border-normal">
          <span class="flex-1">1촌 신청(1<!--나중에 신청이 들어온 수 만큼 증가-->)</span>
          <div class="pt-2">
              <ul>
                  <li class="border-t-1! border-gray-300! py-2 flex items-center">
                      <a href="#" class="flex flex-1">
                          <div>
                              <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" class="aspect-square w-15 object-cover rounded-full"/>
                          </div>
                          <div class="flex-1 ml-4">
                            <div class="font-bold hover:underline">Samsung Memory Marketing Director</div>
                            <div class="text-gray-600">Hwaseong</div>
                          </div>
                      </a>
                      <div class="text-right">
                        <button type="button" class="py-2 text-sm btn-bold rounded-full!">
                          건너뛰기
                        </button>
                        <button type="button" class="px-4 py-2 text-sm button-orange">
                          수락
                        </button>
                      </div>
                  </li>
                  <li class="border-t-1! border-gray-300! py-2 flex items-center">
                      <a href="#" class="flex flex-1">
                          <div>
                              <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" class="aspect-square w-15 object-cover rounded-full"/>
                          </div>
                          <div class="flex-1 ml-4">
                            <div class="font-bold hover:underline">Samsung Memory Marketing Director</div>
                            <div class="text-gray-600">Hwaseong</div>
                          </div>
                      </a>
                      <div class="text-right">
                        <button type="button" class="py-2 text-sm btn-bold rounded-full!">
                          건너뛰기
                        </button>
                        <button type="button" class="px-4 py-2 text-sm button-orange">
                          수락
                        </button>        
                  </li>
                  <li class="border-t-1! border-gray-300! py-2 flex items-center">
                      <a href="#" class="flex flex-1">
                          <div>
                              <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" class="aspect-square w-15 object-cover rounded-full"/>
                          </div>
                          <div class="flex-1 ml-4">
                            <div class="font-bold hover:underline">Samsung Memory Marketing Director</div>
                            <div class="text-gray-600">Hwaseong</div>
                          </div>
                      </a>
                      <div class="text-right">
                        <button type="button" class="py-2 text-sm btn-bold rounded-full!">
                          건너뛰기
                        </button>
                        <button type="button" class="px-4 py-2 text-sm button-orange">
                          수락
                        </button>
                      </div>
                  </li>
              </ul>
          </div>
      </div>

        <!-- 예를 든 예시임 나중에 DB에 추가할 것 !!-->

        <!-- 탑스토리 -->
        <div class="border-normal px-2 py-2">

          <div class="flex justify-between items-center">
            <h2 class="pl-2">LinkedIn 탑스토리</h2>

            <button type="button" data-modal-target="default-modal" data-modal-toggle="default-modal"
              class="btn-bold px-2!">
              모두 표시
            </button>
          </div>


          <div class="mx-auto px-2 grid grid-cols-3 gap-4 my-2">
            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="w-18 rounded-full -mt-12 ml-4">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">연규영</h2>
                <p>백엔드 개발자</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
                <img src="/html/주소짤.jpg" alt="주소짤" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="w-18 rounded-full -mt-12 ml-4">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">이진호</h2>
                <p>백수</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="w-18 rounded-full -mt-12 ml-4">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">김규빈</h2>
                <p>데이터 엔지니어</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="w-18 rounded-full -mt-12 ml-4">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">박채은</h2>
                <p>데이터 분석가</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="w-18 rounded-full -mt-12 ml-4">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">김진성</h2>
                <p>AI 엔지니어</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="w-18 rounded-full -mt-12 ml-4">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">조원재</h2>
                <p>데이터 분석가</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>

          </div>
        </div>
        <!-- 탑스토리 끝 -->

        <!-- 맞춤 추천 -->
        <div class="border-normal px-2 py-4">

          <div class="flex justify-between items-center">
            <h2 class="pl-4">맞춤 추천</h2>
          </div>


          <div class="mx-auto px-2 grid grid-cols-4 gap-2 mt-5">
            <div class="card border-normal col-span-1 relative">
              <figure>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar">
                <div class="w-[67px] rounded-full -mt-6 ml-4 m-auto">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">연규영</h2>
                <p>백엔드 개발자</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>
            
            <div class="card border-normal col-span-1 relative">
              <figure>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar">
                <div class="w-[67px] rounded-full -mt-6 ml-4 m-auto">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">연규영</h2>
                <p>백엔드 개발자</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>
            
            <div class="card border-normal col-span-1 relative">
              <figure>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar">
                <div class="w-[67px] rounded-full -mt-6 ml-4 m-auto">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">연규영</h2>
                <p>백엔드 개발자</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>
            
            <div class="card border-normal col-span-1 relative">
              <figure>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar">
                <div class="w-[67px] rounded-full -mt-6 ml-4 m-auto">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">연규영</h2>
                <p>백엔드 개발자</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>
            
            <div class="card border-normal col-span-1 relative">
              <figure>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar">
                <div class="w-[67px] rounded-full -mt-6 ml-4 m-auto">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">연규영</h2>
                <p>백엔드 개발자</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>
            
            <div class="card border-normal col-span-1 relative">
              <figure>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar">
                <div class="w-[67px] rounded-full -mt-6 ml-4 m-auto">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">연규영</h2>
                <p>백엔드 개발자</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>
            
            <div class="card border-normal col-span-1 relative">
              <figure>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar">
                <div class="w-[67px] rounded-full -mt-6 ml-4 m-auto">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">연규영</h2>
                <p>백엔드 개발자</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>
            
            <div class="card border-normal col-span-1 relative">
              <figure>
                <img src="/240502-Gubi-Showroom-London-003-Print.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar">
                <div class="w-[67px] rounded-full -mt-6 ml-4 m-auto">
                  <img src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">연규영</h2>
                <p>백엔드 개발자</p>
                <div class="card-actions justify-center">
                  <button type="button" class="button-orange w-full"><i class="fa-solid fa-plus"></i> 팔로우</button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- 맞춤 추천 끝 -->

      </div>

      <!-- 컨테이너 끝 -->

    </div>
  </div>
 </div>

  <!-- 모달 창 -->
  <dialog id="my_modal_3" class="modal">
    <div class="modal-box">
      <form method="dialog">
        <button type="button" class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
      </form>
      <h3 class="text-lg font-bold">팔로우 추가</h3>
      <p class="py-4">팔로우 목록에 추가되었습니다!</p>
    </div>
  </dialog>



</body>

</html>