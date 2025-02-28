/**
 * 
 */


let job_search_arr = [];   // 자동 검색된 검색어들을 실시간으로 넣어줄 배열

// 컨텍스트 패스
const contextPath = sessionStorage.getItem("contextpath");

$(document).ready(function () {
    






















    // 다음 버튼 클릭시 회원 경력으로 넘어가는 버튼
    $("input#btn_profile").on("click", function (e) {

        $("h4#h4_1").hide();  // 회원가입 글자 감추기
        $("div#register_menu").hide();  // 회원가입 화면 감추기
        $("h4#h4_2").show();  // 현재 재직정보 보이기
        $("div#career_menu").show();    // 경력 화면 출력

    });//end of $("button#btn_next1").on("click", function (e) {}..


    // 이전 버튼 클릭시 회원가입으로 돌아가는 버튼
    $("input#btn_before1").on("click", function (e) {

        $("h4#h4_1").show();  // 회원가입 글자 보이기
        $("div#register_menu").show();  // 회원가입 화면 감추기
        $("h4#h4_2").hide();  // 현재 재직정보 감추기
        $("div#career_menu").hide();    // 경력 화면 감추기

        
        // TODO -  페이지 넘기면 경력에서 입력한 값들 다 초기화 해야한다.    













            // ============================================================================================================================== //
    // 회원 경력에 대한 처리들


    // 학생인가요 버튼 클릭시 학력 입력 폼 보이기 버튼
    $("input#btn_student").on("click", function (e) {

        $("h4#h4_2").hide();            // 현재 재직정보 감추기
        $("div#career_menu").hide();    // 회원가입 화면 감추기        
        $("h4#h4_3").show();            // 현재 재직정보 감추기
        $("div#student_menu").show();   // 학력 화면 출력


        // TODO -  페이지 넘기면 경력에서서 입력한 값들 다 초기화 해야한다.




    });//end of $("button#btn_student").on("click", function (e) {}..



    //근무지 지역 설정
    // 지역 자동검색
    $("div#displayList2").hide(); // 먼저 검색구역 숨기기 

    let origin_career_searchWord = "";
    let idx2 = -1; // 방향키 자동완성 인덱스 초기값
    // 근무지 지역 검색어 입력 시
    $("input[name='career_region']").keyup(function (e) {

        // 변경될 때마다 $("input[name='career_fk_region_no']").val(); 값을 초기화 해준다.
        $("input[name='career_fk_region_no']").val("");

        // input 에서 한글입력키를 쓰면 무조건 229 가 된다.
        // 결론부터 말씀드리자면, input에서 한글자판 사용시 IME에서 메시지를 가로채기 때문에 keyCode가 229를 가리키는 것이었습니다.
        if (e.keyCode == 229) {
            return;
        }//

        const wordLength = $(this).val().trim().length; // 검색어에서 공백을 제외한 길이

        if (wordLength == 0) {
            $("div#displayList2").hide();
            return;
            // 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다.
        }//end of if (wordLength == 0) {}...

        // 방향키 위아래로 해서 검색어 입력
        switch (e.keyCode) {
            case 13: // 엔터입력시 유효성검사

                let flag = false; // 깃발

                region_search_arr.forEach((item, index, array) => {
                    if ($(this).val() == item.region_name) { // 검색 목록에 정확하게 들어맞으면
                        $("input[name='career_fk_region_no']").val(item.region_no);
                        idx2 = -1; // 인덱스 초기화!
                        // console.log("career_fk_region_no = > ", $("input[name='career_fk_region_no']").val());
                        flag = true;
                        return;
                    }
                });

                if (flag) {
                    $("div#career_regionerror").html("").hide();
                    $("div#displayList2").hide(); // 검색창 감추기

                } else {
                    $("div#career_regionerror").html(`목록에 있는 지역만 입력해주십시오!`).css({ "color": "red" }).show();
                    $("div#displayList2").hide(); // 검색창 감추기

                    return;
                }//end of if (flag) {}...

                break;

            case 40: // 아래키 입력시 목록 이동 선택

                $("div#displayList2").show(); // 검색창 보이기
                if (idx2 == -1) { // 
                    origin_career_searchWord = $(this).val(); // 스트링에 원래 값을 넣어준다.
                    $("li.result").eq(++idx2).addClass("searchWordSelected");    // 첫번째 인덱스
                    $(this).val(region_search_arr[idx2].region_name);

                } else {
                    if (idx2 == region_search_arr.length - 1) {
                        $("li.result").eq(idx2).removeClass("searchWordSelected");    // 첫번째 인덱스
                        idx2 = 0; // 인덱스 0 으로 초기화
                        $("li.result").eq(idx2).addClass("searchWordSelected");    // 첫번째 인덱스
                        $(this).val(region_search_arr[idx2].region_name);

                    } else {
                        $("li.result").eq(idx2).removeClass("searchWordSelected");   // 선택된 인덱스 클래스 삭제
                        $("li.result").eq(++idx2).addClass("searchWordSelected");    // 다음
                        $(this).val(region_search_arr[idx2].region_name);
                    }
                }//
                break;

            case 38: // 윗키 입력시 목록 이동 선택
                $("div#displayList2").show(); // 검색창 보이기
                if (idx2 <= 0) { // 
                    idx2 = -1; // 정확하게 명시하여 초기화
                    $("div#displayList2").hide(); // 검색창 감추기
                    $(this).val(origin_career_searchWord);
                } else {
                    $("li.result").eq(idx2).removeClass("searchWordSelected");   // 선택된 인덱스 클래스 삭제
                    $("li.result").eq(--idx2).addClass("searchWordSelected");    // 이전
                    $(this).val(region_search_arr[idx2].region_name); // 오류 부분
                }
                break;

            default:
                ajax_search2(); // 지역 검색
                break;
            // default code

        };//end of switch...

    });//end of $("input[name='region_name']").keyup(function (e) {}...


    $(document).on("blur", "input[name='career_region']", function (e) {

        let flag = false; // 깃발

        region_search_arr.forEach((item, index, array) => {
            if ($(this).val() == item.region_name) { // 검색 목록에 정확하게 들어맞으면
                $("input[name='career_fk_region_no']").val(item.region_no);
                idx2 = -1; // 인덱스 초기화!
                // console.log("career_fk_region_no = > ", $("input[name='career_fk_region_no']").val());
                flag = true;
                return;
            }
        });

        if (flag) {
            $("div#career_regionerror").html("").hide();

            $("div#displayList2").hide(); // 검색창 감추기
            idx2 = -1; // 인덱스 초기화!

        } else {
            $("div#career_regionerror").html(`목록에 있는 지역만 입력해주십시오!`).css({ "color": "red" }).show();
            $("div#displayList2").hide(); // 검색창 감추기
            idx2 = -1;

            return;
        }//end of if (flag) {}...

    });//end of $(document).on("blur", "input[name='career_region']", function (e) {}...



    // 검색어 클릭시 완성하기
    $(document).on("mousedown", "li[name='result_b']", function (e) {

        const word = $(e.target).text();
        const no = $(e.target).children("input[name='no_result']").val();
        // $("input[name='no_result']").val();
        $("input[name='career_region']").val(word); // 텍스트 박스에 검색된 결과의 문자열을 입력해준다.
        $("input[name='career_fk_region_no']").val(no);
        $("div#displayList2").hide();
        console.log("히든 인풋태그 번호 => ", $("input[name='fk_region_no']").val());

    });//end of $(document).on("click", "span.result", function(e) {}...






    // // 직종 자동검색
    // $("div#displayList3").hide(); // 먼저 검색구역 숨기기 

    // let origin_career_job_searchWord = "";
    // let idx3 = -1; // 방향키 자동완성 인덱스 초기값
    // // 근무지 지역 검색어 입력 시
    // $("input[name='career_job']").keyup(function (e) {

    //     // 변경될 때마다 $("input[name='career_fk_region_no']").val(); 값을 초기화 해준다.
    //     $("input[name='fk_job_no']").val("");

    //     // input 에서 한글입력키를 쓰면 무조건 229 가 된다.
    //     // 결론부터 말씀드리자면, input에서 한글자판 사용시 IME에서 메시지를 가로채기 때문에 keyCode가 229를 가리키는 것이었습니다.
    //     if (e.keyCode == 229) {
    //         return;
    //     }//

    //     const wordLength = $(this).val().trim().length; // 검색어에서 공백을 제외한 길이

    //     if (wordLength == 0) {
    //         $("div#displayList3").hide();
    //         return;
    //         // 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다.
    //     }//end of if (wordLength == 0) {}...

    //     // 방향키 위아래로 해서 검색어 입력
    //     switch (e.keyCode) {
    //         case 13: // 엔터입력시 유효성검사

    //             let flag = false; // 깃발

    //             job_search_arr.forEach((item, index, array) => {
    //                 if ($(this).val() == item.region_name) { // 검색 목록에 정확하게 들어맞으면
    //                     $("input[name='career_fk_region_no']").val(item.region_no);
    //                     idx2 = -1; // 인덱스 초기화!
    //                     // console.log("career_fk_region_no = > ", $("input[name='career_fk_region_no']").val());
    //                     flag = true;
    //                     return;
    //                 }
    //             });

    //             if (flag) {
    //                 $("div#career_regionerror").html("").hide();
    //                 $("div#displayList2").hide(); // 검색창 감추기

    //             } else {
    //                 $("div#career_regionerror").html(`목록에 있는 지역만 입력해주십시오!`).css({ "color": "red" }).show();
    //                 $("div#displayList2").hide(); // 검색창 감추기

    //                 return;
    //             }//end of if (flag) {}...

    //             break;

    //         case 40: // 아래키 입력시 목록 이동 선택

    //             $("div#displayList2").show(); // 검색창 보이기
    //             if (idx2 == -1) { // 
    //                 origin_career_searchWord = $(this).val(); // 스트링에 원래 값을 넣어준다.
    //                 $("li.result").eq(++idx2).addClass("searchWordSelected");    // 첫번째 인덱스
    //                 $(this).val(region_search_arr[idx2].region_name);

    //             } else {
    //                 if (idx2 == region_search_arr.length - 1) {
    //                     $("li.result").eq(idx2).removeClass("searchWordSelected");    // 첫번째 인덱스
    //                     idx2 = 0; // 인덱스 0 으로 초기화
    //                     $("li.result").eq(idx2).addClass("searchWordSelected");    // 첫번째 인덱스
    //                     $(this).val(region_search_arr[idx2].region_name);

    //                 } else {
    //                     $("li.result").eq(idx2).removeClass("searchWordSelected");   // 선택된 인덱스 클래스 삭제
    //                     $("li.result").eq(++idx2).addClass("searchWordSelected");    // 다음
    //                     $(this).val(region_search_arr[idx2].region_name);
    //                 }
    //             }//
    //             break;

    //         case 38: // 윗키 입력시 목록 이동 선택
    //             $("div#displayList2").show(); // 검색창 보이기
    //             if (idx2 <= 0) { // 
    //                 idx2 = -1; // 정확하게 명시하여 초기화
    //                 $("div#displayList2").hide(); // 검색창 감추기
    //                 $(this).val(origin_career_searchWord);
    //             } else {
    //                 $("li.result").eq(idx2).removeClass("searchWordSelected");   // 선택된 인덱스 클래스 삭제
    //                 $("li.result").eq(--idx2).addClass("searchWordSelected");    // 이전
    //                 $(this).val(region_search_arr[idx2].region_name); // 오류 부분
    //             }
    //             break;

    //         default:
    //             ajax_search2(); // 지역 검색
    //             break;
    //         // default code

    //     };//end of switch...

    // });//end of $("input[name='region_name']").keyup(function (e) {}...


    // $(document).on("blur", "input[name='career_region']", function (e) {

    //     let flag = false; // 깃발

    //     region_search_arr.forEach((item, index, array) => {
    //         if ($(this).val() == item.region_name) { // 검색 목록에 정확하게 들어맞으면
    //             $("input[name='career_fk_region_no']").val(item.region_no);
    //             idx2 = -1; // 인덱스 초기화!
    //             // console.log("career_fk_region_no = > ", $("input[name='career_fk_region_no']").val());
    //             flag = true;
    //             return;
    //         }
    //     });

    //     if (flag) {
    //         $("div#career_regionerror").html("").hide();

    //         $("div#displayList2").hide(); // 검색창 감추기
    //         idx2 = -1; // 인덱스 초기화!

    //     } else {
    //         $("div#career_regionerror").html(`목록에 있는 지역만 입력해주십시오!`).css({ "color": "red" }).show();
    //         $("div#displayList2").hide(); // 검색창 감추기
    //         idx2 = -1;

    //         return;
    //     }//end of if (flag) {}...

    // });//end of $(document).on("blur", "input[name='career_region']", function (e) {}...



    // // 검색어 클릭시 완성하기
    // $(document).on("mousedown", "li[name='result_b']", function (e) {

    //     const word = $(e.target).text();
    //     const no = $(e.target).children("input[name='no_result']").val();
    //     // $("input[name='no_result']").val();
    //     $("input[name='career_region']").val(word); // 텍스트 박스에 검색된 결과의 문자열을 입력해준다.
    //     $("input[name='career_fk_region_no']").val(no);
    //     $("div#displayList2").hide();
    //     console.log("히든 인풋태그 번호 => ", $("input[name='fk_region_no']").val());

    // });//end of $(document).on("click", "span.result", function(e) {}...

















    });//end of $("button#btn_before1").on("click", function (e) {}..






});//end of ready...









