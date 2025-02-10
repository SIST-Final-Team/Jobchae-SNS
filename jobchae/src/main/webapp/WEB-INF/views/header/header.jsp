<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>  
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://unpkg.com/@tailwindcss/browser@4"></script>
    <%-- Optional JavaScript --%>
  	<script type="text/javascript" src="<%=ctxPath%>/js/jquery-3.7.1.min.js"></script>
  	<script type="text/javascript" src="<%=ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script>
    <style type="text/tailwindcss">
      @theme {
        --color-clifford: #da373d;
      }
    </style>
  </head>
  <body class="bg-stone-100">
    <nav
      class="w-full h-[5.5vh] bg-white border-b-1 border-gray-300 sticky top-0 flex justify-center"
    >
      <div class="h-full w-[59vw] flex">
        <div class="h-full w-25 flex-1 text-left">
          <a href="">
            <img src="${pageContext.request.contextPath}/images/LinkedIn_icon.svg" class="h-3/4 ml-2 mt-1.5"
          /></a>
        </div>
        <div
          class="h-full w-25 flex-none text-center opacity-50 hover:opacity-100"
        >
          <a href="" class="text-sm"
            ><img
              src="${pageContext.request.contextPath}/images/house-solid.svg"
              class="h-2/5 m-auto mt-1.5 ml-auto justify-end"
            />홈</a
          >
        </div>
        <div
          class="h-full w-25 flex-none text-center opacity-50 hover:opacity-100"
        >
          <a href="" class="text-sm"
            ><img
              src="${pageContext.request.contextPath}/images/user-group-solid.svg"
              class="h-2/5 m-auto mt-1.5"
            />인맥</a
          >
        </div>
        <div
          class="h-full w-25 flex-none text-center opacity-50 hover:opacity-100"
        >
          <a href="" class="text-sm"
            ><img
              src="${pageContext.request.contextPath}/images/briefcase-solid.svg"
              class="h-2/5 m-auto mt-1.5"
            />채용공고</a
          >
        </div>
        <div
          class="h-full w-25 flex-none text-center opacity-50 hover:opacity-100"
        >
          <a href="" class="text-sm"
            ><img
              src="${pageContext.request.contextPath}/images/comment-dots-solid.svg"
              class="h-2/5 m-auto mt-1.5"
            />메시지</a
          >
        </div>
        <a href="" class="text-sm"
          ><div
            class="h-full w-25 flex-none text-center opacity-50 hover:opacity-100"
          >
            <img src="${pageContext.request.contextPath}/images/bell-solid.svg" class="h-2/5 m-auto mt-1.5" />알림
          </div></a
        >
        <div
          class="h-full w-20 flex-none text-center border-r-1 border-gray-300 text-sm opacity-50 hover:opacity-100"
        >
          <img
            src="${pageContext.request.contextPath}/images/no_profile_imagwe.png"
            class="h-2/5 m-auto mt-1.5 round-full"
          />나▼
        </div>
        <div
          class="h-full w-25 flex-none text-center ml-2 text-sm opacity-50 hover:opacity-100"
        >
          <img
            src="${pageContext.request.contextPath}/images/grid-3x3-gap-fill-svgrepo-com.svg"
            class="h-2/5 m-auto mt-1.5"
          />비즈니스용▼
        </div>
      </div>
    </nav>