package com.spring.app.company.controller;

import com.spring.app.company.domain.CompanyVO;
import com.spring.app.company.model.CompanyDAO;
import com.spring.app.company.service.CompanyService;
import com.spring.app.member.domain.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/api/company")
@CrossOrigin(origins = "*")
public class ApiCompanyController {

    private final CompanyDAO companyDAO;
    CompanyService companyService;

    public ApiCompanyController(CompanyService companyService, CompanyDAO companyDAO) {
        this.companyService = companyService;
        this.companyDAO = companyDAO;
    }

    @GetMapping("/dashboard/{company_no}")
    public ResponseEntity<CompanyVO> selectCompany(@PathVariable String company_no, HttpServletRequest request){

        //멤버 정보 조회
        HttpSession session = request.getSession();

        MemberVO member = (MemberVO)session.getAttribute("loginuser");
        member.setMember_id(member.getMember_id());
        member.setMember_birth(member.getMember_birth());


        //회사 정보 조회
        CompanyVO companyVO = companyService.selectCompany(company_no);

        //회사 정보에 멤버 정보 추가
        companyVO.setMember(member);

        return ResponseEntity.ok(companyVO);
    }

    //회사 등록
    @PostMapping("/registerCompany")
    public ModelAndView registerCompany(CompanyVO companyVO, HttpServletRequest request) {

        //파라미터 확인
//        Enumeration<String> parameterNames = request.getParameterNames();
//        while(parameterNames.hasMoreElements()) {
//            String name = parameterNames.nextElement();
//            System.out.println(name +" : "+ request.getParameter(name));
//        }

        //멤버 등록
        MemberVO member = new MemberVO();
        member.setMember_id("user001");
        member.setMember_birth("1996-02-27");
        companyVO.setFkMemberId(member.getMember_id());
        companyVO.setMember(member);
        String industryName = (String)request.getParameter("industryName");

        //회사 등록
        CompanyVO company = companyService.insertCompany(companyVO, industryName);
        //회사 대시보드로 이동
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("redirect:/company/dashboard/"+company.getCompanyNo());
        modelAndView.addObject("company", company);
        return  modelAndView;
    }


    //회사 삭제
    @DeleteMapping("/deleteCompany")
    public ResponseEntity<CompanyVO> deleteCompany(@RequestParam String companyNo, @RequestParam String memberId) {


        CompanyVO companyVO = companyService.deleteCompany(companyNo, memberId);


        return ResponseEntity.ok(companyVO);
    }

    //회사 정보 업데이트
    @PutMapping("/updateCompany")
    public ResponseEntity<CompanyVO> updateCompany(CompanyVO companyVO, @RequestParam String industryName) {

        CompanyVO updateCompany = companyService.updateCompany(companyVO, industryName);

        return ResponseEntity.ok(updateCompany);
    }




}
