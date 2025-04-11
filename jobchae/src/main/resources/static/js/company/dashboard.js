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
    console.log("item : " + item); // 콘솔에 출력합니다.
    url += item + "/";
  }
});
// 변수 선언부 끝

// 함수
//콘텐츠를 렌더링 하는 함수
function renderContent(path) {
  let pageContent = null;

  // path에 따라 다른 페이지를 렌더링합니다.
  switch (path) {
    case "company-profile":
      pageContent = companyPrifileDiv.innerHTML;
      break;
    case "company-board":
      pageContent = rightSideDiv.innerHTML;
      break;
    default:
      pageContent = rightSideDiv.innerHTML;
  }
  contentDiv.innerHTML = pageContent;
}

//함수
//메뉴 클릭 시 페이지 전환 함수
function changePage(path) {
  history.pushState(null, null, path); // 브라우저의 히스토리에 새로운 상태를 추가합니다.
  renderContent(path); // 콘텐츠를 렌더링합니다.
}

//이벤트 리스너
//각 메뉴에 클릭 이벤트를 추가합니다.
Array.from(menuElement).forEach((menu) => {
  menu.addEventListener("click", (e) => {
    e.preventDefault(); // 기본 동작 방지
    const path = e.target.getAttribute("data-root"); // 클릭한 메뉴의 data-path 속성값을 가져옵니다.
    const menuUrl = window.location.pathname.split("/")[menuArrayNum];
    console.log(menuUrl); // 메뉴 URL을 콘솔에 출력합니다.
    changeMenuStyle(menuUrl); // 메뉴 스타일 변경 함수 호출
    history.pushState(null, null, url + path); // 브라우저의 히스토리에 새로운 상태를 추가합니다.
    renderContent(path); // 콘텐츠를 렌더링합니다.
  });
});

//함수 호출
//브라우저에서 뒤로 가기, 앞으로 가기 버튼을 클릭했을 때 실행되는 함수
window.addEventListener("popstate", () => {
  const path = window.location.pathname.split("/")[menuArrayNum]; // 현재 URL 경로에서 메뉴 부분을 가져옵니다.
  renderContent(path); // 콘텐츠를 렌더링합니다.
});

//함수
//메뉴의 스타일을 변경하는 함수
function changeMenuStyle(menuUrl) {
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

//함수 호출
//초기 로딩시 실행되는 함수
window.onload = function () {
  const path = window.location.pathname.split("/")[menuArrayNum]; // 현재 URL 경로에서 메뉴 부분을 가져옵니다.
  // 초기 메뉴 스타일 설정
  changeMenuStyle("/" + path);
};
