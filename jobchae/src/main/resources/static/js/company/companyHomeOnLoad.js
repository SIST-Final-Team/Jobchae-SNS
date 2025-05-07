//이 페이지는 페이지가 처음 로딩되었을 때 필요한 데이터를 가져오는 스크립트입니다.
//필요한 데이터에는 회사의 데이터가 있습니다.
//그리고 최초 페이지 로드시 주소의 메뉴 값을 가져와서 해당하는 메뉴를 보여줍니다.

/*
companyExplain
: 
"미래 IT인재의 요람 쌍용교육센터는,10년 이상의 실무경력을 갖춘 우수한 강사진과 최신교육시설,실무중심의 커리큘럼으로 현장 맞춤형 인재를 양성합니다.\n쌍용교육센터는 1985년부터 다양한 컴퓨터 교육서비스를 제공하며 IT분야로 취업을 원하는 많은 취업 준비생을 취업의 길로 이끌어 온 IT전문 교육기관입니다.\n오랜 기간 동안 축적된 교육운영 노하우를 바탕으로 체계적이고 안정적인 환경에서 전문인재 양성을 하여 6만 명 이상의 수료생을 배출하였고,현업에서 쌍용교육센터 출신 IT전문가들이 다방면에서 역량을 발휘하고 있습니다.\n쌍용교육센터는 전 직원 모두가 한마음이 되어 훈련생 여러분을 정직하게 교육시키고,양질의 교육을 제공하여 여러분의 취업과 자기계발을 위하여 도움이 되도록 최선을 다하겠습니다.\n세상의 중심에서 역량을 펼쳐 나아갈 여러분의 도전을 응원합니다."
companyLogo
: 
null
companyName
: 
"쌍용강북교육센터"
companyNo
: 
1
companyRegisterDate
: 
"2025-03-10T18:00:39.000+00:00"
companySize
: 
6
companyStatus
: 
1
companyType
: 
6
companyWebsite
: 
"https://www.sist.co.kr/index.jsp"
fkMemberId
: 
"dltnstls89"
industry
: 
industryName
: 
"IT 및 소프트웨어 - 소프트웨어 개발"
industryNo
: 
1
[[Prototype]]
: 
Object
member
: 
null
*/
//페이지 초기 로딩 시 주소의 메뉴 값을 가져와서 해당하는 메뉴를 보여줍니다.

//내용물을 보여줄 div
const contentDiv = document.getElementById("contentDiv");

//회사의 데이터를 저장하는 모듈
//변수에 함수를 담아서 외부에서 접근할 수 있도록 합니다.
//이렇게 하면 외부에서 data에 직접 접근할 수 없고, getData()와 setData() 함수를 통해서만 접근할 수 있습니다.
//변수 = (function())() 형태는 함수를 즉시 실행하는 함수 표현식(IIFE)이라고 합니다.
const companyData = (function () {
  //회사의 데이터를 저장할 변수를 선언합니다.
  let data = null;
  //게터 세터 함수를 반환해서 외부에서 접근할 수 있도록 합니다.
  return {
    setData: function (data) {
      this.data = data;
    },
    getData: function () {
      return this.data;
    },
  };
})();

window.onload = function () {
  //주소를 가져온다
  const addressUrl = window.location.pathname;

  //주소에서 메뉴 값을 가져온다
  const menu = addressUrl.split("/")[5];
  const companyId = addressUrl.split("/")[3];

  getContent(menu, contentDiv);
  changeMenuStyle(menu);

  //회사의 데이터를 가져온다.
  getCompanyData(companyId)
    //데이터 가져오는 함수가 성공적으로 데이터를 가져오면
    .then((data) => {
      //회사의 데이터를 가져온 후에 companyData에 저장합니다.
      companyData.setData(data);
      console.log("Company Data:", companyData.getData());

      //회사의 이름을 표시한다.
      const companyName = document.getElementById("companyName");
      console.log("companyName:", companyData.getData().companyName);
      companyName.textContent = companyData.getData().companyName;
    })
    .catch((error) => {
      console.error("Error fetching content:", error);
    });
};

//ajax 요청을 통해서 회사의 데이터를 가져옵니다.
async function getCompanyData(companyId) {
  const response = await fetch(
    `${contextPath}/api/company/selectAdminCompnay/${companyId}`
  );
  const data = await response.json();
  return data;
}
