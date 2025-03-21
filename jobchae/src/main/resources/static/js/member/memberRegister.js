
let is_id_ok = false; // 아이디 입력 블러 중 버튼 바로 누를 시 걸러주는 역할

let is_email_ok = false; // 이메일 입력 블러 중 버튼 바로 누를 시 걸러주는 역할

let b_idcheck_click = false; // 아이디 중복확인 버튼 클릭했는지 여부

// let b_email_click = false; // 이메일 중복확인 버튼 클릭했는지 여부

let b_email_auth_click = false; // 인증버튼 클릭했는지 여부

let is_email_auth = false; // 인증번호를 인증 받았는지 여부



let region_search_arr = [];   // 자동 검색된 검색어들을 실시간으로 넣어줄 배열

// 컨텍스트 패스
const contextPath = sessionStorage.getItem("contextpath");

// const region_search_arr = [];   // 자동 검색된 검색어들을 실시간으로 넣어줄 배열

$(document).ready(function () {

    // 모달 애니메이션 추가
    $("dialog.modal").addClass("animate-slideDown");

    // 사진 첨부
    $("img#profile_img").on("click", function (e) {

        $("input#file_input_profile").click(); // 프로필 사진 설정

    });//end of $("img#profile_img").on("click", function (e) {}...

    // 파일 인풋 값이 들어갔을 때 이벤트
    $("input#file_input_profile").change(function (e) {

        console.log("프로필 사진 => ",$("input#file_input_profile").val());

        const inputFile = $(e.target).get(0).files[0];
        const preview_profile_img = $("img#profile_img"); // 미리보기 사진칸

        if (inputFile) { // 파일을 업로드한 경우

            // console.log("$(e.target).get(0).value!!!!! => ", $(e.target).get(0).value);

            const fileType = inputFile.type; // "image/jpeg", "image/png", ...
            console.log("fileType => ", fileType);
            
            const reg = /image\/(jpg|jpeg|png|webp)$/; // 확장자가 이미지인지 확인하기 위한 regex

            if (!reg.test(fileType)) { // 확장자가 이미지가 아닌 경우
                alert('이미지 파일만 업로드 가능합니다.\n .jpg .jpeg .png, .webp');
                $(e.target).get(0).value = ""; // input 비우기
                return;
            }

            const limitSize = 10 * 1024 * 1024; // 10mb 크기 제한을 위한 변수

            const uploadSize = inputFile.size;

            if (limitSize < uploadSize) { // 이미지 크기가 10mb 이상인 경우
                alert('10MB 미만 이미지만 업로드가 가능합니다.');
                $(e.target).get(0).value = ""; // input 비우기
                return;
            }

            // 이미지 파일을 로드해서 미리보기에 표시
            const fileReader = new FileReader();

            fileReader.readAsDataURL(inputFile);
            fileReader.onload = function () {
                $(preview_profile_img).attr("src", fileReader.result);
                // console.log("fileReader.result => ", fileReader.result);
                $("#icon_label").hide();
            };
        } else { // 파일을 업로드하지 않은 경우
            $(preview_profile_img).attr("src", `${contextPath}/images/no_profile.png`); // 미리보기 이미지 초기화
            console.log("$(e.target).get(0).value => ", $(e.target).get(0).value);
            $(e.target).get(0).value = `${contextPath}/images/no_profile.png`; // 파일 value 도 초기화
            $("#icon_label").show();
        }// 

    });//$("input#file_input_profile").change(function (e) {}...


    // 백그라운드 사진 default 파일을 지정



    // userid 블러 처리
    const func_member_id = (e) => {

        const member_id = $(e.target).val().trim();

        if (member_id == "") { // 입력하지 않거나 공백만 입력했을 경우 

            $(e.target).val("");
            // $(e.target).focus();
            $("div#idcheckResult").html("").hide(); // 아이디 중복체크
            $("div#member_id_error").html("아이디는 필수입력 사항입니다.");

        }
        else { // 공백이 아닌 글자를 입력했을 경우
            const regExp_member_id = /^[a-z][A-Za-z0-9]{4,19}$/;

            // 생성된 정규표현식 객체속에 데이터를 넣어서 검사하기 
            const bool = regExp_member_id.test(member_id); // 리턴타입 boolean

            if (!bool) {
                $("div#idcheckResult").html("").hide(); // 아이디 중복체크
                $("div#member_id_error").html("");
                $(e.target).val("");
                $(e.target).focus();
                $("div#member_id_error").html("아이디는 영문소문자/숫자 4~16 조합으로 입력하세요.");
                console.log("bool => ", bool);

            } else {
                $("div#member_id_error").html("");
                is_id_ok = true;
            }
        }

    }// 아이디가 member_id 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.

    $("input#member_id").blur((e) => { func_member_id(e) });

    // passwd 블러 처리
    $("input#member_passwd").blur((e) => {

        const member_passwd = $(e.target).val().trim();

        if (member_passwd == "") {

            $(e.target).val("");
            // $(e.target).focus();

            $("div#member_passwd_error").html("비밀번호는 필수입력 사항입니다.");

        } else {
            const regExp_member_passwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
            // 숫자/문자/특수문자 포함 형태의 8~16자리 이내의 암호 정규표현식 객체 생성

            const bool = regExp_member_passwd.test(member_passwd);

            if (!bool) { // 암호가 정규표현식에 위배된 경우 
                $("div#member_passwd_error").html("");
                $(e.target).val("").focus();
                $("div#member_passwd_error").html("비밀번호는 숫자/문자/특수문자 포함하여 8~16자리로 입력하세요.");
            }
            else {
                // 암호가 정규표현식에 맞는 경우
                $("div#member_passwd_error").html("");
            }
        }

    });// 아이디가 member_passwd 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.


    // 비밀번호 확인
    $("input#passwdcheck").blur((e) => {

        if ($("input#member_passwd").val() != $(e.target).val()) {
            // 암호와 암호확인값이 틀린 경우 

            if ($(e.target).val() != "") { // 틀렸는데 비어있지 않으면 비우고 포커스 하고 오류출력
                $(e.target).val("").focus();
            }
            // 그냥 비어있으면 출력
            $(`div#passwdcheckerror`).html("비밀번호가 일치하지 않습니다.");

        }
        else {
            // 암호와 암호확인값이 같은 경우
            $(`div#passwdcheckerror`).html("");
        }

    });// 아이디가 pwdcheck 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.


    // name 블러 처리
    $("input#member_name").blur((e) => {

        const member_name = $(e.target).val().trim();
        if (member_name == "") {
            // 입력하지 않거나 공백만 입력했을 경우 

            $(e.target).val("");
            // $(e.target).focus();

            $("div#member_name_error").html("이름은 필수입력 사항입니다.");

        }
        else {
            // 공백이 아닌 글자를 입력했을 경우
            const regExp_member_name = new RegExp(/^[가-힣]{2,10}|[a-zA-Z]{2,10}[a-zA-Z]{2,10}$/);
            // 한글, 또는 영어 

            const bool = regExp_member_name.test(member_name);

            if (!bool) { // 성명이 정규표현식에 위배된 경우 
                $("div#member_name_error").html("");
                $(e.target).val("").focus();
                $("div#member_name_error").html("성명은 한글, 영어로 최대 20글자까지 가능합니다.");
            }
            else {
                // 성명이 정규표현식에 맞는 경우
                $("div#member_name_error").html("");
            }
        }

    });// 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 



    // 생년월일 
    // === jQuery UI 의 datepicker === //
    $("input#datepicker").datepicker({
        dateFormat: 'yy-mm-dd'     //Input Display Format 변경
        , showOtherMonths: true    //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        , showMonthAfterYear: true //년도 먼저 나오고, 뒤에 월 표시
        , changeYear: true         //콤보박스에서 년 선택 가능
        , changeMonth: true        //콤보박스에서 월 선택 가능                
        //  ,showOn: "both"        //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
        //  ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
        //  ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
        //  ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
        , yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
        , monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'] //달력의 월 부분 텍스트
        , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip 텍스트
        , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 부분 텍스트
        , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 부분 Tooltip 텍스트
        , minDate: "-100Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        , maxDate: "today" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)   
        , yearRange: "1900:today"
    });

    // 초기값을 오늘 날짜로 설정
    // $('input#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후) 

    // === 전체 datepicker 옵션 일괄 설정하기 ===  
    //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
    // $(function () {
    //     //모든 datepicker에 대한 공통 옵션 설정
    //     $.datepicker.setDefaults({
    //         dateFormat: 'yy-mm-dd' //Input Display Format 변경
    //         , showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
    //         , showMonthAfterYear: true //년도 먼저 나오고, 뒤에 월 표시
    //         , changeYear: true //콤보박스에서 년 선택 가능
    //         , changeMonth: true //콤보박스에서 월 선택 가능        
    //         // ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
    //         // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
    //         // ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
    //         // ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
    //         , yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
    //         , monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'] //달력의 월 부분 텍스트
    //         , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip 텍스트
    //         , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 부분 텍스트
    //         , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 부분 Tooltip 텍스트
    //         , minDate: "-100Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
    //         // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
    //     });

    //     // input을 datepicker로 선언
    //     $("input#fromDate").datepicker();
    //     $("input#toDate").datepicker();

    //     // From의 초기값을 오늘 날짜로 설정
    //     $('input#fromDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)

    //     // To의 초기값을 3일후로 설정
    //     $('input#toDate').datepicker('setDate', '+3D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
    // });

    ////////////////////////////////////////////////////////////////////

    $("input#datepicker").attr("readonly", true);
    // 생년월일에 키보드로 입력하는 경우 

    $("input#datepicker").bind("change", e => {
        if ($(e.target).val() != "") {
            $(e.target).next().hide();
        }
    }); // 생년월일에 마우스로 값을 변경하는 경우







    // 이메일 메소드
    const func_member_email = (e) => {

        const member_email = $(e.target).val().trim();

        if (member_email == "") {

            $(e.target).val("");
            // $(e.target).focus();
            $(`div#emailCheckResult`).html("").hide(); // 이메일 체크 유무
            $("div#member_email_error").html("이메일은 필수입력 사항입니다.");

        } else {
            const regExp_member_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
            // 이메일 정규표현식 객체 생성

            const bool = regExp_member_email.test(member_email);

            if (!bool) {
                // 이메일이 정규표현식에 위배된 경우 
                $(`div#emailCheckResult`).html("").hide(); // 이메일 체크 유무
                $("div#member_email_error").html("");
                $(e.target).val("").focus();
                $("div#member_email_error").html("이메일 형식이 아닙니다.");
            }
            else { // 이메일이 정규표현식에 맞는 경우

                $("div#member_email_error").html("");
                is_email_ok = true;

            }
        }

    };// 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.


    $("input#member_email").blur((e) => { func_member_email(e) });






    // hp2, hp3 의 name 을 없애자!
    $("input#hp2").blur((e) => {

        // const regExp_hp2 = /^[1-9][0-9]{3}$/; 
        // 또는
        const regExp_hp2 = new RegExp(/^[1-9][0-9]{3}$/);
        // 연락처 국번( 숫자 4자리인데 첫번째 숫자는 1-9 이고 나머지는 0-9) 정규표현식 객체 생성

        const bool = regExp_hp2.test($(e.target).val());

        if (!bool) {
            // 연락처 국번이 정규표현식에 위배된 경우 
            $(e.target).val("");
            // $(e.target).focus();
            $(`div#telerror`).html("휴대폰 형식이 아닙니다.");
        }
        else {
            // 연락처 국번이 정규표현식에 맞는 경우
            $(`div#telerror`).html("");
            $("input#member_tel").val($("input#hp1").val() + $("input#hp2").val() + $("input#hp3").val());
        }

    });// 아이디가 hp2 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.        


    $("input#hp3").blur((e) => {

        const regExp_hp3 = new RegExp(/^\d{4}$/);
        // 연락처 국번( 숫자 4자리인데 첫번째 숫자는 1-9 이고 나머지는 0-9) 정규표현식 객체 생성

        const bool = regExp_hp3.test($(e.target).val());

        if (!bool) {
            // 마지막 전화번호 4자리가 정규표현식에 위배된 경우 
            $(e.target).val("");
            // $(e.target).focus();
            $(`#telerror`).html("휴대폰 형식이 아닙니다.");
        }
        else {
            // 마지막 전화번호 4자리가 정규표현식에 맞는 경우
            $(`#telerror`).html("");
            $("input#member_tel").val($("input#hp1").val() + $("input#hp2").val() + $("input#hp3").val()); // 만들어라
            // console.log("전화번호 완성 => ", $("input#member_tel").val());
            
        }

    });// 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 






    // ///////////////////////////////////////////////////////////////////////////////////////////////////////////
















    // 아이디 중복확인 클릭했을 시 이벤트 처리하기
    $(`button#idcheck`).click(function (e) {

        if (is_id_ok == false) {   // 여기까지 함, 인증번호 칸 숨기고 아이디 이메일 레디 밑에 함수로 선언해서 정리하자!!!
            // func_userid(e);
            return;
        }
        // === 두번째 방법 === //
        $.ajax({
            url: `${contextPath}/api/member/idDuplicateCheck`, //              /member/ 까진 똑같아서 제외함
            data: { "member_id": $(`input#member_id`).val() }, // json 모양 파라미터(객체 아님!!)
            type: "post",  // 빼면 get 방식
            async: true,       // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
            // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
            dataType: "json", // Javascript Standard Object Notation.  dataType은 /MyMVC/member/idDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
            // 만약에 dataType:"xml" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
            // 만약에 dataType:"json" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 json 형식이어야 한다.

            success: function (json) { //    
                // console.log("json => ", json);
                // console.log("typeof json => ", typeof json);

                if (json["isExists"]) {
                    // 입력한 userid 가 이미 사용중인 것이다!
                    $(`div#idcheckResult`).html(`${$(`input#member_id`).val()}은 이미 사용중 이므로 다른 아이디를 입력하세요`).css({ "color": "red" }).show();
                    $(`input#userid`).val("");
                } else {
                    // 사용 가능한 아이디다!
                    $(`div#idcheckResult`).html(`${$(`input#member_id`).val()}은 사용할 수 있습니다!`).css({ "color": "blue" }).show();
                    b_idcheck_click = true;
                }
            }
            ,
            error: function (request, status, error) { // 코딩이 잘못되어지면 어디가 잘못되어졌는지 보여준다!
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });


    });//end of $(`img#idcheck`).click(function (e) {  }....



    // 아이디 값이 변경되면 가입하기 버튼 클릭시 아이디중복확인을 클릭했는지 여부 알아오기 용도 초기화 시키기
    $(`input#member_id`).change(function (e) {
        b_idcheck_click = false;
        is_id_ok = false;
        $(`div#idcheckResult`).html("").hide();
        // 아이디 중복검사를 받아놓고 다시 아이디를 바꾸면 중복확인을 초기화 시켜줘야 한다!!!
    });//end of $(`input#userid`).change(function (e) { }...





    // 이메일 중복확인 클릭했을 시 이벤트 처리하기 
    $(`button#emailcheck`).click(function (e) {

        b_email_auth_click = false; // 또 클릭하면 자기 자신의 전송도 일단 거짓으로 만들자
        is_email_auth = false; // 이메일 인증까지 받아놓고 또 이메일 보내기 누르면 기존 인증번호를 없애야한다.
        $(`div#email_authResult`).html("");

        if (is_email_ok == false) {   // 여기까지 함, 인증번호 칸 숨기고 아이디 이메일 레디 밑에 함수로 선언해서 정리하자!!!
            // func_userid(e);
            return;
        } else {
            // 데이터 베이스 검사 후 중복이 안되면 true 값을 반환, 인증메일 발송
            $.ajax({
                url: `${contextPath}/api/member/emailCheck_Send`, //
                data: { "member_email": $(`input#member_email`).val() },
                type: "post",  // 빼면 get 방식
                async: true,       // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
                dataType: "json", // Javascript Standard Object Notation.  dataType은 /MyMVC/member/idDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 

                success: function (json) { //    
                    console.log("json => ", json);
                    console.log("typeof json => ", typeof json);

                    if (json["isExists"]) {
                        // 입력한 email 가 이미 사용중인 것이다!
                        $(`div#emailCheckResult`).html(`${$(`input#member_email`).val()}은 이미 사용중 이므로 다른 이메일을 입력하세요`).css({ "color": "red" }).show();
                        $(`input#member_email`).val("");
                    } else {
                        // 사용 가능한 이메일   인증번호 발송을 백엔드에서 구현하라
                        $(`div#emailCheckResult`).html(`${$(`input#member_email`).val()}로 인증번호 발송하였습니다!`).css({ "color": "blue" }).show();
                        b_email_auth_click = true;
                        $(`.hide_emailAuth`).slideDown(); // 인증번호 칸 나타내기
                    }
                }
                ,
                error: function (request, status, error) { // 코딩이 잘못되어지면 어디가 잘못되어졌는지 보여준다!
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }//end of if else...

    });//$(`span#email`).click(function (e) { }...




    // 인증번호 확인 버튼 클릭했을 시 이벤트 처리하기 
    $(`button#btn_email_auth`).click(function (e) {

        if (b_email_auth_click == false) {
            alert("이메일이 변경되었습니다. 인증번호를 다시 발급해주세요.");
            return;
            
        } else { // true 여야 데이터 베이스에 들어감
            $.ajax({
                url: `${contextPath}/api/member/emailAuth`,
                data: { "email_auth_text": $(`input#email_auth`).val() },
                type: "post",  // 빼면 get 방식
                async: true,       // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
                dataType: "json", // Javascript Standard Object Notation.  dataType은 /MyMVC/member/idDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 

                success: function (json) { //    

                    if (!json["isExists"]) {
                        // 인증번호가 일치하지 않는다!
                        $(`div#email_authResult`).html(`인증번호가 일치하지 않습니다!`).css({ "color": "red" }).show();
                        $(`input#email_auth`).val("");
                    } else {
                        // 인증번호 일치!
                        $(`div#email_authResult`).html(`인증번호가 일치합니다!`).css({ "color": "blue" }).show();
                        is_email_auth = true; // 인증번호 일치!
                    }
                }
                ,
                error: function (request, status, error) { // 코딩이 잘못되어지면 어디가 잘못되어졌는지 보여준다!
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });

        }//end of if else..

    });//end of $(`button#btn_email_auth`).click(function (e) { }...










    // 이메일 값이 변경되면 가입하기 버튼 클릭시 아이디중복확인을 클릭했는지 여부 알아오기 용도 초기화 시키기
    $(`input#member_email`).change(function (e) {
        b_email_auth_click = false;   // 이메일 인증 버튼 체크
        is_email_auth = false;        // 이메일 인증 했는지 체크
        is_email_ok = false;          // 이메일 입력 중 바로 버튼을 눌렀을 경우 걸러주는 역할
        // 이메일도 중복검사를 받아놓고 다시 바꾸면 중복확인을 초기화 시켜줘야 한다!!!
        $(`div#emailCheckResult`).html("").hide();
        $(`div#email_authResult`).html("").hide();

    });//end of $(`span#email`).click(function (e) { }...






    // 지역 자동검색
    $("div#displayList").hide(); // 먼저 검색구역 숨기기

    let origin_searchWord = "";
    let idx = -1; // 방향키 자동완성 인덱스 초기값
    // 지역 검색어 입력 시
    $("input[name='region_name']").keyup(function (e) {

        // 변경될 때마다 $("input[name='fk_region_no']").val(); 값을 초기화 해준다.
        $("input[name='fk_region_no']").val("");


        // input 에서 한글입력키를 쓰면 무조건 229 가 된다.
        // 결론부터 말씀드리자면, input에서 한글자판 사용시 IME에서 메시지를 가로채기 때문에 keyCode가 229를 가리키는 것이었습니다.
        if (e.keyCode == 229) {
            return;
        }//

        const wordLength = $(this).val().trim().length; // 검색어에서 공백을 제외한 길이

        if (wordLength == 0) {
            $("div#displayList").hide();
            return;
            // 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다.
        }//end of if (wordLength == 0) {}...

        // 방향키 위아래로 해서 검색어 입력
        switch (e.keyCode) {
            case 13: // 엔터입력시 유효성검사

                let flag = false; // 깃발

                region_search_arr.forEach((item, index, array) => {
                    if ($(this).val() == item.region_name) { // 검색 목록에 정확하게 들어맞으면
                        $("input[name='fk_region_no']").val(item.region_no);
                        idx = -1; // 인덱스 초기화!
                        flag = true;
                        return;
                    }
                });

                if (flag) {
                    $("div#regionerror").html("").hide();
                    $("div#displayList").hide(); // 검색창 감추기
                    console.log("히든 인풋1 region_no => ", $("input[name='fk_region_no']").val());
                    // console.log("이거는 여기 와야해서 뜬다!");

                } else {
                    $("div#regionerror").html(`목록에 있는 지역만 입력해주십시오!`).css({ "color": "red" }).show();
                    $("div#displayList").hide(); // 검색창 감추기
                    // console.log("이거 뜨면 목록에 어쩌구에 뜬다!");

                    return;
                }//end of if (flag) {}...

                break;

            case 40: // 아래키 입력시 목록 이동 선택

                $("div#displayList").show(); // 검색창 보이기
                if (region_search_arr.length != 0) { // 검색된 결과 없으면 선택 못하도록
                    
                    if (idx == -1) { // 
                        origin_searchWord = $(this).val(); // 스트링에 원래 값을 넣어준다.
                        $("li.result").eq(++idx).addClass("searchWordSelected");    // 첫번째 인덱스
                        $(this).val(region_search_arr[idx].region_name);
                        // $("input[name='fk_region_no']").val(region_search_arr[idx].region_no);
                    } else {
                        if (idx == region_search_arr.length - 1) {
                            $("li.result").eq(idx).removeClass("searchWordSelected");    // 첫번째 인덱스
                            idx = 0; // 인덱스 0 으로 초기화
                            $("li.result").eq(idx).addClass("searchWordSelected");    // 첫번째 인덱스
                            $(this).val(region_search_arr[idx].region_name);
                            // $("input[name='fk_region_no']").val(region_search_arr[idx].region_no);
                            console.log("region_search_arr 아래키입력 => ", region_search_arr);
    
                        } else {
                            $("li.result").eq(idx).removeClass("searchWordSelected");   // 선택된 인덱스 클래스 삭제
                            $("li.result").eq(++idx).addClass("searchWordSelected");    // 다음
                            $(this).val(region_search_arr[idx].region_name);                // 오류나는 부분. 고치장
                            // $("input[name='fk_region_no']").val(region_search_arr[idx].region_no);
                        }
                    }//
                } else {
                    return;
                }//

                break;

            case 38: // 윗키 입력시 목록 이동 선택
                if (idx <= 0) { // 
                    idx = -1; // 정확하게 명시하여 초기화
                    $("div#displayList").hide(); // 검색창 감추기
                    $(this).val(origin_searchWord);
                } else {
                    $("li.result").eq(idx).removeClass("searchWordSelected");   // 선택된 인덱스 클래스 삭제
                    $("li.result").eq(--idx).addClass("searchWordSelected");    // 이전
                    $(this).val(region_search_arr[idx].region_name);
                    // $("input[name='fk_region_no']").val(region_search_arr[idx].region_no);
                    console.log("region_search_arr 윗키입력 => ", region_search_arr);
                }
                break;

            default:
                ajax_search() // 지역검색 검색창 보이기
                break;
            // default code

        };//end of switch...

    });//end of $("input[name='region_name']").keyup(function (e) {}...

    // 검색어 바뀌면 초기화
    $("input[name='region_name']").on("input", function (e) {
        origin_searchWord = "";
    });


    // 검색어 input 블러 처리
    $(document).on("blur", "input[name='region_name']", function (e) {

        let flag = false; // 깃발

        region_search_arr.forEach((item, index, array) => {
            if ($(this).val() == item.region_name) { // 검색 목록에 정확하게 들어맞으면
                $("input[name='fk_region_no']").val(item.region_no);
                flag = true;
                return;
            }
        });

        if (flag) {
            $("div#regionerror").html("").hide();
            $("div#displayList").hide(); // 검색창 감추기
            idx = -1; // 인덱스 초기화!
            console.log("히든 인풋1 region_no => ", $("input[name='fk_region_no']").val());
            console.log("이거는 여기 와야해서 뜬다!");

        } else {
            $("div#regionerror").html(`목록에 있는 지역만 입력해주십시오!`).css({ "color": "red" }).show();
            $("div#displayList").hide(); // 검색창 감추기
            idx = -1;
            console.log("이거 뜨면 목록에 어쩌구에 뜬다!");

            return;
        }//end of if (flag) {}...

    });//end of $(document).on("blur", "input[name='region_name']", function (e) {}...



    // // 이거 체인지 이벤트 상위호환이다. 엔터 막는 용
    // $("input[name='region_name']").on("input", function (e) {

    // });//end of 



    // 검색어 클릭시 완성하기
    $(document).on("mousedown", "li[name='result_a']", function (e) {
        const word = $(this).text();
        const no = $(this).children("input[name='no_result']").val();
        // $("input[name='no_result']").val();
        $("input[name='region_name']").val(word); // 텍스트 박스에 검색된 결과의 문자열을 입력해준다.
        $("input[name='fk_region_no']").val(no);
        $("div#displayList").hide();
        // console.log("히든 인풋태그 번호 => ", $("input[name='fk_region_no']").val());

    });//end of $(document).on("click", "span.result", function(e) {}...






    // 이용약관 체크박스 모달 처리
    // $("input#agree_checkbox").prop("checked" ,false);

    $("input#agree_checkbox").on("click", function (e) {
        $(e.target).prop("checked", false); // 클릭하면 일단 체크 멈춤

        if ($(e.target).prop("checked") == true) {
            // alert("asdfasdfadsfsdafasdf");
        }

    });//end of $("input#agree_checkbox").on("click", function (e) {}...

    // 이용약관 모달 안의 동의 버튼 클릭 시 
    $("button#btn_agree").on("click", function (e) {

        $("input#agree_checkbox").prop("checked", true); // 체크

        $(".btn-close-modal").click();

    });//end of $("button#btn_agree").on("click", function (e) {}...

    // ====================================================================================================================== //

    // 모달 열기
    $(document).on("click", ".btn-open-modal", function () {
        openModal(this);
    });

    // 취소 버튼 또는 X 버튼으로 모달 닫기
    $(".btn-close-modal").on("click", function (e) {
        dialog = $(this).parent().parent().parent()[0];
        $(dialog).removeClass("animate-slideDown"); // 열리는 애니메이션 제거
        $(dialog).addClass("animate-slideUp"); // 닫히는 애니메이션 추가

        // 애니메이션이 끝난 후 모달 닫기
        setTimeout(() => {
            dialog.close();
            $(dialog).removeClass("animate-slideUp"); // 닫히는 애니메이션 제거
            $(dialog).addClass("animate-slideDown"); // 열리는 애니메이션 추가
        }, 300);
    });

});// end $(document).ready(function(){})----------------------






// Function Declaration
// "가입하기" 버튼 클릭시 호출되는 함수
function goRegister() {

    // === 필수 입력사항 모두 입력했는지 검사하기 시작 === //
    let b_requiredInfo = true;

    $("input.requiredInfo").each(function (index, elmt) {
        const data = $(elmt).val().trim();
        if (data == "") {
            alert("*표시된 필수 입력사항은 모두 입력하셔야 합니다.");
            b_requiredInfo = false;
            return false; // break; 라는 뜻
        }
    });


    if (!b_requiredInfo) {
        return; // goRegister() 함수 종료
    }


    // // *** 지역에 값을 입력했는지 검사하기 시작 *** //
    // arr_addressInfo.push($("input#postcode").val());
    const region_name = $("input#region_name").val().trim();

    if (region_name == "") {
        alert("우편번호 및 주소를 입력하셔야 합니다.");
        return;
    }
    // *** 우편번호 및 주소에 값을 입력했는지 검사하기 끝 *** //


    // 생년월일 입력했는지 검사하기
    const member_birth = $(`input#datepicker`).val().trim();

    if (member_birth == "") {
        alert("생년월일을 입력하셔야 합니다.");
        return;
    }


    // 약관에 동의 했는지 검사 
    const agree_checked_length = $(`input#agree_checkbox:checked`).length; // 1 나와야함

    if (agree_checked_length == 0) {
        alert("이용약관에 동의하셔야 회원가입할 수 있습니다.");
        return;
    }



    // 아이디 중복확인 클릭했는지 여부 확인
    if (!b_idcheck_click) {
        alert("아이디 중복확인을 하셔야 합니다!");
        return;
    }


    // 이메일 중복확인 클릭했는지 여부 확인
    if (!b_email_auth_click) {
        alert("이메일 중복확인을 하셔야 합니다!");
        return;
    }



    // 발송 서브밋
    const frm = document.registerFrm;
    frm.action = `${contextPath}/member/memberRegister`;
    frm.method = "post";
    frm.submit();



    // alert("회원가입 하러 갑니다.");

}// end of function goRegister() {}-------------------------





// let region_search_arr = [];   // 자동 검색된 검색어들을 실시간으로 넣어줄 배열
function ajax_search() {

    const li_id = "_a";

    // 지역 검색어 입력 ajax
    $.ajax({
        url: `${contextPath}/api/member/region/search`,
        type: "get",
        // async: false,
        data: {
            "region_name": $("input[name='region_name']").val()
        },
        dataType: "json",
        success: function (json) {
            // console.log(JSON.stringify(json));
            region_search_arr = json;
            console.log("region_search_arr => ", JSON.stringify(region_search_arr));

            // === 검색어 입력시 자동글 완성하기
            if (json.length > 0) {
                // 검색된 데이터가 있는 경우
                let v_html = `<ul>`;

                $.each(json, function (index, item) {
                    const word = item.region_name;
                    const no = item.region_no;

                    // word.toLowerCase()은 word 를 모두 소문자로 변경하는 것이다.

                    // 검색된 태그 안에 no 넣어주기
                    no_result = `<input type="hidden" name="no_result" value="${item.region_no}" />`;

                    const idx = word.toLowerCase().indexOf($("input[name='region_name']").val().toLowerCase());

                    const len = $("input[name='region_name']").val().length;

                    result = word.substring(0, idx) + "<span class='text-orange-500'>" + word.substring(idx, idx + len) + "</span>" + word.substring(idx + len);

                    v_html += `<li name='result${li_id}' class='result p-2 rounded-lg cursor-pointer hover:bg-gray-100 duration-200'>${result}${no_result}</li>`;

                });// end of $.each(json, function(index, item) {})-------------------

                v_html += `</ul>`;

                $("div#displayList").html(v_html).show(); // 보여줘라

            } else {
                $("div#displayList").html("<div class='p-2'>검색된 값이 없습니다.</div>").show();
            }//end of if (json.length > 0) {}...

        },
        error: function (request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

}//end of function ajax_search() {}...




// 약관 동의 모달 띄우기
function openModal(btnEl) {
    const targetModal = $(btnEl).data("target-modal");
    const modalId = "#modal" + targetModal;
    $(modalId)[0].showModal();
}







