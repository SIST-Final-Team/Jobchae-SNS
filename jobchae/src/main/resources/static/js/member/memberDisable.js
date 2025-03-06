

let isExist = false; // 본인확인 완료면

const contextPath = sessionStorage.getItem("contextpath");


$(document).ready(function () {

    // // 동의 체크박스
    // $("input#agreeCheck").click(function (e) { 
    //     console.log("checkbox => ", $(e.target).prop("checked"));
    // });

    // const checkbox = $("input#agreeCheck").prop('checked');
    // console.log("checkbox => ", checkbox);


    // 본인확인 버튼 클릭 후 비밀번호 변경 시 인증 초기화 용도
    $(`input#member_passwd`).change(function (e) {
        isExist = false;
        $(`span#isExist`).html("").hide();

    });//end of $(`span#email`).click(function (e) { }...







});//end of ready...




// 회원 확인 메소드
function isExistMember() {

    $.ajax({
        url: `${contextPath}/api/member/isExistMember`, //     
        data: {
            "member_id": $(`input#member_id`).val(),
            "member_passwd": $(`input#member_passwd`).val()
        },
        type: "post",
        async: true,       
        dataType: "json", 

        success: function (json) { //   
            if (json["isExists"]) {
                // 본인확인완료
                $(`span#isExist`).html(`본인확인 완료`).css({ "color": "blue" }).show();
                isExist = true;
            } else {
                // 본인이 아님
                $(`span#isExist`).html(`본인이 아닙니다.`).css({ "color": "red" }).show();
            }
        }
        ,
        error: function (request, status, error) { // 코딩이 잘못되어지면 어디가 잘못되어졌는지 보여준다!
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

}//end of function isExistMember(params) {}...





function gomemberDisable() {

    if ($("input#agreeCheck").prop("checked") == false) {
        alert("처리사항 안내 확인 동의를 해주십시오.");
        return;
    }

    if (!isExist) {
        alert("본인인증을 해주십시오.");
        return;
    }

    // 
    if (confirm("정말로 회원을 탈퇴하시겠습니까?")) {

        // 발송 서브밋
        const frm = document.memberDisableFrm;
        frm.action = `${contextPath}/member/memberDisable`;
        frm.method = "post";
        frm.submit();

    } else {
        location.href = `${contextPath}/board/feed`;
        // 
    }

}//end of function gomemberDisable() {}...
















