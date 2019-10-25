package com.douzone.bit.pathfinder.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {

	@RequestMapping("/test")
	public String sample() {
		
		return "Sample";
	}
}
