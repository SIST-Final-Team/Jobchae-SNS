//이 페이지는 페이지가 처음 로딩되었을 때 필요한 데이터를 가져오는 스크립트입니다.
//필요한 데이터에는 회사의 데이터가 있습니다.
//그리고 최초 페이지 로드시 주소의 메뉴 값을 가져와서 해당하는 메뉴를 보여줍니다.

//페이지 초기 로딩 시 주소의 메뉴 값을 가져와서 해당하는 메뉴를 보여줍니다.

//내용물을 보여줄 div
const contentDiv = document.getElementById("contentDiv");

window.onload = function () {
  //주소를 자겨온다
  const addressUrl = window.location.pathname;

  //주소에서 메뉴 값을 가져온다
  const menu = addressUrl.split("/")[5];

  getContent(menu, contentDiv);
  changeMenuStyle(menu);
};
