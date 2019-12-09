package com.douzone.bit.pathfinder.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.model.entity.mongodb.HistoryTb;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.response.AdminBranchResponse;
import com.douzone.bit.pathfinder.model.network.response.AdminUserResponse;
import com.douzone.bit.pathfinder.model.network.response.HistoryResponse;
import com.douzone.bit.pathfinder.service.AdminBranchService;
import com.douzone.bit.pathfinder.service.AdminUserService;
import com.douzone.bit.pathfinder.service.HistoryService;
import com.douzone.bit.pathfinder.service.HomeService;

@RestController
@RequestMapping("/home")
public class HomeController {
	
	@Autowired
	HomeService homeService;
	
	@Autowired
	HistoryService historyService;
	
	@Autowired
	AdminUserService adminUserService;
	
	@Autowired
	AdminBranchService adminBranchService;
	
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

		// 오늘의 배송현황
	@GetMapping("/todayHistoryPercent")
	public double todayHistoryPercent() {

		return historyService.todayHistoryPercent();
	}

	// 전체사용자 수
	@GetMapping("/totalUserCount")
	public Header<List<AdminUserResponse>> userList(@RequestParam String treeId,
			@PageableDefault(sort = { "userIndex" }, direction = Sort.Direction.DESC, size = 10) Pageable pageable) {

		return adminUserService.list(treeId, pageable);
	}

	// 전체지점 수
	@GetMapping("/totalBranchCount")
	public Header<List<AdminBranchResponse>> branchList(
			@PageableDefault(sort = "branchIndex", direction = Sort.Direction.DESC, size = 10) Pageable pageable) {
		return adminBranchService.listpage(pageable);
	}

	// 전체히스토리 수
	@GetMapping("/totalHistoryCount")
	public Header<List<HistoryTb>> historyAll() {

		return historyService.historyAll();
	}
}