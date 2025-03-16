<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style type="text/tailwindcss">
    html {
    font-size: 0.9rem;
    }
    body {
        background-color: rgb(244, 242, 238);
    }
    dialog::backdrop {
        background:rgba(0, 0, 0, 0.6);
    }
    .h1 {
        @apply text-[1.35rem] font-bold;
    }
    .border-normal {
        @apply border-1 border-gray-300 rounded-lg bg-white;
    }
    .border-search-board {
        @apply border-1 border-gray-300 rounded-lg bg-white;

        &>li:not(:last-child) {
            @apply border-b-4 border-gray-200;
        }

        &>li {
            @apply space-y-2;
        }

        &>li:not(.py-0) {
            @apply pt-4 pb-2;
        }
        
        &>li>*:not(.px-0) {
            @apply px-4;
        }

        .button-more {
            @apply rounded-b-lg py-2 text-center font-bold text-lg w-full cursor-pointer hover:bg-gray-100 transition-all duration-200;
        }
    }
    .border-board {
        @apply space-y-4;

        &>div {
            @apply border-1 border-gray-300 rounded-lg bg-white;
        }

        &>div:not(.space-y-0) {
            @apply space-y-2;
        }

        &>div:not(.py-0) {
            @apply pt-4;
            @apply pb-2;
        }
        
        &>div>*:not(.px-0) {
            @apply px-4;
        }

        .button-more {
            @apply rounded-b-lg py-2 text-center font-bold text-lg w-full cursor-pointer hover:bg-gray-100 transition-all duration-200;
        }
    }
    .border-search-member {
        @apply border-1 border-gray-300 rounded-lg bg-white;

        &>div:not(:last-child) {
            @apply border-b-1 border-gray-300 space-y-2;
        }

        &>div:not(.py-0) {
            @apply py-4;
        }
        
        &>div>*:not(.px-0) {
            @apply px-4;
        }
    }
    .button-more {
        @apply rounded-b-lg py-2 text-center font-bold text-lg w-full cursor-pointer hover:bg-gray-100 transition-all duration-200;
    }
    .nav-selected {
        @apply relative before:inline-block before:absolute before:w-0.5 before:h-10 before:bg-green-800 before:mr-2 before:left-0 before:top-1/2 before:-translate-y-1/2;
    }
    .nav {
        @apply list-none pb-2 [&>li]:px-4 [&>li]:hover:bg-gray-100 [&>li]:cursor-pointer [&>li>a]:block [&>li>a]:py-2;
    }
    .border-list {
        @apply my-0.5 space-y-4 py-4 bg-white;
        @apply first:border-1 first:border-gray-300 first:rounded-t-lg;
        @apply not-first:border-1 not-first:border-gray-300;
        @apply last:border-1 last:border-gray-300 last:rounded-b-lg;
    }
    .button-gray:not(.button-selected) {
        @apply border-1 rounded-full border-gray-400 px-3 py-0.5 font-bold text-gray-700 text-lg;
        @apply hover:bg-gray-100 hover:inset-ring-1 hover:inset-ring-gray-400 transition-all duration-200;
        @apply hover:cursor-pointer;
    }
    .button-orange:not(.button-selected) {
        @apply border-1 rounded-full border-orange-500 px-3 py-0.5 font-bold text-orange-500 text-lg;
        @apply hover:bg-gray-100 hover:inset-ring-1 hover:inset-ring-orange-500 transition-all duration-200;
        @apply hover:cursor-pointer;
    }
    .button-selected {
        @apply border-1 border-orange-400 rounded-full px-3 py-0.5 font-bold text-white text-lg bg-orange-400;
        @apply hover:bg-orange-500 hover:border-orange-500 transition-all duration-200;
        @apply hover:cursor-pointer;
    }
    .board-member-profile {
        @apply flex gap-4;

        /* 프로필 이미지 */
        div:first-child>a>img {
            @apply w-15 h-15 object-cover;
        }

        div:nth-child(2) span {
            @apply block text-gray-600 text-sm;
        }

        div:nth-child(2) span:first-child {
            @apply font-bold text-lg text-black;
        }

        /* 프로필 정보 및 팔로우 버튼 */
        div:nth-child(3) {
            @apply flex items-start;

            button {
                @apply px-4 py-1 text-lg rounded-full;
            }

            button:hover {
                @apply bg-gray-100 cursor-pointer;
            }

            /* 팔로우 버튼 */
            .follow-button {
                @apply text-orange-500 font-bold;
            }
            
            /* 팔로우 버튼 */
            .unfollow-button {
                @apply text-black;
            }
        }
    }

    .file-image {
        @apply grid grid-flow-row-dense grid-flow-col gap-1 p-0.5;

        :hover {
            @apply cursor-pointer;
        }

        button:first-child {
            @apply max-h-[50rem] m-auto col-span-3;
        }
        button:not(:first-child) {
            @apply m-auto;
        }
        
        button:not(:first-child)>img {
            @apply object-cover aspect-[3/2];
        }
        button.more-image {
            @apply relative;
        }
        button.more-image>img {
            @apply brightness-50;
        }
        button.more-image>span {
            @apply absolute text-white;
            @apply top-1/2 -translate-y-1/2 left-1/2 -translate-x-1/2;
        }
    }
    
    .reaction-images {
        @apply flex items-center;
        img {
            @apply w-6 rounded-full border-2 border-white;
        }
        img:not(img:last-child) {
            @apply -mr-2;
        }
    }

    .button-underline {
        @apply flex hover:cursor-pointer hover:underline hover:text-orange-500;
    }

    .hover-underline {
        @apply hover:cursor-pointer hover:underline hover:text-orange-500;
    }

    .button-board-action {
        @apply w-full h-10 flex items-center justify-center rounded-md font-bold hover:cursor-pointer hover:bg-gray-100;
    }
    button {
        @apply hover:cursor-pointer;
    }
    
    .btn-transparent {
        @apply px-4 py-1 text-lg rounded-full;
    }

    .btn-transparent:hover {
        @apply bg-gray-100 cursor-pointer;
    }

    dialog.dropdown::backdrop {
        background: transparent;
    }

    /* 모달 애니메이션 */
    .animate-slideDown {
        animation: slideDown 0.4s cubic-bezier(0.22, 1, 0.36, 1);
    }
    .animate-slideUp {
        animation: slideUp 0.4s cubic-bezier(0.4, 0, 0.6, 1);
    }

    @keyframes slideDown {
        from {
            transform: translateY(-20%);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }
    @keyframes slideUp {
        from {
            transform: translateY(0);
            opacity: 1;
        }
        to {
            transform: translateY(-20%);
            opacity: 0;
        }
    }
</style>