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





<style type="text/tailwindcss">
    html {
        font-size: 0.9rem;
    }
    body {
        background-color: rgb(244, 242, 238);
    }
    dialog::backdrop {
        background:rgba(0, 0, 0, 0.6);
    }
    .h1 {
        @apply text-[1.35rem] font-bold;
    }
    .border-normal {
        @apply border-1 border-gray-300 rounded-lg bg-white;
    }
    .border-search-board {
        @apply border-1 border-gray-300 rounded-lg bg-white;

        &>li:not(:last-child) {
            @apply border-b-4 border-gray-200;
        }

        &>li {
            @apply space-y-2;
        }

        &>li:not(.py-0) {
            @apply pt-4 pb-2;
        }

        &>li>*:not(.px-0) {
            @apply px-4;
        }

        .button-more {
            @apply rounded-b-lg py-2 text-center font-bold text-lg w-full cursor-pointer hover:bg-gray-100 transition-all duration-200;
        }
    }
    .border-board {
        @apply space-y-4;

        &>div {
            @apply border-1 border-gray-300 rounded-lg bg-white;
        }

        &>div:not(.space-y-0) {
            @apply space-y-2;
        }

        &>div:not(.py-0) {
            @apply pt-4;
            @apply pb-2;
        }

        &>div>*:not(.px-0) {
            @apply px-4;
        }

        .button-more {
            @apply rounded-b-lg py-2 text-center font-bold text-lg w-full cursor-pointer hover:bg-gray-100 transition-all duration-200;
        }
    }
    .border-search-member {
        @apply border-1 border-gray-300 rounded-lg bg-white;

        &>div:not(:last-child) {
            @apply border-b-1 border-gray-300 space-y-2;
        }

        &>div:not(.py-0) {
            @apply py-4;
        }

        &>div>*:not(.px-0) {
            @apply px-4;
        }
    }
    .button-more {
        @apply rounded-b-lg py-2 text-center font-bold text-lg w-full cursor-pointer hover:bg-gray-100 transition-all duration-200;
    }
    .nav-selected {
        @apply relative before:inline-block before:absolute before:w-0.5 before:h-10 before:bg-green-800 before:mr-2 before:left-0 before:top-1/2 before:-translate-y-1/2;
    }
    .nav {
        @apply list-none pb-2 [&>li]:px-4 [&>li]:hover:bg-gray-100 [&>li]:cursor-pointer [&>li>a]:block [&>li>a]:py-2;
    }
    .border-list {
        @apply my-0.5 space-y-4 py-4 bg-white;
        @apply first:border-1 first:border-gray-300 first:rounded-t-lg;
        @apply not-first:border-1 not-first:border-gray-300;
        @apply last:border-1 last:border-gray-300 last:rounded-b-lg;
    }
    .button-gray:not(.button-selected) {
        @apply border-1 rounded-full border-gray-400 px-3 py-0.5 font-bold text-gray-700 text-lg;
        @apply hover:bg-gray-100 hover:inset-ring-1 hover:inset-ring-gray-400 transition-all duration-200;
        @apply hover:cursor-pointer;
    }
    .button-orange:not(.button-selected) {
        @apply border-1 rounded-full border-orange-500 px-3 py-0.5 font-bold text-orange-500 text-lg;
        @apply hover:bg-gray-100 hover:inset-ring-1 hover:inset-ring-orange-500 transition-all duration-200;
        @apply hover:cursor-pointer;
    }
    .button-selected {
        @apply border-1 border-orange-400 rounded-full px-3 py-0.5 font-bold text-white text-lg bg-orange-400;
        @apply hover:bg-orange-500 hover:border-orange-500 transition-all duration-200;
        @apply hover:cursor-pointer;
    }
    .board-member-profile {
        @apply flex gap-4;

        /* 프로필 이미지 */
        div:first-child>a>img {
            @apply w-15 h-15 object-cover;
        }

        div:nth-child(2) span {
            @apply block text-gray-600 text-sm;
        }

        div:nth-child(2) span:first-child {
            @apply font-bold text-lg text-black;
        }

        /* 프로필 정보 및 팔로우 버튼 */
        div:nth-child(3) {
            @apply flex items-start;

            button {
                @apply px-4 py-1 text-lg rounded-full;
            }

            button:hover {
                @apply bg-gray-100 cursor-pointer;
            }

            /* 팔로우 버튼 */
            .follow-button {
                @apply text-orange-500 font-bold;
            }

            /* 팔로우 버튼 */
            .unfollow-button {
                @apply text-black;
            }
        }
    }

    .file-image {
        @apply grid grid-flow-row-dense grid-flow-col gap-1 p-0.5;

        :hover {
            @apply cursor-pointer;
        }

        button:first-child {
            @apply max-h-[50rem] m-auto col-span-3;
        }
        button:not(:first-child) {
            @apply m-auto;
        }

        button:not(:first-child)>img {
            @apply object-cover aspect-[3/2];
        }
        button.more-image {
            @apply relative;
        }
        button.more-image>img {
            @apply brightness-50;
        }
        button.more-image>span {
            @apply absolute text-white;
            @apply top-1/2 -translate-y-1/2 left-1/2 -translate-x-1/2;
        }
    }

    .reaction-images {
        @apply flex items-center;
        img {
            @apply w-6 rounded-full border-2 border-white;
        }
        img:not(img:last-child) {
            @apply -mr-2;
        }
    }

    .button-underline {
        @apply flex hover:cursor-pointer hover:underline hover:text-orange-500;
    }

    .hover-underline {
        @apply hover:cursor-pointer hover:underline hover:text-orange-500;
    }

    .button-board-action {
        @apply w-full h-10 flex items-center justify-center rounded-md font-bold hover:cursor-pointer hover:bg-gray-100;
    }
    button {
        @apply hover:cursor-pointer;
    }

    .btn-transparent {
        @apply px-4 py-1 text-lg rounded-full;
    }

    .btn-transparent:hover {
        @apply bg-gray-100 cursor-pointer;
    }
	
	
	.chatting_own {
		@apply bg-yellow-100 rounded-lg p-2 text-sm text-gray-800 break-words max-w-xs ml-auto
	}
	.chatting {
		@apply bg-blue-100 rounded-lg p-2 text-sm text-gray-800 break-words max-w-xs mr-auto
	}
	.chatting_own_time {
		@apply text-xs text-gray-500 text-right
	}
	.chatting_time {
		@apply text-xs text-gray-500 text-left
	}
	.message_view {
		@apply flex flex-col justify-end
	}

	
	.sender_name {
        @apply text-sm mb-1 font-bold
    }
	.read_status {
        font-size: 7pt;
    }
	.chat_date{
		@apply bg-gray-200 rounded-full py-1 px-4 w-64 mx-auto justify-center flex justify-items-center text-xs;
	}

    .selected_chatroom{
        @apply relative before:inline-block before:absolute before:w-1 before:h-full before:bg-orange-400 before:mr-2 before:left-0 before:top-1/2 before:-translate-y-1/2;
    }
	
	.green_noReadMark{
		@apply absolute top-4 right-3 w-4 h-4 bg-green-500 rounded-full border-2 border-white;
	}
