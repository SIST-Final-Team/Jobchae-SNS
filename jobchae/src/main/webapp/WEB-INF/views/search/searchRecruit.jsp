<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === JSTL( Java Standard Tag Library) 사용하기 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

    <%-- Quill 에디터 --%>
    <link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet">

    <!-- TailWind Script -->
    <script src="${pageContext.request.contextPath}/js/tailwind.js"></script>
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <%-- TailWind 사용자 정의 CSS --%>
    <jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />

<script type="text/javascript">

let start = 1;
let len = 16;
let hasMore = true; // 글 목록이 더 존재하는지 확인하는 변수
let requestLock = false;

let inputTimeout;        // 입력 후 일정시간이 지난 후 자동완성 검색이 되도록 하는 타임아웃
let suggestClearTimeout; // 자동완성 창을 닫기 위한 타임아웃

    $(document).ready(function() {

        <%-- 자동완성 관련 시작 --%>
        // 검색어가 바뀔 때 0.5초 후 검색
        $(".input-search").on("input", function () {

            const inputEl = this;

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

            const resultName = $(inputId).data("result-name");

            $(inputId).next().addClass("hidden");
            $(inputId).val("");

            const value = $(e.target).data("value");
            if($(`input#\${resultName}\${value}`).length != 0) {
                $(`input[name='\${resultName}'][value='\${value}']`).prop("checked", true);
            }
            else if (value != undefined) {
                html = `
                    <li>
                        <input type="checkbox" name="\${resultName}" id="\${resultName}\${value}" value="\${value}" checked/>
                        <label for="\${resultName}\${value}">\${$(e.target).text()}</label>
                    </li>`;
                $("#"+resultName+"List").append(html);
                $(".btn-reset-dropdown").each((index, elmt) => {
                    if(resultName == $(elmt).data("reset")) {
                        $(elmt).text("초기화").addClass("active");
                        $(elmt).removeClass("btn-close-dropdown");
                    }
                });
            }

            $(".suggest").remove();
        });
        <%-- 자동완성 관련 끝 --%>

        setSearchOption(); // 설정한 검색 옵션대로 체크

        // 검색 결과 불러오기
        getSearchResult('${requestScope.searchWord}');

        $("#recruitList").scroll(function() {
            // 스크롤이 전체 페이지 크기만큼 내려가면
            if( $("#recruitList").scrollTop() + $("#recruitList").height() + 300 >= $("#recruitList").height() ) {
                getSearchResult('${requestScope.searchWord}');
            }
        });

        // 검색옵션 선택 해제
        $(document).on("input", "input[type='checkbox']", function(){
            if($(this).prop("checked")) {
                $(".btn-reset-dropdown").each((index, elmt) => {
                    if($(this).attr("name") == $(elmt).data("reset")) {
                        $(elmt).text("초기화").addClass("active");
                        $(elmt).removeClass("btn-close-dropdown");
                    }
                });
            }
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
            addSearchArr(); // 검색 조건 추가
            searchOptionForm.submit();
        });
    });

    // 검색 옵션 입력
    function setSearchOption(){

        <%-- $("input[type=checkbox]").prop("checked", false); --%>

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

        // 회사가 선택되어 있다면
        if(${not empty requestScope.arr_fk_company_no}) {
            <%-- const arr_fk_company_no = "${requestScope.arr_fk_company_no}".split(",");
            $.each(arr_fk_company_no, (index, item) => {
                $("input[name='fk_company_no'][value='"+item+"']").prop("checked", true);
            }); --%>
            $("button#btnCompany").removeClass("button-gray");
            $("button#btnCompany").addClass("button-selected");
            
            $(".btn-reset-dropdown").each((index, elmt) => {
                if($(elmt).data("reset") == "fk_company_no") {
                    $(elmt).text("초기화").addClass("active");
                    $(elmt).removeClass("btn-close-dropdown");
                }
            });
        }

        // 지역이 선택되어 있다면
        if(${not empty requestScope.arr_fk_region_no}) {
            <%-- const arr_fk_region_no = "${requestScope.arr_fk_region_no}".split(",");
            $.each(arr_fk_region_no, (index, item) => {
                $("input[name='fk_region_no'][value='"+item+"']").prop("checked", true);
            }); --%>
            $("button#btnRegion").removeClass("button-gray");
            $("button#btnRegion").addClass("button-selected");
            
            $(".btn-reset-dropdown").each((index, elmt) => {
                if($(elmt).data("reset") == "fk_region_no") {
                    $(elmt).text("초기화").addClass("active");
                    $(elmt).removeClass("btn-close-dropdown");
                }
            });
        }

        // 근무유형이 선택되어 있다면
        if(${not empty requestScope.arr_recruit_work_type}) {
            const arr_recruit_work_type = "${requestScope.arr_recruit_work_type}".split(",");
            $.each(arr_recruit_work_type, (index, item) => {
                $("input[name='recruit_work_type'][value='"+item+"']").prop("checked", true);
            });
            $("button#btnWorkType").removeClass("button-gray");
            $("button#btnWorkType").addClass("button-selected");
            
            $(".btn-reset-dropdown").each((index, elmt) => {
                if($(elmt).data("reset") == "recruit_work_type") {
                    $(elmt).text("초기화").addClass("active");
                    $(elmt).removeClass("btn-close-dropdown");
                }
            });
        }

        // 고용형태가 선택되어 있다면
        if(${not empty requestScope.arr_recruit_job_type}) {
            const arr_recruit_job_type = "${requestScope.arr_recruit_job_type}".split(",");
            $.each(arr_recruit_job_type, (index, item) => {
                $("input[name='recruit_job_type'][value='"+item+"']").prop("checked", true);
            });
            $("button#btnJobType").removeClass("button-gray");
            $("button#btnJobType").addClass("button-selected");
            
            $(".btn-reset-dropdown").each((index, elmt) => {
                if($(elmt).data("reset") == "recruit_job_type") {
                    $(elmt).text("초기화").addClass("active");
                    $(elmt).removeClass("btn-close-dropdown");
                }
            });
        }
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

    // 검색 옵션 추가하기
    function addSearchArr(){

        let additionalFieldsHtml = ``;

        // 회사 목록 추가
        let arr_fk_company_no = "";
        $("input[name='fk_company_no']:checked").each((index, elmt) => {
            if(index == 0) {
                arr_fk_company_no += $(elmt).val();
            }
            else {
                arr_fk_company_no += ","+$(elmt).val();
            }
        });
        if(arr_fk_company_no != "") {
            additionalFieldsHtml += `<input type="hidden" name="arr_fk_company_no" value="\${arr_fk_company_no}"/>`;
        }
        
        // 지역 목록 추가
        let arr_fk_region_no = "";
        $("input[name='fk_region_no']:checked").each((index, elmt) => {
            if(index == 0) {
                arr_fk_region_no += $(elmt).val();
            }
            else {
                arr_fk_region_no += ","+$(elmt).val();
            }
        });
        if(arr_fk_region_no != "") {
            additionalFieldsHtml += `<input type="hidden" name="arr_fk_region_no" value="\${arr_fk_region_no}"/>`;
        }

        // 근무유형 목록 추가
        let arr_recruit_work_type = "";
        $("input[name='recruit_work_type']:checked").each((index, elmt) => {
            if(index == 0) {
                arr_recruit_work_type += $(elmt).val();
            }
            else {
                arr_recruit_work_type += ","+$(elmt).val();
            }
        });
        if(arr_recruit_work_type != "") {
            additionalFieldsHtml += `<input type="hidden" name="arr_recruit_work_type" value="\${arr_recruit_work_type}"/>`;
        }

        // 고용형태 목록 추가
        let arr_recruit_job_type = "";
        $("input[name='recruit_job_type']:checked").each((index, elmt) => {
            if(index == 0) {
                arr_recruit_job_type += $(elmt).val();
            }
            else {
                arr_recruit_job_type += ","+$(elmt).val();
            }
        });
        if(arr_recruit_job_type != "") {
            additionalFieldsHtml += `<input type="hidden" name="arr_recruit_job_type" value="\${arr_recruit_job_type}"/>`;
        }

        $("#additionalFields").append(additionalFieldsHtml);
    }

    // 검색 결과 가져오기
    function getSearchResult(searchWord) {
        
        if(requestLock) {
            return;
        }
	
        if(!hasMore) { // 모두 불러왔다면
            return; // 종료
        }
        
	    requestLock = true; // 스크롤 이벤트가 여러 번 발생 하기 때문에 ajax를 쓰는동안 락을 걸어야 한다.

        document.searchOptionForm.searchWord.value = searchWord;

        $("#additionalFields").html(""); // 검색 조건 초기화
        addSearchArr(); // 검색 조건 추가

        $("#additionalFields").append(`<input type="hidden" name="start" value="\${start}"/>`);
        $("#additionalFields").append(`<input type="hidden" name="end" value="\${start + len - 1}"/>`);
        const data = $("form[name='searchOptionForm']").serialize();
        $.ajax({
            url: "${pageContext.request.contextPath}/api/search/recruit",
            data: data,
            dataType: "json",
            success: function (json) {
                console.log(JSON.stringify(json));

                if(json.length > 0) {

                    let html = ``;
                    $.each(json, (index, item) => {

                        const companyLogoHtml = (item.company_logo != null)
                            ?`<img src="\${ctxPath}/resources/files/\${item.company_logo}" class="aspect-square w-15 object-cover" />`
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
                            <button type="button" data-recruit-no="\${item.recruit_no}" class="btn-recruit-info w-full text-left flex">
                                <div class="px-2 py-4">
                                    \${companyLogoHtml}
                                </div>
                                <div class="border-b-1 border-gray-300 flex-1 p-2">
                                    <div class="font-bold text-orange-400 text-lg hover:underline">\${item.recruit_job_name}</div>
                                    <div>\${item.recruit_company_name}</div>
                                    <div class="text-gray-600">\${item.region_name} (\${recruit_work_type})</div>
                                </div>
                            </button>
                        </li>`;
                    });

                    $("#recruitList").append(html);

                    $("#resultCount").text($("#recruitList").children().length); // TODO: 무한스크롤에 포함되지 않은 총 개수가 나오도록 바꿔야 한다.

                    $("#recruitList").find(".btn-recruit-info").eq(0).click(); // 첫 번째 항목 선택
                }
                else {
                    if(start==1) { // 목록이 하나도 없다면
                        let html = `<div class="text-center text-lg"><span class="block pb-2">일치하는 채용 공고가 없습니다.</span>
                                </div>`;

                        $("#recruitContainer").html(html);
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

    // 채용공고 1개를 선택했을 때 우측 영역에 내용 표시
    $(document).on("click", ".btn-recruit-info", function() {
        const recruit_no = $(this).data("recruit-no");

        $("#recruitList").children("li").removeClass("bg-gray-100");
        $(this).parent().addClass("bg-gray-100");

        // 내용 바꾸기

        $.ajax({
            url: "${pageContext.request.contextPath}/api/recruit/"+recruit_no,
            dataType: "json",
            success: function (item) {
                console.log(JSON.stringify(item));

                if(item != null) {

                    const companyLogoHtml = (item.company_logo != null)
                        ?`<img src="\${ctxPath}/resources/files/\${item.company_logo}" class="aspect-square w-10 object-cover" />`
                        :`<div class="aspect-square w-10 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-xl text-gray-500"></i></div>`;

                    $("#recruit_company_logo").html(companyLogoHtml);

                    $("#recruit_job_name").text(item.recruit_job_name);
                    $("#recruit_company_name").text(item.recruit_company_name);
                    $("#recruit_region_name").text(item.region_name);
                    $("#recruit_register_date").text(item.recruit_register_date);
                    $("#recruit_explain").html(item.recruit_explain);

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
                    $("#recruit_work_type").text(recruit_work_type);
                    
                    let recruit_job_type = ``;
                    switch(item.recruit_job_type) {
                        case "1":
                            recruit_job_type = `풀타임`;
                        break;
                        case "2":
                            recruit_job_type = `파트타임`;
                        break;
                        case "3":
                            recruit_job_type = `계약직`;
                        break;
                        case "4":
                            recruit_job_type = `임시직`;
                        break;
                        case "5":
                            recruit_job_type = `기타`;
                        break;
                        case "6":
                            recruit_job_type = `자원봉사`;
                        break;
                        case "7":
                            recruit_job_type = `인턴`;
                        break;
                    }
                    $("#recruit_job_type").text(recruit_job_type);

                }
                else {
                    alert("채용공고 정보를 읽어오지 못했습니다.");
                }

            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });

    });
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
        <input type="hidden" name="searchType" value="recruit"/>
        <div id="additionalFields">
        </div>
        <!-- 검색 유형 Dropdown -->
        <dialog id="dropdownSearchType" class="option-dropdown border-normal drop-shadow-lg">
            <ul class="nav font-bold text-gray-600 w-50">
                <li><a href="${pageContext.request.contextPath}/search/all?searchWord=${requestScope.searchWord}">전체</a></li>
                <li><a href="${pageContext.request.contextPath}/search/board?searchWord=${requestScope.searchWord}">글</a></li>
                <li><a href="${pageContext.request.contextPath}/search/member?searchWord=${requestScope.searchWord}">사람</a></li>
                <li><a href="${pageContext.request.contextPath}/search/company?searchWord=${requestScope.searchWord}">회사</a></li>
                <li class="nav-selected"><a href="${pageContext.request.contextPath}/search/recruit?searchWord=${requestScope.searchWord}">채용공고</a></li>
            </ul>
        </dialog>

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
        
        <!-- 회사 Dropdown -->
        <dialog id="dropdownCompany" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
            <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
            <div class="pt-4 space-y-2">
                <ul id="fk_company_noList" class="space-y-4 w-100 h-70 overflow-y-auto px-4">
                    <li>
                        <label for="member_career_company" class="w-14 text-gray-500">회사 또는 단체 *</label><br>
                        <input type="text" name="member_career_company" id="member_career_company"
                        data-target-url="/api/member/company/search"
                        data-search-type="company_name"
                        data-result-name="fk_company_no"
                        class="input-search w-full border-1 rounded-sm p-1 required"/>
                        <span class="hidden error text-red-600 text-sm">회사 또는 단체를 입력하세요.</span>
                    </li>
                    <c:forEach var="company" items="${companyList}">
                        <li>
                            <input type="checkbox" name="fk_company_no" id="fk_company_no${company.company_no}" value="${company.company_no}" checked/>
                            <label for="fk_company_no${company.company_no}">${company.company_name}</label>
                        </li>
                    </c:forEach>
                </ul>
                <hr class="border-gray-200">
                <div class="flex justify-end items-center gap-4 px-4">
                    <div>
                        <button type="button" class="btn-close-dropdown button-board-action px-4 btn-reset-dropdown" data-reset="fk_company_no">취소</button>
                    </div>
                    <div>
                        <button type="button" class="button-selected btn-submit">결과보기</button>
                    </div>
                </div>
            </div>
        </dialog>
        
        <!-- 지역 Dropdown -->
        <dialog id="dropdownRegion" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
            <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
            <div class="pt-4 space-y-2">
                <ul id="fk_region_noList" class="space-y-4 w-100 px-4 h-70 overflow-y-auto">
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
                    <c:forEach var="region" items="${regionList}">
                        <li>
                            <input type="checkbox" name="fk_region_no" id="fk_region_no${region.region_no}" value="${region.region_no}" checked/>
                            <label for="fk_region_no${region.region_no}">${region.region_name}</label>
                        </li>
                    </c:forEach>
                </ul>
                <hr class="border-gray-200">
                <div class="flex justify-end items-center gap-4 px-4">
                    <div>
                        <button type="button" class="btn-close-dropdown button-board-action px-4 btn-reset-dropdown" data-reset="fk_region_no">취소</button>
                    </div>
                    <div>
                        <button type="button" class="button-selected btn-submit">결과보기</button>
                    </div>
                </div>
            </div>
        </dialog>

        <!-- 고용 형태 Dropdown -->
        <dialog id="dropdownJobType" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
            <div class="space-y-2">
                <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
                <ul class="space-y-4 w-60 px-4">
                    <li>
                        <input type="checkbox" name="recruit_job_type" id="recruit_job_type1" value="1"/>
                        <label for="recruit_job_type1">풀타임</label>
                    </li>
                    <li>
                        <input type="checkbox" name="recruit_job_type" id="recruit_job_type2" value="2"/>
                        <label for="recruit_job_type2">파트타임</label>
                    </li>
                    <li>
                        <input type="checkbox" name="recruit_job_type" id="recruit_job_type3" value="3"/>
                        <label for="recruit_job_type3">계약직</label>
                    </li>
                    <li>
                        <input type="checkbox" name="recruit_job_type" id="recruit_job_type4" value="4"/>
                        <label for="recruit_job_type4">임시직</label>
                    </li>
                    <li>
                        <input type="checkbox" name="recruit_job_type" id="recruit_job_type5" value="5"/>
                        <label for="recruit_job_type5">기타</label>
                    </li>
                    <li>
                        <input type="checkbox" name="recruit_job_type" id="recruit_job_type6" value="6"/>
                        <label for="recruit_job_type6">자원봉사</label>
                    </li>
                    <li>
                        <input type="checkbox" name="recruit_job_type" id="recruit_job_type7" value="7"/>
                        <label for="recruit_job_type7">인턴</label>
                    </li>
                </ul>
                <hr class="border-gray-200">
                <div class="flex justify-end items-center gap-4 px-4">
                    <div>
                        <button type="button" class="btn-close-dropdown button-board-action px-4 btn-reset-dropdown" data-reset="recruit_job_type">취소</button>
                    </div>
                    <div>
                        <button type="button" class="button-selected btn-submit">결과보기</button>
                    </div>
                </div>
            </div>
        </dialog>
        
        <!-- 근무 유형 Dropdown -->
        <dialog id="dropdownWorkType" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
            <div class="space-y-2">
                <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
                <ul class="space-y-4 w-60 px-4">
                    <li>
                        <input type="checkbox" name="recruit_work_type" id="recruit_work_type1" value="1"/>
                        <label for="recruit_work_type1">대면근무</label>
                    </li>
                    <li>
                        <input type="checkbox" name="recruit_work_type" id="recruit_work_type2" value="2"/>
                        <label for="recruit_work_type2">대면재택혼합근무</label>
                    </li>
                    <li>
                        <input type="checkbox" name="recruit_work_type" id="recruit_work_type3" value="3"/>
                        <label for="recruit_work_type3">재택근무</label>
                    </li>
                </ul>
                <hr class="border-gray-200">
                <div class="flex justify-end items-center gap-4 px-4">
                    <div>
                        <button type="button" class="btn-close-dropdown button-board-action px-4 btn-reset-dropdown" data-reset="recruit_work_type">취소</button>
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
                <span>채용공고</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
            <button type="button" id="btnSearchDate" class="button-gray btn-open-dropdown">
                <span>올린 날</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
            <button type="button" id="btnRegion" class="button-gray btn-open-dropdown">
                <span>지역</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
            <button type="button" id="btnCompany" class="button-gray btn-open-dropdown">
                <span>회사</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
            <button type="button" id="btnJobType" class="button-gray btn-open-dropdown">
                <span>고용 형태</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
            <button type="button" id="btnWorkType" class="button-gray btn-open-dropdown">
                <span>근무 유형</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
        </div>
    </div>

    <div class="container m-auto grid grid-cols-9 xl:max-w-[1140px] bg-white">

        <%-- 왼쪽 영역 --%>
        <div class="col-span-4 border-1 border-gray-200 pt-16" style="height: calc(100vh - 4rem)">
            <div id="recruitContainer">
                <div class="bg-orange-400 text-white py-4 px-2">
                    <div class="text-lg">"${requestScope.searchWord}"</div>
                    <div class="text-sm">결과 <span id="resultCount"></span></div>
                </div>
                <ul id="recruitList" class="overflow-auto" style="height: calc(100vh - 13.3rem)">
                    <%-- 채용공고 목록 --%>
                </ul>
            </div>
        </div>

        <%-- 오른쪽 영역 --%>
        <div class="col-span-5 border-1 border-gray-200 border-l-0 pt-16" style="height: calc(100vh - 4rem)">
            <div class="overflow-auto h-full p-6">

                <div class="flex">
                    <div class="flex-1 flex items-center gap-2">
                        <div id="recruit_company_logo">
                            <div class="aspect-square w-10 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-xl text-gray-500"></i></div>
                        </div>
                        <div id="recruit_company_name" class="font-bold"></div>
                    </div>
                    <button type="button" class="btn-transparent w-13 h-13 relative"><i class="absolute left-1/2 top-1/2 transform -translate-y-1/2 -translate-x-1/2 fa-solid fa-ellipsis text-xl"></i></button>
                </div>

                <h1 id="recruit_job_name" class="text-3xl font-bold"></h1>

                <div class="text-gray-500 my-2"><span id="recruit_region_name"></span> | <span id="recruit_register_date"></span> | <span class="text-green-700 font-bold">지원을 클릭한 사람 <span id="recruit_view_count">0</span>명</span></div>

                <div class="text-gray-700"><i class="fa-solid fa-briefcase text-gray-500"></i> <span id="recruit_work_type"></span> | <span id="recruit_job_type"></span></div>

                <div class="flex my-4 gap-2">
                    <button type="button" class="button-selected py-1! px-5!">지원</button>
                    <button type="button" class="button-orange py-1! px-5!">저장</button>
                </div>

                <div>
                    <div class="text-2xl font-bold py-4">채용공고 설명</div>
                    <div id="recruit_explain" class="ql-editor text-base! p-0!" contenteditable="false"></div>
                </div>

            </div>

        </div>
    </div>
</body>
</html>