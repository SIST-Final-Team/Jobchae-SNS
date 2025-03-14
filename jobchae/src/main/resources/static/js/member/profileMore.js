
let requestLock = false; // AJAX 요청에 대해 응답이 오기 전에 다시 요청하는 것을 차단
let inputTimeout;        // 입력 후 일정시간이 지난 후 검색이 되도록 하는 타임아웃
let suggestClearTimeout; // 자동완성 창을 닫기 위한 타임아웃

$(document).ready(function () {

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
                        if(reload) {
                            location.reload();
                        }
                        else {
                            getMemberCareerListByMemberId(memberId);
                            $(".btn-close-modal").click(); // 모달 닫기
                        }
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
                        if(reload) {
                            location.reload();
                        }
                        else {
                            getMemberCareerListByMemberId(memberId);
                            $(".btn-close-modal").click(); // 모달 닫기
                        }
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
                        if(reload) {
                            location.reload();
                        }
                        else {
                            getMemberCareerListByMemberId(memberId);
                            $(".btn-close-modal").click(); // 모달 닫기
                        }
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
                        if(reload) {
                            location.reload();
                        }
                        else {
                            getMemberEducationListByMemberId(memberId);
                            $(".btn-close-modal").click(); // 모달 닫기
                        }
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
                        if(reload) {
                            location.reload();
                        }
                        else {
                            getMemberEducationListByMemberId(memberId);
                            $(".btn-close-modal").click(); // 모달 닫기
                        }
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
                        if(reload) {
                            location.reload();
                        }
                        else {
                            getMemberEducationListByMemberId(memberId);
                            $(".btn-close-modal").click(); // 모달 닫기
                        }
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
                        if(reload) {
                            location.reload();
                        }
                        else {
                            getMemberSkillListByMemberId(memberId);
                            $(".btn-close-modal").click(); // 모달 닫기
                        }
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
                        if(reload) {
                            location.reload();
                        }
                        else {
                            getMemberSkillListByMemberId(memberId);
                            $(".btn-close-modal").click(); // 모달 닫기
                        }
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
        location.href = ctxPath + "/member/profile/"+memberId;
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
                if(json.fk_company_no != null) {
                    form.fk_company_no.value = json.fk_company_no;
                }
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

            let v_html = '<div class="absolute suggest bg-white rounded-lg drop-shadow-lg max-h-50 z-999 overflow-y-auto"><ul>';
            if (json.length == 0) {
                v_html += '<li class="hover:bg-gray-100 p-2">검색 결과가 없습니다.</li>';
            }
            else {
                for (let i = 0; i < json.length; i++) {
                    const value = (searchValue != null) ? ' data-value="' + json[i][searchValue] + '"' : "";
                    const logoKey = Object.keys(json).some(key => key.endsWith("_logo"));
                    let logoHtml = ``;
                    // if(logoKey != null) {
                    //     logoHtml = (logoKey != null)?
                    //         `<img src="${ctxPath}/resources/files/${json[i][logoKey]}" class="h-full aspect-square"/>`:``;
                    // }

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
            // console.log(JSON.stringify(json));

            if(json.length > 0) {

                let html = ``;
                $.each(json, (index, item) => {
                    const borderHtml = (index != json.length - 1)?`border-b-1 border-gray-300 `:``;
                    const enddate = (item.member_career_enddate != null)?` ~ ${item.member_career_enddate}`:``;
                    const companyLogoImg = (item.company_logo != null)
                        ?`<img src="${ctxPath}/resources/files/${item.school_logo}" class="aspect-square w-15 object-cover" />`
                        :`<div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-2xl text-gray-500"></i></div>`;
                    
                    const buttonHtml = (isMyProfile)?`<button type="button" data-target-modal="MemberCareer" data-target-no="${item.member_career_no}"
                                class="btn-transparent btn-open-modal"><i
                                    class="fa-solid fa-pen"></i></button>`:``;

                    html += `
                        <li class="${borderHtml}py-2 flex items-start">
                            <a href="#" class="flex flex-1">
                                <div>
                                    ${companyLogoImg}
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-xl hover:underline">${item.job_name}</div>
                                    <div>${item.member_career_company}</div>
                                    <div class="text-gray-600">${item.member_career_startdate}${enddate}</div>
                                </div>
                            </a>
                            ${buttonHtml}
                        </li>`;
                });

                $("#memberCareerList").html(html);

            }
            else {
                const buttonHtml = (isMyProfile)?`<button type="button" data-target-modal="MemberCareer"
                            class="btn-open-modal btn-transparent px-3!"><i class="fa-solid fa-plus"></i></button>
                            <span class="font-bold -ml-1">버튼을 눌러 경력을 추가해보세요.</span>`:``;
                let html = `<li class="text-center text-lg py-2"><span class="block">조회된 경력 정보가 없습니다.</span>
                            ${buttonHtml}
                        </li>`;

                $("#memberCareerList").html(html);
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
                        ?`<img src="${ctxPath}/resources/files/${item.school_logo}" class="aspect-square w-15 object-cover" />`
                        :`<div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-school text-2xl text-gray-500"></i></div>`;
                    
                    const buttonHtml = (isMyProfile)?`<button type="button" data-target-modal="MemberEducation" data-target-no="${item.member_education_no}"
                                class="btn-open-modal btn-transparent"><i class="fa-solid fa-pen"></i></button>`:``;

                    html += `
                        <li class="${borderHtml}py-2 flex items-start">
                            <a href="#" class="flex flex-1">
                                <div>
                                    ${schoolLogoImg}
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-xl hover:underline">${item.school_name}</div>
                                    <div>${item.major_name}</div>
                                    <div class="text-gray-600">${item.member_education_startdate} ~ ${item.member_education_enddate}</div>
                                    <div>학점: ${item.member_education_grade}</div>
                                </div>
                            </a>
                            ${buttonHtml}
                        </li>`;
                });

                $("#memberEducationList").html(html);

            }
            else {
                const buttonHtml = (isMyProfile)?`<button type="button" data-target-modal="MemberEducation"
                            class="btn-open-modal btn-transparent px-3!"><i class="fa-solid fa-plus"></i></button>
                            <span class="font-bold -ml-1">버튼을 눌러 학력을 추가해보세요.</span>`:``;
                let html = `<li class="text-center text-lg py-2"><span class="block">조회된 학력 정보가 없습니다.</span>
                            ${buttonHtml}
                        </li>`;

                $("#memberEducationList").html(html);
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
                    const buttonHtml = (isMyProfile)?`<button type="button" id="deleteMemberSkill"
                                data-member_skill_no="${item.member_skill_no}"
                                data-skill_name="${item.skill_name}"
                                class="btn-transparent"><i class="fa-solid fa-xmark"></i></button>`:``;

                    html += `
                        <li class="${borderHtml}py-2 flex">
                            <a href="#" class="flex-1">
                                <div class="font-bold text-lg hover:underline">${item.skill_name}</div>
                            </a>
                            ${buttonHtml}
                        </li>`;
                });

                $("#memberSkillList").html(html);

            }
            else {
                const buttonHtml = (isMyProfile)?`<button type="button" data-target-modal="MemberSkill"
                            class="btn-open-modal btn-transparent px-3!"><i class="fa-solid fa-plus"></i></button>
                            <span class="font-bold -ml-1">버튼을 눌러 보유기술을 추가해보세요.</span>`:``;
                let html = `<li class="text-center text-lg py-2"><span class="block">조회된 보유기술 정보가 없습니다.</span>
                            ${buttonHtml}
                        </li>`;

                $("#memberSkillList").html(html);
            }
        },
        error: function (request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });
}