// 근무지 지역 검색용 ajax2
function ajax_search2() {

    const li_id = "_b";

    // 지역 검색어 입력 ajax
    $.ajax({
        url: `${contextPath}/member/region/search`,
        type: "get",
        // async: false,
        data: {
            "region_name": $("input[name='career_region']").val()
        },
        dataType: "json",
        success: function (json) {
            // console.log(JSON.stringify(json));
            region_search_arr = json;
            console.log("region_search_arr => ", JSON.stringify(region_search_arr));

            // === 검색어 입력시 자동글 완성하기
            if (json.length > 0) {
                // 검색된 데이터가 있는 경우
                let v_html = `<ul style="list-style:none; padding: 0; margin-left: 0;">`;

                $.each(json, function (index, item) {
                    const word = item.region_name;
                    const no = item.region_no;

                    // word.toLowerCase()은 word 를 모두 소문자로 변경하는 것이다.

                    // 검색된 태그 안에 no 넣어주기
                    no_result = `<input type="hidden" name="no_result" value="${item.region_no}" />`;

                    const idx = word.toLowerCase().indexOf($("input[name='career_region']").val().toLowerCase());

                    const len = $("input[name='career_region']").val().length;

                    result = word.substring(0, idx) + "<span style='color:blue;'>" + word.substring(idx, idx + len) + "</span>" + word.substring(idx + len);

                    v_html += `<li style='cursor:pointer;' name='result${li_id}' class='result'>${result}${no_result}</li>`;

                });// end of $.each(json, function(index, item) {})-------------------

                v_html += `</ul>`;

                $("div#displayList2").html(v_html).show(); // 보여줘라

            } else {
                $("div#displayList2").html("검색된 값이 없습니다.").show();
            }//end of if (json.length > 0) {}...

        },
        error: function (request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

}//end of function ajax_search2() {}...