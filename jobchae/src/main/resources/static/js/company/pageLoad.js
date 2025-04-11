// 이 파일은 회사 페이지 로드 시 기본적으로 필요한 기능을 구현합니다.
//먼저 회사의 정보를 가져오는 ajax 요청을 보냅니다.
// 그 후 회사의 정보를 화면에 표시합니다.

//변수 선언부
const companyName = document.querySelector("#companyName"); //회사명
const companyIndustry = document.querySelector("#companyIndustry"); //업종
const companyLocation = document.querySelector("#companyLocation"); //위치
const companyFollowerCount = document.querySelector("#companyFollowerCount"); //팔로워 수
const companySize = document.querySelector("#companySize"); //회사 규모

//회사 정보를 가져오는 ajax 함수를 정의합니다.
async function getCompanyInfo() {
  const companyNo = window.location.pathname.split("/")[4]; // url에서 회사 번호를 가져옵니다.
  const apiPath = contextPath + "/api/company/dashboard/" + companyNo; // API 경로를 설정합니다.
  const response = await fetch(apiPath, {
    method: "GET",
  });
  const data = await response.json(); // JSON 형식으로 응답을 받습니다.
  await renderCompanyInfo(data); // 받은 데이터를 화면에 표시합니다.

  //받은 데이터를 화면에 표시합니다.
}

async function renderCompanyInfo(data) {
  console.log("function data:"); // 콘솔에 출력합니다.
  console.log(data); // 콘솔에 출력합니다.
  console.log(companyIndustry); // 콘솔에 출력합니다.

  companyName.textContent = data.companyName; //회사명을 표시합니다.
  companyIndustry.textContent = data.industry.industryName; //업종을 표시합니다.
  //   companyLocation.textContent = data.location; //위치를 표시합니다.
  //   followerCount.textContent = data.followerCount; //팔로워 수를 표시합니다.
  companySize.textContent = data.companySize; //회사 규모를 표시합니다.
}

//필요한 요청에 대한 초기화 작업을 수행합니다.
getCompanyInfo(); //회사의 정보를 가져오는 ajax 요청을 보냅니다.
