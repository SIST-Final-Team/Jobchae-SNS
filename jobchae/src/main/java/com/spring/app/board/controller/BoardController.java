package com.spring.app.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
}
