//메뉴 오브젝트
const menuList = document.getElementsByClassName("menuList");

Array.from(menuList).forEach((element) => {
  element.addEventListener("click", (e) => {
    console.log(e.target.getAttribute("data-url"));
    const url = e.target.getAttribute("data-url");
    history.pushState({ url: `${url}` }, "", url);
  });
});

//주소 변경 이벤트 발생시
window.addEventListener("popstate", (e) => {
  console.log(e.state);
});
