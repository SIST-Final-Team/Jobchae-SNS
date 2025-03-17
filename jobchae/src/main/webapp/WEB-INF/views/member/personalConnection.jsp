<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

<%
    String ctxPath = request.getContextPath();
%>    
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
window.addEventListener("DOMContentLoaded", function() {
  const profilesContainer = document.getElementById("profiles");

  // 프로필 컨테이너가 존재하는지 확인
  if (!profilesContainer) {
    console.error("프로필 컨테이너를 찾을 수 없습니다.");
    return;
  }

  const profiles = Array.from(profilesContainer.children); // 카드들을 배열로 변환

  // 랜덤 정렬 함수
  function shuffleArray(array) {
    const copiedArray = [...array]; // 원본 배열을 복사
    return copiedArray.sort(() => Math.random() - 0.5);
  }

  // 배열을 랜덤하게 섞기
  const shuffledProfiles = shuffleArray(profiles);

  // 정렬된 프로필을 다시 컨테이너에 추가
  profilesContainer.innerHTML = ""; // 기존 프로필 내용 초기화
  shuffledProfiles.forEach(profile => {
    profilesContainer.appendChild(profile); // 섞인 프로필 순서대로 추가
  });
});
</script>


<script> 
document.addEventListener("DOMContentLoaded", function () {
	  // 탭 버튼 클릭 시 스타일 변경
	  const buttons = document.querySelectorAll(".tab-btn");
	  buttons.forEach((button) => {
	    button.addEventListener("click", function () {
	      buttons.forEach((btn) => btn.classList.remove("border-green-800", "text-green-700"));
	      this.classList.add("border-green-800", "text-green-700");
	    });
	  });
	
	  // 모달 관련 변수
	  const modal = document.getElementById("default-modal");
	  const openBtn = document.querySelector("[data-modal-toggle='default-modal']");
	  const closeBtns = document.querySelectorAll("[data-modal-hide='default-modal']");
	  const loadingSpinner = document.getElementById("loading-spinner");
	  const modalContent = document.getElementById("modal-content");
	
	  // 모달 열기
	  openBtn.addEventListener("click", function () {
	    modal.classList.remove("hidden");
	    modal.classList.add("flex"); // 중앙 정렬을 위해 flex 추가
	    loadingSpinner.classList.remove("hidden");
	    modalContent.classList.add("hidden");
	
	    // 1초 후에 콘텐츠 표시하고 로딩 스피너 숨기기
	    setTimeout(() => {
	      loadingSpinner.classList.add("hidden");
	      modalContent.classList.remove("hidden");
	    }, 1000);
	  });
	
	  // 모달 닫기 (X 버튼 & 바깥 클릭)
	  closeBtns.forEach((btn) => {
	    btn.addEventListener("click", function () {
	      modal.classList.add("hidden");
	      modal.classList.remove("flex");
	    });
	  });
	
	  // 바깥 영역 클릭 시 모달 닫기
	  modal.addEventListener("click", function (event) {
	    if (event.target === modal) {
	      modal.classList.add("hidden");
	      modal.classList.remove("flex");
	    }
	  });
	});

</script>

