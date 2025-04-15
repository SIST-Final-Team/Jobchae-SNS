let requestLock = false; // AJAX 요청에 대해 응답이 오기 전에 다시 요청하는 것을 차단
let inputTimeout;        // 입력 후 일정시간이 지난 후 검색이 되도록 하는 타임아웃
let suggestClearTimeout; // 자동완성 창을 닫기 위한 타임아웃

$(document).ready(function () {

    // 채용공고 시작 버튼 클릭시 폼 제출
    $("#submitRecruitStep1").on("click", function() {
        const form = document.recruitAddStep1Form;

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
            form.submit();
        }
    });

    // 검색어가 바뀔 때 0.5초 후 검색
    $(document).on("input", ".input-search", function () {

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
    $(document).on("keydown", ".input-search", function (e) {
        if (e.keyCode == 13) {

            if (inputTimeout) {
                clearTimeout(inputTimeout);
            }

            searchAutocomplete(this);
        }
    });

    // 자동완성 드롭다운 모달 열기
    $(document).on("focus", ".input-search", function () {
        $(this).next().addClass("hidden"); // 에러 감추기
        searchAutocomplete(this);
    });

    // 바깥 클릭하면 드롭다운 모달 닫기
    $(document).on("blur", ".input-search", function () {

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
});


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