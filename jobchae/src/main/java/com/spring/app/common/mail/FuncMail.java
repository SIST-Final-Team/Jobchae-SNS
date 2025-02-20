package com.spring.app.common.mail;

import org.springframework.stereotype.Component;

import com.spring.app.common.security.RandomEmailCode;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Component
public class FuncMail {

	// 인증번호 만든 후 이메일 보내는 메소드
	public boolean sendMail(HttpServletRequest request, String member_email) {
		
		// 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
		boolean sendMailSuccess = false;
		
		try {
			RandomEmailCode rd = new RandomEmailCode();
			// 랜덤코드 생성
			String certification_code = rd.makeRandomCode();

			GoogleMail mail = new GoogleMail();

			mail.send_certification_code(member_email, certification_code); // 이메일 보내기
			sendMailSuccess = true; // 매일전송 성공!

			// 세션에 저장해서 인증할 때 쓰자!
			HttpSession session = request.getSession();
			session.setAttribute("certification_code", certification_code);
			
		} catch (Exception e) {
			sendMailSuccess = false; // 매일전송 실패
		}//end of try catch...
		
		return sendMailSuccess;
		
	}//end of public boolean sendMail(String member_id) {}...

	
	
	
	
	// 이메일 인증번호 받아서 일치하는지 확인해주는 메소드
	public boolean emailAuth(HttpServletRequest request, String email_auth_text) {
		
		boolean isExists = false; // 이메일 인증 확인
		
		// 세션에 저장해둔 이메일 인증번호를 가져온다.
		HttpSession session = request.getSession();
		String certification_code = (String)session.getAttribute("certification_code");
		
		// 맞으면 바꿔줌
		if (certification_code.equals(email_auth_text)) {
			isExists = true;
			session.setAttribute("emailCheckOk", true);
			// 유효성 검사에서, 정말로 이메일인증이 확실한지 체크하는 용도로 넣어줌

			// !!!! 중요 !!!! //
			// !!!! 세션에 저장된 인증코드 삭제하기 !!!! //
			session.removeAttribute("certification_code"); // 인증코드만 삭제한다!!!
			
		}//end of if (certification_code.equals(email_auth_text)) {}...
		
		return isExists; // 인증번호가 맞으면 true, 아니면 false
		
	}//end of public boolean emailAuth(HttpServletRequest request, String email_auth_text) {}...
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}//end of class...