<script>
//페이지 로드 후 실행
document.addEventListener('DOMContentLoaded', function () {
    const followButton = document.getElementById('followButton');
    if (!followButton) {
        console.error('followButton 요소를 찾을 수 없습니다.');
        return;
    }

    // followerId와 followingId 가져오기
    const followerId = followButton.getAttribute('data-follower-id');
    const followingId = followButton.getAttribute('data-following-id');

    // 확인용 로그
    console.log(`followerId: ${followerId}, followingId: ${followingId}`);

    // 팔로우 상태 확인 (followerId가 없으면 실행 안 함)
    if (followerId) {
        checkFollowStatus(followerId, followingId);
    } else {
        console.warn('followerId가 없습니다. 로그인 여부를 확인하세요.');
    }
});
</script>

  <script>
        function toggleFollow(button) {
            if (button.classList.contains('button-orange')) {
                // 팔로우 → 언팔로우 전환
                button.classList.remove('button-orange');
                button.classList.add('button-gray');
                button.innerHTML = '<i class="fa-solid fa-minus"></i> 언팔로우';
            } else {
                // 언팔로우 → 팔로우 전환
                button.classList.remove('button-gray');
                button.classList.add('button-orange');
                button.innerHTML = '<i class="fa-solid fa-plus"></i> 팔로우';
            }
        }
        
        function removeProfile(button) {
            // 버튼의 부모 요소인 <li>를 찾아서 삭제
            let profileItem = button.closest("li");
            if (profileItem) {
                profileItem.remove(); // 요소 삭제
            }
        }
        
        
    </script>
    
<script>
window.addEventListener("DOMContentLoaded", function() {
	  const profilesContainer = document.getElementById("profiles");

	  // 프로필 컨테이너가 존재하는지 확인
	  if (!profilesContainer) {
	    console.error("프로필 컨테이너를 찾을 수 없습니다.");
	    return;
	  }

	  const profiles = Array.from(profilesContainer.children); // 카드들을 배열로 변환

	  // 랜덤 정렬 함수
	  function shuffleArray(array) {
	    const copiedArray = [...array]; // 원본 배열을 복사
	    return copiedArray.sort(() => Math.random() - 0.5); // 섞기
	  }

	  // 배열을 랜덤하게 섞기
	  const shuffledProfiles = shuffleArray(profiles);

	  // 정렬된 프로필을 다시 컨테이너에 추가
	  profilesContainer.innerHTML = ""; // 기존 프로필 내용 초기화
	  shuffledProfiles.forEach(profile => {
	    profilesContainer.appendChild(profile); // 섞인 프로필 순서대로 추가
	  });
	});
</script>

<script>
// 프로필 카드 삭제 함수
function removeProfileCard(button) {
  // button이 클릭된 위치에서 부모 카드 요소를 찾음
  const card = button.closest('.card');
  
  if (card) {
    card.remove(); // 해당 카드를 삭제
  }
}
</script>


</head>

