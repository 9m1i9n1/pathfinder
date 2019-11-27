package com.douzone.bit.pathfinder.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/home")
public class HomeController {

	@GetMapping({ "", "/" })
	public ModelAndView home(ModelAndView  mv, HttpServletRequest request) {

		System.out.println(request.getParameter("pageName"));
		mv.setViewName("/home");

		return mv;
	}

}