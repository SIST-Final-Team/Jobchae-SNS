
let is_id_ok = false; // 아이디 입력 블러 중 버튼 바로 누를 시 걸러주는 역할

let is_email_ok = false; // 이메일 입력 블러 중 버튼 바로 누를 시 걸러주는 역할

let b_idcheck_click = false; // 아이디 중복확인 버튼 클릭했는지 여부

// let b_email_click = false; // 이메일 중복확인 버튼 클릭했는지 여부

let b_email_auth_click = false; // 인증버튼 클릭했는지 여부

let is_email_auth = false; // 인증번호를 인증 받았는지 여부

// 컨텍스트 패스
const contextPath = sessionStorage.getItem("contextpath");


$(document).ready(function () {

    // $("div.error").hide();
    $("input#member_id").focus();

    // $("input#name").bind("blur", function(e){ alert("name 에 있던 포커스를 잃어버렸습니다."); }); 
    // 또는
    // $("input#name").blur(function(e){ alert("name 에 있던 포커스를 잃어버렸습니다."); }); 


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
            $(`telerror`).html("휴대폰 형식이 아닙니다.");
        }
        else {
            // 마지막 전화번호 4자리가 정규표현식에 맞는 경우
            $(`telerror`).html("");
            $("input#member_tel").val($("input#hp1").val() + $("input#hp2").val() + $("input#hp3").val()); // 만들어라
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
            url: `${contextPath}/member/idDuplicateCheck`, //              /member/ 까진 똑같아서 제외함
            data: { "member_id": $(`input#member_id`).val() }, // data 속성은 http://localhost:9090/MyMVC/member/idDuplicateCheck.up 로 전송해야할 데이터를 말한다.
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
                url: `${contextPath}/member/emailCheck_Send`, //              /member/ 까진 똑같아서 제외함
                data: { "member_email": $(`input#member_email`).val() }, // // data 속성은 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로 전송해야할 데이터를 말한다.
                type: "post",  // 빼면 get 방식
                async: true,       // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
                dataType: "json", // Javascript Standard Object Notation.  dataType은 /MyMVC/member/idDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
                // 만약에 dataType:"xml" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
                // 만약에 dataType:"json" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 json 형식이어야 한다.

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

        } else { // true 여야 데이터 베이스에 들어감
            $.ajax({
                url: `${contextPath}/member/emailAuth`, //              /member/ 까진 똑같아서 제외함
                data: { "email_auth_text": $(`input#email_auth`).val() }, // data 속성은 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로 전송해야할 데이터를 말한다.
                type: "post",  // 빼면 get 방식
                async: true,       // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
                dataType: "json", // Javascript Standard Object Notation.  dataType은 /MyMVC/member/idDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
                // 만약에 dataType:"xml" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
                // 만약에 dataType:"json" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 json 형식이어야 한다.

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

    // 지역 검색어 입력 시
    $("input[name='member_region']").keyup(function (e) {

        // 변경될 때마다 $("input[name='member_region_no']").val(); 값을 초기화 해준다.
        $("input[name='member_region_no']").val("");

        const wordLength = $(this).val().trim().length; // 검색어에서 공백을 제외한 길이

        if (wordLength == 0) {
            $("div#displayList").hide();
            // 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다.
        } else {
            ajax_search(); // 지역 검색

        }//end of if else (wordLength == 0) {}...

        // 문장 입력 후 엔터를 선택 시 값 넣어주기
        if (e.keyCode == 13) { // 엔터
            // console.log("검색되는 인풋값 => " ,$("input[name='member_region']").val());

            ajax_search_keyWord();
        }//


    });//end of $("input[name='member_region']").keyup(function (e) {}...


    // 검색어 입력시 자동글 완성하기
    $(document).on("click", "span.result", function (e) {

        const word = $(e.target).text();
        const no = $(e.target).children("input[name='no_result']").val();
        // $("input[name='no_result']").val();
        $("input[name='member_region']").val(word); // 텍스트 박스에 검색된 결과의 문자열을 입력해준다.
        $("input[name='member_region_no']").val(no);
        $("div#displayList").hide();
        // console.log("히든 인풋태그 번호 => ", $("input[name='member_region_no']").val());

    });//end of $(document).on("click", "span.result", function(e) {}...



    // // 지역 검색 시 히든 input 태그 안에 번호가 없다면 예외처리
    // $(document).on("keyup", "input[name='member_region']", function(e) {

    //     if(e.keyCode == 13) { // 엔터
    //        // 에이젝스 실행
    //     }//

    // });//    











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

    });//end of $("button#btn_agree").on("click", function (e) {}...


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
    const member_region = $("input#member_region").val().trim();

    if (member_region == "") {
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
    frm.action = "/member/memberRegister";
    frm.method = "post";
    frm.submit();



    // alert("회원가입 하러 갑니다.");

}// end of function goRegister() {}-------------------------





function ajax_search() {

    // 지역 검색어 입력 ajax
    $.ajax({
        url: `${contextPath}/member/regionSearch`,
        type: "get",
        data: {
            "member_region": $("input[name='member_region']").val()
        },
        dataType: "json",
        success: function (json) {
            console.log(JSON.stringify(json));

            // === #93 검색어 입력시 자동글 완성하기
            if (json.length > 0) {
                // 검색된 데이터가 있는 경우
                let v_html = ``;

                $.each(json, function (index, item) {
                    const word = item.region_name;
                    // word.toLowerCase()은 word 를 모두 소문자로 변경하는 것이다.

                    // 검색된 태그 안에 no 넣어주기
                    no_result = `<input type="hidden" name="no_result" value="${item.region_no}" />`;

                    const idx = word.toLowerCase().indexOf($("input[name='member_region']").val().toLowerCase());

                    const len = $("input[name='member_region']").val().length;

                    result = word.substring(0, idx) + "<span style='color:blue;'>" + word.substring(idx, idx + len) + "</span>" + word.substring(idx + len);

                    v_html += `<span style='cursor:pointer;' class='result'>${result}${no_result}</span><br>`;

                });// end of $.each(json, function(index, item) {})-------------------

                $("div#displayList").html(v_html).show(); // 보여줘라

            } else {
                $("div#displayList").hide();
            }//end of if (json.length > 0) {}...

        },
        error: function (request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

}//end of function ajax_search() {}...







// 키워드 바로 엔터시 예외처리 함수
function ajax_search_keyWord() {

    // 지역 검색어 직접 입력 ajax
    $.ajax({
        url: `${contextPath}/member/regionKeyWordSearch`,
        type: "get",
        data: {
            "member_region": $("input[name='member_region']").val()
        },
        dataType: "json",
        success: function (json) {
            console.log(JSON.stringify(json));

            // === 검색어 입력시 직접 검색된 값 넣어주기
            if (json.word != null) { // null 대신 넣었다.
                $("div#regionerror").html("").hide();
                $("input[name='member_region_no']").val(json.no);
                $("div#displayList").hide(); // 검색창 감추기

            } else {
                $("div#regionerror").html(`목록에 있는 지역만 입력해주십시오!`).css({ "color": "red" }).show();
            }//end of if (json.length > 0) {}...

        },
        error: function (request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

}//end of function ajax_search_keyWord() {}...