<body>

 

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
                 <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!" onclick="removeProfileCard(this)">
                 <i class="fa-solid fa-xmark text-white"></i>
                 </button>
                <img src="<%= ctxPath%>/resources/files/profile/스크린샷 2025-03-17 044624.png" alt="배경이미지" class="h-24! w-full object-cover" />
              </figure>
              <div class="avatar">
                <div class="absolute w-18! h-18! rounded-full -mt-12 ml-4">
                  <img src="<%= ctxPath%>/resources/files/profile/Urgot.png" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">이진호</h2>
                <p>우르곳의 신</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                 <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!" onclick="removeProfileCard(this)">
      <i class="fa-solid fa-xmark text-white"></i>
    </button>
                <img src="<%= ctxPath%>/resources/files/2025031115411213833956965000.jpg" alt="배경이미지" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="absolute w-18! h-18! rounded-full -mt-12 ml-4">
                  <img src="<%= ctxPath%>/resources/files/profile/default/profile.png" alt="배경이미지" class="h-16! w-full object-cover" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">김규빈</h2>
                <p>백엔드 개발자</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!" onclick="removeProfileCard(this)">
      <i class="fa-solid fa-xmark text-white"></i>
    </button>
                <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-24! w-full object-cover" />
              </figure>
              <div class="avatar">
                <div class="absolute w-18! h-18! rounded-full -mt-12 ml-4">
                  <img src="<%= ctxPath%>/resources/files/profile/default/profile.png" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">홍길동</h2>
                <p>데이터 엔지니어</p>
                <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                 <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!" onclick="removeProfileCard(this)">
      <i class="fa-solid fa-xmark text-white"></i>
    </button>
                <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-24! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="absolute w-18! h-18! rounded-full -mt-12 ml-4">
                  <img src="<%= ctxPath%>/resources/files/profile/eomjh.png" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">엄정화</h2>
                <p>가수</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
              </div>
            </div>

            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!" onclick="removeProfileCard(this)">
      <i class="fa-solid fa-xmark text-white"></i>
    </button>
                <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-24! w-full object-cover" />
              </figure>
              <div class="avatar">
                <div class="absolute w-18! h-18! rounded-full -mt-12 ml-4">
                  <img src="<%= ctxPath%>/resources/files/profile/default/profile.png" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">이철수</h2>
                <p>데이터 분석가</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
              </div>
            </div>
            
                  <div class="card border-normal col-span-1">
              <figure>
                 <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!" onclick="removeProfileCard(this)">
      <i class="fa-solid fa-xmark text-white"></i>
    </button>
                <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-24! w-full object-cover" />
              </figure>
              <div class="avatar">
                <div class="absolute w-18! h-18! rounded-full -mt-12 ml-4">
                  <img src="<%= ctxPath%>/resources/files/profile/202503161203481125313654737599.webp" />
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">박채은</h2>
                <p>쌍용교육센터</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
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
                class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-300">
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
                class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-300">
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
                class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-300">
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
                class="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-300">
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
          <span class="flex-1">1촌 신청</span>
          <div class="pt-2">
              <ul>
                  <li class="border-t-1! border-gray-300! py-2 flex items-center">
                      <a href="#" class="flex flex-1">
                          <div>
                             <img src="<%= ctxPath%>/resources/files/profile/default/profile.png" alt="배경이미지" class="h-16! w-full object-cover" />
                          </div>
                          <div class="flex-1 ml-4">
                            <div class="font-bold hover:underline">백엔드 개발자</div>
                            <div class="text-gray-600">김영희</div>
                          </div>
                      </a>
                      <div class="text-right">
                        <button type="button" class="py-2 text-sm btn-bold rounded-full!" onclick="removeProfile(this)">
				        건너뛰기
				      </button>
				      <button type="button" class="px-4 py-2 text-sm button-orange" onclick="removeProfile(this)">
				        수락
				      </button>
                      </div>
                  </li>
                  <li class="border-t-1! border-gray-300! py-2 flex items-center">
                      <a href="#" class="flex flex-1">
                          <div>
                              <img src="<%= ctxPath%>/resources/files/profile/Squidward.png" class="aspect-square w-15 object-cover rounded-full"/>
                          </div>
                          <div class="flex-1 ml-4">
                            <div class="font-bold hover:underline">징징이</div>
                            <div class="text-gray-600">이준영</div>
                          </div>
                      </a>
                      <div class="text-right">
                        <button type="button" class="py-2 text-sm btn-bold rounded-full!" onclick="removeProfile(this)">
				        건너뛰기
				      </button>
				      <button type="button" class="px-4 py-2 text-sm button-orange" onclick="removeProfile(this)">
				        수락
				      </button>   
                  </li>
                  <li class="border-t-1! border-gray-300! py-2 flex items-center">
                      <a href="#" class="flex flex-1">
                          <div>
                              <img src="<%= ctxPath%>/resources/files/profile/KartRider.png" class="aspect-square w-15 object-cover rounded-full"/>
                          </div>
                          <div class="flex-1 ml-4">
                            <div class="font-bold hover:underline">카트의 신</div>
                            <div class="text-gray-600">이진호짱123</div>
                          </div>
                      </a>
                      <div class="text-right">
                        <button type="button" class="py-2 text-sm btn-bold rounded-full!" onclick="removeProfile(this)">
				        건너뛰기
				      </button>
				      <button type="button" class="px-4 py-2 text-sm button-orange" onclick="removeProfile(this)">
				        수락
				      </button>
                      </div>
                  </li>
              </ul>
          </div>
      </div>



     		 <!-- 탑스토리 -->
			<div class="border-normal px-2 py-2">
			  <div class="flex justify-between items-center">
			    <h2 class="pl-2">LinkedIn 탑스토리</h2>
			    <button type="button" data-modal-target="default-modal" data-modal-toggle="default-modal"
			      class="btn-bold px-2!">
			      모두 표시
			    </button>
			  </div>
			
			  <!-- 프로필들을 담을 컨테이너 -->
			  <div id="profiles" class="mx-auto px-2 grid grid-cols-3 gap-4 my-2">
            <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!" onclick="removeProfileCard(this)">
      <i class="fa-solid fa-xmark text-white"></i>
    </button>
               <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="absolute w-18! h-18! rounded-full -mt-12 ml-4">
                 <a href="http://localhost/jobchae/member/profile/codms1"><img src="<%= ctxPath%>/resources/files/profile/202503161203481125313654737599.webp" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">박채은</h2>
                <p>쌍용교육센터</p>
                <div class="card-actions justify-center">
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
                </div>
              </div>
            </div>
     
              <div class="card border-normal col-span-1">
              <figure>
                 <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!" onclick="removeProfileCard(this)">
      <i class="fa-solid fa-xmark text-white"></i>
    </button>
               <img src="<%= ctxPath%>/resources/files/profile/KartRiderService_imple.png" alt="배경이미지" class="h-16! w-full object-cover" />
              </figure>
              <div class="avatar">
                <div class="absolute w-18! h-18! rounded-full -mt-12 ml-4">
                 <a href="#"><img src="<%= ctxPath%>/resources/files/profile/KartRider.png" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">이진호짱123</h2>
                <p>카트의 신</p>
                <div class="card-actions justify-center">
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
                </div>
              </div>
            </div>
            
            
            
              <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!" onclick="removeProfileCard(this)">
                  <i class="fa-solid fa-xmark text-white"></i>
                  </button>
              <img src="<%= ctxPath%>/resources/files/profile/SquidwardHouse.png" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="absolute w-18! h-18! rounded-full -mt-12 ml-4">
                 <a href="#"><img src="<%= ctxPath%>/resources/files/profile/Squidward.png" style="border-radius: 50%;" /></a>
                </div>

              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">이준영</h2>
                <p>징징이</p>
                <div class="card-actions justify-center">
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                 </button>
                </div>
              </div>
            </div>
              
 
              <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!" onclick="removeProfileCard(this)">
      <i class="fa-solid fa-xmark text-white"></i>
    </button>
              <img src="<%= ctxPath%>/resources/files/2025031115411213833956965000.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="absolute w-18! h-18! rounded-full -mt-12 ml-4">
                  <a href="#"><img src="<%= ctxPath%>/resources/files/profile/default/profile.png" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">김규빈</h2>
                <p>백엔드 개발자</p>
                <div class="card-actions justify-center">
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
                </div>
              </div>
            </div>
            
            
            
              <div class="card border-normal col-span-1">
              <figure>
               <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!" onclick="removeProfileCard(this)">
      <i class="fa-solid fa-xmark text-white"></i>
    </button>
                <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="absolute w-18! h-18! rounded-full -mt-12 ml-4">
                  <a href="#"><img src="<%= ctxPath%>/resources/files/profile/default/profile.png" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">연규영</h2>
                <p>AI 전문가</p>
                <div class="card-actions justify-center">
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
                </div>
              </div>
            </div>
           
              <div class="card border-normal col-span-1">
              <figure>
                <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!" onclick="removeProfileCard(this)">
      <i class="fa-solid fa-xmark text-white"></i>
    </button>
                 <img src="<%= ctxPath%>/resources/files/profile/스크린샷 2025-03-17 044624.png" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <div class="avatar">
                <div class="absolute w-18! h-18! rounded-full -mt-12 ml-4">
                 <a href="#"><img src="<%= ctxPath%>/resources/files/profile/Urgot.png" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4!">
                <h2 class="card-title">이진호</h2>
                <p>우르곳의 신</p>
                <div class="card-actions justify-center">
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
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
                  <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar relative w-full!">
                <div class="absolute left-1/2 transform -translate-x-1/2 w-[67px] rounded-full -mt-6">   
                   <a href="#"><img src="<%= ctxPath%>/resources/files/profile/default/profile.png" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">김영희</h2>
                <p>프로그래머</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
              </div>
            </div>
            
               <div class="card border-normal col-span-1 relative">
              <figure>
                  <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar relative w-full!">
                <div class="absolute left-1/2 transform -translate-x-1/2 w-[67px] rounded-full -mt-6">   
                   <a href="http://localhost/jobchae/member/profile/user001"><img src="<%= ctxPath%>/resources/files/profile/default/profile.png" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">박민수</h2>
                <p>삼성전자</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
              </div>
            </div>
            
               <div class="card border-normal col-span-1 relative">
              <figure>
                  <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar relative w-full!">
                <div class="absolute left-1/2 transform -translate-x-1/2 w-[67px] rounded-full -mt-6">   
                   <a href="#"><img src="<%= ctxPath%>/resources/files/profile/default/profile.png" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">최지훈</h2>
                <p>백엔드 개발자</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
              </div>
            </div>
            
               <div class="card border-normal col-span-1 relative">
              <figure>
                  <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar relative w-full!">
                <div class="absolute left-1/2 transform -translate-x-1/2 w-[67px] rounded-full -mt-6">   
                   <a href="#"><img src="<%= ctxPath%>/resources/files/profile/eomjh.png" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">엄정화</h2>
                <p>가수</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
              </div>
            </div>
            
              <div class="card border-normal col-span-1 relative">
              <figure>
                  <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar relative w-full!">
                <div class="absolute left-1/2 transform -translate-x-1/2 w-[67px] rounded-full -mt-6">   
                   <a href="#"><img src="<%= ctxPath%>/resources/files/profile/default/profile.png" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">김영희</h2>
                <p>백엔드 개발자</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
              </div>
            </div>
            
              <div class="card border-normal col-span-1 relative">
              <figure>
                  <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar relative w-full!">
                <div class="absolute left-1/2 transform -translate-x-1/2 w-[67px] rounded-full -mt-6">   
                   <a href="#"><img src="<%= ctxPath%>/resources/files/profile/default/profile.png" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">김규빈</h2>
                <p>LG전자</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
              </div>
            </div>
            
               <div class="card border-normal col-span-1 relative">
              <figure>
                  <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar relative w-full!">
                <div class="absolute left-1/2 transform -translate-x-1/2 w-[67px] rounded-full -mt-6">   
                   <a href="#"><img src="<%= ctxPath%>/resources/files/profile/default/profile.png" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">최지훈</h2>
                <p>SW 개발자</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
              </div>
            </div>
            
               <div class="card border-normal col-span-1 relative">
              <figure>
                  <img src="<%= ctxPath%>/resources/files/profile/default/background_img.jpg" alt="배경이미지" class="h-16! w-full object-cover" />

              </figure>
              <button type="button" class="absolute top-2 right-2 w-8 aspect-square rounded-full! bg-black/70!"><i class="fa-solid fa-xmark text-white"></i></button>
              <div class="avatar relative w-full!">
                <div class="absolute left-1/2 transform -translate-x-1/2 w-[67px] rounded-full -mt-6">   
                   <a href="#"><img src="<%= ctxPath%>/resources/files/profile/default/profile.png" style="border-radius: 50%;" /></a>
                </div>
              </div>
              <div class="card-body p-4! text-center">
                <h2 class="card-title justify-center">김철수</h2>
                <p>백엔드 개발자</p>
                 <button type="button" class="button-orange w-full" onclick="toggleFollow(this)">
                    <i class="fa-solid fa-plus"></i> 팔로우
                </button>
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