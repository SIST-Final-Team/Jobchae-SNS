$(document).ready(function () {
    // 검색어 입력 input
    $("input[name='searchWord']").on("keydown", function(e) {
        if(e.keyCode == 13) {
            goSearch();
            return false;
        }
    });
});

function goSearch() {
    const searchOptionForm = document.searchOptionForm;
    
    if(searchOptionForm != undefined) { // 검색 옵션 폼이 있는 경우 옵션을 포함한 검색
        const searchWord = document.searchForm.searchWord.value;
        searchOptionForm.action = ctxPathForSearch + "/search/" + searchOptionForm.searchType.value;
        if(searchWord.trim() != "") {
            searchOptionForm.searchWord.value = searchWord;
            searchOptionForm.submit();
        }
    }
    else { // 검색 옵션 폼이 없는 경우 전체 검색
        const searchForm = document.searchForm;
        searchForm.action = ctxPathForSearch + "/search/all";
        if(searchWord.trim() != "") {
            searchForm.submit();
        }
    }
}