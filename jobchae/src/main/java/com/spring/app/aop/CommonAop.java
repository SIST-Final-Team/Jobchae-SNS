package com.spring.app.aop;

import java.io.IOException;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.spring.app.common.MyUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// === #25. 공통관심사 클래스(Aspect 클래스) 생성하기 === //
// AOP (Aspect Oriented Programming)

@Aspect    // 공통관심사 클래스(Aspect 클래스)로 등록된다.
@Component // Bean 으로 등록된다.
           // !!! 중요 !!! MyspringApplication 클래스에서 @EnableAspectJAutoProxy 을 기재해야 한다. !!!
public class CommonAop {

	// ===== Before Advice(공통관심사, 보조업무) 만들기 ====== //
    /*
        주업무(<예: 글쓰기, 글수정, 댓글쓰기, 직원목록조회 등등>)를 실행하기 앞서서
        이러한 주업무들은 먼저 로그인을 해야만 사용가능한 작업이므로
        주업무에 대한 보조업무<예: 로그인 유무검사> 객체로 로그인 여부를 체크하는
        관심 클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를 생성하여
        동작하도록 만들겠다.
    */

	// === Pointcut(주업무)을 설정해야 한다. === //
	//     Pointcut 이란 공통관심사<예: 로그인 유무검사>를 필요로 하는 메소드를 말한다.
	@Pointcut("execution(public * com.spring.app..*Controller.requiredLogin_*(..))")
	// 접근제한자 : public
	// return 타입 : 맘대로
	// com.spring.app 패키지 아래 어떤 패키지든
	// Controller로 끝나는 클래스
	// 메소드명 : requiredLogin_으로 시작
	// 파라미터 : 있거나 없거나 상관 없음
	public void requiredLogin() {}

	// === Before Advice(공통관심사, 보조업무)를 구현한다. === //
	@Before("requiredLogin()")
	public void loginCheck(JoinPoint joinpoint) { // 로그인 유무 검사하는 메소드 작성하기

		// JoinPoint joinpoint 는 포인트컷 되어진 주업무의 메소드이다.

		// 로그인 유무를 확인하기 위해서는 request 를 통해 session 을 얻어와야 한다.
		HttpServletRequest request = (HttpServletRequest) joinpoint.getArgs()[0]; // 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다.
		HttpServletResponse response = (HttpServletResponse) joinpoint.getArgs()[1]; // 주업무 메소드의 두번째 파라미터를 얻어오는 것이다.

		HttpSession session = request.getSession();

		if(session.getAttribute("loginuser") == null) {
			String message = "먼저 로그인을 하십시오!";
			String loc = request.getContextPath() + "/member/login";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			// >>> 로그인 성공 후 로그인 하기 전 페이지로 돌아가는 작업 만들기 <<< //
			String url = MyUtil.getCurrentURL(request);
			session.setAttribute("goBackURL", url); // 세션에 url 정보를 저장시켜둔다.

			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
	        try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}

		}
	}
	
	
	
	
	
	// 이메일 인증 받았는지 확인하는 AOP
	@Pointcut("execution(public * com.spring.app..*Controller.emailCheckOk_*(..))")
	// 접근제한자 : public
	// return 타입 : 맘대로
	// com.spring.app 패키지 아래 어떤 패키지든
	// Controller로 끝나는 클래스
	// 메소드명 : requiredLogin_으로 시작
	// 파라미터 : 있거나 없거나 상관 없음
	public void emailCheckOk() {}
	
	// === Before Advice(공통관심사, 보조업무)를 구현한다. === //
		@Before("emailCheckOk()")
		public void emailCheck(JoinPoint joinpoint) { // 이메일 체크 유무 검사하는 메소드 작성하기
			// JoinPoint joinpoint 는 포인트컷 되어진 주업무의 메소드이다.

			// 이메일 체크 유무를 확인하기 위해서는 request 를 통해 session 을 얻어와야 한다.
			HttpServletRequest request = (HttpServletRequest) joinpoint.getArgs()[0]; // 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다.
			HttpServletResponse response = (HttpServletResponse) joinpoint.getArgs()[1]; // 주업무 메소드의 두번째 파라미터를 얻어오는 것이다.

			HttpSession session = request.getSession();

			if(session.getAttribute("emailCheckOk") == null || (boolean)session.getAttribute("emailCheckOk") != true) { // 이메일 인증이 true 값이 아니라면
				String message = "email 인증을 받아야 합니다.";
				String loc = request.getContextPath() + "/index"; // 메인페이지로

				request.setAttribute("message", message);
				request.setAttribute("loc", loc);

				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
				
		        try {
					dispatcher.forward(request, response);
				} catch (ServletException | IOException e) {
					e.printStackTrace();
				}

			}
		}//end of public void emailCheck(JoinPoint joinpoint) {}...
	

	// ===== After Advice(보조업무) 만들기 ====== //

//	@Pointcut("execution(public * com.spring.app..*Controller)")
//	public void insert() {}
//	@After("insert()")
//	public void createAlarm(JoinPoint joinpoint) {
//		System.out.println("실행");
//		String methodName = joinpoint.getSignature().getName();
//	}
	// ===== Around Advice(보조업무) 만들기 ====== //
}
















