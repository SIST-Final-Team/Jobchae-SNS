
let is_id_ok = false;

let is_email_ok = false; // 이메일 입력 블러 중 버튼 바로 누를 시 걸러주는 역할


const contextPath = sessionStorage.getItem("contextpath");

$(document).ready(function () {

    const func_userid = (e) => {

        const member_id = $(e.target).val().trim();

        if (member_id == "") { // 입력하지 않거나 공백만 입력했을 경우 

            $(e.target).val("");
            // $(e.target).focus();

            $("div#iderror").html("아이디는 필수입력 사항입니다.");

        }
        else { // 공백이 아닌 글자를 입력했을 경우
            const regExp_member_id = /^[a-z][A-Za-z0-9]{4,19}$/;

            // 생성된 정규표현식 객체속에 데이터를 넣어서 검사하기 
            const bool = regExp_member_id.test(member_id); // 리턴타입 boolean

            if (!bool) {
                $("div#iderror").html("");
                $(e.target).val("");
                $(e.target).focus();
                $("div#iderror").html("아이디는 형식에 맞게 입력하세요.");
                // console.log("bool => ", bool);

            } else {
                $("div#iderror").html("");
                is_id_ok = true;
            }
        }

    }// 아이디가 userid 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.

    $("input#member_id").blur((e) => { func_userid(e) });



    // 이메일 메소드
    const func_email = (e) => {

        const member_email = $(e.target).val().trim();

        if (member_email == "") {

            $(e.target).val("");
            // $(e.target).focus();

            $("div#emailerror").html("이메일은 필수입력 사항입니다.");

        } else {
            const regExp_member_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
            // 이메일 정규표현식 객체 생성

            const bool = regExp_member_email.test(member_email);

            if (!bool) {
                // 이메일이 정규표현식에 위배된 경우 
                $("div#emailerror").html("");
                $(e.target).val("").focus();
                $("div#emailerror").html("이메일 형식이 아닙니다.");
            }
            else { // 이메일이 정규표현식에 맞는 경우

                $("div#emailerror").html("");
                is_email_ok = true;

            }
        }

    };// 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.


    $("input#member_email").blur((e) => { func_email(e) });


});// end $(document).ready(function(){})----------------------





// 비밀번호 변경하기 버튼
function gopasswdFind() {

    if (!is_id_ok) {
        alert("아이디를 입력하십시오!");
        return;
    }

    if (!is_email_ok) {
        alert("이메일을 입력하십시오!");
        return;
    }

    // 아이디 찾기 전송
    const frm = document.passwdFindFrm;

    // 발송 서브밋
    frm.submit();

}//end of function goReactivation() { }...





















