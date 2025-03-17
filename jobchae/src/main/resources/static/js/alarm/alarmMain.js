let pageNumber = 0;
let currentType = "";

const alarmLists = document.getElementById("alarmLists");

// <div class="bg-white rounded-lg shadow mb-4 overflow-hidden">
//     <div class="border-b border-gray-100 p-4 flex">
//       <div class="flex-shrink-0 mr-3">
//         <div
//           class="bg-blue-50 w-10 h-10 rounded flex items-center justify-center"
//         >
//           <i class="fas fa-chart-bar text-blue-500"></i>
//         </div>
//       </div>
//       <div class="flex-grow">
//         <p class="text-sm">
//           회원님의 업데이트 노출수가 지난 주 14회였습니다. 분석 보기
//         </p>
//         <p class="text-xs text-gray-500 mt-1">2시간</p>
//       </div>
//       <div class="flex-shrink-0">
//         <button
//           class="text-gray-500 hover:text-gray-700 hover:bg-gray-100 w-7 h-7 rounded-full"
//         >
//           <i class="fas fa-ellipsis-h"></i>
//         </button>
//       </div>
//     </div>
//   </div>
let notificationHtml = "";
let loadAlarms = true;
let lastItem = "";

//Intersection Observer API
const observer = new IntersectionObserver((entries) => {
  entries.forEach(
    (entry) => {
      if (entry.isIntersecting) {
        // console.log(loadAlarms);
        if (loadAlarms) {
          getAlarms(currentType);
        }
      }
    },
    { threshold: 0.1 }
  );
});

// 알림을 가져오는 비동기 함수
async function getAlarms(type) {
  currentType = type;
  let url = "";
  switch (type) {
    case "all":
      url = `/jobchae/api/alarm/selectAlarmList/${pageNumber}`;
      break;
    case "comment":
      url = `jobchae/api/alarm/selectAlarmListByComment/${pageNumber}`;
      break;
    case "like":
      url = `/jobchae/api/alarm/selectAlarmListByLike/${pageNumber}`;
      break;
    case "followPost":
      url = `/jobchae/api/alarm/selectAlarmListByFollowPost/${pageNumber}`;
      break;
  }
  // console.log(url);

  const response = await fetch(`${url}`);
  const jsonData = await response.json();
  // console.log(jsonData);
  const alarmList = jsonData["list"];
  loadAlarms = jsonData.hasNext;
  // console.log(loadAlarms);
  addAlarms(alarmList);
}

