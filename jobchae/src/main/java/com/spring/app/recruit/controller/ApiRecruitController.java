package com.spring.app.recruit.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.app.recruit.domain.RecruitVO;
import com.spring.app.recruit.service.RecruitService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;


@Controller
@RestController
@RequestMapping(value = "/api/recruit/*")
public class ApiRecruitController {

    @Autowired
    private RecruitService service;

    @PutMapping("edit/{recruit_no}")
    public Map<String, String> putRecruit(RecruitVO editedRecruitVO, @PathVariable String recruit_no) {

        RecruitVO recruitVO = service.getRecruit(recruit_no);
        if(editedRecruitVO.getRecruit_auto_fail() == null) {
            editedRecruitVO.setRecruit_auto_fail("0");
        }
        recruitVO.setRecruit_auto_fail(editedRecruitVO.getRecruit_auto_fail());
        recruitVO.setRecruit_auto_fail_message(editedRecruitVO.getRecruit_auto_fail_message());

        int n = service.updateRecruit(recruitVO);

        Map<String, String> resuiltMap = new HashMap<>();

        resuiltMap.put("result", String.valueOf(n));

        return resuiltMap;
    }

    @GetMapping("{recruit_no}")
    public RecruitVO getRecruit(HttpServletRequest request, @PathVariable String recruit_no) {
        RecruitVO recruitVO = service.getRecruit(recruit_no);

        // html 경로 가져오기
        HttpSession session = request.getSession();
        String root = session.getServletContext().getRealPath("/");
        String path = root + "resources" + File.separator + "files" + File.separator + "recruit";
  
        String file_name = recruitVO.getRecruit_explain_html();

        try {
            recruitVO.setRecruit_explain(Files.readString(Paths.get(path + File.separator + file_name))); // html 파일 내용을 recruit_explain에 저장
        } catch (IOException e) {
            e.printStackTrace();
        }

        return recruitVO;
    }

}
