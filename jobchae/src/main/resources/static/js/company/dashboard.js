// 회사 대시보드 페이지의 JavaScript 코드입니다.
// 이 코드는 회사 대시보드 페이지의 콘텐츠를 동적으로 렌더링하고,
// 메뉴 클릭 시 페이지 전환을 처리하는 기능을 포함하고 있습니다.
// 이 코드의 순서는 다음과 같습니다:
// 처음으로 이 페이지에서 필요한 변수가 선언됩니다.
// 다음으로 초기 로딩 시 실행되는 함수가 정의됩니다.
// 그 다음으로 메뉴 클릭 시 페이지 전환을 처리하는 함수가 정의됩니다.
// 마지막으로 브라우저의 뒤로 가기 및 앞으로 가기 버튼 클릭 시 실행되는 함수가 정의됩니다.

// 변수 선언부
// 전체적인 페이지 부분
const contentDiv = document.getElementById("contentDiv");
const companyPrifileDiv = document.getElementById("company-profile");
const rightSideDiv = document.getElementById("rightSideDiv");
const menuElement = document.getElementsByClassName("menu-element");
const menuArrayNum = 5;
const urlArray = window.location.pathname.split("/"); // URL을 '/'로 나누어 배열로 저장합니다.
let url = ""; // 기본 URL을 저장할 변수입니다.
// url 변수에 URL을 저장합니다.
urlArray.forEach((item, index) => {
  if (index < menuArrayNum) {
    // console.log("item : " + item); // 콘솔에 출력합니다.
    url += item + "/";
  }
});
// 변수 선언부 끝

//함수 영역 -------------------------------------------
//콘텐츠를 렌더링 하는 함수
function renderContent(path) {
  let pageContent = null;
  // path가 null일 경우 빈 문자열로 설정합니다.
  if (path == null) {
    path = "";
  }

  // path에 따라 다른 페이지를 렌더링합니다.
  switch (path) {
    case "":
      console.log("path : " + path); // 콘솔에 출력합니다.
      pageContent = `<div class="py-0!">
                    <h1 class="h1 pt-4">소개</h1>
                    <div class="text-gray-700 whitespace-pre-line mb-4">
                    안녕하세요
                    </div>
                </div>

                <!-- 채용공고 -->
                <div class="space-y-0 pb-0!">
                    <h1 class="h1 mb-0">채용공고</h1>
                    <div class="text-gray-500 pb-2 text-lg">
                        현재 진행 중인 채용공고
                    </div>
                    <div id="jobs" class="border-board flex gap-4 overflow-x-auto pb-4 space-y-0! mb-0!">
                        
                    </div>

                   
                </div>

                <!-- 회사 게시물 -->
                <div class="pb-0!">
                    <h1 class="h1 mb-0">회사 소식</h1>
                    <div id="company-posts" class="space-y-4 mt-4">
                    </div>
                </div>

                <!-- 회사 직원 -->
                <div class="pb-0!">
                    <h1 class="h1 mb-0">사람들</h1>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-4">
                        <div>
                            <h3 class="font-semibold text-gray-700 mb-2">여기서 근무하는 직원 (명)</h3>
                            <p class="text-sm text-gray-500 mb-3">현재 에서 근무 중인 사람들</p>
                            <div class="flex -space-x-2 mb-3">
                                
                            </div>
                            
                        </div>
                        <div>
                            <h3 class="font-semibold text-gray-700 mb-2">연관 회사</h3>
                            <p class="text-sm text-gray-500 mb-3">비슷한 산업에 있는 회사들</p>
                            <ul class="space-y-2">
                                
                            </ul>
                        </div>
                    </div>
                </div>`;
    case "about":
      pageContent = `<div class="py-0!">
                    <h1 class="h1 pt-4">소개</h1>
                    <div class="text-gray-700 whitespace-pre-line mb-4">
                    안녕하세요
                    </div>
                </div>`;
      break;
    case "posts":
      pageContent = "아직 게시물이 없습니다.";
      break;
    case "jobs":
      pageContent = "취업관련 정보가 없습니다.";
      break;
    case "people":
      pageContent = "직원 관련 데이터가 없습니다.";
    default:
      pageContent = "오류";
  }
  contentDiv.innerHTML = pageContent;
}

//메뉴 클릭 시 페이지 전환 함수
function changePage(path) {
  history.pushState(null, null, path); // 브라우저의 히스토리에 새로운 상태를 추가합니다.
  renderContent(path); // 콘텐츠를 렌더링합니다.
}

//메뉴의 스타일을 변경하는 함수
function changeMenuStyle(menuUrl) {
  console.log("menuUrl : " + menuUrl); // 콘솔에 출력합니다.
  Array.from(menuElement).forEach((menu) => {
    const menuPath = menu.getAttribute("data-root"); // 클릭한 메뉴의 data-path 속성값을 가져옵니다.
    // 기존 스타일 제거
    menu.classList.remove("text-green-900", "font-bold", "border-b-2");

    // 현재 URL과 메뉴의 URL이 일치하는 경우에만 스타일을 추가합니다.
    if (menuPath == menuUrl) {
      menu.classList.add("text-green-900", "font-bold", "border-b-2");
    }
  });
}
// 함수 영역 끝-------------------------------------------

//이벤트 리스너 영영----------------------------------------------
//각 메뉴에 클릭 이벤트를 추가합니다.
Array.from(menuElement).forEach((menu) => {
  menu.addEventListener("click", (e) => {
    e.preventDefault(); // 기본 동작 방지
    const path = e.target.getAttribute("data-root"); // 클릭한 메뉴의 data-path 속성값을 가져옵니다.
    // console.log(menuUrl); // 메뉴 URL을 콘솔에 출력합니다.
    history.pushState(null, null, url + path); // 브라우저의 히스토리에 새로운 상태를 추가합니다.
    const menuUrl = window.location.pathname.split("/")[menuArrayNum]; // 현재 URL 경로에서 메뉴 부분을 가져옵니다.
    changeMenuStyle(menuUrl); // 메뉴 스타일 변경 함수 호출
    renderContent(path); // 콘텐츠를 렌더링합니다.
  });
});

//이벤트 리스터 영역 끝----------------------------------------------

//함수 호출
//브라우저에서 뒤로 가기, 앞으로 가기 버튼을 클릭했을 때 실행되는 함수
window.addEventListener("popstate", () => {
  const path = window.location.pathname.split("/")[menuArrayNum]; // 현재 URL 경로에서 메뉴 부분을 가져옵니다.
  renderContent(path); // 콘텐츠를 렌더링합니다.
});

//함수 호출
//초기 로딩시 실행
window.onload = function () {
  const path = window.location.pathname.split("/")[menuArrayNum]; // 현재 URL 경로에서 메뉴 부분을 가져옵니다.
  // 초기 메뉴 스타일 설정
  changeMenuStyle(path);
};
