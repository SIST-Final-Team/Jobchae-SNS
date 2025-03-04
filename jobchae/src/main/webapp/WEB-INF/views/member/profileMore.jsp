<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
</style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script type="text/javascript">
        const ctxPath = '${pageContext.request.contextPath}';
        const memberId = '${requestScope.memberId}'; // 조회 대상 회원 아이디
        let requestLock = false; // AJAX 요청에 대해 응답이 오기 전에 다시 요청하는 것을 차단
        let inputTimeout;        // 입력 후 일정시간이 지난 후 검색이 되도록 하는 타임아웃
        let suggestClearTimeout; // 자동완성 창을 닫기 위한 타임아웃

        $(document).ready(function () {

            // 한 회원의 경력 목록 조회
            getMemberCareerListByMemberId(memberId);

            // 한 회원의 학력 목록 조회
            getMemberEducationListByMemberId(memberId);

            // 한 회원의 보유기술 목록 조회
            getMemberSkillListByMemberId(memberId);

            // select 태그에 연도 표시
            const currentYear = new Date().getFullYear();
            for(let i=1925; i<=currentYear; i++) {
                $("#member_career_startdate_year").append('<option value="'+i+'">'+i+'</option>');
                $("#member_career_enddate_year").append('<option value="'+i+'">'+i+'</option>');
                $("#member_education_startdate_year").append('<option value="'+i+'">'+i+'</option>');
                $("#member_education_enddate_year").append('<option value="'+i+'">'+i+'</option>');
            }
            const endYear = currentYear + 20;
            for(let i=currentYear+1; i<=endYear; i++) {
                $("#member_education_enddate_year").append('<option value="'+i+'">'+i+'</option>');
            }

            // 스크롤 위치에 따라 nav 선택 변경
            $(window).scroll(function () {
                for (let i = 0; i < $(".center>*").length; i++) {
                    if ($(".center>*").eq(i).position().top - 100 <= $(window).scrollTop() &&
                        $(window).scrollTop() < $(".center>*").eq(i).height() + $(".center>*").eq(i).position().top - 100) {
                        $(".nav>li").removeClass("nav-selected");
                        $(".nav>li").eq(i).addClass("nav-selected");
                    }
                    // console.log($(".center>*").eq(i).position().top , $(window).scrollTop());
                }
            });

            // 모달 열기
            $(document).on("click", ".btn-open-modal", function () {
                openModal(this);
            });

            // 바깥 클릭하면 모달 닫기
            /*
            $(".modal").on("click", function(e) {
                if (e.target === this) {
                    this.close();
                }
            });
            */

            // 취소 버튼 또는 X 버튼으로 모달 닫기
            $(".btn-close-modal").on("click", function (e) {
                $(this).parent().parent().parent()[0].close();
            });

            // 검색어가 바뀔 때 0.5초 후 검색
            $(".input-search").on("input", function () {

                const inputEl = this;

                const resultName = $(inputEl).data("result-name");
                $("input[name='"+resultName+"']").val(""); // 결과 비우기

                if (inputTimeout) {
                    clearTimeout(inputTimeout);
                }

                inputTimeout = setTimeout(function () {
                    searchAutocomplete(inputEl);
                }, 500);
            });

            // 엔터를 눌렀을 때 바로 검색
            $(".input-search").on("keydown", function (e) {
                if (e.keyCode == 13) {

                    if (inputTimeout) {
                        clearTimeout(inputTimeout);
                    }

                    searchAutocomplete(this);
                }
            });

            // 자동완성 드롭다운 모달 열기
            $(".input-search").on("focus", function () {
                $(this).next().addClass("hidden"); // 에러 감추기
                searchAutocomplete(this);
            });

            // 바깥 클릭하면 드롭다운 모달 닫기
            $(".input-search").on("blur", function () {

                const $input = $(this);

                if (inputTimeout) {
                    clearTimeout(inputTimeout);
                }

                suggestClearTimeout = setTimeout(() => {

                    const searchResultName = $input.data("result-name");
                    const searchWord = $input.val();

                    // 만약 일련번호가 반드시 필요하다면, 일련번호가 반드시 input 태그에 존재해야 한다.
                    if(searchResultName != undefined) { // 일련번호가 필요한가
                        const $autocompleteList = $(".suggest>ul>li");
                        let found = false;

                        console.log(searchWord);
                        // 입력한 값과 일치하는 결과가 있는지 확인, 결과가 있다면 일련번호 값을 자동으로 입력
                        for (let i = 0; i < $autocompleteList.length; i++) {
                            if ($autocompleteList.eq(i).text() == searchWord) {
                                $(searchResultName).val($autocompleteList.eq(i).data("value"));
                                found = true;
                                break;
                            };
                        }

                        if (!found) {
                            $input.val("");
                            $input.next(".error").removeClass("hidden");
                        }
                        else {
                            $input.next(".error").addClass("hidden");
                        }
                    }
                    $(".suggest").remove(); // 자동완성 창 닫기
                }, 100);
            });

            // 자동완성 클릭 시 자동완성을 없애지 않음
            $(document).on("mousedown", ".suggest", function (e) {
                setTimeout(() => {
                    clearTimeout(suggestClearTimeout);
                }, 50);
            });
            
            // 자동완성 선택 시 값 변경
            $(document).on("mouseup", ".suggest", function (e) {

                const keyword = $(e.target).text();

                const inputId = "#" + $(this).data("target-id");

                $(inputId).next().addClass("hidden");
                $(inputId).val(keyword);

                const value = $(e.target).data("value");
                if (value != undefined) {
                    const resultName = $(inputId).data("result-name");
                    $("input[name='" + resultName + "']").val(value);
                }

                $(".suggest").remove();
            });

            // 날짜 변경시 연도와 월을 input 태그에 입력
            $("input[name='member_career_is_current']").on("change", function() {
                if($(this).prop("checked")) {
                    $("select#member_career_enddate_year").val(0);
                    $("select#member_career_enddate_month").val(0);
                    $("select#member_career_enddate").val(0);
                    $("select#member_career_enddate_year").attr("disabled", true);
                    $("select#member_career_enddate_month").attr("disabled", true);
                    $("input[name='member_career_enddate']").attr("disabled", true);
                }
                else {
                    $("select#member_career_enddate_year").removeAttr("disabled");
                    $("select#member_career_enddate_month").removeAttr("disabled");
                    $("input[name='member_career_enddate']").removeAttr("disabled");
                }
            });

            // 날짜 선택
            $(".select-date").on("change", function() {

                let id = $(this).attr("id");

                if(id.endsWith("_year")) {
                    id = id.substring(0, id.length - "_year".length);
                }
                else if(id.endsWith("_month")) {
                    id = id.substring(0, id.length - "_month".length);
                }

                const year = $("#"+id+"_year").val();
                let month = $("#"+id+"_month").val();
                if(year != 0 && month != 0) {
                    $("input[name='"+id+"']").val(year + "-" + month);
                }
                else {
                    $("input[name='"+id+"']").val("");
                }
            });

            // 경력 입력 폼 제출
            $("#submitMemberCareer").on("click", function() {
                const form = document.memberCareerForm;

                let $emptyElmt = null;

                $(".error:not(.hidden)").each((index, elmt) => {
                    $(elmt).addClass("hidden");
                });

                const inputList = $(form).find(".required:not(input:checkbox)");
                for(let input of inputList) {
                    if(!$(input).attr("disabled") && ($(input).val() == 0 || $(input).val().trim() == "")){
                        $(input).next(".error").removeClass("hidden");
                        $emptyElmt = $(input);
                        break;
                    }
                }

                if($emptyElmt != null) { // 입력하지 않은 input 태그가 존재한다면
                    $emptyElmt.focus();
                }
                else if(form.member_career_no.value != ""){ // 수정

                    $.ajax({
                        url: ctxPath+"/api/member/member-career/update",
                        data:$(form).serialize(),
                        type: "put",
                        dataType: "json",
                        success: function (json) {
                            if(json.result=="1"){
                                getMemberCareerListByMemberId(memberId);
                            }
                            else {
                                alert("경력 수정을 실패했습니다.");
                            }
                        },                     
                        error: function(request, status, error){
                            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                        }
                    });

                }
                else { // 등록
                    $.ajax({
                        url: ctxPath+"/api/member/member-career/add",
                        data:$(form).serialize(),
                        type: "post",
                        dataType: "json",
                        success: function (json) {
                            if(json.result=="1"){
                                getMemberCareerListByMemberId(memberId);
                            }
                            else {
                                alert("경력 등록을 실패했습니다.");
                            }
                        },                     
                        error: function(request, status, error){
                            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                        }
                    });
                }
            });
            
            // 경력 삭제 버튼
            $("#deleteMemberCareer").on("click", function() {
                const form = document.memberCareerForm;

                if(confirm(form.member_career_company.value + " 경력을 삭제하시겠어요?")){

                    $.ajax({
                        url: ctxPath+"/api/member/member-career/delete",
                        data:{"member_career_no":form.member_career_no.value},
                        type: "delete",
                        dataType: "json",
                        success: function (json) {
                            if(json.result=="1"){
                                getMemberCareerListByMemberId(memberId);
                            }
                            else {
                                alert("경력 삭제를 실패했습니다.");
                            }
                        },                     
                        error: function(request, status, error){
                            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                        }
                    });
                }
            });


            // 학력 입력 폼 제출
            $("#submitMemberEducation").on("click", function() {
                const form = document.memberEducationForm;

                let $emptyElmt = null;

                $(".error:not(.hidden)").each((index, elmt) => {
                    $(elmt).addClass("hidden");
                });

                const inputList = $(form).find(".required:not(input:checkbox)");
                for(let input of inputList) {
                    if(!$(input).attr("disabled") && ($(input).val() == 0 || $(input).val().trim() == "")){
                        $(input).next(".error").removeClass("hidden");
                        $emptyElmt = $(input);
                        break;
                    }
                }

                if($emptyElmt != null) { // 입력하지 않은 input 태그가 존재한다면
                    $emptyElmt.focus();
                }
                else if(form.member_education_no.value != ""){ // 수정

                    $.ajax({
                        url: ctxPath+"/api/member/member-education/update",
                        data:$(form).serialize(),
                        type: "put",
                        dataType: "json",
                        success: function (json) {
                            if(json.result=="1"){
                                getMemberEducationListByMemberId(memberId);
                            }
                            else {
                                alert("학력 수정을 실패했습니다.");
                            }
                        },                     
                        error: function(request, status, error){
                            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                        }
                    });

                }
                else { // 등록
                    $.ajax({
                        url: ctxPath+"/api/member/member-education/add",
                        data:$(form).serialize(),
                        type: "post",
                        dataType: "json",
                        success: function (json) {
                            if(json.result=="1"){
                                getMemberEducationListByMemberId(memberId);
                            }
                            else {
                                alert("학력 등록을 실패했습니다.");
                            }
                        },                     
                        error: function(request, status, error){
                            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                        }
                    });
                }
            });
            
            // 학력 삭제 버튼
            $("#deleteMemberEducation").on("click", function() {
                const form = document.memberEducationForm;

                if(confirm(form.school_name.value + " 학력을 삭제하시겠어요?")){

                    $.ajax({
                        url: ctxPath+"/api/member/member-education/delete",
                        data:{"member_education_no":form.member_education_no.value},
                        type: "delete",
                        dataType: "json",
                        success: function (json) {
                            if(json.result=="1"){
                                getMemberEducationListByMemberId(memberId);
                            }
                            else {
                                alert("학력 삭제를 실패했습니다.");
                            }
                        },                     
                        error: function(request, status, error){
                            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                        }
                    });
                }
            });

            // 회원 보유기술 입력 폼 제출
            $("#submitMemberSkill").on("click", function() {
                const form = document.memberSkillForm;

                let $emptyElmt = null;

                $(".error:not(.hidden)").each((index, elmt) => {
                    $(elmt).addClass("hidden");
                });

                const inputList = $(form).find(".required:not(input:checkbox)");
                for(let input of inputList) {
                    if(!$(input).attr("disabled") && ($(input).val() == 0 || $(input).val().trim() == "")){
                        $(input).next(".error").removeClass("hidden");
                        $emptyElmt = $(input);
                        break;
                    }
                }

                if($emptyElmt != null) { // 입력하지 않은 input 태그가 존재한다면
                    $emptyElmt.focus();
                }
                else { // 등록
                    $.ajax({
                        url: ctxPath+"/api/member/member-skill/add",
                        data:$(form).serialize(),
                        type: "post",
                        dataType: "json",
                        success: function (json) {
                            if(json.result=="1"){
                                getMemberSkillListByMemberId(memberId);
                            }
                            else if(json.result=="-1") {
                                alert("이미 등록된 보유기술입니다.");
                            }
                            else {
                                alert("보유기술 등록을 실패했습니다.");
                            }
                        },                     
                        error: function(request, status, error){
                            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                        }
                    });
                }
            });
            
            // 보유기술 삭제 버튼
            $(document).on("click", "#deleteMemberSkill", function() {
                const member_skill_no = $(this).data("member_skill_no");
                const skill_name = $(this).data("skill_name");

                if(confirm(skill_name + " 보유기술을 삭제하시겠어요?")){

                    $.ajax({
                        url: ctxPath+"/api/member/member-skill/delete",
                        data:{"member_skill_no":member_skill_no},
                        type: "delete",
                        dataType: "json",
                        success: function (json) {
                            if(json.result=="1"){
                                getMemberSkillListByMemberId(memberId);
                            }
                            else {
                                alert("보유기술 삭제를 실패했습니다.");
                            }
                        },                     
                        error: function(request, status, error){
                            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                        }
                    });
                }
            });

            // 뒤로가기 버튼
            $("button.back").on("click", function () {
                location.href = ctxPath + "/member/profile";
            });

        });// end of $(document).ready(function () {})----------------------



        // 등록 또는 수정 모달 띄우기
        function openModal(btnEl) {
            const btnId = $(btnEl).attr("id");
            const targetModal = $(btnEl).data("target-modal");
            const targetNo = $(btnEl).data("target-no");

            // 폼 리셋
            $("form").each(function (index, elmt) {
                elmt.reset();
                
                $("select#member_career_enddate_year").removeAttr("disabled");
                $("select#member_career_enddate_month").removeAttr("disabled");
                $("input[name='member_career_enddate']").removeAttr("disabled");
                
                $("#deleteMemberCareer").hide();
                $("#deleteMemberEducation").hide();
            });

            if (targetNo != null) {
                if (targetModal == "MemberCareer") {
                    getMemberCareer(targetNo);
                    $("#deleteMemberCareer").show();
                }
                else if (targetModal == "MemberEducation") {
                    getMemberEducation(targetNo);
                    $("#deleteMemberEducation").show();
                }
            }

            const modalId = "#modal" + targetModal;
            const rect = btnEl.getBoundingClientRect();
            $(modalId)[0].showModal();
        }

        // 회원 경력 수정시 1개 정보 조회하기
        function getMemberCareer(memberCareerNo) {
            $.ajax({
                url: ctxPath + "/api/member/member-career",
                data: { "member_career_no": memberCareerNo },
                dataType: "json",
                success: function (json) {
                    // console.log(JSON.stringify(json));

                    if(json.member_career_no != null) {

                        const form = document.memberCareerForm;

                        form.member_career_no.value = json.member_career_no;
                        form.fk_region_no.value = json.fk_region_no;
                        form.region_name.value = json.region_name;
                        form.fk_job_no.value = json.fk_job_no;
                        form.job_name.value = json.job_name;
                        form.member_career_company.value = json.member_career_company;
                        form.member_career_type.value = json.member_career_type;
                        form.member_career_startdate.value = json.member_career_startdate;
                        form.member_career_startdate_year.value = json.member_career_startdate.split("-")[0];
                        form.member_career_startdate_month.value = json.member_career_startdate.split("-")[1];

                        if(json.member_career_is_current == 1) {
                            form.member_career_is_current.checked = true;
                            $("select#member_career_enddate_year").attr("disabled", true);
                            $("select#member_career_enddate_month").attr("disabled", true);
                            $("input[name='member_career_enddate']").attr("disabled", true);
                        }
                        else {
                            form.member_career_enddate.value = json.member_career_enddate;

                            form.member_career_enddate_year.value = json.member_career_enddate.split("-")[0];
                            form.member_career_enddate_month.value = json.member_career_enddate.split("-")[1];
                        }
                        form.member_career_explain.value = json.member_career_explain;

                    }
                    else {
                        alert("경력 정보를 가져오는 중 오류가 발생했습니다.");
                    }
                },
                error: function (request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }

        // 회원 학력 수정시 1개 정보 조회하기
        function getMemberEducation(memberEducationNo) {
            $.ajax({
                url: ctxPath + "/api/member/member-education",
                data: { "member_education_no": memberEducationNo },
                dataType: "json",
                success: function (json) {
                    // console.log(JSON.stringify(json));

                    if(json.member_education_no != null) {

                        const form = document.memberEducationForm;

                        form.member_education_no.value = json.member_education_no;
                        form.fk_school_no.value = json.fk_school_no;
                        form.school_name.value = json.school_name;
                        form.fk_major_no.value = json.fk_major_no;
                        form.major_name.value = json.major_name;
                        form.member_education_degree.value = json.member_education_degree;

                        form.member_education_startdate.value = json.member_education_startdate;
                        form.member_education_startdate_year.value = json.member_education_startdate.split("-")[0];
                        form.member_education_startdate_month.value = json.member_education_startdate.split("-")[1];

                        form.member_education_enddate.value = json.member_education_enddate;
                        form.member_education_enddate_year.value = json.member_education_enddate.split("-")[0];
                        form.member_education_enddate_month.value = json.member_education_enddate.split("-")[1];
                        
                        form.member_education_grade.value = json.member_education_grade;
                        form.member_education_explain.value = json.member_education_explain;

                    }
                    else {
                        alert("학력 정보를 가져오는 중 오류가 발생했습니다.");
                    }
                },
                error: function (request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }

        // 자동완성
        function searchAutocomplete(inputEl) {

            if (requestLock) {
                return;
            }
            requestLock = true;

            const searchType = $(inputEl).data("search-type");
            const searchWord = $(inputEl).val();
            const searchResultName = $(inputEl).data("result-name");
            let searchValue = null;
            if (searchResultName != undefined) { // 만약 일련번호가 필요하다면
                searchValue = searchResultName.slice("fk_".length);
            }
            const targetUrl = ctxPath + $(inputEl).data("target-url");

            $.ajax({
                url: targetUrl,
                data: { [searchType]: searchWord },
                dataType: "json",
                success: function (json) {
                    // console.log(JSON.stringify(json));

                    let v_html = '<div class="absolute suggest bg-white rounded-lg drop-shadow-lg z-999"><ul>';
                    if (json.length == 0) {
                        v_html += '<li class="hover:bg-gray-100 p-2">검색 결과가 없습니다.</li>';
                    }
                    else {
                        for (let i = 0; i < json.length; i++) {
                            const value = (searchValue != null) ? ' data-value="' + json[i][searchValue] + '"' : "";
                            const logoKey = Object.keys(json).some(key => key.endsWith("_logo"));
                            let logoHtml = ``;
                            if(logoKey != null) {
                                logoHtml = (logoKey != null)?
                                    `<img src="\${ctxPath}/resources/files/\${json[i][logoKey]}" class="h-full aspect-square"/>`:``;
                            }

                            v_html += '<li class="hover:bg-gray-100 p-2"' + value + '>' + logoHtml + json[i][searchType] + '</li>';
                        }
                    }

                    v_html += '</ul></div>';

                    $(".suggest").remove();

                    const inputId = $(inputEl).attr("id");
                    const width = $(inputEl).width();
                    $(inputEl).parent().append(v_html);
                    $(".suggest").css({ "width": width + 8 });
                    $(".suggest").data("target-id", inputId);

                    requestLock = false;
                },
                error: function (request, status, error) { // 결과 에러 콜백함수
                    console.log(error);
                    requestLock = false;
                }
            });
        }

        // 한 회원의 경력 정보를 모두 가져오는 함수
        function getMemberCareerListByMemberId(memberId) {
            $.ajax({
                url: ctxPath + "/api/member/member-career/" + memberId,
                dataType: "json",
                success: function (json) {
                    console.log(JSON.stringify(json));

                    if(json.length > 0) {

                        let html = ``;
                        $.each(json, (index, item) => {
                            const borderHtml = (index != json.length - 1)?`border-b-1 border-gray-300 `:``;
                            const enddate = (item.member_career_enddate != null)?` ~ \${item.member_career_enddate}`:``;

                            html += `
                                <li class="\${borderHtml}py-2 flex items-start">
                                    <a href="#" class="flex flex-1">
                                        <div>
                                            <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover" />
                                        </div>
                                        <div class="flex-1 ml-4">
                                            <div class="font-bold text-xl hover:underline">\${item.job_name}</div>
                                            <div>\${item.member_career_company}</div>
                                            <div class="text-gray-600">\${item.member_career_startdate}\${enddate}</div>
                                        </div>
                                    </a>
                                    <button type="button" data-target-modal="MemberCareer" data-target-no="\${item.member_career_no}"
                                        class="btn-transparent btn-open-modal"><i
                                            class="fa-solid fa-pen"></i></button>
                                </li>`;
                        });

                        $("#memberCareerList").html(html);

                    }
                    else {
                        alert("경력 정보를 가져오는 중 오류가 발생했습니다.");
                    }
                },
                error: function (request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }

        // 한 회원의 학력 정보를 모두 가져오는 함수
        function getMemberEducationListByMemberId(memberId) {
            $.ajax({
                url: ctxPath + "/api/member/member-education/" + memberId,
                dataType: "json",
                success: function (json) {
                    console.log(JSON.stringify(json));

                    if(json.length > 0) {

                        let html = ``;
                        $.each(json, (index, item) => {
                            const borderHtml = (index != json.length - 1)?`border-b-1 border-gray-300 `:``;
                            const schoolLogoImg = (item.school_logo != null)
                                ?`<img src="\${ctxPath}/resources/\${item.school_logo}" class="aspect-square w-15 object-cover" />`
                                :`<div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-school text-2xl text-gray-500"></i></div>`;

                            html += `
                                <li class="\${borderHtml}py-2 flex items-start">
                                    <a href="#" class="flex flex-1">
                                        <div>
                                            \${schoolLogoImg}
                                        </div>
                                        <div class="flex-1 ml-4">
                                            <div class="font-bold text-xl hover:underline">\${item.school_name}</div>
                                            <div>\${item.major_name}</div>
                                            <div class="text-gray-600">\${item.member_education_startdate} ~ \${item.member_education_enddate}</div>
                                            <div>학점: \${item.member_education_grade}</div>
                                        </div>
                                    </a>
                                    <button type="button" data-target-modal="MemberEducation" data-target-no="1"
                                        class="btn-open-modal btn-transparent"><i class="fa-solid fa-pen"></i></button>
                                </li>`;
                        });

                        $("#memberEducationList").html(html);

                    }
                    else {
                        alert("학력 정보를 가져오는 중 오류가 발생했습니다.");
                    }
                },
                error: function (request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }

        // 한 회원의 학력 정보를 모두 가져오는 함수
        function getMemberSkillListByMemberId(memberId) {
            $.ajax({
                url: ctxPath + "/api/member/member-skill/" + memberId,
                dataType: "json",
                success: function (json) {
                    console.log(JSON.stringify(json));

                    if(json.length > 0) {

                        let html = ``;
                        $.each(json, (index, item) => {
                            const borderHtml = (index != json.length - 1)?`border-b-1 border-gray-300 `:``;

                            html += `
                                <li class="\${borderHtml}py-2 flex">
                                    <a href="#" class="flex-1">
                                        <div class="font-bold text-lg hover:underline">\${item.skill_name}</div>
                                    </a>
                                    <button type="button" id="deleteMemberSkill"
                                        data-member_skill_no="\${item.member_skill_no}"
                                        data-skill_name="\${item.skill_name}"
                                        class="btn-transparent"><i class="fa-solid fa-xmark"></i></button>
                                </li>`;
                        });

                        $("#memberSkillList").html(html);

                    }
                    else {
                        alert("학력 정보를 가져오는 중 오류가 발생했습니다.");
                    }
                },
                error: function (request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }

    </script>
    <style>
        dialog.dropdown::backdrop {
            background: transparent;
        }
    </style>
    
    <!-- 경력 Modal -->
    <dialog id="modalMemberCareer"
        class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
        <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button"
                    class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
                <h1 class="h1 px-8">경력 입력</h1>

                <hr class="border-gray-200 mt-4">
            </div>

            <!-- 모달 내용 -->
            <div class="space-y-4 overflow-auto">
                <div class="text-gray-500 px-8">* 필수</div>
                <form name="memberCareerForm">
                    <input type="hidden" name="member_career_no">
                    <ul class="space-y-4 px-8">
                        <li>
                            <label for="job_name" class="text-gray-500">직종 *</label><br>
                            <input type="text" name="job_name" id="job_name"
                                data-target-url="/api/member/job/search"
                                data-search-type="job_name"
                                data-result-name="fk_job_no"
                                class="input-search w-full border-1 rounded-sm p-1" />
                            <input type="hidden" name="fk_job_no" class="required"/>
                            <span class="hidden error text-red-600 text-sm">직종을 목록에서 선택하세요.</span>
                        </li>
                        <li>
                            <label for="member_career_type" class="text-gray-500">고용 형태 *</label><br>
                            <select name="member_career_type" class="w-full border-1 rounded-sm p-1 required"
                                id="member_career_type">
                                <option value="0">선택하세요</option>
                                <option value="1">정규직</option>
                                <option value="2">시간제</option>
                                <option value="3">자영업/개인사업</option>
                                <option value="4">프리랜서</option>
                                <option value="5">계약직</option>
                                <option value="6">인턴</option>
                                <option value="7">수습생</option>
                                <option value="8">시즌</option>
                            </select>
                            <span class="hidden error text-red-600 text-sm">고용 형태를 목록에서 선택하세요.</span>
                        </li>
                        <li>
                            <label for="member_career_company" class="w-14 text-gray-500">회사 또는 단체 *</label><br>
                            <div class="relative">
                                <input type="text" name="member_career_company" id="member_career_company"
                                data-target-url="/api/member/company/search"
                                data-search-type="company_name"
                                data-result-name="fk_company_no"
                                class="input-search w-full border-1 rounded-sm p-1 required"/>
                                <!-- <img src="" class="h-full aspect-square absolute top-0 left-0"/> -->
                                <div class="absolute top-0 left-0 aspect-square h-full bg-gray-200 flex items-center justify-center z-999">
                                    <i class="fa-solid fa-building text-gray-500"></i>
                                </div>
                                <span class="hidden error text-red-600 text-sm">회사 또는 단체를 입력하세요.</span>
                            </div>
                            <input type="hidden" name="fk_company_no"/>
                        </li>
                        <li class="flex items-center gap-2">
                            <input type="checkbox" name="member_career_is_current" value="1" style="zoom:1.5;" class="accent-orange-600 opacity-60 required" id="member_career_is_current"/>
                            <label for="member_career_is_current" class="text-lg pb-0.5">현재 이 업무로 근무 중</label>
                        </li>
                        <li>
                            <label class="text-gray-500">시작일 *</label><br>
                            <div class="flex gap-4">
                                <select id="member_career_startdate_year" class="select-date w-full border-1 rounded-sm p-1">
                                    <option value="0">연도</option>
                                </select>
                                <select id="member_career_startdate_month" class="select-date w-full border-1 rounded-sm p-1">
                                    <option value="0">월</option>
                                    <option value="01">1월</option>
                                    <option value="02">2월</option>
                                    <option value="03">3월</option>
                                    <option value="04">4월</option>
                                    <option value="05">5월</option>
                                    <option value="06">6월</option>
                                    <option value="07">7월</option>
                                    <option value="08">8월</option>
                                    <option value="09">9월</option>
                                    <option value="10">10월</option>
                                    <option value="11">11월</option>
                                    <option value="12">12월</option>
                                </select>
                            </div>
                            <input type="hidden" name="member_career_startdate"class="required"/>
                            <span class="hidden error text-red-600 text-sm">시작일을 선택하세요.</span>
                        </li>
                        <li>
                            <label class="text-gray-500">종료일 *</label><br>
                            <div class="flex gap-4">
                                <select id="member_career_enddate_year"
                                    class="select-date w-full border-1 rounded-sm p-1 disabled:border-0 disabled:bg-gray-200">
                                    <option value="0">연도</option>
                                </select>
                                <select id="member_career_enddate_month"
                                    class="select-date w-full border-1 rounded-sm p-1 disabled:border-0 disabled:bg-gray-200">
                                    <option value="0">월</option>
                                    <option value="01">1월</option>
                                    <option value="02">2월</option>
                                    <option value="03">3월</option>
                                    <option value="04">4월</option>
                                    <option value="05">5월</option>
                                    <option value="06">6월</option>
                                    <option value="07">7월</option>
                                    <option value="08">8월</option>
                                    <option value="09">9월</option>
                                    <option value="10">10월</option>
                                    <option value="11">11월</option>
                                    <option value="12">12월</option>
                                </select>
                            </div>
                            <input type="hidden" name="member_career_enddate" class="required"/>
                            <span class="hidden error text-red-600 text-sm">종료일을 선택하세요.</span>
                        </li>
                        <li>
                            <label for="region_name" class="text-gray-500">지역 *</label><br>
                            <input type="text" name="region_name" id="region_name"
                                data-target-url="/api/member/region/search"
                                data-search-type="region_name"
                                data-result-name="fk_region_no"
                                class="input-search w-full border-1 rounded-sm p-1" />
                            <input type="hidden" name="fk_region_no" class="required"/>
                            <span class="hidden error text-red-600 text-sm">지역을 목록에서 선택하세요.</span>
                        </li>
                        <li>
                            <label for="member_career_explain" class="text-gray-500">설명</label><br>
                            <textarea name="member_career_explain" id="member_career_explain"
                                class="w-full h-40 border-1 rounded-sm p-1 resize-none"></textarea>
                        </li>
                    </ul>
                </form>
            </div>

            <!-- 모달 하단부 -->
            <div>
                <hr class="border-gray-200 mb-4">
                <div class="flex justify-between items-center px-4">
                    <div>
                        <button type="button" id="deleteMemberCareer" class="btn-transparent">경력 삭제</button>
                    </div>
                    <div>
                        <button type="button" id="submitMemberCareer" class="button-selected">저장</button>
                    </div>
                </div>
            </div>
        </div>
    </dialog>

    <!-- 학력 Modal -->
    <dialog id="modalMemberEducation"
        class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
        <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button"
                    class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
                <h1 class="h1 px-8">학력 입력</h1>

                <hr class="border-gray-200 mt-4">
            </div>

            <!-- 모달 내용 -->
            <div class="space-y-4 overflow-auto">
                <div class="text-gray-500 px-8">* 필수</div>
                <form name="memberEducationForm">
                    <input type="hidden" name="member_education_no">
                    <ul class="space-y-4 px-8">
                        <li>
                            <label for="school_name" class="text-gray-500">학교 *</label><br>
                            <input type="text" name="school_name" id="school_name"
                                data-target-url="/api/member/school/search"
                                data-search-type="school_name"
                                data-result-name="fk_school_no"
                                class="input-search w-full border-1 rounded-sm p-1" />
                            <input type="hidden" name="fk_school_no" class="required"/>
                            <span class="hidden error text-red-600 text-sm">학교를 선택하세요.</span>
                        </li>
                        <li>
                            <label for="member_education_degree" class="text-gray-500">학위 *</label><br>
                            <select name="member_education_degree" class="w-full border-1 rounded-sm p-1 required"
                                id="member_education_degree">
                                <option value="0">선택하세요</option>
                                <option value="1">중학교 졸업</option>
                                <option value="2">고등학교 졸업</option>
                                <option value="3">전문학사</option>
                                <option value="4">학사</option>
                                <option value="5">석사</option>
                                <option value="6">박사</option>
                            </select>
                            <span class="hidden error text-red-600 text-sm">학위를 목록에서 선택하세요.</span>
                        </li>
                        <li>
                            <label for="major_name" class="text-gray-500">전공 *</label><br>
                            <input type="text" name="major_name" id="major_name"
                                data-target-url="/api/member/major/search"
                                data-search-type="major_name"
                                data-result-name="fk_major_no"
                                class="input-search w-full border-1 rounded-sm p-1" />
                            <input type="text" name="fk_major_no" class="hidden required" />
                            <span class="hidden error text-red-600 text-sm">전공을 선택하세요.</span>
                        </li>
                        <li>
                            <label class="text-gray-500">입학일 *</label><br>
                            <div class="flex gap-4">
                                <select id="member_education_startdate_year" class="select-date w-full border-1 rounded-sm p-1">
                                    <option value="0">연도</option>
                                </select>
                                <select id="member_education_startdate_month"
                                    class="select-date w-full border-1 rounded-sm p-1">
                                    <option value="0">월</option>
                                    <option value="01">1월</option>
                                    <option value="02">2월</option>
                                    <option value="03">3월</option>
                                    <option value="04">4월</option>
                                    <option value="05">5월</option>
                                    <option value="06">6월</option>
                                    <option value="07">7월</option>
                                    <option value="08">8월</option>
                                    <option value="09">9월</option>
                                    <option value="10">10월</option>
                                    <option value="11">11월</option>
                                    <option value="12">12월</option>
                                </select>
                            </div>
                            <input type="hidden" name="member_education_startdate" class="required"/>
                            <span class="hidden error text-red-600 text-sm">입학일을 선택하세요.</span>
                        </li>
                        <li>
                            <label class="text-gray-500">졸업일(예정) *</label><br>
                            <div class="flex gap-4">
                                <select id="member_education_enddate_year"
                                    class="select-date w-full border-1 rounded-sm p-1">
                                    <option value="0">연도</option>
                                </select>
                                <select id="member_education_enddate_month"
                                    class="select-date w-full border-1 rounded-sm p-1">
                                    <option value="0">월</option>
                                    <option value="01">1월</option>
                                    <option value="02">2월</option>
                                    <option value="03">3월</option>
                                    <option value="04">4월</option>
                                    <option value="05">5월</option>
                                    <option value="06">6월</option>
                                    <option value="07">7월</option>
                                    <option value="08">8월</option>
                                    <option value="09">9월</option>
                                    <option value="10">10월</option>
                                    <option value="11">11월</option>
                                    <option value="12">12월</option>
                                </select>
                            </div>
                            <input type="hidden" name="member_education_enddate" class="required"/>
                            <span class="hidden error text-red-600 text-sm">졸업일을 선택하세요.</span>
                        </li>
                        <li>
                            <label for="member_education_grade" class="text-gray-500">학점 *</label><br>
                            <input type="number" name="member_education_grade" id="member_education_grade"
                                class="w-full border-1 rounded-sm p-1 required" min=2.0 max=4.5/>
                                <span class="hidden error text-red-600 text-sm">학점을 선택하세요.</span>
                        </li>
                        <li>
                            <label for="member_education_explain" class="text-gray-500">설명</label><br>
                            <textarea name="member_education_explain" id="member_education_explain"
                                class="w-full h-40 border-1 rounded-sm p-1 resize-none"></textarea>
                        </li>
                    </ul>
                </form>
            </div>

            <!-- 모달 하단부 -->
            <div>
                <hr class="border-gray-200 mb-4">
                <div class="flex justify-between items-center px-4">
                    <div>
                        <button type="button" id="deleteMemberEducation" class="btn-transparent">학력 삭제</button>
                    </div>
                    <div>
                        <button type="button" id="submitMemberEducation" class="button-selected">저장</button>
                    </div>
                </div>
            </div>
        </div>
    </dialog>

    <!-- 보유기술 Modal -->
    <dialog id="modalMemberSkill"
        class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
        <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button"
                    class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
                <h1 class="h1 px-8">보유기술 입력</h1>

                <hr class="border-gray-200 mt-4">
            </div>

            <!-- 모달 내용 -->
            <div class="space-y-4 overflow-auto">
                <div class="text-gray-500 px-8">* 필수</div>
                <form name="memberSkillForm">
                    <ul class="space-y-4 px-8">
                        <li>
                            <label for="skill_name" class="text-gray-500">보유기술 *</label><br>
                            <input type="text" name="skill_name" id="skill_name"
                                data-target-url="/api/member/skill/search"
                                data-search-type="skill_name"
                                data-result-name="fk_skill_no"
                                class="input-search w-full border-1 rounded-sm p-1" />
                            <input type="text" name="fk_skill_no" class="hidden" />
                        </li>
                    </ul>
                </form>
            </div>

            <!-- 모달 하단부 -->
            <div>
                <hr class="border-gray-200 mb-4">
                <div class="flex justify-end items-center px-4">
                    <div>
                        <button type="button" id="submitMemberSkill" class="button-selected">저장</button>
                    </div>
                </div>
            </div>
        </div>
    </dialog>
    <!-- 본문 -->
    <div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px]">

        <!-- 중앙 본문 -->
        <div class="center col-span-14 md:col-span-10 space-y-2 my-5">
            <div class="scroll-mt-22 border-board">

                <!-- 경력 -->
                <div>
                    <div class="flex items-center">
                        <button type="button" class="back btn-transparent"><i
                                class="fa-solid fa-arrow-left-long"></i></button>
                        <h1 class="h1 flex-1">경력</h1>
                        <button type="button" data-target-modal="MemberCareer"
                            class="btn-transparent btn-open-modal"><i class="fa-solid fa-plus"></i></button>
                    </div>

                    <ul id="memberCareerList" class="space-y-2">
                        <li class="border-b-1 border-gray-300 py-2 flex items-start">
                            <a href="#" class="flex flex-1">
                                <div>
                                    <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover" />
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-xl hover:underline">직종</div>
                                    <div>단체</div>
                                    <div class="text-gray-600">2018년 3월 ~ 2023년 2월</div>
                                </div>
                            </a>
                            <button type="button" data-target-modal="MemberCareer" data-target-no="2"
                                class="btn-transparent btn-open-modal"><i
                                    class="fa-solid fa-pen"></i></button>
                        </li>
                        <li class="py-2 flex items-start">
                            <a href="#" class="flex flex-1">
                                <div>
                                    <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover" />
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-xl hover:underline">직종</div>
                                    <div>단체</div>
                                    <div class="text-gray-600">2018년 3월 ~ 2023년 2월</div>
                                </div>
                            </a>
                            <button type="button" data-target-modal="MemberCareer" data-target-no="3"
                                class="btn-transparent btn-open-modal"><i class="fa-solid fa-pen"></i></button>
                        </li>
                    </ul>
                </div>

                <!-- 학력 -->
                <div>
                    <div class="flex items-center">
                        <button type="button" class="back btn-transparent"><i
                                class="fa-solid fa-arrow-left-long"></i></button>
                        <h1 class="h1 flex-1">학력</h1>
                        <button type="button" data-target-modal="MemberEducation"
                            class="btn-open-modal btn-transparent"><i class="fa-solid fa-plus"></i></button>
                    </div>

                    <ul id="memberEducationList" class="space-y-2">
                        <li class="border-b-1 border-gray-300 py-2 flex items-start">
                            <a href="#" class="flex flex-1">
                                <div>
                                    <!-- <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover" /> -->
                                    <div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-school text-2xl text-gray-500"></i></div>
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-xl hover:underline">대학교</div>
                                    <div>컴퓨터 공학 석사</div>
                                    <div class="text-gray-600">2018년 3월 ~ 2023년 2월</div>
                                    <div>학점: 0</div>
                                </div>
                            </a>
                            <button type="button" data-target-modal="MemberEducation" data-target-no="1"
                                class="btn-open-modal btn-transparent"><i class="fa-solid fa-pen"></i></button>
                        </li>
                        <li class="py-2 flex items-start">
                            <a href="#" class="flex flex-1">
                                <div>
                                    <div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-school text-2xl text-gray-500"></i></div>
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-xl hover:underline">대학교</div>
                                    <div>컴퓨터 공학 석사</div>
                                    <div class="text-gray-600">2018년 3월 ~ 2023년 2월</div>
                                    <div>학점: 0</div>
                                </div>
                            </a>
                            <button type="button" data-target-modal="MemberEducation" data-target-no="1"
                                class="btn-open-modal btn-transparent"><i class="fa-solid fa-pen"></i></button>
                        </li>
                    </ul>
                </div>

                <!-- 보유기술 -->
                <div>
                    <div class="flex items-center">
                        <button type="button" class="back btn-transparent"><i
                                class="fa-solid fa-arrow-left-long"></i></button>
                        <h1 class="h1 flex-1">보유기술</h1>
                        <button type="button" data-target-modal="MemberSkill"
                            class="btn-open-modal btn-transparent"><i class="fa-solid fa-plus"></i></button>
                    </div>

                    <ul id="memberSkillList" class="space-y-2">
                        <li class="border-b-1 border-gray-300 py-2 flex">
                            <a href="#" class="flex-1">
                                <div class="font-bold text-lg hover:underline">스프링 MVC</div>
                            </a>
                            <button type="button" id="deleteMemberSkill"
                                data-member_skill_no="1"
                                data-skill_name="스프링 MVC"
                                class="btn-transparent"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li class="py-2 flex">
                            <a href="#" class="flex-1">
                                <div class="font-bold text-lg hover:underline">스프링 프레임워크</div>
                            </a>
                            <button type="button" id="deleteMemberSkill"
                                data-member_skill_no="2"
                                data-skill_name="스프링 프레임워크"
                                class="btn-transparent"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 우측 광고 -->
        <div class="right-side lg:col-span-4 h-full relative hidden lg:block">
            <div class="border-list sticky top-20 space-y-2 text-center relative">
                <div class="absolute top-5 right-5 bg-white rounded-sm text-[0.9rem]">
                    <span class="pl-1.5 font-bold">광고</span>
                    <button type="button"
                        class="font-bold hover:bg-gray-100 cursor-pointer px-1.5 py-1 rounded-r-sm"><i
                            class="fa-solid fa-ellipsis"></i></button>
                </div>
                <div>
                    <img src="7.png" />
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