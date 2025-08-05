<%--
  Created by IntelliJ IDEA.
  User: gyu99
  Date: 25. 8. 4.
  Time: 오후 8:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
  input.member-checkbox {
    zoom: 1.2;
  }
</style>

<style type="text/tailwindcss">
  /* 모달 애니메이션 */
  .animate-slideDown {
    animation: slideDown 0.4s cubic-bezier(0.22, 1, 0.36, 1);
  }
  .animate-slideUp {
    animation: slideUp 0.4s cubic-bezier(0.4, 0, 0.6, 1);
  }

  @keyframes slideDown {
    from {
      transform: translateY(-20%);
      opacity: 0;
    }
    to {
      transform: translateY(0);
      opacity: 1;
    }
  }
  @keyframes slideUp {
    from {
      transform: translateY(0);
      opacity: 1;
    }
    to {
      transform: translateY(-20%);
      opacity: 0;
    }
  }
  .button-disabled {
    @apply border-1 border-gray-200 rounded-full px-3 py-0.5 font-bold text-gray-400 text-lg bg-gray-200;
    @apply cursor-not-allowed!;
  }
</style>

<script>
  requestLock = false;
  $(document).ready(function () {

      // === 모달 관련 자바스크립트 ====================================================================================

      // 모달 애니메이션 추가 (애니메이션 선언은 modalCreateChatroom.jsp의 tailwindcss 참조)
      $("dialog.modal").addClass("animate-slideDown");

      // 모달 열기
      $(document).on("click", ".btn-open-modal", function () {// 채팅방 생성 모달 띄우기
          const targetModal = $(this).data("target-modal");
          const modalId = "#modal" + targetModal;
          $(modalId)[0].showModal();
      });

      // X 버튼으로 모달 닫기
      $(".btn-close-modal").on("click", function (e) {
          dialog = $(this).parent().parent().parent()[0];
          $(dialog).removeClass("animate-slideDown"); // 열리는 애니메이션 제거
          $(dialog).addClass("animate-slideUp"); // 닫히는 애니메이션 추가

          // 애니메이션이 끝난 후 모달 닫기
          setTimeout(() => {
              dialog.close();
              $(dialog).removeClass("animate-slideUp"); // 닫히는 애니메이션 제거
              $(dialog).addClass("animate-slideDown"); // 열리는 애니메이션 추가
          }, 300);
      });

      // ==========================================================================================================

    // 친구(팔로우) 목록 가져오기
    getFollowers();

    // 체크박스 체크되면 채팅방 만들기 버튼 활성화
    $(document).on("input", ".member-checkbox", function() {
        if($(".member-checkbox:checked").length > 0) {
            const $createChatroom = $("#createChatroom");
            $createChatroom.removeClass("button-disabled");
            $createChatroom.addClass("button-selected");
        }
        else {
            const $createChatroom = $("#createChatroom");
            $createChatroom.removeClass("button-selected");
            $createChatroom.addClass("button-disabled");
        }
    });

    // 채팅방 만들기 버튼 클릭시 폼 제출
    $("#createChatroom").on("click", function () {
        const $membersEl = $(".member-checkbox:checked"); // 참여자 <li> Elements
        const followIdList = [];
        const followNameList = [];

        // 참여자 아이디 목록과 이름 목록을 리스트에 저장
        for(let i=0; i<$membersEl.length; i++) {
            followIdList.push($membersEl.eq(i).data("member-id"));
            followNameList.push($membersEl.eq(i).data("member-name"));
        }

        // console.log(followIdList);
        // console.log(followNameList);

        createChatroom(followIdList, followNameList); // 채팅방 만들기
    });

  });

  // 친구(팔로우) 목록 가져오기
  function getFollowers() {
    if(requestLock) {
      return;
    }
    requestLock = true;
    $.ajax({
      url: ctxPath + "/api/follow/following-members",
      data: {"followerId": "${sessionScope.loginuser.member_id}"},
      type: "get",
      dataType: "json",
      success: function (json) {
        if(json.length !== 0) {
          // console.log(json);
          let html = "";
          for(let i = 0; i < json.length ; i++) {
            html += `
              <li class="flex">
                <input type="checkbox" id="memberCheckbox\${i}" class="member-checkbox my-auto h-full accent-orange-600 opacity-70 mr-2"
                  data-member-id="\${json[i].member_id}" data-member-name=\${json[i].member_name}>
                <label for="memberCheckbox\${i}" class="border-b-1 border-gray-200 w-full text-left flex px-6 py-3">
                  <img class="w-15 h-15 object-cover rounded-full mr-4"
                       src="${pageContext.request.contextPath}/resources/files/profile/\${json[i].member_profile}"  alt="프로필 이미지"/>
                  <div class="flex-1">
                    <div class="font-bold text-[1.05rem]">\${json[i].member_name}</div>
                    <div class="text-gray-500 text-sm">\${json[i].region_name}</div>
                  </div>
                </label>
              </li>
            `;
          }
          $(".following-list").html(html);
        }
        requestLock = false;
      },
      error: function (request, status, error) {
        console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        requestLock = false;
      }
    });
  }

  // 채팅방 만들기
  function createChatroom(followIdList, followNameList) {
      if(requestLock) {
          return;
      }
      requestLock = true;
      $.ajax({
          url: ctxPath + "/chat/createchatroom",
          data: {"follow_id_List": followIdList,
                 "follow_name_List": followNameList},
          type: "post",
          dataType : "json",
          success: function (json) {
              requestLock = false;
              if(json.roomId != null) {
                  window.location = ctxPath + "/chat/mainChat/" + json.roomId;
              }
              else {
                  alert("오류로 인하여 채팅방 개설이 불가합니다. 나중에 다시 시도해주십시오.");
              }
          },
          error: function (request, status, error) {
              console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
              requestLock = false;
          }
      });
  }
