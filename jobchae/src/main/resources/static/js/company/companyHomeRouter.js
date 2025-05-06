//메뉴 오브젝트
const menuList = document.getElementsByClassName("menuList");

// 메뉴 클릭시 메뉴에 저장된 url 값을 가져온다
// 가져온 url 값으로 history.pushState()를 호출하여 주소를 변경한다
// 주소 변경 후 페이지 내용을 변경 한다
Array.from(menuList).forEach((element) => {
  element.addEventListener("click", (e) => {
    // console.log(e.target.getAttribute("data-url"));
    const url = e.target.getAttribute("data-url");
    //주소 변경
    history.pushState({ url: `${url}` }, "", url);

    //메뉴 스타일 변경
    changeMenuStyle(url);

    //내용을 변경한다
    getContent(url, contentDiv)
      .then((result) => {
        console.log("주소 변경 성공");
      })
      .catch((error) => {
        console.error("Error fetching content:", error);
      });
  });
});

// 주소 변경이 발생하면 해당 주소를 가져와서 페이지의 내용물을 변경한다.
// 페이지 변경은 페이지 변경을 위한 함수를 생성한다
// 페이지 주소 변경 후 새로 고침을 해도 해당 페이지가 그대로 보이도록 하기 위해
// 페이지 로드 시에 현재 주소를 가져와서 해당 페이지를 보여준다.
// 페이지를 보여주는 것은 페이지를 변경하는 함수를 호출한다.

//주소 변경 이벤트 발생시
window.addEventListener("popstate", (e) => {
  console.log(e.state.url);
  //메뉴 스타일 변경
  changeMenuStyle(e.state.url);
  getContent(e.state.url, contentDiv)
    .then((result) => {
      console.log("주소 변경 성공");
    })
    .catch((error) => {
      console.error("Error fetching content:", error);
    });
});

//페이지 로드 시에 현재 주소를 가져와서 해당 페이지를 보여준다.
async function getContent(menu, contentDiv) {
  switch (menu) {
    case "dashboard":
      await loadDashboard(contentDiv);
      return "대시보드";
    case "post":
      await loadPost(contentDiv);
      return "게시물";
    case "analytics":
      await loadAnalytics(contentDiv);
      return "분석";
    case "feed":
      await loadFeed(contentDiv);
      return "피드";
    case "activity":
      await loadActivity(contentDiv);
      return "활동";
    case "message":
      await loadMessage(contentDiv);
      return "메세지";
    case "pageContent":
      await loadPageContent(contentDiv);
      return "페이지 내용";
    case "hiring":
      await loadHiring(contentDiv);
      return "채용";
    case "premium":
      await loadPremium(contentDiv);
      return "프리미엄";
    case "advertisement":
      await loadAdvertisement(contentDiv);
      return "광고";
    case "setting":
      await loadSetting(contentDiv);
      return "설정";
    default:
      console.log("기본값");
      return "기본값";
  }
}

//메뉴 스타일 변경 함수
function changeMenuStyle(url) {
  // 클릭된 메뉴
  let menuElement;
  // 모든 메뉴의 스타일을 초기화합니다.
  Array.from(menuList).forEach((element) => {
    // 클릭된 메뉴를 찾습니다.
    if (element.getAttribute("data-url") == url) {
      menuElement = element;
    }
    element.classList.remove("text-green-900", "border-l-4");
  });
  //클릭된 메뉴의 스타일을 변경합니다.
  menuElement.classList.add("text-green-900", "border-l-4");
}