</style>

<%--
<script type="text/javascript">
	const ctxPath = '${pageContext.request.contextPath}';
    const memberId = '${requestScope.memberId}'; // 조회 대상 회원 아이디
    const reload = true; // 등록, 수정, 삭제 후 페이지 새로고침 여부
    const isMyProfile = ${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.member_id}; // 본인의 프로필인지 여부
</script>
--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member/profileMore.js"></script>


<%-- context path --%>
<c:set var="ctx_path" value="${pageContext.request.contextPath}"/>

<%-- 현재 로그인 사용자 아이디 --%>
<c:set var="login_member_id" value="${sessionScope.loginuser.member_id}"/>

<%-- 현재 로그인 사용자명 --%>
<c:set var="login_member_name" value="${sessionScope.loginuser.member_name}"/>

<%--&lt;%&ndash; 채팅방 정보 &ndash;%&gt;--%>
<%--<c:set var="chat_room" value="${requestScope.chat_room}"/>--%>

<%-- 참여자 정보 --%>
<%-- <c:set var="participants" value="${chat_room.participants}"/> --%>


<script src="${pageContext.request.contextPath}/js/chat/textareaFunction.js" defer></script> <!-- defer 속성 추가 -->

<script type="text/javascript">


let roomId = "${not empty requestScope.roomId ? requestScope.roomId : ''}"; // 지정된 채팅방인 경우 채팅방 id
let last_chat_date = ""; // 마지막으로 불러온 채팅의 날짜 기록용
let current_roomId = ""; 	 // 클릭한 채팅방의 번호를 수신 때 사용해야한다.

    $(document).ready(function() {

        // === 모달 관련 자바스크립트 (김규빈) ===========================================================================

        // 채팅방 나가기 드롭다운 모달 열기
        $(document).on("click", ".btn-open-dropdown", function() {
            const btnId = $(this).attr("id");
            const dropdownId = "#dropdown" + btnId.slice(3);
            const rect = this.getBoundingClientRect();

            $(dropdownId).css({"left":rect.left+"px","top":(rect.bottom)+"px"});
            $(dropdownId)[0].showModal();
        });

        // 바깥 클릭하면 드롭다운 모달 닫기
        $(document).on("click", ".option-dropdown", function(e) {
            if (e.target === this) {
                this.close();
            }
        });

        // ==========================================================================================================

        // 스크롤 위치에 따라 nav 선택 변경
        $(window).scroll(function() {
            for(let i=0; i<$(".center>*").length; i++) {
                if( $(".center>*").eq(i).position().top - 100 <= $(window).scrollTop() &&
                    $(window).scrollTop() < $(".center>*").eq(i).height() + $(".center>*").eq(i).position().top - 100 ) {
                    $(".nav>li").removeClass("nav-selected");
                    $(".nav>li").eq(i).addClass("nav-selected");
                }
                // console.log($(".center>*").eq(i).position().top , $(window).scrollTop());
            }
        });


        // ==========================================================================================================
        loadChatRoom(); // 채팅방 목록 표시(속도 때문에 전방배치, 먼저보여주기용도)
        $(".input-area").addClass("hidden"); // 처음에는 메시지 보내기 부분 숨기기
		
		
		// 웹소켓 연결 모듈을 통하여 연결 및 구독
        WebSocketManager.connect("${ctx_path}/ws", function () {
            // 2번째 인자인 콜백함수는 웹소캣 연결이 완료 되면 바로 실행되는 함수이다.(여기가 바로 그곳)
			// 웹소캣 연결은 비동기여서 속도차이 때문에 문제가 터질 수 있다.
			
			// 채팅방에 구독 처리 후 메시지 수신 시 채팅 내역에 보여주기
            WebSocketManager.subscribeMessage("/user/" + "${login_member_id}" + "/message", function (message) {
                showChat(message);
            });

            // 세션 만료되면 웹소캣 분리 후 알려주기
            WebSocketManager.subscribeSessionStatus("/user/" + "${login_member_id}" + "/errors", function (signal) {
                if (signal.chatType === "LOGOUT") {
                    WebSocketManager.disconnect(); // 웹소캣 연결 해제
					// 알려주고 확인하면 로그인 페이지로
					alert("세션이 만료되어 다시 로그인 해주십시오.");
                    location.href = `${pageContext.request.contextPath}/member/login`
				}//
			});

            // 만약 입장할 채팅방이 이미 정해져있다면 아래와 같은 주소로 접속했음
            // chat/chatMain/{roomId}
            if(roomId != "") {
                console.log("입장 시 룸아이디 존재하면 => ", roomId);
                // 해당하는 채팅방이 존재하는지 확인
                if($('.chatroom-list[data-room-id='+roomId+']').length > 0) {
                    // 클릭한 채팅방의 번호를 수신 때 사용해야해서 저장
                    current_roomId = roomId;
                    enterChatRoom(roomId); // 채팅방 입장
                }
                else {
                    console.log("일치하는 채팅방 없음 : "+ roomId);
                }
            }

            // 채팅방 선택시 입장
            $(document).on("click", ".chatroom-list", function () {
                roomId = $(this).data("room-id"); // 채팅방 id 설정
                // 클릭한 채팅방의 번호를 수신 때 사용해야해서 저장
                current_roomId = roomId;
                enterChatRoom(roomId); // 채팅방 입장
                console.log("선택된 채팅방의 방번호 => "+ current_roomId);
            });
        });//end of WebSocketManager.connect("${ctx_path}/ws", function () {}...
		
        
        // 엔터키 입력시 채팅 전송 처리
        $("textarea#message").on('keydown', function(e) {
            if (e.keyCode == 13) {
                if (!e.shiftKey) {
                    e.preventDefault();
                    if ($(e.target).val().trim() !== "") {
                        sendMessage(current_roomId);
                    }
                }//
            }
        });//end of $("textarea#message").keydown(function (e) {}..

        // 보내기 버튼 클릭시 채팅 전송 처리
        $("button#btn_send").click(function (e) {
            if ($("textarea#message").val().trim() !== "") {
                sendMessage(current_roomId);
            }
        });//end of $("button#btn_send").click(function (e) {}...
		

        // 채팅방 나가기 버튼 클릭시
        $(".leave-chat").on("click", function() {
            if(confirm("채팅방을 나가시겠습니까?")) {
                // // 만약 채팅방에 이미 입장되어 있다면
                // if(WebSocketManager.isConnected) {
                //     WebSocketManager.disconnect(); // 채팅방 퇴장
                // }

                $.ajax({
                    url: "${ctx_path}/chat/leaveChatRoom", //
                    data: {"roomId": roomId},
                    type: "post",
                    async: true,
                    success: function () {
                        const $enteredChatroomEl = $('.chatroom-list[data-room-id='+roomId+']');
                        $enteredChatroomEl.remove(); // 접속한 채팅방 <li> 제거

                        $(".input-area").addClass("hidden"); // 메시지 입력창 표시
                        $(".chatroom-title").html("&nbsp;"); // 채팅방 타이틀 상단에 표시
                        $("#chatting_view").html(`
                            <div class="h-full flex justify-center text-9xl">
                                <i class="fa-solid fa-comment-dots mt-[calc(20vh)] text-gray-100 "></i>
                            </div>`); // 채팅 내용 제거하고 회색 채팅 아이콘 표시

                        $("#btnChatMenu").addClass("hidden"); // 채팅방 메뉴
                        $(".option-dropdown").click(); // 드롭다운 메뉴 닫기
						resetTimesAndRoomId(); // 방을 나가면 채팅마지막 확인 시간이랑 방번호 초기화 해야함
                    },
                    error: function (request, status, error) { // 코딩이 잘못되어지면 어디가 잘못되어졌는지 보여준다!
                        alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                    }
                });
            }
        });// end of $(".leave-chat").on("click", function() {})...
        
    });//end of $(document).ready(function() {}...레디






    // 채팅방 입장 함수
    function enterChatRoom(roomId) {
		
		if (roomId === "") {
            alert("error", "채팅방 입장을 실패하였습니다");
            return;
        }
        
		getFollowersForInvite(); // 초대할 멤버 목록을 초기화, modalAddChatMember.jsp에 있음

        read_LastNoReadChat(roomId); // 안읽었던 채팅들 읽기 표시
		
		recordTimesInChatRoom(roomId); // 채팅방의 채팅 마지막 확인 시간 기록
		
        // 이전 채팅 내역 불러오기
        $.ajax({
            url    : "${ctx_path}/chat/load_chat_history/" + roomId,
            type   : "post", // 개인정보니까 post 하자
            success: function (json) {
                loadChat(json);
            },
            error  : function (error) {
                alert("error", "채팅방 입장을 실패하였습니다");
                WebSocketManager.disconnect();
            }
        });

        // 선택된 채팅방 주황색 표시해주기
        $(".chatroom-list").removeClass("selected_chatroom");
        const $enteredChatroomEl = $('.chatroom-list[data-room-id='+roomId+']');
        $enteredChatroomEl.addClass("selected_chatroom");

        // 스크롤을 입장한 채팅방의 위치로 이동
        $enteredChatroomEl[0].scrollIntoView({
            behavior: 'smooth', // 스크롤을 부드럽게 처리
            block: 'nearest'
        });

        $(".input-area").removeClass("hidden"); // 메시지 입력창 표시
        $(".chatroom-title").text($(this).find(".chatroom-member-names").text()); // 채팅방 타이틀 상단에 표시

        $("#btnChatMenu").removeClass("hidden"); // 채팅방 메뉴
    }// end of function enterChatRoom(roomId) {}...


    // 마지막 채팅을 방 목록에 표시해주기 위한 함수
    function updateLastChat(roomId, message) {
        const now = new Date();
        const month = (now.getMonth()+1) < 10? '0' + (now.getMonth()+1) : (now.getMonth()+1);
        const day = now.getDate() < 10? '0' + now.getDate() : now.getDate();

        const $selectedChatroom = $('.chatroom-list[data-room-id='+roomId+']');
        $selectedChatroom.find(".last-chat").text(message);
        $selectedChatroom.find(".chat-date").text(`\${now.getFullYear()}-\${month}-\${day}`);

        $selectedChatroom.prependTo($("#chatting_list")); // 채팅방을 맨 위로 이동시키기
        $("#chatting_list").scrollTop(0);
    }// end of function updateLastChat(roomId, message) {}...


	// 읽지않는 마지막 채팅을 방 목록에 표시해주기 위한 함수
	function updateLastChat_noRead(roomId, message) {
        const now = new Date();
        const month = (now.getMonth()+1) < 10? '0' + (now.getMonth()+1) : (now.getMonth()+1);
        const day = now.getDate() < 10? '0' + now.getDate() : now.getDate();
        
        // console.log("들어온 채팅이 선택한 방이 아닌 경우 => "+roomId);
        const $selectedChatroom = $('.chatroom-list[data-room-id="' + roomId + '"]');
    	$selectedChatroom.find(".last-chat").text(message).css({'font-weight': 'bold'}); // 굵게
    	$selectedChatroom.find(".chat-date").text(`\${now.getFullYear()}-\${month}-\${day}`).css({'font-weight': 'bold'});

        $selectedChatroom.prependTo($("#chatting_list")); // 채팅방을 맨 위로 이동시키기
        $("#chatting_list").scrollTop(0);

        // 초록 동그라미 표시
        $selectedChatroom.find(".green_noReadMark").removeClass("hidden");
		
    }// end of function updateLastChat(roomId, message) {}...

	
	// 읽지않은 마지막 채팅이 있는 채팅방을 클릭 시 상태변화 함수
	function read_LastNoReadChat(roomId) {

        const $selectedChatroom = $('.chatroom-list[data-room-id="' + roomId + '"]');
        $selectedChatroom.find(".last-chat").css({'font-weight': 'normal'}); // 다시 얇게
        $selectedChatroom.find(".chat-date").css({'font-weight': 'normal'});
        
        // 초록 동그라미 표시 삭제
        $selectedChatroom.find(".green_noReadMark").addClass("hidden");
    }

	// 읽지않는 마지막 채팅을 방 목록에 표시해주기 위한 함수(채팅방을 불러올 때만 사용)
	function updateLastChat_noRead_ChatRoomLoad(roomId, message) {
    	const now = new Date();
    	const month = (now.getMonth()+1) < 10? '0' + (now.getMonth()+1) : (now.getMonth()+1);
    	const day = now.getDate() < 10? '0' + now.getDate() : now.getDate();

    	// console.log("들어온 채팅이 선택한 방이 아닌 경우 => "+roomId);
        const $selectedChatroom = $('.chatroom-list[data-room-id="' + roomId + '"]');
    	$selectedChatroom.find(".last-chat").text(message).css({'font-weight': 'bold'}); // 굵게
    	$selectedChatroom.find(".chat-date").text(`\${now.getFullYear()}-\${month}-\${day}`).css({'font-weight': 'bold'});
    	
    	// 초록 동그라미 표시
    	$selectedChatroom.find(".green_noReadMark").removeClass("hidden");

	}// end of function updateLastChat(roomId, message) {}...
    
    
    


    let chatRoomList = []; // 채팅방 목록을 저장, 초대할 멤버 목록에서 현재 채팅방에 있는 사람을 제외하기 위해 modalAddChatMember.jsp에서 사용

    // 채팅페이지를 들어오면 바로 채팅방 목록을 보여줘야한다. 다 포스트 방식으로 해서 보안 강화하자
    function loadChatRoom() {
        $.ajax({
            url: "${ctx_path}/chat/loadChatRoom", //
            type: "post",
            async: false,       // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
            success: function (chatRoomRespDTOList) { //이거 json 객체이다.
                
                if (chatRoomRespDTOList.length > 0) {
                    let v_html = ``;

                    chatRoomList = chatRoomRespDTOList;
                    
                    for (let chatroomDTO of chatRoomRespDTOList) {
                        let chatDate = "";
                        if(chatroomDTO.latestChat.sendDate != null) {
                            chatDate = chatroomDTO.latestChat.sendDate
                                .substring(0, 10)
                                .replace(/^(\d{4})-(\d{2})-(\d{2})$/, '$1-$2-$3');
                        }

                        // 채팅방 이름을 "김규빈, 이준영, 이진호" 와 같은 형식으로 표시
                        let partiMemberList = chatroomDTO.chatRoom.partiMemberList; // 참여자 목록

                        const memberNameArray = partiMemberList.map(member => member.member_name) // map으로 참여자 이름을 배열로 가져오기
                            .filter(name => name !== '${sessionScope.loginuser.member_name}'); // 본인 이름 제외
                        // ["김규빈","이준영","이진호"]

                        const memberNames = memberNameArray.join(', ');
                        // "김규빈, 이준영, 이진호"

                        let memberProfilesHtml =  getProfileImagesHtml(chatroomDTO.memberProfileList);

                        // 채팅방에 안읽은 메세지(있으면 true, 없으면 false)
						// TODO 채팅방을 마지막으로 확인한 시간을 기록했으니 그거를 기준으로 안읽은 채팅이 있는지 없는지 구별 가능
						// 구현해야한다.
                        const unreadMarkClass = chatroomDTO.unReadChat ? '' : 'hidden'; // 안 읽었으면 '', 읽었으면 'hidden'
                        const fontWeightClass = chatroomDTO.unReadChat ? 'font-bold' : '';
                        console.log("unReadChat => ", chatroomDTO.unReadChat);
                        
                        v_html += `
                        <li class="chatroom-list relative p-4 hover:bg-gray-100 cursor-pointer border-b border-gray-200" data-room-id="\${chatroomDTO.chatRoom.roomId}">
							<span class="green_noReadMark \${unreadMarkClass}"></span> <!-- 안읽음 표시를 위한 span 태그 -->
							<div class="flex items-center space-x-4">
                                    \${memberProfilesHtml}
                            	<div class="flex-1 truncate">
									<div class="font-medium flex">
                                    	<div class="truncate chatroom-member-names">\${memberNames}</div>
                                       	<div class="text-gray-500 ml-1">\${partiMemberList.length}</div>
                                    </div>
                                	<div class="text-gray-500 text-sm truncate last-chat \${fontWeightClass}">\${chatroomDTO.latestChat.message?chatroomDTO.latestChat.message:""}</div>
                                </div>
                            	<div class="ml-auto w-20 text-gray-500 text-sm text-right chat-date \${fontWeightClass}">\${chatDate}</div>
                            </div>
                        </li>`;
                    }//end of for...
                    
                    $("#chatting_list").html(v_html);
                    
                } else {// 채팅방이 아예 없으면 없다고 표시
                    const v_html = `<div class="text-center text-gray-500 mt-4">채팅 내역이 없습니다.</div>`;
                    $("#chatting_list").html(v_html);
                }
                
            }
            ,
            error: function (request, status, error) { // 코딩이 잘못되어지면 어디가 잘못되어졌는지 보여준다!
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });//
    
    }//end of function loadChatRoom() {}...


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 채팅 부분
    
    
    // 채팅 송신
    function sendMessage(roomId) {
        const login_member_id = "${login_member_id}";
        const login_member_name = "${login_member_name}";

        // 채팅방 및 사용자 식별자가 존재하지 않을 경우
        if (roomId === "" || login_member_id === "") {
            alert("채팅 전송을 실패했습니다.");
            return;
        }

        // 채팅 내용 유효성 검사 후 송신
        if ($("textarea#message").val() != "") {
            WebSocketManager.send("/send/" + roomId,
                {
                    'senderId': login_member_id,
                    'senderName': login_member_name,
                    'message': $("#message").val(),
                    'chatType': "TALK"
                });
            updateLastChat(roomId, $("#message").val()); // 마지막 채팅 업데이트
            $("#message").val('');
        }//
    }//end of function sendMessage() {}...


    
 	// 받아온 채팅 내역 보여주기
    function showChat(chat) {
    	if (chat && chat.message) {
    		const login_member_id = "${login_member_id}";

            if (login_member_id == "") {
                alert("채팅 내역을 불러오는데 실패했습니다.");
                return;
            }//
            
            /////////////////////////////////////////////////////////////////////////////////
         	// 각 채팅의 송신날짜 년/월/일을 채팅 상단에 띄우기 위한 임시 저장값
            
            // // 년/월/일 형태 문자열 추출
            // const sendDate = chat.sendDate.substring(11, 16);
            //
         	// // 각 채팅을 표시하기 전에 날짜가 바뀌면 상단에 날짜를 표시
            // if (chat.sendDate.substring(0, 10) != last_chat_date && current_roomId != "") { // 마지막 채팅의 날짜를 비교하자
            //     const chatDate = chat.sendDate
            //         			 .substring(0, 10)
            //         			 .replace(/^(\d{4})-(\d{2})-(\d{2})$/, '$1년 $2월 $3일');
            //
            //     $("#chatting_view").append($("<div class='chat_date'>").text(chatDate));
            //     last_chat_date = chat.sendDate.substring(0, 10);
            // }//end of if (chat.sendDate.substring(0, 10) != current_date) {}...
			
			// 인스턴스 타입의 시간을 써야해서 바꾸는 시간출력
            const sendDateTime = new Date(chat.sendDate);

            const hours = String(sendDateTime.getHours()).padStart(2, '0'); // 2자리 숫자보다 작으면 0 붙인다!
            const minutes = String(sendDateTime.getMinutes()).padStart(2, '0');
            const sendDate = `\${hours}:\${minutes}`; // 메세지 표시 시간

			// 출력 시 채팅 날짜에 따른 구분을 위한 시간
            const year = sendDateTime.getFullYear();
            const month = String(sendDateTime.getMonth() + 1).padStart(2, '0');
            const day = String(sendDateTime.getDate()).padStart(2, '0');
            const chatDate = `\${year}-\${month}-\${day}`; // 날짜 구분 시간

            if (chatDate !== last_chat_date && current_roomId != "") {
                const chatDate = `\${year}년 \${month}월 \${day}일`;
                $("#chatting_view").append($("<div class='chat_date'>").text(chatDate));
                last_chat_date = chatDate; // yyyy - mm - dd 형태
			}
			
			/////////////////////////////////////////////////////////////////////////////////
   
			// 만약 선택한 채팅방의 채팅인지 아닌지 비교(TODO 선택한 채팅방의 메세지면 바로 읽음 처리해야함)
			if (current_roomId === chat.roomId) {
                recordTimesInChatRoom(current_roomId); // 선택한 채팅방이면 메세지가 왔을 때 마지막 채팅 확인 시간을 기록
                console.log("채팅방 만들자마자 여기가 실행되는지, 채팅방번호 => ", current_roomId);
                
                // 넘어온 메시지가 입장인지 퇴장인지 판별해주자
                if (chat.chatType === "LEAVE") {
                    $("#chatting_view").append($("<div class='chat_date'>").text(chat.message));
                } else if(chat.chatType === "ENTER") {
                    $("#chatting_view").append($("<div class='chat_date'>").text(chat.message));
                } else if (chat.chatType === "TALK") {
                    const chathtml = $(`<div data-chat_id = \${chat.id}>`) // data-chat_id 는 속성으로 선언가능
                        // 자신이 보낸 메시지인지 상대가 보낸 메시지인지 확인
                        .addClass("message_view") // 메세지 표시부분
                        .append(chat.senderId == login_member_id ? null : $("<div class='sender_name'>").text(chat.senderName))
                        .append($("<div>").addClass(chat.senderId == login_member_id ? 'chatting_own' : 'chatting')
                            // .append($("<pre>").text(chat.message))
                            .append($("<div>").addClass("whitespace-pre-wrap break-words").text(chat.message))
                            .append(chat.senderId == login_member_id ? $("<div class='chatting_own_time'>").text(sendDate) :
                                $("<div class='chatting_time'>").text(sendDate)));

                    $("#chatting_view").append(chathtml);
                }
                updateLastChat(chat.roomId, chat.message); // 마지막 채팅 업데이트
				
                // 스크롤을 하단으로 내리기
                scrollToBottom();
                
			}else {// 해당 채팅방으로 오지않은 메세지인 경우 않읽은 메세지 표시해줘야함
                
                
                updateLastChat_noRead(chat.roomId, chat.message);
				
			}//if (current_roomId === chat.roomId) {}...
			
			
			
        }//end of if (chat && chat.message) {}...
    }//end of function showChat(chat) {}...



    // 전체 채팅 내역 불러오기
    function loadChat(chatList) { // 이거 json 객체이다.
    	const login_member_id = "${login_member_id}";

        if (login_member_id == "") {
        	alert("error", "채팅 내역을 불러오는데 실패했습니다.");
        	return;
      	}//

        if (chatList != null) {
            $("#chatting_view").html(""); // 처음 입장시 채팅 목록 비우기
            $("textarea#message").text(""); // 입력한 텍스트 비우기
			
            // 각 채팅의 송신날짜 년/월/일을 채팅 상단에 띄우기 위한 임시 저장값
            let dateString = "";
    		for (let chat of chatList) {
    			if (chat && chat.message) {// TODO 여기 메세지 20개씩 제일 최근의 메세지를 가져올 것이다. 내가 안읽은 부분이 있다면
										   // TODO 그 채팅 위에 20개, 밑으로 모두 가져올 것이다.
    				// // 송신날짜를 시/분으로 저장
                    // const sendDate = chat.sendDate.substring(11, 16);
    				//
                    // // 각 채팅을 표시하기 전에 날짜가 바뀌면 상단에 날짜를 표시
                    // if (chat.sendDate.substring(0, 10) != dateString) {
                    //     const chatDate = chat.sendDate
                    //         			 .substring(0, 10)
                    //         			 .replace(/^(\d{4})-(\d{2})-(\d{2})$/, '$1년 $2월 $3일');
                    //
                    //     $("#chatting_view").append($("<div class='chat_date'>").text(chatDate));
                    //     dateString = chat.sendDate.substring(0, 10);
                    //     last_chat_date = chat.sendDate.substring(0, 10); // 마지막 채팅 날짜 저장
                    // }//end of if (chat.sendDate.substring(0, 10) != dateString) {}...

                    // 인스턴스 타입의 시간을 써야해서 바꾸는 시간출력
                    const sendDateTime = new Date(chat.sendDate);

                    const hours = String(sendDateTime.getHours()).padStart(2, '0'); // 2자리 숫자보다 작으면 0 붙인다!
                    const minutes = String(sendDateTime.getMinutes()).padStart(2, '0');
                    const sendDate = `\${hours}:\${minutes}`; // 메세지 표시 시간

                    // 출력 시 채팅 날짜에 따른 구분을 위한 시간
                    const year = sendDateTime.getFullYear();
                    const month = String(sendDateTime.getMonth() + 1).padStart(2, '0');
                    const day = String(sendDateTime.getDate()).padStart(2, '0');
                    const chatDate = `\${year}-\${month}-\${day}`; // 날짜 구분 시간

                    if (chatDate !== dateString) { // 불러온 채팅이 기존에 불러온 채팅 날짜와 달라진다면
                        const chatDateString = `\${year}년 \${month}월 \${day}일`;
                        $("#chatting_view").append($("<div class='chat_date'>").text(chatDateString));
                        last_chat_date = chatDate; // 마지막으로 채팅한 날짜를 설정해준다.(채팅 보낼 때 사용)
                        dateString = chatDate; // 불러온 채팅 날짜를 새롭게 바꾸기
                    }
					/////////////////////////////////////////////////////////////////////////////////////////////
					
    				if (chat.chatType === "LEAVE") {
                        $("#chatting_view").append($("<div class='chat_date'>").text(chat.message));
                	} else if(chat.chatType === "ENTER") {
                        $("#chatting_view").append($("<div class='chat_date'>").text(chat.message));
                    } else if (chat.chatType === "TALK") {
                		const chathtml = $(`<div data-chat_id = \${chat.id}>`) // data-chat_id 는 속성으로 선언가능
                			// 자신이 보낸 메시지인지 상대가 보낸 메시지인지 확인
                        	.addClass("message_view") // 메세지 표시부분
                        	.append(chat.senderId == login_member_id ? null : $("<div class='sender_name'>").text(chat.senderName))
                        	.append($("<div>").addClass(chat.senderId == login_member_id ? 'chatting_own' : 'chatting')
                        			// .append($("<pre>").text(chat.message))
                                .append($("<div>").addClass("whitespace-pre-wrap break-words").text(chat.message))
                            .append(chat.senderId == login_member_id ? $("<div class='chatting_own_time'>").text(sendDate) : 
                                    								   $("<div class='chatting_time'>").text(sendDate))
                        	);
                		$("#chatting_view").append(chathtml);
                	}//end of if (chat.chatType == "1") {}...

                	// 스크롤을 하단으로 내리기
                	scrollToBottom();
            	}//end of if (chat && chat.message) {}...
    		}//end of for (let chat of chatList) {}...

//                 sendReadStatus();
        }//end of if (chatList != null) {}...
    
    }//end of function loadChat(chatList) {}...



    // 채팅 내역 갱신 시 스크를을 하단으로 내려 포커싱을 하기 위한 함수
    function scrollToBottom() {
        const chatContainer = $("div#chatting_view");
        chatContainer.scrollTop(chatContainer.prop("scrollHeight"));
    }


    // 채팅 프로필 개수에 따라 알맞는 모양의 HTML 코드를 반환
    function getProfileImagesHtml(imageFileNames) {
        const count = imageFileNames.length;
        const baseUrl = '${pageContext.request.contextPath}/resources/files/profile/';

        if (count === 1) {
            const $img = $('<img>')
                .attr('src', baseUrl + imageFileNames[0])
                .addClass('w-full h-full object-cover rounded-full absolute');
            return $('<div>')
                .addClass('w-16 h-16 relative overflow-hidden')
                .append($img)
                .prop('outerHTML');

        } else if (count === 2) {
            const $container = $('<div>')
                .addClass('w-16 h-16 relative overflow-hidden');

            const $img1 = $('<img>')
                .attr('src', baseUrl + imageFileNames[0])
                .addClass('w-2/3 h-2/3 object-cover absolute top-0 left-0 rounded-full')
                .css('z-index', 2);

            const $img2 = $('<img>')
                .attr('src', baseUrl + imageFileNames[1])
                .addClass('w-2/3 h-2/3 object-cover absolute bottom-0 right-0 rounded-full')
                .css('z-index', 1);

            return $container.append($img1, $img2).prop('outerHTML');

        } else {
            const $grid = $('<div>')
                .addClass('grid grid-cols-2 grid-rows-2 w-full h-full absolute');

            imageFileNames.slice(0, 4).forEach((fileName) => {
                const $img = $('<img>')
                    .attr('src', baseUrl + fileName)
                    .addClass('w-full h-full object-cover rounded-full');
                $grid.append($img);
            });

            return $('<div>')
                .addClass('w-16 h-16 relative overflow-hidden')
                .append($grid)
                .prop('outerHTML');
        }
    }

    
    // 현재 채팅방에서 내가 본 마지막 메세지 시간
    let lastReadTimestamp = ""; // 아직 안쓴다.
    
    // 채팅방에 들어왔을 때, 새로운 메세지가 왔을 때, 채팅방을 나갈 때 시간을 기록한다.
    function recordTimesInChatRoom(roomId) {
        
        updateReadTimes(roomId, new Date()); // 현재 시간으로 업데이트
        console.log("커런트룸아이디 => ", current_roomId);
	}//end of function enterChatRoomTime(roomId) {}...
 

	// 방을 나가거나 변경 시 마지막 시간과 채팅방 아이디를 초기화
	function resetTimesAndRoomId() {
        current_roomId = "";
        lastReadTimestamp = "";
        // roomId = ""; // 전송된 룸아이디 초기화, 새로고침 후 초기화 되면 그 전 화면으로 돌려놓자
	}//end of function resetTimesAndRoomId(roomId) {}...
 

	// 서버로 기록된 시간을 보낸다.
	function updateReadTimes(roomId, timestamp) {
        WebSocketManager.sendReadStatus("/send/"+ roomId +"/chatRoomReadTimes",
            {
                // 'roomId': roomId,
                'lastReadTimestamp' : timestamp.toISOString() // ISO 8601 형식으로 변환
            });
        // console.log("시간이 전송 됐다! => ", timestamp.toISOString());
        // console.log("지금 roomId가 정말로 들어오는지 확인 => ", roomId);
	}//end of function updateReadTimes() {}... timestamp.toISOString()


	// 채팅창이 켜져있는 윈도우창을 닫을 때 실행(마지막으로 확인한 채팅방의 마지막 읽기 시간을 기록)
	$(window).on('beforeunload', function (e) {
        if (current_roomId !== "" && current_roomId !== null) { // 현재 선택된 채팅방
            updateReadTimesOnLeave(current_roomId, new Date());
            resetTimesAndRoomId();
            // 웹소캣이 연결되어 있다면 바로 종료해라.
            if (WebSocketManager.isConnected()) {
                WebSocketManager.disconnect();
			}
        
        }
	});//end of $(window).on('beforeunload', function (e) {}...

	// 페이지 닫을 때, 마지막으로 채팅방 읽음 시간 기록해주는 함수
	function updateReadTimesOnLeave(roomId, timestamp) {
        const url = "${ctx_path}/chat/readTimesChatRoomOnLeave";
        const data = {
            "roomId": roomId,
			"timestamp": timestamp.toISOString()
		};
        // 데이터를 JSON 문자열로 변환
        const blob = new Blob([JSON.stringify(data)], { type: "application/json" });
        
        // sendBeacon으로 데이터 전송
		navigator.sendBeacon(url, blob); // 창이 닫힐 때 사용하다록 만들어진 API, 많은 양의 데이터는 못보낸다.
	}//



    ////////////////////////////////////////////////////////////////////////////////////////////////



</script>
<style>
    dialog.option-dropdown::backdrop {
        background: transparent;
    }
</style>

<%-- 채팅방 생성 모달 --%>
<jsp:include page="/WEB-INF/views/chat/modalCreateChatroom.jsp" />

<%-- 채팅방 초대하기 모달 --%>
<jsp:include page="/WEB-INF/views/chat/modalAddChatMember.jsp" />

<!-- 본문 -->
<div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px]">
    
    <!-- 중앙 본문 -->
    <div class="center col-span-14 md:col-span-10 space-y-2 my-5">
        <div class="scroll-mt-22 border-board">

            <%-- 여기에 채팅화면을 뽑아내야한다. --%>
            <div class="flex flex-col md:flex-row py-0!">
                
                <%-- 채팅방 목록 --%>
                <div class="w-full md:w-[calc(50%-50px)] px-0! border-r md:border-r-1 border-gray-200 mb-0!">
                    <div class="overflow-y-auto">

                        <div class="h1 px-4 border-b border-gray-200 flex">
                            <div class="flex-1 pt-4 pb-2">메시지</div>
                            <div><button class="btn-open-modal cursor-pointer px-3 py-1 my-2 -mr-2 text-black/50 hover:text-black" data-target-modal="CreateChatroom"><i class="fa-solid fa-pen-to-square"></i></button></div>
                        </div>

                        <!-- Chat List -->
                        <ul id="chatting_list" class="divide-y divide-gray-200 max-h-[calc(100vh-12rem)] overflow-y-auto">
                            <%-- 채팅방 목록 표시 --%>
                        </ul>
                    </div>
                </div>

                <%-- 채팅 내용 --%>
                <div class="w-full md:w-[calc(50%+50px)] pb-4! px-0!">
                    <div id="chat_profile" class=""><%-- 채팅하는 사람의 프로필표시부분 --%>

                        <div class="h1 px-4 border-b border-gray-200 flex">
                            <div class="chatroom-title flex-1 pt-4 pb-2">&nbsp;</div>
                            <div><button class="btn-open-dropdown hidden cursor-pointer px-3 py-1 my-2 -mr-2 text-black/50 hover:text-black" id="btnChatMenu"><i class="fa-solid fa-ellipsis-vertical"></i></button></div>
                        </div>
                        <%-- 채팅방 나가기 드롭다운 --%>
                        <dialog id="dropdownChatMenu" class="option-dropdown border-normal drop-shadow-lg">
                            <div class="space-y-2">
                                <ul class="w-40 overflow-hidden font-bold text-gray-700">
                                    <li>
                                        <button class="invite-chat w-full hover:bg-gray-200 cursor-pointer pl-2 text-left! text-gray-500 py-2"><i class="fa-solid fa-user-plus mr-2"></i>초대하기</button>
                                    </li>
                                    <li>
                                        <button class="leave-chat w-full hover:bg-gray-200 cursor-pointer pl-2 text-left! text-red-400 py-2"><i class="fa-solid fa-arrow-right-from-bracket mr-2"></i>채팅방 나가기</button>
                                    </li>
                                </ul>
                            </div>
                        </dialog>
                    </div>
                        
                    <!-- Messages 표시 부분 -->
                    <div id="chatting_view" class="h-[calc(100vh-20rem)] overflow-y-auto space-y-4 p-4">
                        <div class="h-full flex justify-center text-9xl">
                            <i class="fa-solid fa-comment-dots mt-[calc(20vh)] text-gray-100 "></i>
                        </div>
                    </div>
                    <%-- 여기 끝 --%>


                    <!-- Input Area -->
                    <div class="border-t border-gray-200 pt-4 px-4 input-area">
                        <div class="relative flex gap-2">
                            <textarea
                                    id="message"
                                    class="flex-1 w-full py-2 px-3 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-orange-200 text-sm resize-none overflow-y-auto"
                                    rows="1"
                                    placeholder="메시지 쓰기"
                                    style="max-height: 14em;"
                                    onkeyup="adjustTextareaHeight(this)"></textarea>
                            <button id="btn_send" class="bg-orange-400 hover:bg-orange-600 text-white py-2 px-4 rounded-lg text-sm font-medium">보내기</button>
                        </div>


