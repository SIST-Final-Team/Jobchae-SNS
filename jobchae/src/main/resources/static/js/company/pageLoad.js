// 이 파일은 회사 페이지 로드 시 기본적으로 필요한 기능을 구현합니다.
//먼저 회사의 정보를 가져오는 ajax 요청을 보냅니다.
// 그 후 회사의 정보를 화면에 표시합니다.
//변수 선언부
const companyName = document.querySelector("#companyName"); //회사명
const companyIndustry = document.querySelector("#companyIndustry"); //업종
const companyLocation = document.querySelector("#companyLocation"); //위치
const companyFollowerCount = document.querySelector("#companyFollowerCount"); //팔로워 수
const companySize = document.querySelector("#companySize"); //회사 규모
const companyLogo = document.querySelector("#company-profile-logo"); //회사 로고
const webLinkButton = document.querySelector("#webLinkButton"); //웹사이트 링크 버튼
const companyBackgroundImg = document.querySelector("#company-background-img"); //회사 프로필의 백그라운드 이미지
let companyData = null; //회사 데이터
let companySizeText = null; //회사 규모 텍스트
/*
 <select id="companySize" name="companySize">
              <option value="1">규모 선택</option>
              <option value="2">0-1</option>
              <option value="3">2-10</option>
              <option value="4">11-50</option>
              <option value="5">51-200</option>
              <option value="6">201-500</option>
              <option value="7">501-1000</option>
              <option value="8">1001-5000</option>
              <option value="9">5001-10000</option>
              <option value="10">10000+</option></select
            ><br /><br />
*/

//회사 정보를 가져오는 ajax 함수를 정의합니다.
async function getCompanyInfo() {
  const companyNo = window.location.pathname.split("/")[4]; // url에서 회사 번호를 가져옵니다.
  const apiPath = contextPath + "/api/company/dashboard/" + companyNo; // API 경로를 설정합니다.
  const response = await fetch(apiPath, {
    method: "GET",
  });
  const data = await response.json(); // JSON 형식으로 응답을 받습니다.
  await renderCompanyInfo(data); // 받은 데이터를 화면에 표시합니다.
  companyData = data; // 회사 데이터를 저장합니다.

  //받은 데이터를 화면에 표시합니다.
}

async function renderCompanyInfo(data) {
  companyName.textContent = data.companyName; //회사명을 표시합니다.
  companyIndustry.textContent = data.industry.industryName; //업종을 표시합니다.
  //   companyLocation.textContent = data.location; //위치를 표시합니다.
  //   followerCount.textContent = data.followerCount; //팔로워 수를 표시합니다.
  companySize.textContent = data.companySize; //회사 규모를 표시합니다.

  //회사의 로고를 표시합니다.
  //회사의 로고가 없을 경우 기본 로고를 표시합니다.
  if (data.companyLogo == null) {
    const logoPath = contextPath + "/images/no_company_logo.jpg";
    console.log("no company logo"); // 콘솔에 출력합니다.
    console.log(logoPath); // 콘솔에 출력합니다.
    companyLogo.src = logoPath; //회사 로고를 표시합니다.
  } else {
    const logoPath =
      contextPath + "/resources/files/companyLogo/" + data.companyLogo;
    companyLogo.src = logoPath; //회사 로고를 표시합니다.
  }

  //회사 프로필의 백그라운드 이미지를 설정합니다.
  companyBackgroundImg.src =
    contextPath + "/resources/files/profile/default/background_img.jpg";
  //웹사이트 링크 버튼을 클릭했을 때 회사의 웹사이트로 이동합니다.
  console.log(webLinkButton); // 콘솔에 출력합니다.
  webLinkButton.href = data.companyWebsite; //웹사이트 링크를 설정합니다.

  //숫자에 따라 회사 규모를 표시합니다.
  switch (data.companySize) {
    case 0:
      companySize.textContent = "규모 선택";
      break;
    case 1:
      companySize.textContent = "0-1";
      companySizeText = "0-1";
      break;
    case 2:
      companySize.textContent = "2-10";
      companySizeText = "2-10";
      break;
    case 3:
      companySize.textContent = "11-50";
      companySizeText = "11-50";
      break;
    case 4:
      companySize.textContent = "51-200";
      companySizeText = "51-200";
      break;
    case 5:
      companySize.textContent = "201-500";
      companySizeText = "201-500";
      break;
    case 6:
      companySize.textContent = "501-1000";
      companySizeText = "501-1000";
      break;
    case 7:
      companySize.textContent = "1001-5000";
      companySizeText = "1001-5000";
      break;
    case 8:
      companySize.textContent = "5001-10000";
      companySizeText = "5001-10000";
      break;
    case 9:
      companySize.textContent = "10000+";
      companySizeText = "10000+";
      break;
    default:
      companySize.textContent = "규모 선택";
  }
}

//필요한 요청에 대한 초기화 작업을 수행합니다.
// getCompanyInfo(); //회사의 정보를 가져오는 ajax 요청을 보냅니다.
