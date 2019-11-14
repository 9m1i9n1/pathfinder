package com.douzone.bit.pathfinder.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/home")
public class HomeController {

	@GetMapping("/ajax")
	public ModelAndView Ajaxhome() {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("ajax.home");
		
		return mv;
	}
	
	@GetMapping({ "", "/" })
	public ModelAndView home(Model model) {

		ModelAndView mv = new ModelAndView();

		mv.setViewName("/sample/dashboard/index");

		return mv;
	}

}