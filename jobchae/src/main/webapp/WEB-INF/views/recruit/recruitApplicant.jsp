<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

<%-- Quill 에디터 --%>
<link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet">

<%-- PDF 뷰어 --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js"></script>

<script type="text/javascript">

let start = 1;
let len = 16;
let hasMore = true; // 지원자 목록이 더 존재하는지 확인하는 변수
let requestLock = false;
let memberTel = ''; // 회원 전화번호 복사를 위한 변수

// 채용공고 일련번호
const pathSegments = window.location.pathname.split("/");
// /jobchae/recruit/detail/37/applicant 를 아래와 같이 변환
// ["", "jobchae", "recruit", "detail", "37", "applicant"]
const recruit_no = pathSegments[4]; // "37"

let applyList = []; // 채용지원 json list

$(document).ready(function() {

    initSearchOption(); // 검색 옵션 초기화

    getSearchResult(); // 검색 결과 ajax 요청

    // 정렬기준 드롭다운 모달 열기
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
            initSearchOption(); // 검색 옵션을 원래대로 되돌리기
            this.close();
        }
    });
    
    // 취소 버튼 또는 X 버튼으로 드롭다운 모달 닫기
    $(document).on("click", ".btn-close-dropdown", function(e) {
        $(".option-dropdown").click();
    });

    // 검색 옵션 결과보기 버튼
    $(".btn-submit").on("click", function() {
        $("#applyList").html("");
        start = 1;
        len = 16;
        hasMore = true;
        requestLock = false;
        applyList = []; // 채용지원 json list

        getSearchResult(); // 검색 결과 ajax 요청
        $(".option-dropdown").click();
    });

    // PDF 더보기 버튼
    $("#pdfMore").on("click", function() {
        $("#pdfContainer").toggleClass("h-80").toggleClass("h-200");

        if($("#pdfContainer").is(".h-80")) {
            $(this).html('더보기 <i class="fa-solid fa-chevron-down">');
        }
        else {
            $(this).html('더보기 취소 <i class="fa-solid fa-chevron-up">');
        }
    });

    // 필수 자격 질문이 없으면 숨기기
    if ($("#questionRequiredList").children().length == 0) {
        $("#questionRequiredDiv").hide();
    }
    // 우대 자격(필수가 아닌) 질문이 없으면 숨기기
    if ($("#questionNotRequiredList").children().length == 0) {
        $("#questionNotRequiredDiv").hide();
    }

    // 채용지원 1개를 선택했을 때 우측 영역에 내용 표시
    $(document).on("click", ".btn-apply-info", function() {

        $("#applyInfoContainer").scrollTop(0);

        const apply_no = $(this).data("apply-no");

        $("#applyList").children("li").removeClass("apply-selected");
        $(this).parent().addClass("apply-selected");

        // 내용 바꾸기
        let apply = applyList.find(item => item.apply_no == apply_no);

        if(apply.apply_checked == 0) {
            $.ajax({
                url:ctxPath + "/api/recruit/apply/check/" + apply_no,
                type:"put",
                dataType: "json",
                success: function (json) {
                    // console.log(JSON.stringify(json));
                },
                error: function (request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }
        $("#applyListItem"+apply_no).removeClass("apply-new");

        $(".applyMemberName").text(apply.memberVO.member_name);
        $("#applyRegionName").text(apply.memberVO.region_name);
        $("#applyTimeAgo").text(apply.time_ago);

        $(".btn-update-apply-result").data("apply-no", apply_no);
        changeStyleApplyResultButton(apply_no, apply.apply_result);

        $("#memberEmail").text(apply.memberVO.member_email);
        $("#memberEmailLink").attr("href", "mailto:"+apply.memberVO.member_email);
        $("#memberTel").text(apply.memberVO.member_tel);
        memberTel = apply.memberVO.member_tel;

        // 경력 목록 불러오기
        if(apply.memberVO.member_career_company != null) {
            getMemberCareerListByMemberId(apply.memberVO.member_id);
        }
        else {
            $("#memberCareerListContainer").hide();
        }

        // 학력 목록 불러오기
        if(apply.memberVO.school_name != null) {
            getMemberEducationListByMemberId(apply.memberVO.member_id);
        }
        else {
            $("#shcoolListContainer").hide();
        }

        // 프로필 링크
        $(".view-profile").attr("href", "${pageContext.request.contextPath}/member/profile/"+apply.memberVO.member_id);

        // 이력서 파일 다운로드
        const url = `${pageContext.request.contextPath}/resources/files/apply/\${apply.apply_resume}`;
        $("#applyResumeDownload").attr("href", url);

        // 이력서가 PDF 파일인 경우
        if(apply.apply_resume.endsWith(".pdf")) {
            $("#pdfMore").parent().prev().show();
            $("#pdfMore").show();
            $("#pdfMore").html('더보기 <i class="fa-solid fa-chevron-down">');
            $("#pdfContainer").addClass("h-80").removeClass("h-200");

            $("#pdfContainer").html("");

            // PDF 불러오기
            pdfjsLib.getDocument(url).promise.then(pdf => {
                const container = document.getElementById('pdfContainer');

                // 전체 페이지 수만큼 반복
                for (let pageNum = 1; pageNum <= pdf.numPages; pageNum++) {
                    pdf.getPage(pageNum).then(page => {
                    const scale = 1.5; // 확대/축소 비율
                    const viewport = page.getViewport({ scale });

                    // canvas 생성
                    const canvas = document.createElement('canvas');
                    const context = canvas.getContext('2d');
                    canvas.height = viewport.height;
                    canvas.width = viewport.width;
                    canvas.className = 'w-full border border-gray-200 rounded shadow';

                    // PDF 페이지를 canvas에 렌더링
                    page.render({
                        canvasContext: context,
                        viewport: viewport
                    });

                    // container에 canvas 추가
                    container.appendChild(canvas);
                    });
                }
            });
        }
        else { // 이력서가 Word 파일인 경우
            $("#pdfMore").parent().prev().hide();
            $("#pdfMore").hide();
            $("#pdfContainer").removeClass("h-80").removeClass("h-200");

            let html = `
                <a href="${pageContext.request.contextPath}/resources/files/apply/\${apply.apply_resume}"
                    class="border-rwd flex items-center font-bold overflow-hidden hover:underline block">
                    <div class="bg-blue-900 px-2 py-6 text-white">DOC</div>
                    <div class="flex-1 ml-2">\${apply.memberVO.member_name}님의 이력서</div>
                </a>`;
            $("#pdfContainer").html(html);
        }

        // 답변 점수
        $("#advantageScore").text(apply.advantage_score);
        $("#requiredScore").text(apply.required_score);

        // 답변 목록
        $.each(apply.answerVOList, (index, item) => {
            $("#answerFor"+item.fk_question_no).text(item.answer_query);

            let correct = $("#answerFor"+item.fk_question_no).data("correct");

            if(correct == item.answer_query) { // 대답이 정답이라면
                $("#answerMarkFor"+item.fk_question_no).html(`<i class="fa-solid fa-check text-green-700"></i>`);
            }
            else {
                $("#answerMarkFor"+item.fk_question_no).html(`<i class="fa-solid fa-xmark text-red-600"></i>`);
            }
        });

    });

    // 경력 더보기 버튼
    $("#memberCareerMore").on("click", function() {
        $(this).toggleClass("show-more");

        if($("#memberCareerList").is(".show-more")) {
            $("#memberCareerList").children().slice(1).slideDown(200);
            $(this).html('더보기 취소 <i class="fa-solid fa-chevron-up">');
        }
        else {
            $("#memberCareerList").children().slice(1).slideUp(200);
            $(this).html(`경력 더보기 \${$("#memberCareerList").children().length - 1} <i class="fa-solid fa-chevron-down">`);
        }
    });

    // 학력 더보기 버튼
    $("#memberEducationMore").on("click", function() {
        $(this).toggleClass("show-more");

        if($(this).is(".show-more")) {
            $("#memberEducationList").children().slice(1).slideDown(200);
            $(this).html('더보기 취소 <i class="fa-solid fa-chevron-up">');
        }
        else {
            $("#memberEducationList").children().slice(1).slideUp(200);
            $(this).html(`학력 더보기 \${$("#memberEducationList").children().length - 1} <i class="fa-solid fa-chevron-down">`);
        }
    });

    // 적임자 분류
    $(document).on("click", ".btn-update-apply-result", function() {
        let applyResult = $(this).data("apply-result");
        let applyNo = $(this).data("apply-no");
        console.log(applyNo);

        $.ajax({
            url: ctxPath + "/api/recruit/apply/update/" + applyNo,
            type: "put",
            data: {"apply_result": applyResult},
            dataType: "json",
            success: function (json) {
                // console.log(JSON.stringify(json));
                if(json.result == 1) {
                    // alert("수정이 완료되었습니다.");
                    changeStyleApplyResultButton(applyNo, applyResult); // 분류 버튼 수정
                    $(".option-dropdown").click(); // 드롭다운 닫기
                }
                else {
                    alert("수정을 실패하였습니다.");
                }
            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    });

    // 전화번호 복사 버튼
    $("#memberTelCopy").on("click", function() {
        navigator.clipboard.writeText(memberTel).then(() => {
            alert("전화번호가 클립보드에 복사되었습니다.");
        });
    });

});

// 평가 결과(적임자, 부적임자 등)에 따른 버튼 모양 변경
function changeStyleApplyResultButton(applyNo, applyResult) {
    applyResult = Number(applyResult);
    switch(applyResult) {
        case 0: // 미분류
            $("#btnUpdateApplyResultContainer").html(`<button type="button" id="btnUpdateApplyResult" class="button-selected btn-open-dropdown">지원자 분류 <i class="fa-solid fa-caret-down"></i></button>`);
            $(`#applyResult\${applyNo}`).html(``);
            break;
        case 1: // 적임자
            $("#btnUpdateApplyResultContainer").html(`<button type="button" id="btnUpdateApplyResult" class="btn-open-dropdown"><span class="text-green-600 font-bold">적임자</span> <i class="fa-solid fa-caret-down"></i></button>`);
            $(`#applyResult\${applyNo}`).html(`<span class="text-green-600 font-bold">적임자</span> · `);
            break;
        case 2: // 중립
            $("#btnUpdateApplyResultContainer").html(`<button type="button" id="btnUpdateApplyResult" class="btn-open-dropdown"><span class="text-gray-600 font-bold">중립</span> <i class="fa-solid fa-caret-down"></i></button>`);
            $(`#applyResult\${applyNo}`).html(`<span class="text-gray-600 font-bold">중립</span> · `);
            break;
        case 3: // 부적임자
            $("#btnUpdateApplyResultContainer").html(`<button type="button" id="btnUpdateApplyResult" class="btn-open-dropdown"><span class="text-red-600 font-bold">부적임자</span> <i class="fa-solid fa-caret-down"></i></button>`);
            $(`#applyResult\${applyNo}`).html(`<span class="text-red-600 font-bold">부적임자</span> · `);
            break;
    }
}

// 검색 옵션 초기화
function initSearchOption(){

    const params = new URLSearchParams(location.search);

    const searchApplyOrderBy = params.get("searchApplyOrderBy") || "registerdate"; // 정렬 기준
    const searchApplyCareerYearList = params.getAll("searchApplyCareerYearList");  // 경력 연차
    const searchApplyResultList = params.getAll("searchApplyResultList"); // 평가 결과 목록
    const searchApplyRegionList = params.getAll("searchApplyRegionList"); // 지역 목록
    const searchApplySkillList = params.getAll("searchApplySkillList");   // 전문분야 목록

    $("input[type=checkbox]").prop("checked", false);

    // 정렬 기준
    $("button#btnSearchApplyOrderBy").removeClass("button-gray");
    $("button#btnSearchApplyOrderBy").addClass("button-selected");
    $("input[name='searchApplyOrderBy'][value='"+searchApplyOrderBy+"']").prop("checked", true);

    // 평가가 선택되어 있다면
    if(searchApplyResultList.length > 0) {
        $.each(searchApplyResultList, (index, item) => {
            $("input[name='searchApplyResultList'][value='"+item+"']").prop("checked", true);
        });
        $("button#btnSearchApplyResultList").removeClass("button-gray");
        $("button#btnSearchApplyResultList").addClass("button-selected");
    }
    else {
        $("button#btnSearchApplyResultList").removeClass("button-selected");
        $("button#btnSearchApplyResultList").addClass("button-gray");
    }

    // 경력 연차가 선택되어 있다면
    if(searchApplyCareerYearList.length > 0) {
        $.each(searchApplyCareerYearList, (index, item) => {
            $("input[name='searchApplyCareerYearList'][value='"+item+"']").prop("checked", true);
        });
        $("button#btnSearchApplyCareerYearList").removeClass("button-gray");
        $("button#btnSearchApplyCareerYearList").addClass("button-selected");
    }
    else {
        $("button#btnSearchApplyCareerYearList").removeClass("button-selected");
        $("button#btnSearchApplyCareerYearList").addClass("button-gray");
    }

    // 지역이 선택되어 있다면
    if(searchApplyRegionList.length > 0) {
        $.each(searchApplyRegionList, (index, item) => {
            $("input[name='searchApplyRegionList'][value='"+item+"']").prop("checked", true);
        });
        $("button#btnSearchApplyRegionList").removeClass("button-gray");
        $("button#btnSearchApplyRegionList").addClass("button-selected");
    }
    else {
        $("button#btnSearchApplyRegionList").removeClass("button-selected");
        $("button#btnSearchApplyRegionList").addClass("button-gray");
    }

    // 전문분야가 선택되어 있다면
    if(searchApplySkillList.length > 0) {
        $.each(searchApplySkillList, (index, item) => {
            $("input[name='searchApplySkillList'][value='"+item+"']").prop("checked", true);
        });
        $("button#btnSearchApplySkillList").removeClass("button-gray");
        $("button#btnSearchApplySkillList").addClass("button-selected");
    }
    else {
        $("button#btnSearchApplySkillList").removeClass("button-selected");
        $("button#btnSearchApplySkillList").addClass("button-gray");
    }

}

// 검색 옵션 추가하기
function addSearchArr(){

    let additionalFieldsHtml = ``;

    // 평가 결과 목록 추가
    let searchApplyResultList = "";
    $("input[name='searchApplyResultList']:checked").each((index, elmt) => {
        if(index == 0) {
            searchApplyResultList += $(elmt).val();
        }
        else {
            searchApplyResultList += ","+$(elmt).val();
        }
    });
    if(searchApplyResultList != "") {
        additionalFieldsHtml += `<input type="hidden" name="searchApplyResultList" value="\${searchApplyResultList}"/>`;
    }

    // 지역 목록 추가
    let searchApplyRegionList = "";
    $("input[name='searchApplyRegionList']:checked").each((index, elmt) => {
        if(index == 0) {
            searchApplyRegionList += $(elmt).val();
        }
        else {
            searchApplyRegionList += ","+$(elmt).val();
        }
    });
    if(searchApplyRegionList != "") {
        additionalFieldsHtml += `<input type="hidden" name="searchApplyRegionList" value="\${searchApplyRegionList}"/>`;
    }

    // 경력 연차 목록 추가
    let searchApplyCareerYearList = "";
    $("input[name='searchApplyCareerYearList']:checked").each((index, elmt) => {
        if(index == 0) {
            searchApplyCareerYearList += getSearchApplyCareerYearListValue($(elmt).val());
        }
        else {
            searchApplyCareerYearList += ","+getSearchApplyCareerYearListValue($(elmt).val());
        }
    });
    console.log(searchApplyCareerYearList);
    if(searchApplyCareerYearList != "") {
        additionalFieldsHtml += `<input type="hidden" name="searchApplyCareerYearList" value="\${searchApplyCareerYearList}"/>`;
    }

    // 전문분야 목록 추가
    let searchApplySkillList = "";
    $("input[name='searchApplySkillList']:checked").each((index, elmt) => {
        if(index == 0) {
            searchApplySkillList += $(elmt).val();
        }
        else {
            searchApplySkillList += ","+$(elmt).val();
        }
    });
    if(searchApplySkillList != "") {
        additionalFieldsHtml += `<input type="hidden" name="searchApplySkillList" value="\${searchApplySkillList}"/>`;
    }

    $("#additionalFields").append(additionalFieldsHtml);
}

// 경력 연차 값 반환 함수
function getSearchApplyCareerYearListValue(value) {

    let result = "";

    switch(value) {
        case "0": // 1년 미만
            result = "0";
            break;
        case "1": // 1 - 2년
            result = "1,2";
            break;
        case "2": // 3 - 5년
            result = "3,4,5";
            break;
        case "3": // 6 - 10년
            result = "6,7,8,9,10";
            break;
        case "4": // 11년 이상
            result = "11";
            break;
        default:
            break;
    }

    return result;
}

// 검색 결과 가져오기
function getSearchResult() {
    
    if(requestLock) {
        return;
    }

    if(!hasMore) { // 모두 불러왔다면
        return; // 종료
    }
    
    requestLock = true; // 스크롤 이벤트가 여러 번 발생 하기 때문에 ajax를 쓰는동안 락을 걸어야 한다.

    ////////// URL 주소 수정 ///////////
    // 폼에서 값 수집
    const params = {
        searchApplyOrderBy: $("input[name='searchApplyOrderBy']:checked").val(),
        searchApplyCareerYearList: $("input[name='searchApplyCareerYearList']:checked").map(function () { return this.value; }).get(),
        searchApplyResultList: $("input[name='searchApplyResultList']:checked").map(function () { return this.value; }).get(),
        searchApplyRegionList: $("input[name='searchApplyRegionList']:checked").map(function () { return this.value; }).get(),
        searchApplySkillList: $("input[name='searchApplySkillList']:checked").map(function () { return this.value; }).get(),
    };

    // multiple 값이 배열인 경우 처리
    const searchParams = new URLSearchParams();

    for (let key in params) {
        const value = params[key];
        if (Array.isArray(value)) {
            value.forEach(v => searchParams.append(key, v)); // 같은 키로 여러 개 추가됨
        } else if (value != null && value != '') {
            searchParams.set(key, value);
        }
    }

    const queryString = searchParams.toString();
    const newUrl = `\${window.location.pathname}?\${queryString}`;

    history.pushState({}, '', newUrl);
    ////////// URL 주소 수정 ///////////

    document.searchOptionForm.recruit_no.value = recruit_no;

    $("#additionalFields").html(""); // 검색 조건 초기화
    addSearchArr(); // 검색 조건 추가

    $("#additionalFields").append(`<input type="hidden" name="start" value="\${start}"/>`);
    $("#additionalFields").append(`<input type="hidden" name="end" value="\${start + len - 1}"/>`);
    const data = $("form[name='searchOptionForm']").serialize();
    $.ajax({
        url: "${pageContext.request.contextPath}/api/recruit/apply",
        data: data,
        dataType: "json",
        success: function (json) {
            // console.log(JSON.stringify(json));

            if(json.searchApplyCount > 0) {

                applyList = applyList.concat(json.applyList);

                $("#totalApplyCount").text(json.totalApplyCount);
                $("#searchApplyCount").text(json.searchApplyCount);

                let html = ``;
                $.each(json.applyList, (index, item) => {
                    let specList = [];

                    const pushItems = (source, limit) => {
                        if (!source) return;
                        const items = source.split(",");
                        for (let i = 0; i < items.length && specList.length < limit; i++) {
                            specList.push(`<div>\${items[i]}</div>`);
                        }
                    };

                    // 최대 2개까지 company, school 순으로 채움
                    pushItems(item.memberVO.member_career_company, 2);
                    pushItems(item.memberVO.school_name, 2);

                    let regionNameHtml = (item.memberVO.region_name != null) ? `<div>\${item.memberVO.region_name}</div>`:``;

                    let scoreHtml = (item.required_score != "0/0") ? `필수 자격 \${item.required_score}`:`우대 자격 \${item.advantage_score}`;

                    let applyResultHtml = `<span id="applyResult\${item.apply_no}"></span>`;
                    switch(Number(item.apply_result)) {
                        case 1:
                            applyResultHtml = `<span id="applyResult\${item.apply_no}"><span class="text-green-600 font-bold">적임자</span> · </span>`;
                            break;
                        case 2:
                            applyResultHtml = `<span id="applyResult\${item.apply_no}"><span id="applyResult\${item.apply_no}" class="text-gray-600 font-bold">중립</span> · </span>`;
                            break;
                        case 3:
                            applyResultHtml = `<span id="applyResult\${item.apply_no}"><span id="applyResult\${item.apply_no}" class="text-red-600 font-bold">부적임자</span> · </span>`;
                            break;
                        default:
                            break;
                    }

                    let checkedHtml = (item.apply_checked == 0)?`apply-new`:``;

                    html += `
                        <li id="applyListItem\${item.apply_no}" class="border-b-1 border-gray-200 \${checkedHtml}">
                            <button type="button" data-apply-no="\${item.apply_no}" class="btn-apply-info w-full text-left flex px-6 py-3 hover:underline">
                                <img class="w-15 h-15 object-cover rounded-full mr-4"
                                    src="${pageContext.request.contextPath}/resources/files/profile/\${item.memberVO.member_profile}" />
                                <div class="flex-1">
                                    <div class="font-bold text-[1.05rem]">\${item.memberVO.member_name}</div>
                                    \${regionNameHtml}

                                    <div class="text-gray-500 my-2">
                                        \${specList.join("\n")}
                                    </div>

                                    <div class="text-gray-500">\${applyResultHtml}지원함: <span>\${item.time_ago}</span> · \${scoreHtml}</div>
                                </div>
                            </button>
                        </li>`;
                });

                $("#applyList").append(html);

                $("#emptyContainer").addClass("hidden");
                $("#mainContainer").removeClass("hidden");

                $("#applyList").find(".btn-apply-info").eq(0).click(); // 첫 번째 항목 선택
            }
            else {
                if(start==1) { // 목록이 하나도 없다면
                    $("#mainContainer").addClass("hidden");
                    $("#emptyContainer").removeClass("hidden");
                }

                hasMore = false; // 더이상 불러올 목록이 없음
            }

            start += json.applyList.length;
            requestLock = false;
        },
        error: function (request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
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
                $("#memberCareerListContainer").show();

                let html = ``;
                $.each(json, (index, item) => {
                    const borderHtml = (index != json.length - 1)?`border-b-1 border-gray-300 `:``;
                    const enddate = (item.member_career_enddate != null)?` ~ \${item.member_career_enddate}`:` ~ 현재`;
                    const companyLogoImg = (item.company_logo != null)
                        ?`<img src="${pageContext.request.contextPath}/resources/files/\${item.school_logo}" class="aspect-square w-15 object-cover" />`
                        :`<div class="aspect-square w-10 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-lg text-gray-500"></i></div>`;

                    html += `
                        <li class="py-2 flex items-start">
                            <div>
                                \${companyLogoImg}
                            </div>
                            <div class="flex-1 ml-4">
                                <div class="font-bold text-lg">\${item.job_name}</div>
                                <div>\${item.member_career_company}</div>
                                <div class="text-gray-600 text-sm">\${item.member_career_startdate}\${enddate}</div>
                            </div>
                        </li>`;
                });

                $("#memberCareerList").html(html);

                if(json.length > 1) {
                    $("#memberCareerList").children().slice(2).hide();
                    $("#memberCareerMore").show();
                    $("#memberCareerMore").html(`경력 더보기 \${$("#memberCareerList").children().length - 1} <i class="fa-solid fa-chevron-down">`);
                }
                else {
                    $("#memberCareerMore").hide();
                }

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
            // console.log(JSON.stringify(json));

            if(json.length > 0) {
                $("#memberEducationListContainer").show();

                let html = ``;
                $.each(json, (index, item) => {
                    const schoolLogoImg = (item.school_logo != null)
                        ?`<img src="${ctxPath}/resources/files/\${item.school_logo}" class="aspect-square w-15 object-cover" />`
                        :`<div class="aspect-square w-10 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-school text-lg text-gray-500"></i></div>`;

                    const endDate = new Date(`\${item.member_education_enddate}-01`);
                    const today = new Date();

                    const endDateHtml = (endDate <= today)?` ~ \${item.member_education_enddate}`:` ~ 현재`;

                    html += `
                        <li class="py-2 flex items-start">
                            <div>
                                \${schoolLogoImg}
                            </div>
                            <div class="flex-1 ml-4">
                                <div class="font-bold text-lg">\${item.school_name}</div>
                                <div>\${item.major_name}</div>
                                <div class="text-gray-600 text-sm">\${item.member_education_startdate}\${endDateHtml}</div>
                                <div class="text-gray-600 text-sm">학점: \${item.member_education_grade}</div>
                            </div>
                        </li>`;
                });

                $("#memberEducationList").html(html);

                if(json.length > 1) {
                    $("#memberEducationList").children().slice(1).hide();
                    $("#memberEducationMore").show();
                    $("#memberEducationMore").html(`학력 더보기 \${$("#memberEducationList").children().length - 1} <i class="fa-solid fa-chevron-down">`);
                }
                else {
                    $("#memberEducationMore").hide();
                }

            }
        },
        error: function (request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });
}

</script>
<style>
dialog.option-dropdown::backdrop {
    background: transparent;
}
</style>

<%-- TailWind 사용자 정의 CSS --%>
<jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />

    <!-- 검색옵션 Form -->
    <form name="searchOptionForm">
        <input type="hidden" name="recruit_no">
        <div id="additionalFields">
        </div>
    </form>

    <!-- 정렬 기준 Dropdown -->
    <dialog id="dropdownSearchApplyOrderBy" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
        <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-4 top-3">✕</button>
        <div class="px-4 -mt-1 text-lg">정렬 기준</div>
        <div class="pt-4 space-y-2">
            <ul class="space-y-4 w-60 px-4">
                <li>
                    <input type="radio" name="searchApplyOrderBy" id="orderByRegisterdate" value="registerdate"/>
                    <label for="orderByRegisterdate">지원순</label>
                </li>
                <li>
                    <input type="radio" name="searchApplyOrderBy" id="orderByMemberName" value="member_name"/>
                    <label for="orderByMemberName">이름</label>
                </li>
            </ul>
            <hr class="border-gray-200">
            <div class="flex justify-end items-center gap-4 px-4">
                <div>
                    <button type="button" class="button-selected btn-submit">결과보기</button>
                </div>
            </div>
        </div>
    </dialog>

    <!-- 평가 Dropdown -->
    <dialog id="dropdownSearchApplyResultList" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
        <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-4 top-3">✕</button>
        <div class="px-4 -mt-1 text-lg">평가</div>
        <div class="pt-4 space-y-2">
            <ul id="searchApplyResultList" class="space-y-4 w-60 px-4 max-h-70 overflow-y-auto">
                <li>
                    <input type="checkbox" name="searchApplyResultList" id="searchApplyResultList0" value="0" checked/>
                    <label for="searchApplyResultList0">미분류</label>
                </li>
                <li>
                    <input type="checkbox" name="searchApplyResultList" id="searchApplyResultList1" value="1" checked/>
                    <label for="searchApplyResultList1">적임자</label>
                </li>
                <li>
                    <input type="checkbox" name="searchApplyResultList" id="searchApplyResultList2" value="2" checked/>
                    <label for="searchApplyResultList2">중립</label>
                </li>
                <li>
                    <input type="checkbox" name="searchApplyResultList" id="searchApplyResultList3" value="3"/>
                    <label for="searchApplyResultList3">부적임자</label>
                </li>
            </ul>
            <hr class="border-gray-200">
            <div class="flex justify-end items-center gap-4 px-4">
                <div>
                    <button type="button" class="button-selected btn-submit">결과보기</button>
                </div>
            </div>
        </div>
    </dialog>
    
    <!-- 지역 Dropdown -->
    <dialog id="dropdownSearchApplyRegionList" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
        <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-4 top-3">✕</button>
        <div class="px-4 -mt-1 text-lg">지역</div>
        <div class="pt-4 space-y-2">
            <ul id="searchApplyRegionList" class="space-y-4 w-60 px-4 max-h-70 overflow-y-auto">
                <c:forEach var="region" items="${regionList}">
                    <li>
                        <input type="checkbox" name="searchApplyRegionList" id="searchApplyRegionList${region.region_no}" value="${region.region_no}"/>
                        <label for="searchApplyRegionList${region.region_no}">${region.region_name}</label>
                    </li>
                </c:forEach>
            </ul>
            <hr class="border-gray-200">
            <div class="flex justify-end items-center gap-4 px-4">
                <div>
                    <button type="button" class="button-selected btn-submit">결과보기</button>
                </div>
            </div>
        </div>
    </dialog>
    
    <!-- 경력 연차 Dropdown -->
    <dialog id="dropdownSearchApplyCareerYearList" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
        <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-4 top-3">✕</button>
        <div class="px-4 -mt-1 text-lg">경력 연차</div>
        <div class="pt-4 space-y-2">
            <ul id="searchApplyCareerYearList" class="space-y-4 w-60 px-4 max-h-70 overflow-y-auto">
                <li>
                    <input type="checkbox" name="searchApplyCareerYearList" id="searchApplyCareerYearList0" value="0"/>
                    <label for="searchApplyCareerYearList0">1년 미만</label>
                </li>
                <li>
                    <input type="checkbox" name="searchApplyCareerYearList" id="searchApplyCareerYearList1" value="1"/>
                    <label for="searchApplyCareerYearList1">1 - 2년</label>
                </li>
                <li>
                    <input type="checkbox" name="searchApplyCareerYearList" id="searchApplyCareerYearList2" value="2"/>
                    <label for="searchApplyCareerYearList2">3 - 5년</label>
                </li>
                <li>
                    <input type="checkbox" name="searchApplyCareerYearList" id="searchApplyCareerYearList3" value="3"/>
                    <label for="searchApplyCareerYearList3">6 - 10년</label>
                </li>
                <li>
                    <input type="checkbox" name="searchApplyCareerYearList" id="searchApplyCareerYearList4" value="4"/>
                    <label for="searchApplyCareerYearList4">11년 이상</label>
                </li>
            </ul>
            <hr class="border-gray-200">
            <div class="flex justify-end items-center gap-4 px-4">
                <div>
                    <button type="button" class="button-selected btn-submit">결과보기</button>
                </div>
            </div>
        </div>
    </dialog>
    
    <!-- 전문 분야 Dropdown -->
    <dialog id="dropdownSearchApplySkillList" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
        <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-4 top-3">✕</button>
        <div class="px-4 -mt-1 text-lg">전문 분야</div>
        <div class="pt-4 space-y-2">
            <ul id="searchApplySkillList" class="space-y-4 w-60 px-4 max-h-70 overflow-y-auto">
                <c:forEach var="skill" items="${skillList}">
                    <li>
                        <input type="checkbox" name="searchApplySkillList" id="searchApplySkillList${skill.skill_no}" value="${skill.skill_no}"/>
                        <label for="searchApplySkillList${skill.skill_no}">${skill.skill_name}</label>
                    </li>
                </c:forEach>
            </ul>
            <hr class="border-gray-200">
            <div class="flex justify-end items-center gap-4 px-4">
                <div>
                    <button type="button" class="button-selected btn-submit">결과보기</button>
                </div>
            </div>
        </div>
    </dialog>

    <%-- 지원자 분류 --%>
    <dialog id="dropdownUpdateApplyResult" class="option-dropdown border-normal pt-4 pb-1 drop-shadow-lg">
        <div class="px-4 -mt-1 text-lg"><span class="applyMemberName"></span>님 분류:</div>
        <div class="px-4 text-sm text-gray-500">(비공개)</div>
        <div class="pt-4 space-y-2">
            <ul class="w-60 overflow-hidden font-bold text-gray-700">
                <li><button type="button" class="btn-update-apply-result w-full hover:bg-gray-100 px-4 py-2 text-left transition-all duration-100" data-apply-result="1">적임자</button></li>
                <li><button type="button" class="btn-update-apply-result w-full hover:bg-gray-100 px-4 py-2 text-left transition-all duration-100" data-apply-result="2">중립</button></li>
                <li><button type="button" class="btn-update-apply-result w-full hover:bg-gray-100 px-4 py-2 text-left transition-all duration-100" data-apply-result="3">부적임자</button></li>
            </ul>
        </div>
    </dialog>

    <%-- 지원자 정보 보기 --%>
    <dialog id="dropdownMemberInfo" class="option-dropdown border-normal pt-1 pb-1 drop-shadow-lg">
        <div class="space-y-2">
            <ul class="w-60 overflow-hidden font-bold text-gray-700">
                <li><a class="view-profile w-full hover:bg-gray-100 px-4 py-2 block cursor-pointer transition-all duration-100"><i class="fa-solid fa-user"></i> 전체 프로필 보기</a></li>
                <li>
                    <a id="memberEmailLink" class="w-full hover:bg-gray-100 px-4 py-2 flex cursor-pointer gap-2 transition-all duration-100">
                        <div><i class="fa-solid fa-envelope"></i></div>
                        <div class="flex-1">
                            <div id="memberEmail">123</div>
                            <div class="text-sm text-gray-500 font-normal">이메일 주소</div>
                        </div>
                    </a>
                </li>
                <li>
                    <button type="button" id="memberTelCopy" class="w-full hover:bg-gray-100 px-4 py-2 flex text-left gap-2 transition-all duration-100">
                        <div><i class="fa-solid fa-phone"></i></div>
                        <div class="flex-1">
                            <div id="memberTel">123</div>
                            <div class="text-sm text-gray-500 font-normal">전화번호 복사</div>
                        </div>
                    </button></li>
            </ul>
        </div>
    </dialog>

    <%-- 채용공고 옵션 --%>
    <dialog id="dropdownRecruitOption" class="option-dropdown border-normal pt-1 pb-1 drop-shadow-lg">
        <div class="space-y-2">
            <ul class="w-60 overflow-hidden font-bold text-gray-700">
                <li><a href="${pageContext.request.contextPath}/recruit/view/${requestScope.recruitVO.recruit_no}"
                        class="w-full hover:bg-gray-100 px-4 py-2 text-left transition-all duration-100 block cursor-pointer"><i class="fa-solid fa-eye"></i> 지원자 상태로 보기
                    </a>
                </li>
                <li><a href="${pageContext.request.contextPath}/recruit/main/upload"
                        class="w-full hover:bg-gray-100 px-4 py-2 text-left transition-all duration-100 block cursor-pointer"><i class="fa-solid fa-list"></i> 나의 채용공고 모두 보기
                    </a>
                </li>
            </ul>
        </div>
    </dialog>

    <!-- 상단 헤더 -->
    <div class="fixed left-0 pb-0 bg-white w-full z-99">
        <div class="bg-white">

            <%-- 회사 정보 --%>
            <div class="flex space-x-2 xl:max-w-[1140px] m-auto py-4">
                <div>
                <c:if test="${not empty requestScope.recruitVO.company_logo}">
                    <img src="${pageContext.request.contextPath}/resources/files/companyLogo/${requestScope.recruitVO.company_logo}" class="aspect-square w-15 object-cover" />
                </c:if>
                <c:if test="${empty requestScope.recruitVO.company_logo}">
                    <div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-2xl text-gray-500"></i></div>
                </c:if>
                </div>
                <div class="flex-1 text-base/5">
                    <div class="font-bold">${requestScope.recruitVO.recruit_job_name}</div>
                    <div>${requestScope.recruitVO.company_name} · ${requestScope.recruitVO.region_name}<span>
                        <c:if test='${requestScope.recruitVO.recruit_work_type == "1"}'>(대면근무)</c:if>
                        <c:if test='${requestScope.recruitVO.recruit_work_type == "2"}'>(대면재택혼합근무)</c:if>
                        <c:if test='${requestScope.recruitVO.recruit_work_type == "3"}'>(재택근무)</c:if>
                        </span>
                    </div>
                    
                    <div>
                        <c:if test='${requestScope.recruitVO.recruit_closed == "0"}'><span class="text-green-700 font-bold">진행중</span></c:if>
                        <c:if test='${requestScope.recruitVO.recruit_closed == "1"}'><span class="text-red-500 font-bold">마감됨</span></c:if>
                        ·
                        <span class="text-gray-500">만든 날짜: ${requestScope.recruitVO.time_ago}</span>
                    </div>
                </div>

                <div class="flex items-center gap-2">
                    <a href="${pageContext.request.contextPath}/recruit/detail/${requestScope.recruitVO.recruit_no}" class="inline-block button-orange">채용공고 관리</a>
                    <button type="button" id="btnRecruitOption" class="btn-open-dropdown btn-transparent w-10 h-10 relative">
                        <i class="absolute left-1/2 top-1/2 transform -translate-y-1/2 -translate-x-1/2 fa-solid fa-ellipsis"></i>
                    </button>
                </div>
            </div>

            <hr class="border-gray-200">

            <div class="flex gap-2 bg-white xl:max-w-[1140px] m-auto py-4">
                <button type="button" id="btnSearchApplyOrderBy" class="button-selected btn-open-dropdown">
                    <span>지원일순</span>
                    <i class="fa-solid fa-caret-down"></i>
                </button>
                <button type="button" id="btnSearchApplyResultList" class="button-gray btn-open-dropdown">
                    <span>평가</span>
                    <i class="fa-solid fa-caret-down"></i>
                </button>
                <button type="button" id="btnSearchApplyRegionList" class="button-gray btn-open-dropdown">
                    <span>지역</span>
                    <i class="fa-solid fa-caret-down"></i>
                </button>
                <button type="button" id="btnSearchApplyCareerYearList" class="button-gray btn-open-dropdown">
                    <span>경력 연차</span>
                    <i class="fa-solid fa-caret-down"></i>
                </button>
                <c:if test="${not empty skillList}">
                    <button type="button" id="btnSearchApplySkillList" class="button-gray btn-open-dropdown">
                        <span>전문 분야</span>
                        <i class="fa-solid fa-caret-down"></i>
                    </button>
                </c:if>
            </div>

            <hr class="border-gray-200">
        </div>
    </div>

    <%-- 필터 검색 결과가 없는 경우 --%>
    <div id="emptyContainer" class="hidden text-center pt-40">
        <img src="${pageContext.request.contextPath}/images/no_recruit.svg" alt="" class="my-4 mx-auto w-50">
        <div class="text-2xl font-bold mt-4">결과 없음</div>
        <div class="text-lg text-gray-500">지원자 필터를 적용해보세요.</div>
    </div>

    <div id="mainContainer" class="container m-auto grid grid-cols-5 xl:max-w-[1140px]">

        <%-- 왼쪽 영역 --%>
        <div class="col-span-2 border-1 border-gray-200 pt-39 bg-white" style="height: calc(100vh - 3.8rem)">
            <div id="applyContainer">
                <div class="py-3 px-6 font-bold text-lg border-b-1 border-gray-200">
                    지원자 <span id="totalApplyCount">0</span>명(결과 <span id="searchApplyCount">0</span>)
                </div>
                <ul id="applyList" class="overflow-auto" style="height: calc(100vh - 17rem)">
                    <%-- 지원자 목록 --%>
                    <%-- <li class="border-b-1 border-gray-200 apply-selected">
                        <button type="button" data-apply-no="\${item.apply_no}" class="btn-apply-info w-full text-left flex px-6 py-3 hover:underline">
                            <img class="w-15 h-15 object-cover rounded-full mr-4"
                                src="${pageContext.request.contextPath}/resources/files/profile/${sessionScope.loginuser.member_profile}" />
                            <div class="flex-1">
                                <div class="font-bold text-[1.05rem]">${sessionScope.loginuser.member_name}</div>
                                <c:if test="${not empty sessionScope.loginuser.school_name}">
                                    <div>${sessionScope.loginuser.school_name} 학생</div>
                                </c:if>
                                <c:if test="${not empty sessionScope.loginuser.member_career_company}">
                                    <div>${sessionScope.loginuser.member_career_company} 재직중</div>
                                </c:if>
                                <c:if test="${not empty sessionScope.loginuser.region_name}">
                                    <div class="text-gray-500 text-sm">${sessionScope.loginuser.region_name}</div>
                                </c:if>

                                <div class="text-gray-500 my-2">
                                    <div>Korean Red Ginseng CheongKwanJang 正 ...</div>
                                    <div>Abeka 출판 편집자 • 2021 ~ 2021</div>
                                </div>

                                <div class="text-gray-500">지원함: <span>2개월 전</span> · 필수 자격 <span>3/3</span></div>
                            </div>
                        </button>
                    </li>
                    <li class="border-b-1 border-gray-200">
                        <button type="button" data-apply-no="\${item.apply_no}" class="btn-recruit-info w-full text-left flex px-6 py-3 hover:underline">
                            <img class="w-15 h-15 object-cover rounded-full mr-4"
                                src="${pageContext.request.contextPath}/resources/files/profile/${sessionScope.loginuser.member_profile}" />
                            <div class="flex-1">
                                <div class="font-bold text-[1.05rem]">${sessionScope.loginuser.member_name}</div>
                                <c:if test="${not empty sessionScope.loginuser.school_name}">
                                    <div>${sessionScope.loginuser.school_name} 학생</div>
                                </c:if>
                                <c:if test="${not empty sessionScope.loginuser.member_career_company}">
                                    <div>${sessionScope.loginuser.member_career_company} 재직중</div>
                                </c:if>
                                <c:if test="${not empty sessionScope.loginuser.region_name}">
                                    <div class="text-gray-500 text-sm">${sessionScope.loginuser.region_name}</div>
                                </c:if>

                                <div class="text-gray-500 my-2">
                                    <div>Korean Red Ginseng CheongKwanJang 正 ...</div>
                                    <div>Abeka 출판 편집자 • 2021 ~ 2021</div>
                                </div>

                                <div class="text-gray-500">지원함: <span>2개월 전</span> · 필수 자격 <span>3/3</span></div>
                            </div>
                        </button>
                    </li>
                    <li class="border-b-1 border-gray-200 apply-new">
                        <button type="button" data-apply-no="\${item.apply_no}" class="btn-recruit-info w-full text-left flex px-6 py-3 hover:underline">
                            <img class="w-15 h-15 object-cover rounded-full mr-4"
                                src="${pageContext.request.contextPath}/resources/files/profile/${sessionScope.loginuser.member_profile}" />
                            <div class="flex-1">
                                <div class="font-bold text-[1.05rem]">${sessionScope.loginuser.member_name}</div>
                                <c:if test="${not empty sessionScope.loginuser.school_name}">
                                    <div>${sessionScope.loginuser.school_name} 학생</div>
                                </c:if>
                                <c:if test="${not empty sessionScope.loginuser.member_career_company}">
                                    <div>${sessionScope.loginuser.member_career_company} 재직중</div>
                                </c:if>
                                <c:if test="${not empty sessionScope.loginuser.region_name}">
                                    <div class="text-gray-500 text-sm">${sessionScope.loginuser.region_name}</div>
                                </c:if>

                                <div class="text-gray-500 my-2">
                                    <div>Korean Red Ginseng CheongKwanJang 正 ...</div>
                                    <div>Abeka 출판 편집자 • 2021 ~ 2021</div>
                                </div>

                                <div class="text-gray-500">지원함: <span>2개월 전</span> · 필수 자격 <span>3/3</span></div>
                            </div>
                        </button>
                    </li> --%>
                    
                </ul>
            </div>
        </div>

        <%-- 오른쪽 영역 --%>
        <div class="col-span-3 border-gray-200 pt-39" style="height: calc(100vh - 3.8rem)">
            <div id="applyInfoContainer" class="overflow-auto h-full p-6 pr-0 space-y-4">

                <div class="border-rwd p-6 pb-4 text-lg">
                    <div class="text-3xl"><span class="applyMemberName"></span>님의 지원서</div>
                    <div id="applyRegionName" class="mt-2"></div>
                    <div class="text-gray-500 mb-2">지원함: <span id="applyTimeAgo"></span></div>

                    <div class="flex gap-2">
                        <span id="btnUpdateApplyResultContainer"></span>
                        <button type="button" class="button-orange">메시지</button>
                        <button type="button" id="btnMemberInfo" class="btn-open-dropdown button-gray">...</button>
                    </div>
                </div>

                <div class="border-rwd p-6 pb-0 text-lg">
                    <div class="text-2xl mb-4">프로필 분석</div>

                    <div id="memberCareerListContainer">
                        <div class="font-bold">경력</div>
                        <ul id="memberCareerList" class="text-base">
                            <li class="${(status.count < requestScope.memberCareerVOList.size() && status.count < 2)? 'border-b-1 border-gray-300 ':''}py-2 flex items-start">
                                <a href="#" class="flex flex-1">
                                    <div>
                                        <c:if test="${not empty item.company_logo}">
                                            <img src="${pageContext.request.contextPath}/resources/files/companyLogo/${item.company_logo}" class="aspect-square w-10 object-cover" />
                                        </c:if>
                                        <c:if test="${empty item.company_logo}">
                                            <div class="aspect-square w-10 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-lg text-gray-500"></i></div>
                                        </c:if>
                                    </div>
                                    <div class="flex-1 ml-4">
                                        <div class="font-bold text-lg hover:underline">\${item.job_name}</div>
                                        <div>\${item.member_career_company}</div>
                                        <div class="text-gray-600 text-sm">\${item.member_career_startdate} ~ \${item.member_career_enddate}</div>
                                    </div>
                                </a>
                            </li>
                        </ul>
                        <button type="button" id="memberCareerMore" class="text-orange-500 font-bold py-1 px-2 text-base inline-block rounded-lg hover:bg-orange-100 mb-2 transition-all duration-200">경력 더보기 <i class="fa-solid fa-chevron-down"></i></button>
                    </div>

                    <div id="memberEducationListContainer">
                        <div class="font-bold">학력</div>
                        <ul id="memberEducationList" class="text-base">
                            <li class="${(status.count < requestScope.memberEducationVOList.size() && status.count < 2)? 'border-b-1 border-gray-300 ':''}py-2 flex items-start">
                                <a href="#" class="flex flex-1">
                                    <div>
                                        <%-- <c:if test="${not empty item.school_logo}">
                                            <img src="${pageContext.request.contextPath}/resources/files/${item.school_logo}" class="aspect-square w-10 object-cover" />
                                        </c:if>
                                        <c:if test="${empty item.school_logo}"> --%>
                                            <div class="aspect-square w-10 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-school text-lg text-gray-500"></i></div>
                                        <%-- </c:if> --%>
                                    </div>
                                    <div class="flex-1 ml-4">
                                        <div class="font-bold text-lg hover:underline">\${item.school_name}</div>
                                        <div>\${item.major_name}</div>
                                        <div class="text-gray-600 text-sm">\${item.member_education_startdate} ~ \${item.member_education_enddate}</div>
                                        <%-- <div>학점: ${item.member_education_grade}</div> --%>
                                    </div>
                                </a>
                            </li>
                        </ul>
                        <button type="button" id="memberEducationMore" class="text-orange-500 font-bold py-1 px-2 text-base inline-block rounded-lg hover:bg-orange-100 transition-all duration-200">학력 더보기 <i class="fa-solid fa-chevron-down"></i></button>
                    </div>

                    <hr class="border-gray-200 -mx-6 mt-4">

                    <div class="flex justify-center my-2">
                        <a class="view-profile text-orange-500 font-bold py-1 px-2 inline-block rounded-lg hover:bg-orange-100 transition-all duration-200">전체 프로필 보기</a>
                    </div>
                </div>

                <div class="border-rwd p-6 pb-0 text-lg">
                    <div class="flex">
                        <div class="text-2xl mb-4 flex-1">이력서</div>
                        <a id="applyResumeDownload" target='_blank' class="text-orange-500 font-bold hover:underline"><i class="fa-solid fa-download mr-2"></i>다운로드</a>
                    </div>

                    <div id="pdfContainer" class="w-full h-80 overflow-y-auto p-2 space-y-4 transition-all duration-200">
                        <!-- pdf 영역 -->
                    </div>

                    <hr class="border-gray-200 -mx-6 mt-4">

                    <div class="flex justify-center my-2">
                        <button type="button" id="pdfMore" class="text-orange-500 font-bold py-1 px-2 inline-block rounded-lg hover:bg-orange-100 transition-all duration-200">더 보기 <i class="fa-solid fa-chevron-down"></i></button>
                    </div>
                </div>

                <div class="border-rwd p-6 text-lg">
                    <div class="text-2xl mb-4">선별 질문 답변</div>


                    <div id="questionRequiredDiv">
                        <div class="font-bold my-2">필수 자격(<span id="requiredScore"></span> 충족)</div>

                        <ul id="questionRequiredList" class="grid grid-cols-2 gap-x-8 gap-y-4 text-base mb-6">
                            <c:forEach var="item" items="${requestScope.recruitVO.questionVOList}" varStatus="status">
                                <c:if test='${item.question_required == "1"}'>
                                    <li class="col-span-1">
                                        <div><span id="answerMarkFor${item.question_no}"><i class="fa-solid fa-check text-green-700"></i></span> ${item.question_query}</div>
                                        <div class="text-gray-500 text-sm">모범 답안: ${item.question_correct}</div>
                                        <div id="answerFor${item.question_no}" data-correct="${item.question_correct}" class="font-bold"></div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>

                    <div id="questionNotRequiredDiv">
                        <div class="font-bold my-2">우대 자격(<span id="advantageScore"></span> 충족)</div>
                        
                        <ul id="questionNotRequiredList" class="grid grid-cols-2 gap-x-8 gap-y-4 text-base">
                            <c:forEach var="item" items="${requestScope.recruitVO.questionVOList}" varStatus="status">
                                <c:if test='${item.question_required != "1"}'>
                                    <li class="col-span-1">
                                        <div><span id="answerMarkFor${item.question_no}"><i class="fa-solid fa-check text-green-700"></i></span> ${item.question_query}</div>
                                        <%-- <div><span><i class="fa-solid fa-xmark text-red-600"></i></span> ${item.question_query}</div> --%>
                                        <div class="text-gray-500 text-sm">모범 답안: ${item.question_correct}</div>
                                        <div id="answerFor${item.question_no}" data-correct="${item.question_correct}" class="font-bold"></div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </div>
</body>
</html>