<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === JSTL( Java Standard Tag Library) 사용하기 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

    <!-- TailWind Script -->
    <script src="${pageContext.request.contextPath}/js/tailwind.js"></script>
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <%-- TailWind 사용자 정의 CSS --%>
    <jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />
    
<script type="text/javascript">

let start = 1;
let len = 8;
let hasMore = true; // 글 목록이 더 존재하는지 확인하는 변수
let requestLock = false;

$(document).ready(function() {

    // 검색 결과 불러오기
    getSearchResult('${requestScope.searchWord}');
    
    // 무한 스크롤
    $(window).scroll(function() {
        // 스크롤이 전체 페이지 크기만큼 내려가면
        if( $(window).scrollTop() + $(window).height() + 300 >= $(document).height() ) {
            getSearchBoardResult('${requestScope.searchWord}');
        }
    });

    // 스크롤 위치에 따라 nav 선택 변경
    $(window).scroll(function() {
        for(let i=0; i<$(".center>*").length; i++) {
            if( $(".center>*").eq(i).position().top - 200 <= $(window).scrollTop() &&
                $(window).scrollTop() < $(".center>*").eq(i).height() + $(".center>*").eq(i).position().top - 200 ) {
                $(".nav>li").removeClass("nav-selected");
                $(".nav>li").eq(i).addClass("nav-selected");
            }
            // console.log($(".center>*").eq(i).position().top , $(window).scrollTop());
        }
    });

    // 팔로우 버튼
    $(document).on("click", ".follow-button:not(.followed)", function() {
        follow(this, "post");
    });
    // 언팔로우 버튼
    $(document).on("click", ".follow-button.followed", function() {
        follow(this, "delete");
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
                    $(".follow-button").each((index, elmt) => {
                        if($(elmt).data("following-id") == followingId) {
                            
                            $(elmt).addClass("followed");
                            $(elmt).html("팔로우 중");
                            $(elmt).prop("disabled", false);
                        }
                    });
                }
                if(method == "delete") {
                    $(".follow-button").each((index, elmt) => {
                        if($(elmt).data("following-id") == followingId) {
                            $(elmt).removeClass("followed");
                            $(elmt).html("<i class='fa-solid fa-plus'></i> 팔로우");
                            $(elmt).prop("disabled", false);
                        }
                    });
                }
            },
            error: function (request, status, error) {
                console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }

    function getSearchResult(searchWord) {

        $.ajax({
            url: "${pageContext.request.contextPath}/api/search/board",
            data: {"searchWord":searchWord
                  ,"start":1
                  ,"end":3},
            async: false,
            dataType: "json",
            success: function (json) {
                // console.log(JSON.stringify(json));

                if(json.length > 0) {

                    let html = ``;
                    $.each(json, (index, item) => {

                        if(index >= 2) {
                            return;
                        }

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

                            // console.log(imageList.length);

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
                            // console.log(reactionStatusList);
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

                        // 첫 번째 글이라면
                        const firstBoardHtml = (index == 0)?`
                            <h1 class="h1">업데이트</h1>
                            <div class="flex space-x-2 pb-2">
                                <a href="${pageContext.request.contextPath}/search/board?searchWord=${requestScope.searchWord}&searchDate=1">
                                    <button type="button" class="button-gray">최근 24시간</button>
                                </a>
                                <a href="${pageContext.request.contextPath}/search/board?searchWord=${requestScope.searchWord}&searchDate=7">
                                    <button type="button" class="button-gray">지난 주</button>
                                </a>
                                <a href="${pageContext.request.contextPath}/search/board?searchWord=${requestScope.searchWord}&searchDate=30">
                                    <button type="button" class="button-gray">지난 달</button>
                                </a>
                            </div>`:``;

                        html += `
                            <li>
                                \${firstBoardHtml}
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
                                <!-- 추천 댓글 버튼 -->
                                <div class="py-0">
                                    <ul class="grid grid-cols-2 gap-4 text-center">
                                        <li>
                                            <button type="button" class="button-board-action">
                                                <i class="fa-regular fa-thumbs-up mr-2"></i>
                                                <span>추천</span>
                                            </button>
                                        </li>
                                        <li>
                                            <button type="button" class="button-board-action">
                                                <i class="fa-regular fa-comment mr-2"></i>
                                                <span>댓글</span>
                                            </button>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            `;
                    });

                    $(".board-container").removeClass("hidden");

                    $("#update").append(html);
                }
                    
                if(json.length>2) {
                    start += json.length - 1;
                    const moreHtml = `
                        <li class="px-0 py-0">
                            <a href="${pageContext.request.contextPath}/search/board?searchWord=${requestScope.searchWord}" class="p-0!">
                                <button type="button" class="button-more">업데이트 결과 모두 보기</button>
                            </a>
                        </li>`;
                    $("#update").append(moreHtml);

                    $("#updateMore").removeClass("hidden");
                    $("#updateMoreNav").removeClass("hidden");

                    getSearchBoardResult(searchWord);
                }
                else {
                    hasMore = false;
                }
            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });

        $.ajax({
            url: "${pageContext.request.contextPath}/api/search/member",
            data: {"searchWord":searchWord
                  ,"start":1
                  ,"end":4},
            async: false,
            dataType: "json",
            success: function (json) {
                // console.log(JSON.stringify(json));

                if(json.length > 0) {

                    let html = ``;
                    $.each(json, (index, item) => {

                        if(index >= 3) {
                            return;
                        }

                        const borderHtml = (index != json.length - 1)?`border-b-1 border-gray-300 `:``;
                        html += `
                        <li class="\${borderHtml}py-2">
                            <a href="${pageContext.request.contextPath}/member/profile/\${item.member_id}" class="flex">
                                <div>
                                    <img src="${pageContext.request.contextPath}/resources/files/profile/\${item.member_profile}" class="aspect-square w-15 object-cover rounded-full"/>
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-lg hover:underline">\${item.member_name}</div>
                                    <div>\${(item.member_career_company!=null)?item.member_career_company:""}</div>
                                    <div class="text-gray-600">\${item.region_name}</div>
                                </div>
                            </a>
                        </li>`;

                        if(json.length>=3) {
                            $("#memberMore").removeClass("hidden");
                        }
                    });
                    
                    $(".member-container").removeClass("hidden");

                    $("#memberList").append(html);
                }
            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });

        $.ajax({
            url: "${pageContext.request.contextPath}/api/search/company",
            data: {"searchWord":searchWord
                  ,"start":1
                  ,"end":4},
            async: false,
            dataType: "json",
            success: function (json) {
                // console.log(JSON.stringify(json));

                if(json.length > 0) {

                    let html = ``;
                    $.each(json, (index, item) => {

                        if(index >= 3) {
                            return;
                        }

                        const borderHtml = (index != json.length - 1)?`border-b-1 border-gray-300 `:``;
                        const companyLogoImg = (item.company_logo != null)
                            ?`<img src="\${ctxPath}/resources/files/companyLogo/\${item.company_logo}" class="aspect-square w-15 object-cover" />`
                            :`<div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-2xl text-gray-500"></i></div>`;

                        html += `
                        <li class="border-b-1 border-gray-300  py-2">
                            <a href="\${ctxPath}/company/dashboard/\${item.company_no}/" class="flex">
                                <div>
                                    \${companyLogoImg}
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-lg hover:underline">\${item.company_name}</div>
                                    <div>\${item.industry_name}</div>
                                    <%-- <div class="text-gray-600">\${item.region_name}</div> --%>
                                </div>
                            </a>
                        </li>`;

                        if(json.length>=3) {
                            $("#companyMore").removeClass("hidden");
                        }
                    });

                    $(".company-container").removeClass("hidden");

                    $("#companyList").append(html);
                }
                
            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });

        $.ajax({
            url: "${pageContext.request.contextPath}/api/search/recruit",
            data: {"searchWord":searchWord
                  ,"start":1
                  ,"end":3},
            dataType: "json",
            success: function (json) {
                // console.log(JSON.stringify(json));

                if(json.length > 0) {

                    let html = ``;
                    $.each(json, (index, item) => {

                        const companyLogoHtml = (item.company_logo != null)
                            ?`<img src="\${ctxPath}/resources/files/companyLogo/\${item.company_logo}" class="aspect-square w-15 object-cover" />`
                            :`<div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-2xl text-gray-500"></i></div>`;

                        let recruit_work_type = ``;
                        switch(item.recruit_work_type) {
                            case "1":
                                recruit_work_type = `대면근무`;
                            break;
                            case "2":
                                recruit_work_type = `대면재택혼합근무`;
                            break;
                            case "3":
                                recruit_work_type = `재택근무`;
                            break;
                        }

                        html += `
                        <li>
                            <a href="${pageContext.request.contextPath}/recruit/view/\${item.recruit_no}" class="btn-recruit-info w-full text-left flex border-b-1 border-gray-300">
                                <div class="px-2 py-4">
                                    \${companyLogoHtml}
                                </div>
                                <div class="flex-1 p-2">
                                    <div class="font-bold text-lg hover:underline">\${item.recruit_job_name}</div>
                                    <div>\${item.company_name}</div>
                                    <div class="text-gray-600">\${item.region_name} (\${recruit_work_type})</div>
                                </div>
                            </a>
                        </li>`;
                    });

                    $("#recruitList").append(html);

                    $(".recruit-container").removeClass("hidden");

                    if(json.length>=3) {
                        $("#recruitMore").removeClass("hidden");
                    }

                }
            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                requestLock = false;
            }
        });

        // 모든 검색 결과가 없다면
        if($(".board-container.hidden").length > 0 && $(".member-container.hidden").length > 0
            && $(".company-container.hidden").length > 0 && $(".recruit-container.hidden").length > 0) {

            $("#mainContainer").addClass("hidden");
            $("#emptyContainer").removeClass("hidden");
        }
    }

    function getSearchBoardResult(searchWord) {
        
        if(requestLock) {
            return;
        }
	
        if(!hasMore) { // 모두 불러왔다면
            return; // 종료
        }
        
	    requestLock = true; // 스크롤 이벤트가 여러 번 발생 하기 때문에 ajax를 쓰는동안 락을 걸어야 한다.
        $.ajax({
            url: "${pageContext.request.contextPath}/api/search/board",
            data: {"searchWord":searchWord
                  ,"start":start
                  ,"end":start + len - 1},
            dataType: "json",
            success: function (json) {
                // console.log(JSON.stringify(json));

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

                            // console.log(imageList.length);

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
                            // console.log(reactionStatusList);
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

                        // 첫 번째 글이라면
                        const firstBoardHtml = (index == 0 && start == 3)?`
                            <h1 class="h1">업데이트 더보기</h1>
                            <div class="flex space-x-2 pb-2">
                                <a href="${pageContext.request.contextPath}/search/board?searchWord=${requestScope.searchWord}&searchDate=1">
                                    <button type="button" class="button-gray">최근 24시간</button>
                                </a>
                                <a href="${pageContext.request.contextPath}/search/board?searchWord=${requestScope.searchWord}&searchDate=7">
                                    <button type="button" class="button-gray">지난 주</button>
                                </a>
                                <a href="${pageContext.request.contextPath}/search/board?searchWord=${requestScope.searchWord}&searchDate=30">
                                    <button type="button" class="button-gray">지난 달</button>
                                </a>
                            </div>`:``;

                        html += `
                            <li>
                                \${firstBoardHtml}
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
                                <!-- 추천 댓글 버튼 -->
                                <div class="py-0">
                                    <ul class="grid grid-cols-2 gap-4 text-center">
                                        <li>
                                            <button type="button" class="button-board-action">
                                                <i class="fa-regular fa-thumbs-up mr-2"></i>
                                                <span>추천</span>
                                            </button>
                                        </li>
                                        <li>
                                            <button type="button" class="button-board-action">
                                                <i class="fa-regular fa-comment mr-2"></i>
                                                <span>댓글</span>
                                            </button>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            `;
                    });

                    $("#updateMore").append(html);
                }
                else {
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

    // 검색어 변경 버튼 클릭시
    $(document).on("click", "#btnSearchFocus", function() {
        $('input[name="searchWord"]').click();
        $('input[name="searchWord"]').focus();
    });
});
</script>
<style>
dialog::backdrop {
    background: transparent;
}
</style>

    <!-- 상단 헤더 -->
    <div class="sticky top-15 left-0 p-4 bg-white w-full z-99 drop-shadow-md h-16">
        <ul class="flex gap-2 bg-white xl:max-w-[1140px] m-auto">
            <li class="board-container hidden">
                <a href="${pageContext.request.contextPath}/search/board?searchWord=${requestScope.searchWord}">
                    <button type="button" value="borad" class="button-gray btn-search-type">
                        <span>글</span>
                    </button>
                </a>
            </li>
            <li class="member-container hidden">
                <a href="${pageContext.request.contextPath}/search/member?searchWord=${requestScope.searchWord}">
                    <button type="button" value="member" class="button-gray btn-search-type">
                        <span>사람</span>
                    </button>
                </a>
            </li>
            <li class="company-container hidden">
                <a href="${pageContext.request.contextPath}/search/company?searchWord=${requestScope.searchWord}">
                    <button type="button" value="company" class="button-gray btn-search-type">
                        <span>회사</span>
                    </button>
                </a>
            </li>
            <li class="recruit-container hidden">
                <a href="${pageContext.request.contextPath}/search/recruit?searchWord=${requestScope.searchWord}">
                    <button type="button" value="recruit" class="button-gray btn-search-type">
                        <span>채용공고</span>
                    </button>
                </a>
            </li>
        </ul>
    </div>

    <!-- 본문 -->
    <div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px] mt-5">
        <!-- 좌측 네비게이션 -->
        <div class="left-side col-span-3 hidden md:block h-full relative">
            <div class="border-normal sticky top-36">
                <h1 class="h1 p-4">이 페이지에는</h1>
                <ul class="nav">
                    <li class="nav-selected board-container hidden"><a href="#update">업데이트</a></li>
                    <li class="member-container hidden"><a href="#member">사람</a></li>
                    <li class="company-container hidden"><a href="#company">회사</a></li>
                    <li class="recruit-container hidden"><a href="#recruit">채용공고</a></li>
                    <li id="updateMoreNav" class="hidden"><a href="#updateMore">업데이트 더보기</a></li>
                </ul>
            </div>
        </div>
        
        <div id="emptyContainer" class="hidden col-span-10 md:col-span-7 space-y-2 mb-5 text-center border-rwd p-4">
            <img src="${pageContext.request.contextPath}/images/no_recruit.svg" alt="" class="my-4 mx-auto w-50">
            <div class="text-2xl font-bold mt-4">결과 없음</div>
            <div class="text-lg text-gray-500">검색어를 간단히 하시거나 다른 검색어로 해보세요.</div>
            <button type="button" id="btnSearchFocus" class="button-gray mt-4 mb-8">검색어 변경</button>
        </div>

        <!-- 중앙 본문 -->
        <div id="mainContainer" class="center col-span-10 md:col-span-7 space-y-2 mb-5">

            <ul id="update" class="board-container hidden scroll-mt-36 border-search-board">
                <%-- 게시물 목록 표시 --%>
            </ul>
            
            <div id="member" class="member-container hidden scroll-mt-36 border-normal pt-4">
                <div class="space-y-2 px-4 pb-2">
                    <h1 class="h1">사람</h1>
                    <%-- <div class="flex space-x-2">
                        <button type="button" class="button-gray">맞팔</button>
                        <button type="button" class="button-gray">팔로우</button>
                        <button type="button" class="button-gray">전체</button>
                    </div> --%>
                </div>
                <div class="px-4">
                    <ul id="memberList">
                        <%-- 회원 목록 표시 --%>
                    </ul>
                    <div class="flex">
                    </div>
                </div>
                
                <div id="memberMore" class="px-0 py-0 hidden">
                    <a href="${pageContext.request.contextPath}/search/member?searchWord=${requestScope.searchWord}">
                        <button type="button" class="button-more">사람 결과 모두 보기</button>
                    </a>
                </div>
            </div>

            
            <div id="company" class="company-container hidden scroll-mt-36 border-normal pt-4">
                <div class="space-y-2 px-4 pb-2">
                    <h1 class="h1">회사</h1>
                </div>
                <div class="px-4">
                    <ul id="companyList">
                        <%-- 회사 목록 표시 --%>
                    </ul>
                    <div class="flex">
                    </div>
                </div>
                
                <div id="companyMore" class="px-0 py-0 hidden">
                    <a href="${pageContext.request.contextPath}/search/company?searchWord=${requestScope.searchWord}">
                        <button type="button" class="button-more">회사 결과 모두 보기</button>
                    </a>
                </div>
            </div>

            
            <div id="recruit" class="recruit-container hidden scroll-mt-36 border-normal pt-4">
                <div class="space-y-2 px-4 pb-2">
                    <h1 class="h1">채용공고</h1>
                </div>
                <div class="px-4">
                    <ul id="recruitList">
                        <%-- 채용공고 목록 표시 --%>
                    </ul>
                    <div class="flex">
                    </div>
                </div>
                
                <div id="recruitMore" class="px-0 py-0 hidden">
                    <a href="${pageContext.request.contextPath}/search/recruit?searchWord=${requestScope.searchWord}">
                        <button type="button" class="button-more">채용공고 결과 모두 보기</button>
                    </a>
                </div>
            </div>

            <ul id="updateMore" class="scroll-mt-36 border-search-board hidden">
                <%-- 글 목록 표시 --%>
            </ul>
        </div>

        <!-- 우측 광고 -->
        <div class="right-side lg:col-span-4 h-full relative hidden lg:block">
            <div class="border-list sticky top-36 space-y-2 text-center relative">
                <div class="absolute top-5 right-5 bg-white rounded-sm text-[0.9rem]">
                    <span class="pl-1.5 font-bold">광고</span>
                    <button type="button" class="font-bold hover:bg-gray-100 cursor-pointer px-1.5 py-1 rounded-r-sm"><i class="fa-solid fa-ellipsis"></i></button>
                </div>
                <div>
                    <img src="${pageContext.request.contextPath}/images/ad2.png"/>
                </div>
                <div class="px-4">
                    <p class="font-bold">${sessionScope.loginuser.member_name}님, syoffice에서 All in One Company Service를 경험하세요.</p>
                </div>
                <div class="px-4">
					<a href="http://syoffice.kro.kr/syoffice">
                    <button type="button" class="button-orange">방문하기</button>
					</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>