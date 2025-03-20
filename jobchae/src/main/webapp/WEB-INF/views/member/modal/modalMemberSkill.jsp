<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<dialog id="modalMemberSkill"
    class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
    <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
        <!-- 모달 상단부 -->
        <div>
            <button type="button"
                class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
            <h1 class="h1 px-8">보유기술 입력</h1>

            <hr class="border-gray-200 mt-4">
        </div>

        <!-- 모달 내용 -->
        <div class="space-y-4 overflow-auto min-h-80">
            <div class="text-gray-500 px-8">* 필수</div>
            <form name="memberSkillForm">
                <ul class="space-y-4 px-8">
                    <li>
                        <label for="skill_name" class="text-gray-500">보유기술 *</label><br>
                        <input type="text" name="skill_name" id="skill_name" placeholder="예: 스프링 프레임워크"
                            autocomplete="off"
                            data-target-url="/api/member/skill/search"
                            data-search-type="skill_name"
                            data-result-name="fk_skill_no"
                            class="input-search w-full border-1 rounded-sm p-2 border-gray-400" />
                        <input type="text" name="fk_skill_no" class="hidden" />
                    </li>
                </ul>
            </form>
        </div>

        <!-- 모달 하단부 -->
        <div>
            <hr class="border-gray-200 mb-4">
            <div class="flex justify-end items-center px-4">
                <div>
                    <button type="button" id="submitMemberSkill" class="button-selected">저장</button>
                </div>
            </div>
        </div>
    </div>
</dialog>