const fileInput = document.getElementById("logo-upload");
const uploadArea = document.getElementById("upload-area");
const previewArea = document.getElementById("preview-area");
const thumbnailPreview = document.getElementById("thumbnail-preview");
const fileNameSpan = document.getElementById("file-name");
const fileSizeSpan = document.getElementById("file-size");
const deleteButton = document.getElementById("delete-button");

// 파일 입력(input) 값이 변경되었을 때 실행될 함수
fileInput.addEventListener("change", function (event) {
  const file = event.target.files[0]; // 선택된 파일 가져오기

  if (file) {
    // 파일이 선택되었다면
    // 파일 정보 읽기
    const reader = new FileReader();

    reader.onload = function (e) {
      // 썸네일 이미지 설정
      thumbnailPreview.src = e.target.result;

      // 파일 이름 설정
      fileNameSpan.textContent = file.name;

      // 파일 크기 설정 (KB 단위, 소수점 1자리)
      const fileSizeKB = (file.size / 1024).toFixed(1);
      fileSizeSpan.textContent = `${fileSizeKB}KB`;

      // 영역 전환: 초기 영역 숨기고 미리보기 영역 보여주기
      uploadArea.classList.add("hidden"); // Tailwind hidden 클래스 추가
      previewArea.classList.remove("hidden"); // Tailwind hidden 클래스 제거
      previewArea.classList.add("flex"); // display: flex 활성화 (Tailwind)
    };

    // 파일을 읽어서 Data URL 형태로 변환
    reader.readAsDataURL(file);
  }
});

// 삭제 버튼(X) 클릭 시 실행될 함수
deleteButton.addEventListener("click", function () {
  // 파일 입력 필드 값 초기화
  fileInput.value = null;

  // 썸네일 이미지 초기화 (선택 사항)
  thumbnailPreview.src = "#"; // 빈 값 또는 기본 이미지 경로

  // 영역 전환: 미리보기 영역 숨기고 초기 영역 보여주기
  previewArea.classList.add("hidden"); // Tailwind hidden 클래스 추가
  previewArea.classList.remove("flex"); // display: flex 비활성화
  uploadArea.classList.remove("hidden"); // Tailwind hidden 클래스 제거
});

//업종 리스트 보여주기---------------------------------------------------------------------------
//업종 리스트 보여주기의 과정
//처리에 필요한 변수들 생성 - 업종 리스트 불러오기 - 지연 함수 생성(요청 과부하 방지)
//필요한 이벤트 리스너 추가 - 입력시 업종 리스트 보여주기 - 업종 리스트 선택시 값 변경

//필요한 변수 선언
const industryName = document.getElementById("industryName");
const listDiv = document.getElementById("listDiv");
const optionList = document.getElementById("optionList");
let industryList = [];

//업종 리스트 불러오기
fetch(`${contextPath}/api/industry/list`)
  .then((response) => {
    if (response.ok) {
      // 응답이 성공적일 경우 JSON으로 변환
      return response.json();
    } else {
      throw new Error("업종 리스트를 불러오는 데 실패했습니다.");
    }
  })
  .then((data) => {
    //반환된 데이터로 업종 리스트를 생성
    const list = Array.from(data); // 데이터 배열로 변환
    ////업종 이름들을 담을 배열 생성
    list.forEach((element) => {
      industryList.push(element.industryName);
    });
    console.log(industryList); //업종 리스트 확인
  })
  .catch((error) => {
    console.error("Error:", error);
  });

//지연처리 함수
const debounce = (func, delay) => {
  let timeout;
  return function (...args) {
    clearTimeout(timeout);
    timeout = setTimeout(() => {
      func.apply(this, args);
    }, delay);
  };
};

//지연처리 함수 생성
const debounced = debounce(function (inputValue) {
  //실제 로직 처리 시작
  if (this.length > 0) {
    //일치하는 업종리스트가 있으면
    const filteredList = industryList.filter((item) => item.includes(this));
    if (filteredList.length > 0) {
      console.log("업종 리스트에 포함된 업종입니다.");
    }
  }
}, 500);

//이벤트 리스너 추가
industryName.addEventListener("input", (e) => {
  const inputValue = e.target.value;
  //지연함수 호출
  debounced.call(inputValue);
});

//업종 리스트 보여주기 끝---------------------------------------------------

//전역 클릭시 실행되는 이벤트 리스너
document.addEventListener("click", (e) => {
  //만약 업종 관련 부분 이외에 클릭이 발생하면 업종 리스트를 숨김
  if (e.target.id != "listDiv" && e.target.id != "industryName") {
    //만약 업종리스트가 보이고 있다면 숨김
    if (!listDiv.classList.contains("hidden")) {
      listDiv.classList.add("hidden"); //업종 리스트 숨기기
    }
  }
});
