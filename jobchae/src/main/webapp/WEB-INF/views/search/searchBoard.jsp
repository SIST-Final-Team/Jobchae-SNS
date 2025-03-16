<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === JSTL( Java Standard Tag Library) 사용하기 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

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

        .button-board-action {
            @apply w-full h-10 rounded-md font-bold hover:cursor-pointer hover:bg-gray-100;
        }
        button {
            @apply hover:cursor-pointer;
        }
    </style>

<script type="text/javascript">

let start = 1;
let len = 8;
let hasMore = true; // 글 목록이 더 존재하는지 확인하는 변수
let requestLock = false;

    $(document).ready(function() {
        // 검색 옵션 불러오기
        setSearchOption();

        // 검색 결과 불러오기
        getSearchResult('${requestScope.searchWord}');

        // 무한 스크롤
        $(window).scroll(function() {
            // 스크롤이 전체 페이지 크기만큼 내려가면
            if( $(window).scrollTop() + $(window).height() + 300 >= $(document).height() ) {
                getSearchResult('${requestScope.searchWord}');
            }
        });

        // 검색옵션 선택 해제
        $("input[type='radio']").on("input", function(){
            $(".btn-reset-dropdown").each((index, elmt) => {
                if($(this).attr("name") == $(elmt).data("reset")) {
                    $(elmt).text("초기화").addClass("active");
                    $(elmt).removeClass("btn-close-dropdown");
                }
            });
        });

        // 검색옵션 초기화 버튼을 누른 경우
        $(document).on("click", ".btn-reset-dropdown.active", function() {
            const resetInputName = $(this).data("reset");
            $("input[name='"+resetInputName+"']").prop("checked", false);
            $(this).text("취소").removeClass("active");
            $(this).addClass("btn-close-dropdown");
        });
        
        // 정렬기준 드롭다운 모달 열기
        $(".btn-open-dropdown").on("click", function() {
            const btnId = $(this).attr("id");
            const dropdownId = "#dropdown" + btnId.slice(3);
            const rect = this.getBoundingClientRect();
    
            $(dropdownId).css({"left":rect.left+"px","top":(rect.bottom)+"px"});
            $(dropdownId)[0].showModal();
        });
    
        // 바깥 클릭하면 드롭다운 모달 닫기
        $(".option-dropdown").on("click", function(e) {
            if (e.target === this) {
                setSearchOption(); // 검색 옵션을 원래대로 되돌리기
                this.close();
            }
        });
        
        // 취소 버튼 또는 X 버튼으로 드롭다운 모달 닫기
        $(document).on("click", ".btn-close-dropdown", function(e) {
            $(".option-dropdown").click();
        });

        // 검색 옵션 결과보기 버튼
        $(".btn-submit").on("click", function() {
            $("#additionalFields").html(""); // 검색 옵션 초기화
            searchOptionForm.submit();
        });
    });

    // 검색 옵션 되돌리기
    function setSearchOption() {
        // 올린 날이 선택되어 있다면
        if(${not empty requestScope.searchDate}) {
            $("input[name='searchDate']").each((index, elmt) => {
                if($(elmt).val() == "${requestScope.searchDate}") {
                    $(elmt).prop("checked", true);
                }
            });
            $("button#btnSearchDate").removeClass("button-gray");
            $("button#btnSearchDate").addClass("button-selected");
            
            $(".btn-reset-dropdown").each((index, elmt) => {
                if($(elmt).data("reset") == "searchDate") {
                    $(elmt).text("초기화").addClass("active");
                    $(elmt).removeClass("btn-close-dropdown");
                }
            });
        }
        else {
            $("input[name='searchDate']").prop("checked", false);
        }

        // 콘텐츠 종류가 선택되어 있다면
        if(${not empty requestScope.searchContentType}) {
            $("input[name='searchContentType']").each((index, elmt) => {
                if($(elmt).val() == "${requestScope.searchContentType}") {
                    $(elmt).prop("checked", true);
                }
            });
            $("button#btnSearchContentType").removeClass("button-gray");
            $("button#btnSearchContentType").addClass("button-selected");
            
            $(".btn-reset-dropdown").each((index, elmt) => {
                if($(elmt).data("reset") == "searchContentType") {
                    $(elmt).text("초기화").addClass("active");
                    $(elmt).removeClass("btn-close-dropdown");
                }
            });
        }
        else {
            $("input[name='searchContentType']").prop("checked", false);
        }
    }

    function getSearchResult(searchWord) {
        
        if(requestLock) {
            return;
        }
	
        if(!hasMore) { // 모두 불러왔다면
            return; // 종료
        }
        
	    requestLock = true; // 스크롤 이벤트가 여러 번 발생 하기 때문에 ajax를 쓰는동안 락을 걸어야 한다.

        document.searchOptionForm.searchWord.value = searchWord;

        $("#additionalFields").html(""); // 검색 옵션 초기화

        $("#additionalFields").append(`<input type="hidden" name="start" value="\${start}"/>`);
        $("#additionalFields").append(`<input type="hidden" name="end" value="\${start + len - 1}"/>`);
        const data = $("form[name='searchOptionForm']").serialize();
        console.log(data);
        $.ajax({
            url: "${pageContext.request.contextPath}/api/search/board",
            data: data,
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

                        html += `
                            <li>
                                <div class="board-member-profile">
                                    <div>
                                        <a href="#"><img src="${pageContext.request.contextPath}/resources/files/profile/\${item.member_profile}" class="aspect-square w-15 object-cover rounded-full"/></a>
                                    </div>
                                    <div class="flex-1">
                                        <a href="${pageContext.request.contextPath}/member/profile/\${item.fk_member_id}">
                                            <span>\${item.member_name}</span>
                                            <span>팔로워 \${item.followerCount.toLocaleString('en')}명</span>
                                        </a>
                                        <span>\${item.board_register_date}</span>
                                    </div>
                                    <div>
                                        <button type="button" class="follow-button"><i class="fa-solid fa-plus"></i>&nbsp;팔로우</button>
                                        <button type="button"><i class="fa-solid fa-ellipsis"></i></button>
                                    </div>
                                </div>
                                <!-- 글 내용 -->
                                <div>
                                    \${item.board_content}
                                </div>
                                <!-- 사진 또는 동영상 등 첨부파일 -->
                                <div class="px-0">
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
                else {
                    if(start==1) { // 목록이 하나도 없다면
                        let html = `<li class="text-center text-lg"><span class="block pb-2">조회된 글이 없습니다.</span>
                                </li>`;

                        $("#update").html(html);
                    }
                    hasMore = false; // 더이상 불러올 목록이 없음
                }

				start += json.length;
                requestLock = false;
            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                requestLock = false;
            }
        });
    }
</script>
<style>
dialog.option-dropdown::backdrop {
    background: transparent;
}
</style>

    <!-- 검색옵션 Form 시작 -->
    <form name="searchOptionForm">
        <%-- 검색어 input --%>
        <input type="hidden" name="searchWord"/>
        <input type="hidden" name="searchType" value="board"/>
        <div id="additionalFields">
        </div>
        <!-- 검색 유형 Dropdown -->
        <dialog id="dropdownSearchType" class="option-dropdown border-normal drop-shadow-lg">
            <ul class="nav font-bold text-gray-600 w-50">
                <li><a href="${pageContext.request.contextPath}/search/all?searchWord=${requestScope.searchWord}">전체</a></li>
                <li class="nav-selected"><a href="${pageContext.request.contextPath}/search/board?searchWord=${requestScope.searchWord}">글</a></li>
                <li><a href="${pageContext.request.contextPath}/search/member?searchWord=${requestScope.searchWord}">사람</a></li>
                <li><a href="${pageContext.request.contextPath}/search/company?searchWord=${requestScope.searchWord}">회사</a></li>
                <%-- <li><a href="${pageContext.request.contextPath}/search/recruit?searchWord=${requestScope.searchWord}">채용</a></li> --%>
            </ul>
        </dialog>
    
        <!-- 정렬 기준 Dropdown -->
        <%-- <dialog id="dropdownSearchSortBy" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
            <div class="space-y-2">
                <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
                <ul class="space-y-4 w-60 px-4">
                    <li>
                        <input type="radio" name="searchSortBy" id="searchSortByRelative" value="relative"/>
                        <label for="searchSortByRelative">관련순</label>
                    </li>
                    <li>
                        <input type="radio" name="searchSortBy" id="searchSortByRecent" value="recent"/>
                        <label for="searchSortByRecent">최신순</label>
                    </li>
                </ul>
                <hr class="border-gray-200">
                <div class="flex justify-end items-center gap-4 px-4">
                    <div>
                        <button type="button" class="btn-close-dropdown button-board-action px-4 btn-reset-dropdown" data-reset="searchSortBy">취소</button>
                    </div>
                    <div>
                        <button type="button" class="button-selected btn-submit">결과보기</button>
                    </div>
                </div>
            </div>
        </dialog> --%>
        
        <!-- 올린 날 Dropdown -->
        <dialog id="dropdownSearchDate" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
            <div class="space-y-2">
                <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
                <ul class="space-y-4 w-60 px-4">
                    <li>
                        <input type="radio" name="searchDate" id="searchDateToday" value="1"/>
                        <label for="searchDateToday">24시간 내</label>
                    </li>
                    <li>
                        <input type="radio" name="searchDate" id="searchDateWeek" value="7"/>
                        <label for="searchDateWeek">지난 주</label>
                    </li>
                    <li>
                        <input type="radio" name="searchDate" id="searchDateMonth" value="30"/>
                        <label for="searchDateMonth">지난 달</label>
                    </li>
                </ul>
                <hr class="border-gray-200">
                <div class="flex justify-end items-center gap-4 px-4">
                    <div>
                        <button type="button" class="btn-close-dropdown button-board-action px-4 btn-reset-dropdown" data-reset="searchDate">취소</button>
                    </div>
                    <div>
                        <button type="button" class="button-selected btn-submit">결과보기</button>
                    </div>
                </div>
            </div>
        </dialog>
        
        <!-- 콘텐츠 종류 Dropdown -->
        <dialog id="dropdownSearchContentType" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
            <div class="space-y-2">
                <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
                <ul class="space-y-4 w-60 px-4">
                    <li>
                        <input type="radio" name="searchContentType" id="searchContentTypeVideo" value="video"/>
                        <label for="searchContentTypeVideo">동영상</label>
                    </li>
                    <li>
                        <input type="radio" name="searchContentType" id="searchContentTypeImage" value="image"/>
                        <label for="searchContentTypeImage">이미지</label>
                    </li>
                    <%-- <li>
                        <input type="radio" name="searchContentType" id="searchContentTypeRecruit" value="recruit"/>
                        <label for="searchContentTypeRecruit">채용공고</label>
                    </li> --%>
                </ul>
                <hr class="border-gray-200">
                <div class="flex justify-end items-center gap-4 px-4">
                    <div>
                        <button type="button" class="btn-close-dropdown button-board-action px-4 btn-reset-dropdown" data-reset="searchContentType">취소</button>
                    </div>
                    <div>
                        <button type="button" class="button-selected btn-submit">결과보기</button>
                    </div>
                </div>
            </div>
        </dialog>
    </form>
    <!-- 검색옵션 Form 끝 -->

    <!-- 상단 헤더 -->
    <div class="fixed left-0 p-4 bg-white w-full z-99 drop-shadow-md">
        <div class="flex gap-2 bg-white xl:max-w-[1140px] m-auto">
            <button type="button" id="btnSearchType" class="button-selected btn-open-dropdown">
                <span>글</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
            <%-- <button type="button" id="btnSearchSortBy" class="button-gray btn-open-dropdown">
                <span>정렬기준</span>
                <i class="fa-solid fa-caret-down"></i>
            </button> --%>
            <button type="button" id="btnSearchDate" class="button-gray btn-open-dropdown">
                <span>올린 날</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
            <button type="button" id="btnSearchContentType" class="button-gray btn-open-dropdown">
                <span>콘텐츠 종류</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
        </div>
    </div>

    <div class="container m-auto mt-23 grid grid-cols-14 gap-6 xl:max-w-[1140px]">
        <div class="center col-span-14 md:col-span-7 space-y-2 mb-5">
            <ul id="update" class="border-board">
                <!-- 게시물 -->
                <%--
                <li>
                    <!-- 멤버 프로필 -->
                    <div class="board-member-profile">
                        <div>
                            <a href="#"><img src="./쉐보레전면.jpg" /></a>
                        </div>
                        <div class="flex-1">
                            <a href="#">
                                <span>CMC Global Company Limited.</span>
                                <span>팔로워 26,549명</span>
                            </a>
                            <span>1년</span>
                        </div>
                        <div>
                            <button type="button" class="follow-button"><i class="fa-solid fa-plus"></i>&nbsp;팔로우</button>
                            <button type="button"><i class="fa-solid fa-ellipsis"></i></button>
                        </div>
                    </div>
                    <!-- 글 내용 -->
                    <div>
                        <p>
                            On February 10, 2025, representatives from CMC Corp attended a meeting with the government regarding tasks and solutions for private enterprises to accelerate and contribute to the country's rapid and sustainable development in the new era.
                        </p>
                    </div>
                    <!-- 사진 또는 동영상 등 첨부파일 -->
                    <div class="px-0">
                        <div class="file-image">
                            <button type="button"><img src="4.png"/></button>
                            <button type="button"><img src="6.png"/></button>
                            <button type="button"><img src="7.png"/></button>
                            <button type="button" class="more-image"><img src="240502-Gubi-Showroom-London-003-Print.jpg"/>
                                <span class="flex items-center">
                                    <span><i class="fa-solid fa-plus"></i></span>
                                    <span class="text-4xl">3</span>
                                </span>
                            </button>
                        </div>
                    </div>
                    <!-- 반응 및 댓글 수(아무 반응 및 댓글이 없으면 표시하지 않음, 댓글만 있으면 댓글만 표시 등) -->
                    <div>
                        <ul class="flex gap-4 text-gray-600">
                            <li class="flex-1">
                                <button type="button" class="button-underline">
                                    <div class="reaction-images">
                                        <img src="images/like_small.svg"/>
                                        <img src="images/celebrate_small.svg"/>
                                        <img src="images/insightful_small.svg"/>
                                    </div>
                                    <span id="reactionCount">120</span>
                                </button>
                            </li>
                            <li>
                                <button type="button" class="button-underline">
                                    <span>댓글&nbsp;</span>
                                    <span id="commentCount">1,205</span>
                                </button>
                            </li>
                            <li>
                                <button type="button" class="button-underline">
                                    <span>퍼감&nbsp;</span>
                                    <span id="commentCount">4</span>
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
                --%>
            </ul>
        </div>

        <div class="right-side col-span-4 h-full relative hidden lg:block">
            <div class="border-list sticky top-37 space-y-2 text-center relative bg-white">
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