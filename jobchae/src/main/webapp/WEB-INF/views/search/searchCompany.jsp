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

        $(window).scroll(function() {
            // 스크롤이 전체 페이지 크기만큼 내려가면
            if( $(window).scrollTop() + $(window).height() + 300 >= $(document).height() ) {
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

        $("input[type=checkbox]").prop("checked", false);

        // 업종이 선택되어 있다면
        // 먼저 업종 목록을 모두 가져온 다음 체크박스로 표시한 다음 실행되어야 한다.
        if(${not empty requestScope.arr_fk_industry_no}) {
            const arr_fk_industry_no = "${requestScope.arr_fk_industry_no}".split(",");
            $.each(arr_fk_industry_no, (index, item) => {
                $("input[name='fk_industry_no'][value='"+item+"']").prop("checked", true);
            });
            $("button#btnIndustry").removeClass("button-gray");
            $("button#btnIndustry").addClass("button-selected");
            
            $(".btn-reset-dropdown").each((index, elmt) => {
                if($(elmt).data("reset") == "fk_industry_no") {
                    $(elmt).text("초기화").addClass("active");
                    $(elmt).removeClass("btn-close-dropdown");
                }
            });
        }

        // 지역이 선택되어 있다면
        if(${not empty requestScope.arr_fk_region_no}) {
            const arr_fk_region_no = "${requestScope.arr_fk_region_no}".split(",");
            $.each(arr_fk_region_no, (index, item) => {
                $("input[name='fk_region_no'][value='"+item+"']").prop("checked", true);
            });
            $("button#btnRegion").removeClass("button-gray");
            $("button#btnRegion").addClass("button-selected");
            
            $(".btn-reset-dropdown").each((index, elmt) => {
                if($(elmt).data("reset") == "fk_region_no") {
                    $(elmt).text("초기화").addClass("active");
                    $(elmt).removeClass("btn-close-dropdown");
                }
            });
        }

        // 회사 규모가 선택되어 있다면
        if(${not empty requestScope.arr_company_size}) {
            const arr_company_size = "${requestScope.arr_company_size}".split(",");
            $.each(arr_company_size, (index, item) => {
                $("input[name='company_size'][value='"+item+"']").prop("checked", true);
            });
            $("button#btnCompanySize").removeClass("button-gray");
            $("button#btnCompanySize").addClass("button-selected");
            
            $(".btn-reset-dropdown").each((index, elmt) => {
                if($(elmt).data("reset") == "company_size") {
                    $(elmt).text("초기화").addClass("active");
                    $(elmt).removeClass("btn-close-dropdown");
                }
            });
        }
    }

    // 자동완성
    function searchAutocomplete(inputEl) {
        
        // 업종 검색은 코드가 다름
        if($(inputEl).data("search-type") == "industry_name") {
            searchAutocompleteForIndustry(inputEl);
            return;
        }

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
    
    // 업종 자동완성
    function searchAutocompleteForIndustry(inputEl) {

        if (requestLock) {
            return;
        }
        requestLock = true;

        const targetUrl = ctxPath + $(inputEl).data("target-url");
        const searchWord = $(inputEl).val();

        $.ajax({
            url: targetUrl + searchWord,
            dataType: "json",
            success: function (json) {
                // console.log(JSON.stringify(json));

                let v_html = '<div class="absolute suggest bg-white rounded-lg drop-shadow-lg max-h-50 z-999 overflow-y-auto"><ul>';
                if (json.length == 0) {
                    v_html += '<li class="hover:bg-gray-100 p-2">검색 결과가 없습니다.</li>';
                }
                else {
                    for (let i = 0; i < json.length; i++) {
                        v_html += `<li class="hover:bg-gray-100 p-2" data-value="\${json[i].industryNo}">\${json[i].industryName}</li>`;
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

        // 업종 목록 추가
        let arr_fk_industry_no = "";
        $("input[name='fk_industry_no']:checked").each((index, elmt) => {
            if(index == 0) {
                arr_fk_industry_no += $(elmt).val();
            }
            else {
                arr_fk_industry_no += ","+$(elmt).val();
            }
        });
        if(arr_fk_industry_no != "") {
            additionalFieldsHtml += `<input type="hidden" name="arr_fk_industry_no" value="\${arr_fk_industry_no}"/>`;
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

        // 회사 규모 목록 추가
        let arr_company_size = "";
        $("input[name='company_size']:checked").each((index, elmt) => {
            if(index == 0) {
                arr_company_size += $(elmt).val();
            }
            else {
                arr_company_size += ","+$(elmt).val();
            }
        });
        if(arr_company_size != "") {
            additionalFieldsHtml += `<input type="hidden" name="arr_company_size" value="\${arr_company_size}"/>`;
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
            url: "${pageContext.request.contextPath}/api/search/company",
            data: data,
            dataType: "json",
            success: function (json) {
                console.log(JSON.stringify(json));

                if(json.length > 0) {

                    let html = ``;
                    $.each(json, (index, item) => {

                        const borderHtml = (index != json.length - 1)?`border-b-1 border-gray-300 `:``;
                        html += `
                        <li class="border-b-1 border-gray-300  py-2">
                            <a href="#" class="flex">
                                <div>
                                    <img src="${pageContext.request.contextPath}/resources/files/company/\${item.company_logo}" class="aspect-square w-15 object-cover"/>
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-lg hover:underline">\${item.company_name}</div>
                                    <div>\${item.industry_name}</div>
                                    <div class="text-gray-600">\${item.region_name}</div>
                                </div>
                            </a>
                        </li>`;
                    });

                    $("#companyList").append(html);
                }
                else {
                    if(start==1) { // 목록이 하나도 없다면
                        let html = `<li class="text-center text-lg"><span class="block pb-2">조회된 회사가 없습니다.</span>
                                </li>`;

                        $("#companyList").html(html);
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
        <input type="hidden" name="searchType" value="company"/>
        <div id="additionalFields">
        </div>
        <!-- 검색 유형 Dropdown -->
        <dialog id="dropdownSearchType" class="option-dropdown border-normal drop-shadow-lg">
            <ul class="nav font-bold text-gray-600 w-50">
                <li><a href="${pageContext.request.contextPath}/search/all?searchWord=${requestScope.searchWord}">전체</a></li>
                <li><a href="${pageContext.request.contextPath}/search/board?searchWord=${requestScope.searchWord}">글</a></li>
                <li><a href="${pageContext.request.contextPath}/search/member?searchWord=${requestScope.searchWord}">사람</a></li>
                <li class="nav-selected"><a href="${pageContext.request.contextPath}/search/company?searchWord=${requestScope.searchWord}">회사</a></li>
                <li><a href="${pageContext.request.contextPath}/search/recruit?searchWord=${requestScope.searchWord}">채용공고</a></li>
            </ul>
        </dialog>
        
        <!-- 업종 Dropdown -->
        <dialog id="dropdownIndustry" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
            <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
            <div class="pt-4 space-y-2">
                <ul id="fk_industry_noList" class="space-y-4 w-100 h-70 px-4 overflow-y-auto">
                    <li>
                        <label for="industry_name" class="text-gray-500">업종 *</label><br>
                        <input type="text" name="industry_name" id="industry_name" placeholder="업종 입력"
                            data-target-url="/api/industry/list/"
                            data-search-type="industry_name"
                            data-result-name="fk_industry_no"
                            class="input-search w-full border-1 rounded-sm p-1" />
                        <input type="text" name="fk_industry_no" class="hidden" />
                    </li>
                    <c:forEach var="industry" items="${industryList}">
                        <li>
                            <input type="checkbox" name="fk_industry_no" id="fk_industry_no${industry.industry_no}" value="${industry.industry_no}" checked/>
                            <label for="fk_industry_no${industry.industry_no}">${industry.industry_name}</label>
                        </li>
                    </c:forEach>
                </ul>
                <hr class="border-gray-200">
                <div class="flex justify-end items-center gap-4 px-4">
                    <div>
                        <button type="button" class="btn-close-dropdown button-board-action px-4 btn-reset-dropdown" data-reset="fk_industry_no">취소</button>
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
        
        <!-- 회사 규모 Dropdown -->
        <dialog id="dropdownCompanySize" class="option-dropdown border-normal pt-4 pb-2 drop-shadow-lg">
            <div class="space-y-2">
                <button type="button" class="btn-close-dropdown btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
                <ul class="space-y-4 w-60 px-4">
                    <li>
                        <input type="checkbox" name="company_size" id="company_size1" value="1"/>
                        <label for="company_size1">직원 0-1명</label>
                    </li>
                    <li>
                        <input type="checkbox" name="company_size" id="company_size2" value="2"/>
                        <label for="company_size2">직원 2-10명</label>
                    </li>
                    <li>
                        <input type="checkbox" name="company_size" id="company_size3" value="3"/>
                        <label for="company_size3">직원 11-50명</label>
                    </li>
                    <li>
                        <input type="checkbox" name="company_size" id="company_size4" value="4"/>
                        <label for="company_size4">직원 51-200명</label>
                    </li>
                    <li>
                        <input type="checkbox" name="company_size" id="company_size5" value="5"/>
                        <label for="company_size5">직원 201-500명</label>
                    </li>
                    <li>
                        <input type="checkbox" name="company_size" id="company_size6" value="6"/>
                        <label for="company_size6">직원 501-1,000명</label>
                    </li>
                    <li>
                        <input type="checkbox" name="company_size" id="company_size7" value="7"/>
                        <label for="company_size7">직원 1,001-5,000명</label>
                    </li>
                    <li>
                        <input type="checkbox" name="company_size" id="company_size8" value="8"/>
                        <label for="company_size8">직원 5,001-10,000명</label>
                    </li>
                    <li>
                        <input type="checkbox" name="company_size" id="company_size9" value="9"/>
                        <label for="company_size9">직원 10,000명 이상</label>
                    </li>
                </ul>
                <hr class="border-gray-200">
                <div class="flex justify-end items-center gap-4 px-4">
                    <div>
                        <button type="button" class="btn-close-dropdown button-board-action px-4 btn-reset-dropdown" data-reset="company_size">취소</button>
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
                <span>회사</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
            <button type="button" id="btnIndustry" class="button-gray btn-open-dropdown">
                <span>업종</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
            <button type="button" id="btnRegion" class="button-gray btn-open-dropdown">
                <span>지역</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
            <button type="button" id="btnCompanySize" class="button-gray btn-open-dropdown">
                <span>회사 규모</span>
                <i class="fa-solid fa-caret-down"></i>
            </button>
        </div>
    </div>

    <div class="container m-auto mt-23 grid grid-cols-14 gap-6 xl:max-w-[1140px]">
        <div class="center col-span-14 md:col-span-7 space-y-2 mb-5">
            
            <div id="member" class="scroll-mt-36 border-normal py-2">
                <div class="px-4">
                    <ul id="companyList">
                        <%-- <li class="border-b-1 border-gray-300  py-2">
                            <a href="#" class="flex">
                                <div>
                                    <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover"/>
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-lg hover:underline">Samsung Electronics</div>
                                    <div>Samsung Memory Marketing Director</div>
                                    <div class="text-gray-600">Hwaseong</div>
                                </div>
                            </a>
                        </li> --%>
                    </ul>
                    <div class="flex">
                    </div>
                </div>
            </div>
        </div>

        <div class="right-side col-span-4 h-full relative hidden lg:block">
            <div class="border-list sticky top-37 space-y-2 text-center relative bg-white">
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