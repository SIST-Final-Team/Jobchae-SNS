<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<dialog id="modalMemberCareer"
    class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
    <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
        <!-- 모달 상단부 -->
        <div>
            <button type="button"
                class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
            <h1 class="h1 px-8">경력 입력</h1>

            <hr class="border-gray-200 mt-4">
        </div>

        <!-- 모달 내용 -->
        <div class="space-y-4 overflow-auto">
            <div class="text-gray-500 px-8">* 필수</div>
            <form name="memberCareerForm">
                <input type="hidden" name="member_career_no">
                <ul class="space-y-4 px-8">
                    <li>
                        <label for="job_name" class="text-gray-500">직종 *</label><br>
                        <input type="text" name="job_name" id="job_name"
                            data-target-url="/api/member/job/search"
                            data-search-type="job_name"
                            data-result-name="fk_job_no"
                            class="input-search w-full border-1 rounded-sm p-2 border-gray-400" />
                        <input type="hidden" name="fk_job_no" class="required"/>
                        <span class="hidden error text-red-600 text-sm">직종을 목록에서 선택하세요.</span>
                    </li>
                    <li>
                        <label for="member_career_type" class="text-gray-500">고용 형태 *</label><br>
                        <select name="member_career_type" class="w-full border-1 rounded-sm p-2 border-gray-400 required"
                            id="member_career_type">
                            <option value="0">선택하세요</option>
                            <option value="1">정규직</option>
                            <option value="2">시간제</option>
                            <option value="3">자영업/개인사업</option>
                            <option value="4">프리랜서</option>
                            <option value="5">계약직</option>
                            <option value="6">인턴</option>
                            <option value="7">수습생</option>
                            <option value="8">시즌</option>
                        </select>
                        <span class="hidden error text-red-600 text-sm">고용 형태를 목록에서 선택하세요.</span>
                    </li>
                    <li>
                        <label for="member_career_company" class="w-14 text-gray-500">회사 또는 단체 *</label><br>
                        <div class="relative">
                            <input type="text" name="member_career_company" id="member_career_company"
                            data-target-url="/api/member/company/search"
                            data-search-type="company_name"
                            data-result-name="fk_company_no"
                            class="input-search w-full border-1 rounded-sm p-2 border-gray-400 required"/>
                            <span class="hidden error text-red-600 text-sm">회사 또는 단체를 입력하세요.</span>
                        </div>
                        <input type="hidden" name="fk_company_no"/>
                    </li>
                    <li class="flex items-center gap-2">
                        <input type="checkbox" name="member_career_is_current" value="1" style="zoom:1.5;" class="accent-orange-600 opacity-60 required" id="member_career_is_current"/>
                        <label for="member_career_is_current" class="text-lg pb-0.5">현재 이 업무로 근무 중</label>
                    </li>
                    <li>
                        <label class="text-gray-500">시작일 *</label><br>
                        <div class="flex gap-4">
                            <select id="member_career_startdate_year" class="select-date w-full border-1 rounded-sm p-2 border-gray-400">
                                <option value="0">연도</option>
                            </select>
                            <select id="member_career_startdate_month" class="select-date w-full border-1 rounded-sm p-2 border-gray-400">
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
                        <input type="hidden" name="member_career_startdate"class="required"/>
                        <span class="hidden error text-red-600 text-sm">시작일을 선택하세요.</span>
                    </li>
                    <li>
                        <label class="text-gray-500">종료일 *</label><br>
                        <div class="flex gap-4">
                            <select id="member_career_enddate_year"
                                class="select-date w-full border-1 rounded-sm p-2 border-gray-400 disabled:border-0 disabled:bg-gray-200">
                                <option value="0">연도</option>
                            </select>
                            <select id="member_career_enddate_month"
                                class="select-date w-full border-1 rounded-sm p-2 border-gray-400 disabled:border-0 disabled:bg-gray-200">
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
                        <input type="hidden" name="member_career_enddate" class="required"/>
                        <span class="hidden error text-red-600 text-sm">종료일을 선택하세요.</span>
                    </li>
                    <li>
                        <label for="region_name" class="text-gray-500">지역 *</label><br>
                        <input type="text" name="region_name" id="region_name"
                            data-target-url="/api/member/region/search"
                            data-search-type="region_name"
                            data-result-name="fk_region_no"
                            class="input-search w-full border-1 rounded-sm p-2 border-gray-400" />
                        <input type="hidden" name="fk_region_no" class="required"/>
                        <span class="hidden error text-red-600 text-sm">지역을 목록에서 선택하세요.</span>
                    </li>
                    <li>
                        <label for="member_career_explain" class="text-gray-500">설명</label><br>
                        <textarea name="member_career_explain" id="member_career_explain"
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
                    <button type="button" id="deleteMemberCareer" class="btn-transparent">경력 삭제</button>
                </div>
                <div>
                    <button type="button" id="submitMemberCareer" class="button-selected">저장</button>
                </div>
            </div>
        </div>
    </div>
</dialog>