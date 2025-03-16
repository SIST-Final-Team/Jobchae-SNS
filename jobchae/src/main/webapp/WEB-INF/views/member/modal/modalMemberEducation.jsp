<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<dialog id="modalMemberEducation"
    class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
    <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
        <!-- 모달 상단부 -->
        <div>
            <button type="button"
                class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
            <h1 class="h1 px-8">학력 입력</h1>

            <hr class="border-gray-200 mt-4">
        </div>

        <!-- 모달 내용 -->
        <div class="space-y-4 overflow-auto">
            <div class="text-gray-500 px-8">* 필수</div>
            <form name="memberEducationForm">
                <input type="hidden" name="member_education_no">
                <ul class="space-y-4 px-8">
                    <li>
                        <label for="school_name" class="text-gray-500">학교 *</label><br>
                        <input type="text" name="school_name" id="school_name" placeholder="예: 서울대학교"
                            data-target-url="/api/member/school/search"
                            data-search-type="school_name"
                            data-result-name="fk_school_no"
                            class="input-search w-full border-1 rounded-sm p-2 border-gray-400" />
                        <input type="hidden" name="fk_school_no" class="required"/>
                        <span class="hidden error text-red-600 text-sm">학교를 선택하세요.</span>
                    </li>
                    <li>
                        <label for="member_education_degree" class="text-gray-500">학위 *</label><br>
                        <select name="member_education_degree" class="w-full border-1 rounded-sm p-2 border-gray-400 required"
                            id="member_education_degree">
                            <option value="0">선택하세요</option>
                            <option value="1">중학교 졸업</option>
                            <option value="2">고등학교 졸업</option>
                            <option value="3">전문학사</option>
                            <option value="4">학사</option>
                            <option value="5">석사</option>
                            <option value="6">박사</option>
                        </select>
                        <span class="hidden error text-red-600 text-sm">학위를 목록에서 선택하세요.</span>
                    </li>
                    <li>
                        <label for="major_name" class="text-gray-500">전공 *</label><br>
                        <input type="text" name="major_name" id="major_name"
                            data-target-url="/api/member/major/search"
                            data-search-type="major_name"
                            data-result-name="fk_major_no"
                            class="input-search w-full border-1 rounded-sm p-2 border-gray-400" />
                        <input type="text" name="fk_major_no" class="hidden required" />
                        <span class="hidden error text-red-600 text-sm">전공을 선택하세요.</span>
                    </li>
                    <li>
                        <label class="text-gray-500">입학일 *</label><br>
                        <div class="flex gap-4">
                            <select id="member_education_startdate_year" class="select-date w-full border-1 rounded-sm p-2 border-gray-400">
                                <option value="0">연도</option>
                            </select>
                            <select id="member_education_startdate_month"
                                class="select-date w-full border-1 rounded-sm p-2 border-gray-400">
                                <option value="0">월</option>
                                <option value="01">1월</option>
                                <option value="02">2월</option>
                                <option value="03">3월</option>
                                <option value="04">4월</option>
                                <option value="05">5월</option>
                                <option value="06">6월</option>
                                <option value="07">7월</option>
                                <option value="08">8월</option>
                                <option value="09">9월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </div>
                        <input type="hidden" name="member_education_startdate" class="required"/>
                        <span class="hidden error text-red-600 text-sm">입학일을 선택하세요.</span>
                    </li>
                    <li>
                        <label class="text-gray-500">졸업일(예정) *</label><br>
                        <div class="flex gap-4">
                            <select id="member_education_enddate_year"
                                class="select-date w-full border-1 rounded-sm p-2 border-gray-400">
                                <option value="0">연도</option>
                            </select>
                            <select id="member_education_enddate_month"
                                class="select-date w-full border-1 rounded-sm p-2 border-gray-400">
                                <option value="0">월</option>
                                <option value="01">1월</option>
                                <option value="02">2월</option>
                                <option value="03">3월</option>
                                <option value="04">4월</option>
                                <option value="05">5월</option>
                                <option value="06">6월</option>
                                <option value="07">7월</option>
                                <option value="08">8월</option>
                                <option value="09">9월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </div>
                        <input type="hidden" name="member_education_enddate" class="required"/>
                        <span class="hidden error text-red-600 text-sm">졸업일을 선택하세요.</span>
                    </li>
                    <li>
                        <label for="member_education_grade" class="text-gray-500">학점 *</label><br>
                        <input type="number" name="member_education_grade" id="member_education_grade" placeholder="예: 3.5"
                            class="w-full border-1 rounded-sm p-2 border-gray-400 required" min=2.0 max=4.5/>
                            <span class="hidden error text-red-600 text-sm">학점을 선택하세요.</span>
                    </li>
                    <li>
                        <label for="member_education_explain" class="text-gray-500">설명</label><br>
                        <textarea name="member_education_explain" id="member_education_explain"
                            class="w-full h-40 border-1 rounded-sm p-2 border-gray-400 resize-none"></textarea>
                    </li>
                </ul>
            </form>
        </div>

        <!-- 모달 하단부 -->
        <div>
            <hr class="border-gray-200 mb-4">
            <div class="flex justify-between items-center px-4">
                <div>
                    <button type="button" id="deleteMemberEducation" class="btn-transparent">학력 삭제</button>
                </div>
                <div>
                    <button type="button" id="submitMemberEducation" class="button-selected">저장</button>
                </div>
            </div>
        </div>
    </div>
</dialog>