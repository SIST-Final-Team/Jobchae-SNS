

is_email_send = false; // 이메일 보냈는지

is_email_auth = false; // 이메일 인증번호 맞는지

const contextpath = sessionStorage.getItem("contextpath"); // 헤더에 추가한 컨텍스트패스

$(document).ready(function () {

    // 아이디 input 잠금
    $(`input#member_id`).attr("readonly", true);
    // 이메일 intput 잠금
    $(`input#member_email`).attr("readonly", true);


    // 인증번호 확인 버튼 클릭했을 시 이메일 발송 이벤트 처리하기 
    $(`button#emailSend`).click(function (e) {

		is_email_send = false; // 또 클릭하면 자기 자신의 전송도 일단 거짓으로 만들자
		is_email_auth = false; // 이메일 인증까지 받아놓고 또 이메일 보내기 누르면 기존 인증번호를 없애야한다.
		$(`div#email_authResult`).html("");
		
        $.ajax({
            url: `${contextpath}/api/member/emailSend`, //             
            data: { "member_email": $(`input#member_email`).val() }, // // data 속성은 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로 전송해야할 데이터를 말한다.
            type: "post",  // 빼면 get 방식
            async: true,       // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
            // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
            dataType: "json", // Javascript Standard Object Notation.  dataType은 /MyMVC/member/idDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
            // 만약에 dataType:"xml" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
            // 만약에 dataType:"json" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 json 형식이어야 한다.

            success: function (json) { //    

                if (!json["sendMailSuccess"]) {
                    // 인증번호 메일 발송 실패
                    $(`div#emailSendResult`).html(`인증번호를 발송하지 못했습니다!`).css({ "color": "red" });
                } else {
                    // 인증번호 발송
                    $(`div#emailSendResult`).html(`인증번호를 발송했습니다!`).css({ "color": "blue" });
                    is_email_send = true; // 인증번호 발송성공!
                    $(`.hide_emailAuth`).slideDown(); // 인증번호 칸 나타내기
                }
            }
            ,
            error: function (request, status, error) { // 코딩이 잘못되어지면 어디가 잘못되어졌는지 보여준다!
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });

    });//end of $(`button#btn_email_auth`).click(function (e) { }...




    // 인증번호 확인 버튼 클릭했을 시 이벤트 처리하기 
    $(`button#btn_email_auth`).click(function (e) {

        if (is_email_send == false) {
            alert("인증번호 발송 실패하였습니다. 나중에 다시 시도해주십시오.");
            return;

        } else { // true 여야 데이터 베이스에 들어감
            $.ajax({
                url: `${contextpath}/api/member/emailAuth`,
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
	

});//end of ready...



// 휴면계정 복구하기 버튼
function goReactivation() {

    if (!is_email_send) {
		alert("이메일 인증 후 휴면계정 해제가 가능합니다.");
        return;
    }

    if (!is_email_auth) {
		alert("인증번호 인증 후 휴면계정 해제가 가능합니다.");
		return;
    }



	// 휴면 계정 복구 전송
	const frm = document.reactivationFrm;

	// 발송 서브밋
	frm.action = `${contextpath}/member/memberReactivation`;
	frm.method = "post";
	frm.submit();

}//end of function goReactivation() { }...
























