package com.douzone.bit.pathfinder.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.response.HistoryResponse;
import com.douzone.bit.pathfinder.service.HistoryService;

@RestController
@RequestMapping("/home")
public class HomeController {
	
	@Autowired
	HistoryService historyService;
	
	@GetMapping({ "", "/" })
	public ModelAndView home(ModelAndView  mv, HttpServletRequest request) {
		mv.setViewName("/home");

		return mv;
	}
	
	@GetMapping("/recentlyHistory")
	public Header<List<HistoryResponse>> recentlyHistory(){
		return historyService.readRecentlyHistoryUseHome();
	}
	
	@GetMapping("/todayHistory")
	public Header<List<HistoryResponse>> todayHistory(){
		return historyService.readTodayHistoryUseHome();
	}


}