let htmlResultListFirst = ``;  // 검색결과 리스트 최근 3개
let htmlResultListSecond = ``; // 모든 검색결과 리스트
let html_recentPage = ``;      // 최근 방문 프로필 리스트

document.addEventListener("DOMContentLoaded", function () {
  //객체 가져오기
  const searchBoxInput = document.querySelector("#searchInput");
  const SearchResultBox = document.querySelector("#SearchResultBox");
  const clickBlackout = document.querySelector("#clickBlackout");
  const SearchBoxButton = document.querySelector("#SearchBoxSeeAll");
  const searchBoxMenuRecentPage = document.querySelector(
    "#searchBoxMenuRecentPage"
  );
  const searchBoxMenuRecent = document.querySelector("#searchBoxMenuRecent");
  //결과 데이터
  const data = JSON.parse(
    '[{"num":1},{"num":2},{"num":3},{"num":4},{"num":5},{"num":6},{"num":7},{"num":8},{"num":9},{"num":10},{"num":11},{"num":12},{"num":13},{"num":14},{"num":15}]'
  );
  //검색 결과 개수 카운트
  let resultListCount = 0;


  const headerProfile = document.getElementById("headerProfile");
  const headerProfileIcon = document.getElementById("headerProfileIcon");


  //프로필 아이콘 클릭시
  headerProfileIcon.addEventListener("click", () => {
    headerProfileIcon.classList.toggle("opacity-50");
    headerProfile.classList.toggle("hidden");
  });

  //프로필 박스 클릭시
  headerProfile.addEventListener("click", (e) => {
    //이벤트 버블링 방지
    e.stopPropagation();
  });


  getSearchHistory(); // 검색 기록 가져오기
  getProfileView(); // 프로필 방문 기록 가져오기

  //검색 버튼 클릭시
  //스타일 클래스 토글
  searchBoxInput.addEventListener("click", (e) => {
    //이벤트 버블링 방지
    e.stopPropagation();
    const className = SearchResultBox.className;
    if (className.indexOf("hidden") != -1) {
      SearchResultBox.classList.toggle("hidden");
      clickBlackout.classList.toggle("searchBoxShadow");
	  clickBlackout.style.display="block";
      searchBoxInput.classList.toggle("searchBoxActive");
      SearchResultBox.classList.toggle("searchBoxResultActive");
    }
  });
  //바디 선택시
  clickBlackout.addEventListener("click", (e) => {
    const className = e.target.className;

    //스타일 클래스 토글
    if (
      SearchResultBox.className.indexOf("hidden") == -1 &&
      className.substring(0, "SearchBoxDropDown".length) != "SearchBoxDropDown"
    ) {
      SearchResultBox.classList.toggle("hidden");
      clickBlackout.classList.toggle("searchBoxShadow");
	  clickBlackout.style.display="none";
      searchBoxInput.classList.toggle("searchBoxActive");
      SearchResultBox.classList.toggle("searchBoxResultActive");
      searchBoxReturn();
    }
  });

  //모두보기 버튼 클릭시
  SearchBoxButton.addEventListener("click", (e) => {
    e.stopPropagation();
    //모두보기 버튼 텍스트 변경
    //기본 상태인 경우
    if (SearchBoxButton.textContent.trim() == "모두 보기") {
      SearchBoxButton.textContent = "지우기";
      searchBoxMenuRecentPage.innerHTML = "<hr class='border-gray-200'/>";
      searchBoxMenuRecent.innerHTML = htmlResultListSecond;
      //검색결과가 10개 이상일 경우 스크롤바 생성
      if (resultListCount > 10) {
        document
          .querySelector("#searchBoxMenuRecentSecond")
          .classList.add("h-80", "overflow-auto");
      }
    } else {
      //모든 검색결과 화면일 경우
      //   SearchBoxButton.textContent = "모두 보기";
      //   searchBoxMenuRecentPage.innerHTML = html_recentPage;
      //   searchBoxMenuRecent.innerHTML = htmlResultListFirst;
      //   document
      //     .querySelector("#searchBoxMenuRecentSecond")
      //     .classList.remove("h-80", "overflow-auto");
      searchBoxReturn();
    }
  });

  //처음 검색화면으로 복귀 함수
  function searchBoxReturn() {
    SearchBoxButton.textContent = "모두 보기";
    searchBoxMenuRecentPage.innerHTML = html_recentPage;
    searchBoxMenuRecent.innerHTML = htmlResultListFirst;
    if(document.querySelector("#searchBoxMenuRecentSecond") != null) {
      document
        .querySelector("#searchBoxMenuRecentSecond")
        .classList.remove("h-80", "overflow-auto");
    }
  }

  function getSearchHistory() {
    $.ajax({
      url: "/jobchae/history/search",
      dataType: "json",
      async:"false",
      success: function (json) {
        if(json.length>0) {
          htmlResultListFirst = `<ul class="SearchBoxDropDown">`; // 검색결과 리스트 최근 3개
          htmlResultListSecond = `<ul class="SearchBoxDropDown" id="searchBoxMenuRecentSecond">`; // 모든 검색결과 리스트
          for(let i=0; i<json.length; i++) {
  
            //검색결과 리스트 최근 3개
            if(i<3) {
              htmlResultListFirst += `
                    <li class="SearchBoxDropDown mb-2 mr-5">
                      <a href="${ctxPath}/search/all?searchWord=${json[i].searchHistoryWord}" class="w-full hover:bg-gray-200 flex py-1 rounded">
                        <div class="SearchBoxDropDown w-1/11"><i class="fa-solid fa-magnifying-glass"></i></div>
                        <div class="SearchBoxDropDown w-10/11">${json[i].searchHistoryWord}</div>
                      </a>
                    </li>`;
            }
            htmlResultListSecond += `<li class="SearchBoxDropDown mb-2 mr-5">
                                      <a href="${ctxPath}/search/all?searchWord=${json[i].searchHistoryWord}" class="w-full hover:bg-gray-200 flex py-1 rounded">
                                        <div class="SearchBoxDropDown w-1/11"><i class="fa-solid fa-magnifying-glass"></i></div>
                                        <div class="SearchBoxDropDown w-10/11">${json[i].searchHistoryWord}</div>
                                      </a>
                                      </li>`;
          }
          htmlResultListFirst += `</ul>`;
          htmlResultListSecond += `</ul>`;
        }
        else {
          htmlResultListFirst += `<div>검색 기록이 없습니다.</div>`;
          htmlResultListSecond += `<div>검색 기록이 없습니다.</div>`;
        }

        searchBoxReturn();
        
      }
    });
  }

  function getProfileView() {
    $.ajax({
      url: "/jobchae/history/profile",
      dataType: "json",
      async:"false",
      success: function (json) {
        console.log(JSON.stringify(json));
        if(json.length>0) {
          
          html_recentPage = `<ul>`; // 최근 방문 프로필 리스트
          for(let i=0; i<json.length; i++) {
            html_recentPage += `
              <li class="SearchBoxDropDown rounded-lg">
                <a href="${ctxPath}/member/profile/${json[i].member_id}" class="text-center">
                  <div class="SearchBoxDropDown">
                    <img
                      class="SearchBoxDropDown w-10 h-10 mx-auto"
                      src="${ctxPath}/resources/files/profile/${json[i].member_profile}"
                    />
                  </div>
                  <div>
                    <span clas="SearchBoxDropDown text-[0.8rem] font-bold"
                      >${json[i].member_name}</span
                    >
                  </div>
                </a>
              </li>`;
          }
          html_recentPage += `</ul>`;
        }
        else {
          html_recentPage = ``;
        }

        searchBoxReturn();
        
      },
      error: function (request, status, error) {
          alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
      }
    });
  }
});