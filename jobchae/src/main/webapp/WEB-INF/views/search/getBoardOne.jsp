<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === JSTL( Java Standard Tag Library) 사용하기 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

    <style type="text/tailwindcss">
        html {
            font-size: 0.9rem;
        }
        body {
            background-color: rgb(244, 242, 238);
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

            &>li {
                @apply border-1 border-gray-300 rounded-lg space-y-2 bg-white;
            }

            &>li {
                @apply pt-4;
                @apply pb-2;
            }
            
            &>li>*:not(.px-0) {
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
            @apply relative before:inline-block before:absolute before:w-[2.5px] before:h-10 before:bg-green-800 before:mr-2 before:left-0 before:top-1/2 before:-translate-y-1/2;
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
                
                /* 언팔로우 버튼 */
                .follow-button.followed {
                    @apply text-gray-600 font-normal;
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

        .button-board-action {
            @apply w-full h-10 rounded-md font-bold hover:cursor-pointer hover:bg-gray-100;
        }
        button {
            @apply hover:cursor-pointer;
        }
    </style>

<script type="text/javascript">

    $(document).ready(function() {
        getBoard(); // 글 불러오기

        getComment("${requestScope.board_no}"); // 댓글 불러오기

        // 팔로우 버튼
        $(document).on("click", ".follow-button:not(.followed)", function() {
            follow(this, "post");
        });
        // 언팔로우 버튼
        $(document).on("click", ".follow-button.followed", function() {
            follow(this, "delete");
        });
    });

    // 팔로우
    // method 팔로우: "post", 언팔로우: "delete"
    function follow(followButton, method) {

        $(followButton).prop("disabled", true);

        const followingId = $(followButton).data("following-id");

        $.ajax({
            url: "${pageContext.request.contextPath}/api/follow",
            data: {"followerId" : "${sessionScope.loginuser.member_id}"
                    ,"followingId" : followingId},
            type: method,
            dataType: "json",
            success: function (json) {

                if(method == "post") {
                    $(followButton).addClass("followed");
                    $(followButton).html("팔로우 중");
                    $(followButton).prop("disabled", false);
                }
                if(method == "delete") {
                    $(followButton).removeClass("followed");
                    $(followButton).html("<i class='fa-solid fa-plus'></i> 팔로우");
                    $(followButton).prop("disabled", false);
                }
            },
            error: function (request, status, error) {
                console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }

    // 글 읽어오기
    function getBoard() {

        $.ajax({
            url: "${pageContext.request.contextPath}/api/search/board/${requestScope.board_no}",
            dataType: "json",
            success: function (json) {
                console.log(JSON.stringify(json));

                if(json.length > 0) {

                    let html = ``;
                    $.each(json, (index, item) => {

                        const fileList = item.fileList;
                        let imageHtml = ``;
                        // 첨부파일이 존재한다면
                        if(fileList != null) {

                            let imageList = [];
                            let otherFileList = [];

                            for(let i=0; i<fileList.length; i++) {
                                const index = fileList[i].file_name.lastIndexOf(".");
                                const fileType = fileList[i].file_name.substring(index);

                                const reg = /(jpeg|jpg|png|webp)$/; // 확장자가 이미지인지 확인하기 위한 regex
                                
                                if(reg.test(fileType)){ // 확장자가 이미지인 경우
                                    imageList.push(fileList[i]); // 이미지 리스트에 추가
                                }
                                else { // 확장자가 이미지가 아닌 경우
                                    otherFileList.push(fileList[i]); // 기타 파일 리스트에 추가
                                }
                            }

                            console.log(imageList.length);

                            // 이미지가 존재한다면
                            if(imageList.length > 0) {
                                imageHtml += `<div class="file-image">`;
                                const size = (imageList.length > 4) ? 4 : imageList.length;
                                for(let i=0; i<size; i++) {
                                    if(imageList.length > 4 && i == size - 1) {
                                        imageHtml += `
                                            <button type="button" class="more-image"><img src="${pageContext.request.contextPath}/resources/files/board/\${imageList[i].file_name}"/>
                                                <span class="flex items-center">
                                                    <span><i class="fa-solid fa-plus"></i></span>
                                                    <span class="text-4xl">\${imageList.length-size}</span>
                                                </span>
                                            </button>`;
                                    }
                                    else {
                                        imageHtml += `<button type="button"><img src="${pageContext.request.contextPath}/resources/files/board/\${imageList[i].file_name}"/></button>`;
                                    }
                                }
                                imageHtml += `</div>`;
                            }
                        }

                        let reactionHtml = ``;
                        // 반응이 존재한다면
                        if(item.reactionStatusList != null) {
                            const reactionStatusList = item.reactionStatusList.split(",");
                            console.log(reactionStatusList);
                            reactionHtml += `<button type="button" class="button-underline">
                                                <div class="reaction-images">`;

                            for(let i=0; i<reactionStatusList.length; i++) {
                                let reactionImage;
                                switch(reactionStatusList[i]) {
                                    case "1": // 추천
                                        reactionImage = `like_small.svg`;
                                        break;
                                    case "2": // 축하
                                        reactionImage = `celebrate_small.svg`;
                                        break;
                                    case "3": // 응원
                                        reactionImage = `support_small.svg`;
                                        break;
                                    case "4": // 하트
                                        reactionImage = `love_small.svg`;
                                        break;
                                    case "5": // 통찰력
                                        reactionImage = `insightful_small.svg`;
                                        break;
                                    case "6": // 웃음
                                        reactionImage = `funny_small.svg`;
                                        break;
                                }
                                reactionHtml += `<img src="${pageContext.request.contextPath}/images/emotion/\${reactionImage}"/>`;
                            }

                            reactionHtml += `</div>
                                            <span id="reactionCount">\${item.reactionCount}</span>
                                        </button>`;
                        }
                        
                        // 팔로우 버튼
                        let followButtonHtml = ``;
                        if(item.isFollow == "0") {
                            followButtonHtml = `<button type="button" class="follow-button" data-following-id="\${item.fk_member_id}"><i class="fa-solid fa-plus"></i>&nbsp;팔로우</button>`;
                        }
                        else if (item.isFollow == "1") {
                            followButtonHtml = `<button type="button" class="follow-button followed" data-following-id="\${item.fk_member_id}">팔로우 중</button>`;
                        }

                        html += `
                            <li class="flex flex-col min-h-60">
                                <div class="board-member-profile">
                                    <div>
                                        <a href="${pageContext.request.contextPath}/member/profile/\${item.fk_member_id}"><img src="${pageContext.request.contextPath}/resources/files/profile/\${item.member_profile}" class="aspect-square w-15 object-cover rounded-full"/></a>
                                    </div>
                                    <div class="flex-1">
                                        <a href="${pageContext.request.contextPath}/member/profile/\${item.fk_member_id}">
                                            <span>\${item.member_name}</span>
                                            <span>팔로워 \${item.followerCount.toLocaleString('en')}명</span>
                                        </a>
                                        <span>\${item.board_register_date}</span>
                                    </div>
                                    <div>
                                        \${followButtonHtml}
                                        <button type="button"><i class="fa-solid fa-ellipsis"></i></button>
                                    </div>
                                </div>
                                <!-- 글 내용 -->
                                <div>
                                    \${item.board_content}
                                </div>
                                <!-- 사진 또는 동영상 등 첨부파일 -->
                                <div class="px-0 flex-grow">
                                    \${imageHtml}
                                </div>
                                <!-- 반응 및 댓글 수(아무 반응 및 댓글이 없으면 표시하지 않음, 댓글만 있으면 댓글만 표시 등) -->
                                <div>
                                    <ul class="flex gap-4 text-gray-600">
                                        <li class="flex-1">
                                            \${reactionHtml}
                                        </li>
                                        <li>
                                            <button type="button" class="button-underline">
                                                <span>댓글&nbsp;</span>
                                                <span id="commentCount">\${item.commentCount}</span>
                                            </button>
                                        </li>
                                        <li>
                                            <button type="button" class="button-underline">
                                                <span>퍼감&nbsp;</span>
                                                <span id="embedCount">\${item.embedCount}</span>
                                            </button>
                                        </li>
                                    </ul>
                                </div>

                                <hr class="border-gray-300 mx-4">
                                <!-- 추천 댓글 퍼가기 등 버튼 -->
                                <div class="py-0">
                                    <ul class="grid grid-cols-4 gap-4 text-center">
                                        <li>
                                            <button type="button" class="button-board-action">
                                                <i class="fa-regular fa-thumbs-up"></i>
                                                <span>추천</span>
                                            </button>
                                        </li>
                                        <li>
                                            <button type="button" class="button-board-action">
                                                <i class="fa-regular fa-comment"></i>
                                                <span>댓글</span>
                                            </button>
                                        </li>
                                        <li>
                                            <button type="button" class="button-board-action">
                                                <i class="fa-solid fa-retweet"></i>
                                                <span>퍼가기</span>
                                            </button>
                                        </li>
                                        <li>
                                            <button type="button" class="button-board-action">
                                                <i class="fa-regular fa-paper-plane"></i>
                                                <span>보내기</span>
                                            </button>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            `;
                    });

                    $("#update").append(html);
                }
                else { // 목록이 하나도 없다면

                    alert("삭제되었거나 없는 글입니다.");
                    history.back();
                }
            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }

    function getComment(board_no) {
        $.ajax({
            url: "${pageContext.request.contextPath}/api/search/comment/"+board_no,
            dataType: "json",
            success: function (json) {
                console.log(JSON.stringify(json));

            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }
</script>

    <div class="container m-auto mt-4 grid grid-cols-14 gap-6 xl:max-w-[1140px]">
        <div class="center col-span-14 md:col-span-7 space-y-2 mb-5">
            <ul id="update" class="border-board">
                <!-- 게시물 -->
            </ul>
        </div>

        <div class="right-side col-span-4 h-full relative hidden lg:block">
            <div class="border-list sticky top-19 space-y-2 text-center relative bg-white">
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