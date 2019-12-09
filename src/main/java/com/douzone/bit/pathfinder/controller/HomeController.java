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
import com.douzone.bit.pathfinder.service.HomeService;

@RestController
@RequestMapping("/home")
public class HomeController {
	
	@Autowired
	HomeService homeService;
	
	@Autowired
	HistoryService historyService;
	
	@GetMapping({ "", "/" })
	public ModelAndView home(ModelAndView  mv, HttpServletRequest request) {

		System.out.println(request.getParameter("pageName"));
		mv.setViewName("/home");

		return mv;
	}
	
	@GetMapping("/recentlyHistory")
	public Header<List<HistoryResponse>> recentlyHistory(
			@PageableDefault(size = 5) Pageable pageable){

		return historyService.readRecentlyHistoryUseHome(pageable);
	}
	
	@GetMapping("/todayHistory")
	public Header<List<HistoryResponse>> todayHistory(
			@PageableDefault(size = 5) Pageable pageable){

		return historyService.readTodayHistoryUseHome(pageable);
	}
	
	@GetMapping("/getTotalCount.do")
	public int[] totalCount() {
		
		return homeService.getTotalCount();
	}
}