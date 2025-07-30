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
		@apply bg-gray-200 rounded-full py-1 px-4 w-64 mx-auto justify-center flex justify-items-center text-xs
	}

    .selected_chatroom{
        @apply relative before:inline-block before:absolute before:w-1 before:h-full before:bg-orange-400 before:mr-2 before:left-0 before:top-1/2 before:-translate-y-1/2;
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

<%-- 채팅방 정보 --%>
<c:set var="chat_room" value="${requestScope.chat_room}"/>

<%-- 참여자 정보 --%>
<%-- <c:set var="participants" value="${chat_room.participants}"/> --%>


<script src="${pageContext.request.contextPath}/js/chat/textareaFunction.js" defer></script> <!-- defer 속성 추가 -->

<script type="text/javascript">

const room_id = "1234"; // 실험용으로 하나 박아뒀다! 나중에 수정 요함

let last_chat_date = ""; // 마지막으로 불러온 채팅의 날짜 기록용

    $(document).ready(function() {

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


        // 엔터키 입력시 채팅 전송 처리
        $("textarea#message").on('keydown', function(e) {
            if (e.keyCode == 13) {
            	if (!e.shiftKey) {
            		e.preventDefault();
            		if ($(e.target).val().trim() !== "") {
                    	sendMessage();
                	}
            	}//
            }
        });//end of $("textarea#message").keydown(function (e) {}..

        // 보내기 버튼 클릭시 채팅 전송 처리
        $("button#btn_send").click(function (e) {
            if ($("textarea#message").val().trim() !== "") {
                sendMessage();
            }
        });//end of $("button#btn_send").click(function (e) {}...





        // 웹소켓 연결 모듈을 통하여 연결 및 구독
        WebSocketManager.connect("${ctx_path}/ws", function () {
//             const roomId = "${chat_room.room_id}";
            const roomId = room_id; // 실험용 데이터

            if (roomId == "") {
            	alert("error", "채팅방 입장을 실패하였습니다");
                return;
            }

            // 이전 채팅 내역 불러오기
            $.ajax({
                url: "${ctx_path}/chat/load_chat_history/" + roomId,
                type: "post", // 개인정보니까 post 하자
                success: function (json) {
                    loadChat(json);
                },
                error: function (error) {
                    alert("error", "채팅방 입장을 실패하였습니다");
                    WebSocketManager.disconnect();
                }
            });

            // 채팅방에 구독 처리 후 메시지 수신 시 채팅 내역에 보여주기
            WebSocketManager.subscribeMessage("/room/" + roomId, function (message) {
                showChat(message);
            });

//             // 채팅 읽음 카운트 구독 처리, 갱신된 읽음 개수 전파
//             WebSocketManager.subscribeReadStatus("/room/" + roomId + "/read", function (chatList) {
//                 updateReadStatus(chatList);
//             });
        });
        
        
        
    });//end of $(document).ready(function() {}...레디





    // 채팅페이지를 들어오면 바로 채팅방 목록을 보여줘야한다. 다 포스트 방식으로 해서 보안 강화하자
    function loadChatRoom() {
        $.ajax({
            url: "${ctx_Path}/chat/loadChatRoom", //
            type: "post",
            async: true,       // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
            success: function (chatroomList) { //이거 json 객체이다.
                
                if (chatroomList != null) {
                    let v_html = ``;
                    
                    for (let chatroom of chatroomList) {
                        
                        v_html += `
                            <li class="p-4 hover:bg-gray-100 cursor-pointer">
                                <div class="flex items-center space-x-4">
                                    <div class="relative">
                                        <img src=" " class="w-12 h-12 rounded-full object-cover">
                                    </div>
                                    <div class="flex-1 truncate">
			                            <div class="font-medium">/${chatroom.latestChat.senderName}</div>
                                        <div class="text-gray-500 text-sm truncate">/${chatroom.latestChat.message}</div>
		                            </div>
                                   	<div class="ml-auto w-15 text-gray-500 text-sm text-right">1월 26일(마지막 보낸시각으로 수정할 것)</div>
                                </div>
                            </li>`;
                    }
                    
                    
                    
                } else {// 채팅방이 아예 없으면 없다고 표시
                
                }
                
            }
            ,
            error: function (request, status, error) { // 코딩이 잘못되어지면 어디가 잘못되어졌는지 보여준다!
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });//
    
    }//end of function loadChatRoom() {}...



    <%--// 기존에 참여하던 채팅방 입장(클릭하면 채팅방의 채팅 내용 출력)--%>
    <%--function goChatRoom(room_id, sender_name) {--%>
    <%--    $.ajax({--%>
    <%--        url: "${ctx_path}/chat/join",--%>
    <%--        type: "post",--%>
    <%--        data: {--%>
    <%--        "room_id": room_id--%>
    <%--        },--%>
    <%--        success: function (html) {--%>
    <%--            openSideTab(html, sender_name);--%>
    <%--        },--%>
    <%--        error: function (request, status, error) { // 코딩이 잘못되어지면 어디가 잘못되어졌는지 보여준다!--%>
    <%--            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);--%>
    <%--        }--%>
    <%--    });--%>
    <%--}//end of function goChatRoom(room_id, sender_name) {}...--%>
    
    
    
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 채팅 부분
    
    
    // 채팅 송신
    function sendMessage() {
// 		const roomId = "${chat_room.roomId}"; // 일단 잠궈놓음
        const roomId = room_id; // 실험용 데이터
        const login_member_id = "${login_member_id}";
        const login_member_name = "${login_member_name}";

        // 채팅방 및 사용자 식별자가 존재하지 않을 경우
        if (roomId == "" || login_member_id == "") {
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
                    'chatType': 0
                });
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
            
            // 년/월/일 형태 문자열 추출
            const sendDate = chat.sendDate.substring(11, 16);
            
         	// 각 채팅을 표시하기 전에 날짜가 바뀌면 상단에 날짜를 표시
            if (chat.sendDate.substring(0, 10) != last_chat_date) { // 마지막 채팅의 날짜를 비교하자
                const chatDate = chat.sendDate
                    			 .substring(0, 10)
                    			 .replace(/^(\d{4})-(\d{2})-(\d{2})$/, '$1년 $2월 $3일');
                
                $("#chatting_view").append($("<div class='chat_date'>").text(chatDate));
                last_chat_date = chat.sendDate.substring(0, 10);
            }//end of if (chat.sendDate.substring(0, 10) != current_date) {}...
			/////////////////////////////////////////////////////////////////////////////////
            
            const chathtml = $(`<div data-chat_id = \${chat.id}>`) // data-chat_id 는 속성으로 선언가능
        	// 자신이 보낸 메시지인지 상대가 보낸 메시지인지 확인
        	.addClass("message_view") // 메세지 표시부분
            .append(chat.senderId == login_member_id ? null : $("<div class='sender_name'>").text(chat.senderName))
            .append($("<div>").addClass(chat.senderId == login_member_id ? 'chatting_own' : 'chatting')
            		.append($("<pre>").text(chat.message))
//             		.append(chat.senderId == login_member_id ? $("<span class='read_status'>").text(chat.unReadCount == 0 ? "" : chat.unReadCount) : null)
			// 읽음은 나중에!
            		.append(chat.senderId == login_member_id ? $("<div class='chatting_own_time'>").text(sendDate) : 
                    		        						   $("<div class='chatting_time'>").text(sendDate)));

            $("#chatting_view").append(chathtml);

            // 스크롤을 하단으로 내리기
            scrollToBottom();

            // 읽음 처리
//             sendReadStatus();
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
        	// 각 채팅의 송신날짜 년/월/일을 채팅 상단에 띄우기 위한 임시 저장값
            let current_date = "";

    		for (let chat of chatList) {
    			if (chat && chat.message) {
    				// 송신날짜를 시/분으로 저장
                    const sendDate = chat.sendDate.substring(11, 16);
    				
                    // 각 채팅을 표시하기 전에 날짜가 바뀌면 상단에 날짜를 표시
                    if (chat.sendDate.substring(0, 10) != current_date) {
                        const chatDate = chat.sendDate
                            			 .substring(0, 10)
                            			 .replace(/^(\d{4})-(\d{2})-(\d{2})$/, '$1년 $2월 $3일');
                        
                        $("#chatting_view").append($("<div class='chat_date'>").text(chatDate));
                        current_date = chat.sendDate.substring(0, 10);
                        last_chat_date = chat.sendDate.substring(0, 10); // 마지막 채팅 날짜 저장
                    }//end of if (chat.sendDate.substring(0, 10) != current_date) {}... 
    				
    			
    				if (chat.chatType == "1") { // TODO 서버알림채팅인데 이거 규영씨랑 논의해보자
    //                         	handleProductNoticeForm(chat);
                	} else {
                		const chathtml = $(`<div data-chat_id = \${chat.id}>`) // data-chat_id 는 속성으로 선언가능
                			// 자신이 보낸 메시지인지 상대가 보낸 메시지인지 확인
                        	.addClass("message_view") // 메세지 표시부분
                        	.append(chat.senderId == login_member_id ? null : $("<div class='sender_name'>").text(chat.senderName))
                        	.append($("<div>").addClass(chat.senderId == login_member_id ? 'chatting_own' : 'chatting')
                        			.append($("<pre>").text(chat.message))
//                          .append(chat.senderId == login_member_id ? $("<span class='read_status'>").text(chat.unReadCount == 0 ? "" : chat.unReadCount) : null)
							// 읽음은 나중에!
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



    ////////////////////////////////////////////////////////////////////////////////////////////////



</script>
<style>
    dialog.dropdown::backdrop {
        background: transparent;
    }
</style>

<!-- 본문 -->
<div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px]">
    
    <!-- 중앙 본문 -->
    <div class="center col-span-14 md:col-span-10 space-y-2 my-5">
        <div class="scroll-mt-22 border-board">

            <%-- 여기에 채팅화면을 뽑아내야한다. --%>
            <div class="flex flex-col md:flex-row py-0!">
                
                <%-- 채팅방 목록 --%>
                <div class="w-full md:w-[calc(50%-50px)] py-4! px-0! border-r md:border-r-1 border-gray-200 mb-0!">
                    <div class="overflow-y-auto">

                        <div class="h1 px-4 pb-2 border-b border-gray-200">메시지</div>

                        <!-- Chat List -->
                        <ul id="chatting_list" class="divide-y divide-gray-200">
                        	
                            <li class="p-4 hover:bg-gray-100 cursor-pointer selected_chatroom border-b border-gray-200">
                                <div class="flex items-center space-x-4">
									<div class="relative">
                                    	<img src="https://i.namu.wiki/i/BwXretoFfCKQCWSPGsfBPHj0gHKnJ3sEViYKhvbKUTWxETuUFJQa1Bl2-IuvO2Q6-oDP2wGZFm6lJAG7zdUSY0kWhmTLP81VxFtdQE1ctKuYNPWrolwanztcbdaMHOWsQhnD9FJbehPCoC-NxUJc0w.webp" alt="프로필" class="w-12 h-12 rounded-full object-cover">
                                        <span class="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border border-white"></span>
                                    </div>
                                    <div class="flex-1 truncate">
                                    	<div class="font-medium">엄정화</div>
                                        <div class="text-gray-500 text-sm truncate">GIF를 보냄asdfasdasdsafasdfasdfsaffasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasfdasf</div>
                                    </div>
                                   	<div class="ml-auto w-15 text-gray-500 text-sm text-right">1월 26일</div>
                                </div>
                            </li>

                            <li class="p-4 hover:bg-gray-100 cursor-pointer border-b border-gray-200">
                                <div class="flex items-center space-x-4">
                                    <div class="relative">
                                        <img src="https://i.namu.wiki/i/BwXretoFfCKQCWSPGsfBPHj0gHKnJ3sEViYKhvbKUTWxETuUFJQa1Bl2-IuvO2Q6-oDP2wGZFm6lJAG7zdUSY0kWhmTLP81VxFtdQE1ctKuYNPWrolwanztcbdaMHOWsQhnD9FJbehPCoC-NxUJc0w.webp" alt="프로필" class="w-12 h-12 rounded-full object-cover">
                                        <span class="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border border-white"></span>
                                    </div>
                                    <div class="flex-1 truncate">
                                        <div class="font-medium">이진호</div>
                                        <div class="text-gray-500 text-sm truncate">GIF를 보냄asdfasdasdsafasdfasdfsaffasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasfdasf</div>
                                    </div>
                                    <div class="ml-auto w-15 text-gray-500 text-sm text-right">1월 26일</div>
                                </div>
                            </li>

                            <li class="p-4 hover:bg-gray-100 cursor-pointer border-b border-gray-200">
                                <div class="flex items-center space-x-4">
                                    <div class="relative">
                                        <img src="https://i.namu.wiki/i/BwXretoFfCKQCWSPGsfBPHj0gHKnJ3sEViYKhvbKUTWxETuUFJQa1Bl2-IuvO2Q6-oDP2wGZFm6lJAG7zdUSY0kWhmTLP81VxFtdQE1ctKuYNPWrolwanztcbdaMHOWsQhnD9FJbehPCoC-NxUJc0w.webp" alt="프로필" class="w-12 h-12 rounded-full object-cover">
                                        <span class="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border border-white"></span>
                                    </div>
                                    <div class="flex-1 truncate">
                                        <div class="font-medium">이준영</div>
                                        <div class="text-gray-500 text-sm truncate">GIF를 보냄asdfasdasdsafasdfasdfsaffasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasfdasf</div>
                                    </div>
                                    <div class="ml-auto w-15 text-gray-500 text-sm text-right">1월 26일</div>
                                </div>
                            </li>
                            
                        </ul>
                    </div>
                </div>

                <%-- 채팅 내용 --%>
                <div class="w-full md:w-[calc(50%+50px)] py-4! px-0!">
                    <div id="chat_profile" class=""><%-- 채팅하는 사람의 프로필표시부분 --%>
                    	<div class="h1 px-4 pb-2 border-b border-gray-200">엄정화</div>
                    </div>
                        
                    <!-- Messages 표시 부분 -->
                    <div id="chatting_view" class="h-[600px] overflow-y-auto space-y-4 p-4">
                    	
                    </div>
                    <%-- 여기 끝 --%>


                    <!-- Input Area -->
                    <div class="border-t border-gray-200 pt-4 px-4">
                        <div class="relative">
            						<textarea
                                            id="message"
                                            class="w-full py-2 px-3 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-orange-200 text-sm resize-none overflow-y-auto"
                                            rows="1"
                                            placeholder="메시지 쓰기"
                                            style="max-height: 14em;"
                                            onkeyup="adjustTextareaHeight(this)"></textarea>
                        </div>
                        <div class="flex items-center justify-between">
                            <div class="space-x-3 ml-2">
                                <button class="text-gray-500 hover:text-gray-700"><i class="fa-solid fa-image text-lg"></i></button>
                                <button class="text-gray-500 hover:text-gray-700"><i class="fa-solid fa-file text-lg"></i></button>
                            </div>
                            <div>
                                <button id="btn_send" class="bg-orange-400 hover:bg-orange-600 text-white mt-2 py-2 px-4 rounded-lg text-sm font-medium">보내기</button>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>

    <!-- 우측 광고 -->
    <div class="right-side lg:col-span-4 h-full relative hidden lg:block">
        <div class="border-list sticky top-20 space-y-2 text-center relative">
            <div class="absolute top-5 right-5 bg-white rounded-sm text-[0.9rem]">
                <span class="pl-1.5 font-bold">광고</span>
                <button type="button" class="font-bold hover:bg-gray-100 cursor-pointer px-1.5 py-1 rounded-r-sm"><i class="fa-solid fa-ellipsis"></i></button>
            </div>
            <div>
                <img src="7.png"/>
            </div>
            <div class="px-4">
                <p class="font-bold">준영님, Tridge의 관련 채용공고를 살펴보세요.</p>
                <p>업계 최신 뉴스와 취업 정보를 받아보세요.</p>
            </div>
            <div class="px-4">
                <button type="button" class="button-orange">팔로우</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>