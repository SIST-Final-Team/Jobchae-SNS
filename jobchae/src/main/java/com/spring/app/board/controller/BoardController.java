package com.spring.app.board.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.board.service.BoardService;

@Controller
@RequestMapping(value="/board/*")
public class BoardController {

	@Autowired
	BoardService service;
	
	@GetMapping("feed")
	public ModelAndView feed(ModelAndView mav) {
		
		mav.setViewName("feed/board");
		
		return mav;
	}
	
	
	// 파일첨부가 없는 글쓰기
	@PostMapping("add")
	public ModelAndView add(@RequestParam String fk_member_id, @RequestParam String board_content, @RequestParam String board_visibility, ModelAndView mav) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("board_content", board_content);
		paraMap.put("board_visibility", board_visibility);
		
		int n = service.add(paraMap);
		//System.out.println("n ~~~~~" + n);
		
		mav.setViewName("redirect:/board/feed");	// feed 화면으로 새로고침
		return mav;
	}
	
}