// 알림 추가 함수
function addAlarms(alarmList) {
  // console.log(alarmList);
  let notificationIsRead = "";
  let notificationIsDeleted = false;
  const alarmLength = alarmList.length;
  const today = new Date();

  // 알림이 없을 경우 observer 해제
  if (loadAlarms == false) {
    observer.disconnect();
  }

  alarmList.forEach((alarm, index) => {
    // console.log(alarm);
    switch (alarm.notificationIsRead) {
      case -1:
        notificationIsDeleted = true;
        break;
      case 0:
        notificationIsRead = "bg-blue-50";
        break;
      case 1:
        notificationIsRead = "bg-blue-50";
        break;
      case 2:
        notificationIsRead = "bg-white";
        break;
    }

    let notificationContent = "";
    let notificationLogo = "";
    let boardContent = "";
    // 게시물 내용
    if (
      alarm.notificationType == "FOLLOWER_POST" ||
      alarm.notificationType == "COMMENT" ||
      alarm.notificationType == "LIKE"
    ) {
      boardContent = alarm.alarmData.boardContent.replace(/<[^>]*>/g, "");
      // console.log(boardContent);
      // 게시물 내용이 25자 이상일 경우 ...으로 표시
      if(boardContent != null){
        if (boardContent.length > 25) {
          boardContent = boardContent.substring(0, 25) + "...";
        }
      }
    }
    // 댓글 내용
    let commentContent = "";
    if (alarm.notificationType == "COMMENT") {
      commentContent = alarm.alarmData.commentContent;
      // 댓글 내용이 25자 이상일 경우 ...으로 표시
      if(commentContent != null){
        if (commentContent.length > 25) {
          commentContent = commentContent.substring(0, 25) + "...";
        }
      }

    }

    // console.log(alarm);
    switch (alarm.notificationType) {
      case "COMMENT": // 댓글
        notificationLogo = `/jobchae/resources/files/profile/${alarm.targetMember.member_profile}`;
        notificationContent = `${alarm.targetMember.member_name}님이 게시물에 댓글이 달았습니다.
                <div class="bg-white border border-gray-400 rounded-lg"><p class="border-b border-gray-300 mt-2 mb-2">${boardContent}</p>
                <p class="mt-2 mb-2">${commentContent}</p></div>
                `;
        break;
      case "FOLLOW": //팔로우 알림
        notificationLogo = `/jobchae/resources/files/profile/${alarm.targetMember.member_profile}`;
        notificationContent = `<a class ="targetLink" href="/${alarm.alarmData.targetURL}">${alarm.targetMember.member_name} 님이 팔로우 하기 시작했습니다.</a>`;
        break;
      case "LIKE": //좋아요 알림
        notificationLogo = `/jobchae/resources/files/profile/${alarm.targetMember.member_profile}`;
        notificationContent = `${alarm.targetMember.member_name}님이 게시물에 반응을 했습니다.`;
        break;
      case "FOLLOWER_POST": //팔로워의 게시물 알림
        notificationLogo = `/jobchae/resources/files/profile/${alarm.targetMember.member_profile}`;
        notificationContent = `팔로우 하고 있는 ${alarm.targetMember.member_name}님이 게시물을 올렸습니다.${alarm.alarmData.boardContent}`;
        break;
    }
    // 알림 등록 날짜
    const date = new Date(alarm.notificationRegisterDate);

    // 시간 계산
    const diffrentDate = getDiffrentTime(date, today);

    // console.log(alarm);

    // if (date.get) console.log(date);
    if (!notificationIsDeleted) {
      notificationHtml += `
            <div class="${notificationIsRead} rounded-lg shadow mb-4 alarmItem" data-alarm-id =${alarm.notificationNo} >
              <div class="border-b border-gray-100 p-4 flex">
                <div class="flex-shrink-0 mr-3">
                  <div
                    class="bg-blue-50 w-10 h-10 rounded flex items-center justify-center"
                  >
                    <img
                      src="${notificationLogo}"
                      alt="Profile"
                      class="w-9 h-9 rounded-full">
                  </div>
                </div>
                <div class="flex-grow">
                  <p class="text-sm">
                    ${notificationContent}
                  </p>
                  <p class="text-xs text-gray-500 mt-1">${diffrentDate}</p>
                </div>
                <div class="flex-shrink-0">
                  <details
                    class="text-gray-500 hover:text-gray-700 hover:bg-gray-100 w-7 h-7 rounded-full text-center items-center relative rounded"
                  >
                  <summary>
                    <i class="fas fa-ellipsis-h"></i>
                  </summary>
                    <div class="w-62 absolute border border-gray-300 z-50 p-2 right-0 bg-white rounded-lg shadow alarmDropdown">
                      <button class="p-2 w-full block text-left hover:bg-gray-100 alarmUpdateReadButton alarmDropdown"><i class="fa-regular fa-bell"></i>&nbsp;&nbsp;&nbsp;&nbsp;읽음 설정&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-greater-than"></i></button>
                      <button class="p-2 w-full block text-left hover:bg-gray-100 alarmDeleteButton alarmDropdown"><i class="fa-solid fa-trash"></i>&nbsp;&nbsp;&nbsp;&nbsp;알림 삭제&nbsp;&nbsp;&nbsp;</button>
                    </div>
                  </details>
                </div>
              </div>
            </div>`;
    }
    if (alarmLength - 1 == index) {
      lastItem = alarm.notificationNo;
    }
  });

  // console.log(notificationHtml);
  // 알림 리스트 추가
  alarmLists.innerHTML = notificationHtml;
  // 페이지 넘버 증가
  pageNumber++;
  const deleteButton = document.getElementsByClassName("alarmDeleteButton");
  const updateReadButton = document.getElementsByClassName(
    "alarmUpdateReadButton"
  );

  Array.from(deleteButton).forEach((item) => {
    item.addEventListener("click", (e) => {
      deleteAlarm(e);
    });
  });
  Array.from(updateReadButton).forEach((item) => {
    item.addEventListener("click", (e) => {
      const notificationItem = e.target.closest(".alarmItem");
      updateAlarmRead(notificationItem);
    });
  });

  // 알림 카운트 초기화
  const newAlarmCount = document.getElementById("newAlarmCount");
  // console.log("알림데이터는 " + newAlarmCount);
  newAlarmCount.textContent = 0;
  if (!newAlarmCount.classList.contains("!hidden")) {
    newAlarmCount.classList.add("!hidden");
  }

  // 알림 클릭시 읽음 처리
  const targetLink = document.getElementsByClassName("targetLink");
  Array.from(targetLink).forEach((item) => {
    item.addEventListener("click", (e) => {
      const notificationItem = e.target.closest(".alarmItem");
      updateAlarmRead(notificationItem);
    });
  });

  // observer 등록
  observer.observe(document.querySelector(`[data-alarm-id="${lastItem}"]`));
}

