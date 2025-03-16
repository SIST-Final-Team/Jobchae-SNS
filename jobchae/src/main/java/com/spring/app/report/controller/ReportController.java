package com.spring.app.report.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.domain.ReportVO;
import com.spring.app.member.service.MemberService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/member/profile/{userld}") // 기본 URL 경로 설정
public class ReportController {

    @Autowired
    MemberService service;

    // 신고 처리 API
    @PostMapping("")
    public ResponseEntity<Map<String, Object>> createReport(
            @RequestParam("Fk_reported_member_id") String fk_reported_member_id,
            @RequestParam("Report_type") int report_type,
            @RequestParam(value = "Additional_explanation", required = false) String additional_explanation,
            HttpSession session) {

        // 세션에서 로그인 사용자 정보 가져오기
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            // 임시 로그인 처리 
            loginUser = new MemberVO();
            loginUser.setMember_id("user003"); // 임시 사용자 ID 설정
            session.setAttribute("loginUser", loginUser); // 세션에 설정
        } 
        
     // 임시 신고 대상 사용자 ID (테스트용)
        if (fk_reported_member_id == null || fk_reported_member_id.isEmpty()) {
            fk_reported_member_id = "minjun9492";  // 임시 사용자 ID 설정
        }
        

        // 로그인한 회원 아이디 추출
        String loginUserId = loginUser.getMember_id(); // MemberVO의 member_id 컬럼 값
        
        // 로그인된 사용자 정보 로그 출력
        System.out.println("신고 처리 요청: 로그인한 사용자: " + loginUserId);
        
        System.out.println("신고할 회원 아이디: " + fk_reported_member_id);

        // ReportVO 객체를 직접 생성하여 서비스에 전달
        ReportVO report = new ReportVO();
        report.setFk_member_id(loginUserId);  // 로그인한 사용자의 아이디 넣기!
        report.setFk_reported_member_id(fk_reported_member_id);
        report.setAdditional_explanation(additional_explanation);
        report.setReport_type(report_type);

        boolean isSuccess = service.createReport(report);
        
        // 응답에 데이터를 담아 JSON 형식으로 반환
        Map<String, Object> response = new HashMap<>();
        if (isSuccess) {
            response.put("success", true);
            response.put("message", "신고가 성공적으로 접수되었습니다.");
            return ResponseEntity.ok(response);
        } else {
            response.put("success", false);
            response.put("message", "신고 처리에 실패했습니다.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }

}