</script>

<dialog id="modalCreateChatroom"
        class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
  <div class="modal-box w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
    <!-- 모달 상단부 -->
    <div>
      <button type="button" class="btn-close-modal absolute aspect-square w-10 right-3 top-4">
        <i class="fa-solid fa-xmark text-xl"></i>
      </button>
      <h1 class="h1 px-6">채팅방 만들기</h1>

      <hr class="border-gray-200 mt-4">
    </div>

    <!-- 모달 내용 -->
    <div class="space-y-4 overflow-auto">
      <div class="px-6">
        <div class="text-gray-500 pb-2">초대할 회원을 선택하세요.</div>
        <ul class="following-list">
          <li class="flex">
            <input type="checkbox" id="memberCheckbox1" class="member-checkbox my-auto h-full accent-orange-600 opacity-70 mr-2">
            <label for="memberCheckbox1" class="border-b-1 border-gray-200 w-full text-left flex px-6 py-3">
              <img class="w-15 h-15 object-cover rounded-full mr-4"
                   src="${pageContext.request.contextPath}/resources/files/profile/default/profile.png"  alt="프로필 이미지"/>
              <div class="flex-1">
                <div class="font-bold text-[1.05rem]">회원명</div>
<%--                  <div>학교명 학생</div>--%>
                  <div>회사명 재직중</div>
                  <div class="text-gray-500 text-sm">지역</div>
              </div>
            </label>
          </li>
          <li class="flex">
            <input type="checkbox" id="memberCheckbox2" class="member-checkbox my-auto h-full accent-orange-600 opacity-70 mr-2">
            <label for="memberCheckbox2" class="border-b-1 border-gray-200 w-full text-left flex px-6 py-3">
              <img class="w-15 h-15 object-cover rounded-full mr-4"
                   src="${pageContext.request.contextPath}/resources/files/profile/default/profile.png"  alt="프로필 이미지"/>
              <div class="flex-1">
                <div class="font-bold text-[1.05rem]">회원명</div>
                <%--                  <div>학교명 학생</div>--%>
                <div>회사명 재직중</div>
                <div class="text-gray-500 text-sm">지역</div>
              </div>
            </label>
          </li>
          <li class="flex">
            <input type="checkbox" id="memberCheckbox3" class="member-checkbox my-auto h-full accent-orange-600 opacity-70 mr-2">
            <label for="memberCheckbox3" class="border-b-1 border-gray-200 w-full text-left flex px-6 py-3">
              <img class="w-15 h-15 object-cover rounded-full mr-4"
                   src="${pageContext.request.contextPath}/resources/files/profile/default/profile.png"  alt="프로필 이미지"/>
              <div class="flex-1">
                <div class="font-bold text-[1.05rem]">회원명</div>
                <%--                  <div>학교명 학생</div>--%>
                <div>회사명 재직중</div>
                <div class="text-gray-500 text-sm">지역</div>
              </div>
            </label>
          </li>
        </ul>
      </div>
    </div>

    <!-- 모달 하단부 -->
    <div>
      <hr class="border-gray-200 mb-4">
      <div class="flex justify-end items-center px-6 pb-1">
        <div>
<%--          <button type="button" id="createChatroom" class="button-selected">채팅방 만들기</button>--%>
          <button type="button" id="createChatroom" class="button-disabled">채팅방 만들기</button>
        </div>
      </div>
    </div>
  </div>
</dialog>