//시간 계산 함수
function getDiffrentTime(date, today) {
  let year = today.getFullYear() - date.getFullYear();
  let month = today.getMonth() - date.getMonth();
  let day = today.getDate() - date.getDate();
  const diffrentDate = today - date;
  let second = Math.floor(diffrentDate / 1000);
  let minute = Math.floor(second / 60);
  let hour = Math.floor(minute / 60);

  if (day < 0) {
    month -= 1;
    const lastDayofLastMonth = new Date(
      today.getFullYear(),
      today.getMonth(),
      0
    ).getDate();

    day += lastDayofLastMonth;
  }

  if (month < 0) {
    year -= 1;
    month += 12;
  }
  if (year > 0) {
    return year + "년 전";
  }
  if (month > 0) {
    return month + "달 전";
  }
  if (day > 0) {
    return day + "일 전";
  }
  hour = today.getHours() - date.getHours();
  if (hour > 0) {
    return hour + "시간 전";
  }
  minute = today.getMinutes() - date.getMinutes();
  if (minute > 0) {
    return minute + "분 전";
  }
  second = today.getSeconds() - date.getSeconds();
  if (second > 5) {
    return second + "초 전";
  } else {
    return "방금 전";
  }
}

// 알림 삭제 함수
async function deleteAlarm(e) {
  // console.log("deleteAlarm");
  const notificationNo = e.target.closest(".alarmItem").dataset.alarmId;
  const response = await fetch(
    `http://localhost/jobchae/api/alarm/deleteAlarm/${notificationNo}`,
    {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
  const jsonData = await response.json();
  // console.log(jsonData);
  if (response.status == 200) {
    console.log(e.target.closest(".alarmItem"));
    e.target.closest(".alarmItem").remove();
  }
}

// 알림 읽음 처리 함수
async function updateAlarmRead(notificationItem) {
  const notificationNo = notificationItem.getAttribute("data-alarm-id");
  // console.log(notificationNo);
  const response = await fetch(
    `http://localhost/jobchae/api/alarm/updateAlarmRead/${notificationNo}`,
    {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
  if (response.status == 200) {
    notificationItem.classList.remove("bg-blue-50");
    notificationItem.classList.add("bg-white");
  }
  const jsonData = await response.json();
}

function getAlarmListByFilter(filter) {}
// 필터링 함수
async function selectByFilter() {
  const alarmFilter = document.getElementsByClassName("filterButton");
  Array.from(alarmFilter).forEach((item) => {

    item.addEventListener("click", (e) => {

      pageNumber = 0;
      alarmLists.innerHTML = "";
      notificationHtml = "";
      // console.log(e.target.getAttribute("data-type"));
      getAlarms(e.target.getAttribute("data-type"));

        // 필터링 버튼 스타일 변경
      changeButtonStyle(e.target, Array.from(alarmFilter));


    });
  });
}

function changeButtonStyle(target, buttons){
  // 모든 필터링 버튼 스타일 변경
  buttons.forEach((item) => {
    // 현재 선택되어 있는 필터링 버튼 스타일 변경
    if(item.classList.contains("button-selected")){
      item.classList.remove("button-selected");
      item.classList.add("button-gray");
    }
  });
  // 눌린 필터링 버튼 스타일 변경")
  if(target.classList.contains("button-gray")){
    target.classList.remove("button-gray");
    target.classList.add("button-selected");
  }

}

// 비동기 함수 초기화
async function initialize() {
  // 알림 가져오기
  await getAlarms("all");
  await selectByFilter();
}

// 초기화 함수 실행
initialize();
