package com.spring.app.company.controller;

import com.spring.app.common.FileManager;
import com.spring.app.company.domain.CompanyVO;
import com.spring.app.company.model.CompanyDAO;
import com.spring.app.company.service.CompanyService;
import com.spring.app.member.domain.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.apache.coyote.Response;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.lang.reflect.Member;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    @Autowired
    FileManager fileManager;


    //회사의 정보를 조회
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
    public ModelAndView registerCompany(CompanyVO companyVO, MultipartHttpServletRequest request, @RequestParam(value = "industryName") String industryName) {

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
//        String industryName = (String)request.getParameter("industryName");
        System.out.println("industryName => "+industryName);

        //세션 정보 확인
        HttpSession session = request.getSession();


        //파일 처리
        MultipartFile logoFile = request.getFile("company_logo");
        if(logoFile != null && !logoFile.isEmpty()) {
            String root = session.getServletContext().getRealPath("/");
            String path = root + "resources" + File.separator + "files" + File.separator + "companyLogo";
            String originCompanyLogoFilename = logoFile.getOriginalFilename();


            String LogoFileName = "";

            byte[] bytes_company_logo = null;
            try {
                bytes_company_logo = logoFile.getBytes();
                LogoFileName = fileManager.doFileUpload(bytes_company_logo, logoFile.getOriginalFilename(), path);

                String fileExt = originCompanyLogoFilename.substring(originCompanyLogoFilename.lastIndexOf("."));
                System.out.println("fileExt => "+fileExt);
                // 백엔드에서 한번 더 사진파일로 걸러주자
                if (!".jpg".equalsIgnoreCase(fileExt) && !".png".equalsIgnoreCase(fileExt) && !".webp".equalsIgnoreCase(fileExt) && !".jpeg".equalsIgnoreCase(fileExt)) {

//                    System.out.println("업로드할 수 없는 파일입니다.");
                    return null;
                }//end of if (fileExt != ".jpg" || fileExt != ".png" || fileExt != ".webp") {}...

//                System.out.println("LogoFileName => "+LogoFileName);
                LogoFileName = fileManager.doFileUpload(bytes_company_logo, originCompanyLogoFilename, path);

                //CompanyVO에 파일명 저장
                companyVO.setCompanyLogo(LogoFileName);
//                System.out.println("LogoFileName => "+LogoFileName);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        System.out.println("companyVO => "+companyVO.toString());
        //회사 등록
        CompanyVO company = companyService.insertCompany(companyVO, industryName);
        System.out.println("company => "+company.toString());
        //회사 대시보드로 이동
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("redirect:/company/dashboard/"+company.getCompanyNo()+"/");
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
        System.out.println("회사 업데이트 => " + updateCompany.toString());

        return ResponseEntity.ok(updateCompany);
    }


    //운영자의 회사 정보 조회
    @GetMapping("/selectAdminCompnay/{company_no}")
    public ResponseEntity<CompanyVO> selectAdminCompany(@PathVariable String company_no, HttpServletRequest request) {
        //이 함수의 논리구조
        //입력받은 company_no를 통해 회사 정보를 조회 - 세션에 있는 운영자 정보와 비교
        //만약 운영자 ID와 로그인한 유저의 ID가 같은지 비교
        //같다면 회사 정보를 반환
        //같지 않다면 에러 페이지를 반환

        //세선 정보 저장
        HttpSession session = request.getSession();


        CompanyVO companyVO = companyService.selectCompany(company_no);
        MemberVO memberVO =  (MemberVO)session.getAttribute("loginuser");

        //회사의 운영자 정보와 세션의 운영자 정보가 일치하는지 확인
        //멤버의 정보를 변수에 저장
        String companyAdminId = companyVO.getFkMemberId();
        String sessionMemberId = memberVO.getMember_id();

        //운영자 정보가 일치하지 않을 경우 에러 페이지로 반환
        if(!companyAdminId.equals(sessionMemberId)){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }

        //운영자 정보가 일치할 경우 회사 정보를 반환
        return ResponseEntity.ok(companyVO);


    }


    //사용자의 회사 정보 조회

    @GetMapping("/selectCompanyByMemberId")
    public ResponseEntity<List<CompanyVO>>selectCompanyByMemberId(HttpServletRequest request){

        //세션 정보 저장
        HttpSession session = request.getSession();

        //세션에서 멤버 정보 조회
        MemberVO member = (MemberVO)session.getAttribute("loginuser");
        ResponseEntity<List<CompanyVO>> response = null;

        List<CompanyVO> companyList = companyService.selectCompanyByMemberId(member.getMember_id());

        response = ResponseEntity.ok(companyList);
        return response;
    }
        





}
