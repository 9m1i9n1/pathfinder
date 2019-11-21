package com.douzone.bit.pathfinder.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.service.UserinfoService;

@RestController
@RequestMapping("/userinfo")
public class UserinfoController {

	@Autowired
	UserinfoService userinfoService;

	@GetMapping({ "", "/" })
	public ModelAndView userInfo() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/userinfo");

		return mv;
	}
}