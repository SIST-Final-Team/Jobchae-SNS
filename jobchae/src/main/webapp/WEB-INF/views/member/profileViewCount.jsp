<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

<%-- TailWind 사용자 정의 CSS --%>
<jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />

<%-- Highchart --%>
<style type="text/css">
.highcharts-figure,
.highcharts-data-table table {
    min-width: 360px;
    max-width: 800px;
    margin: 1em auto;
}

.highcharts-data-table table {
    font-family: Verdana, sans-serif;
    border-collapse: collapse;
    border: 1px solid #ebebeb;
    margin: 10px auto;
    text-align: center;
    width: 100%;
    max-width: 500px;
}

.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}

.highcharts-data-table th {
    font-weight: 600;
    padding: 0.5em;
}

.highcharts-data-table td,
.highcharts-data-table th,
.highcharts-data-table caption {
    padding: 0.5em;
}

.highcharts-data-table thead tr,
.highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}

.highcharts-data-table tr:hover {
    background: #f1f7ff;
}
</style>
<script src="${pageContext.request.contextPath}/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="${pageContext.request.contextPath}/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="${pageContext.request.contextPath}/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="${pageContext.request.contextPath}/Highcharts-10.3.1/code/modules/accessibility.js"></script>

<script type="text/javascript">
$(document).ready(function() {

    getViewCount("프로필 조회 수", "profileViewCountContainer", "profile", "2"); // 프로필 조회
    getViewCount("업데이트 노출 수", "boardViewCountContainer", "board", "1"); // 업데이트 노출
    getViewCount("검색결과 노출 수", "searchProfileViewCountContainer", "profile", "1"); // 검색결과 노출
});

function fillMissingData(json, daysBefore) {
    const today = new Date();
    const viewCounts = {};
    const viewCountDates = [];

    // daysBefore 일 전까지의 날짜를 YYYY-MM-DD 형식으로 생성
    for (let i = daysBefore; i >= 0; i--) {
        const date = new Date(today);
        date.setDate(today.getDate() - i);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더함
        const day = String(date.getDate()).padStart(2, '0');
        const formattedDate = `\${year}-\${month}-\${day}`;
        viewCountDates.push(formattedDate);
        viewCounts[formattedDate] = 0; // 초기값 0으로 설정
    }

    // JSON 데이터를 순회하면서 viewCounts 객체 업데이트
    json.forEach(item => {
        viewCounts[item.viewCountRegisterDate] = item.viewCount;
    });

    // 최종 결과 배열 생성
    const filledViewCounts = viewCountDates.map(date => viewCounts[date]);

    return {
        viewCountDates: viewCountDates,
        viewCounts: filledViewCounts
    };
}

function getViewCount(name, resultContainerId, viewCountTargetType, viewCountType) {

    $.ajax({
        url: "${pageContext.request.contextPath}/api/history/view-count",
        data: {"viewCountTargetType" : viewCountTargetType
                ,"viewCountType" : viewCountType},
        dataType: "json",
        success: function (json) {
            console.log(JSON.stringify(json));

            if(json.length > 0) {

                // 6일 전까지의 데이터를 채우기
                const filledData = fillMissingData(json, 6);

                const viewCountDates = filledData.viewCountDates;
                const viewCounts = filledData.viewCounts;

                Highcharts.chart(resultContainerId, {
                    chart: {
                        type: 'line'
                    },
                    title: {
                        text: name
                    },
                    subtitle: {
                        text: ''
                    },
                    xAxis: {
                        categories: viewCountDates
                    },
                    yAxis: {
                        title: {
                            text: name
                        }
                    },
                    plotOptions: {
                        line: {
                            dataLabels: {
                                enabled: true
                            },
                            enableMouseTracking: false
                        }
                    },
                    series: [{
                        name: name,
                        data: viewCounts
                    }]
                });
            }
            else {
                $("#"+resultContainerId).html(`<span class="block pb-2">조회된 정보가 없습니다.</span>`);
            }

        },
        error: function (request, status, error) {
            console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }


    });
}

</script>

    <!-- 본문 -->
    <div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px]">

        <!-- 중앙 본문 -->
        <div class="center col-span-14 md:col-span-10 space-y-2 my-5">
            <div class="scroll-mt-22 border-board">

                <!-- 프로필 조회 -->
                <div id="profileViewCount">
                    <div class="flex items-center">
                        <h1 class="h1 flex-1">프로필 조회</h1>
                    </div>

                    <div id="profileViewCountContainer"></div>
                </div>

                <!-- 업데이트 노출 -->
                <div id="boardViewCount">
                    <div class="flex items-center">
                        <h1 class="h1 flex-1">업데이트 노출</h1>
                    </div>

                    <div id="boardViewCountContainer"></div>
                </div>

                <!-- 검색결과 노출 -->
                <div id="searchProfileViewCount">
                    <div class="flex items-center">
                        <h1 class="h1 flex-1">검색결과 노출</h1>
                    </div>

                    <div id="searchProfileViewCountContainer"></div>
                </div>
            </div>
        </div>

        <!-- 우측 광고 -->
        <div class="right-side lg:col-span-4 h-full relative hidden lg:block -z-1">
            <div class="border-list sticky top-20 space-y-2 text-center relative">
                <div class="absolute top-5 right-5 bg-white rounded-sm text-[0.9rem]">
                    <span class="pl-1.5 font-bold">광고</span>
                    <button type="button" class="font-bold hover:bg-gray-100 cursor-pointer px-1.5 py-1 rounded-r-sm"><i class="fa-solid fa-ellipsis"></i></button>
                </div>
                <div>
                    <img src="7.png"/>
                </div>
                <div class="px-4">
                    <p class="font-bold">준영님, Tridge의 관련 채용공고를 살펴보세요.</p>
                    <p>업계 최신 뉴스와 취업 정보를 받아보세요.</p>
                </div>
                <div class="px-4">
                    <button type="button" class="button-orange">팔로우</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>