<%--                        <div class="relative">--%>
<%--            						<textarea--%>
<%--                                            id="message"--%>
<%--                                            class="w-full py-2 px-3 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-orange-200 text-sm resize-none overflow-y-auto"--%>
<%--                                            rows="1"--%>
<%--                                            placeholder="메시지 쓰기"--%>
<%--                                            style="max-height: 14em;"--%>
<%--                                            onkeyup="adjustTextareaHeight(this)"></textarea>--%>
<%--                        </div>--%>
<%--                        <div class="flex items-center justify-between">--%>
<%--                            <div class="space-x-3 ml-2">--%>
<%--                                <button class="text-gray-500 hover:text-gray-700"><i class="fa-solid fa-image text-lg"></i></button>--%>
<%--                                <button class="text-gray-500 hover:text-gray-700"><i class="fa-solid fa-file text-lg"></i></button>--%>
<%--                            </div>--%>
<%--                            <div>--%>
<%--                                <button id="btn_send" class="bg-orange-400 hover:bg-orange-600 text-white mt-2 py-2 px-4 rounded-lg text-sm font-medium">보내기</button>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                    </div>


                </div>
            </div>
        </div>
    </div>

    <!-- 우측 광고 -->
    <div class="right-side lg:col-span-4 h-full relative lg:block">
        <div class="border-list sticky top-20 space-y-2 text-center relative">
            <div class="absolute top-5 right-5 bg-white rounded-sm text-[0.9rem]">
                <span class="pl-1.5 font-bold">광고</span>
                <button type="button" class="font-bold hover:bg-gray-100 cursor-pointer px-1.5 py-1 rounded-r-sm"><i class="fa-solid fa-ellipsis"></i></button>
            </div>
            <div>
                <img src="${pageContext.request.contextPath}/images/ad.png"/>
            </div>
            <div class="px-4">
                <p class="font-bold">${sessionScope.loginuser.member_name}님, ANTICO에서 경매에 참여해보세요.</p>
                <p>ANTICO에서 나에게 맞는 물건을 살펴보세요.</p>
            </div>
            <div class="px-4">
                <a href="http://antico.shop/antico/index">
                    <button type="button" class="button-orange">방문하기</button>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>