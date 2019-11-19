package com.douzone.bit.pathfinder.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequestMapping("/history")
public class HistoryController {

	@GetMapping("/ajax")
	public String AjaxHistory() {
		
		return "ajax.history";
	}
	
	@GetMapping({ "", "/" })
	public String history(Model model) {
		
		return "/history";
	}

}