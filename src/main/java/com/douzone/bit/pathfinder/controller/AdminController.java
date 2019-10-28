package com.douzone.bit.pathfinder.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.service.AdminService;

@RestController
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;

	@GetMapping({ "", "/" })
	public String admin(Model model) {

		return "/admin/mainManage";
	}

//  @GetMapping("/branchmanage")
//  public String branchManage(Model model) {
//
//    return "/admin/branchManage";
//  }

	@GetMapping("/branchmanage/read/{branchIndex}")
	public ModelAndView read(@PathVariable Long branchIndex) {

		ModelAndView mv = new ModelAndView();
		Header<BranchTb> a = adminService.read(branchIndex);
		a.getData().getBranchAddr();

		mv.setViewName("/admin/branchManage");
		mv.addObject("read", adminService.read(branchIndex));

		return mv;
	}

	// 페이징처리
	@GetMapping("/branchmanage")
	public ModelAndView search(
			@PageableDefault(sort = "branchIndex", direction = Sort.Direction.DESC, size = 15) Pageable pageable) {

		ModelAndView mv = new ModelAndView();
		Header<List<BranchTb>> b = adminService.search(pageable);

		mv.addObject("initpage", b.getData());
		System.out.println(b);
		mv.setViewName("/admin/branchManage");
		return mv;

	}

	@GetMapping("/usermanage")
	public ModelAndView userManage(Model model) {

		ModelAndView mv = new ModelAndView();

		mv.setViewName("/admin/userManage");
		return mv;
	}

	@GetMapping("/carmanage")
	public ModelAndView carManage(Model model) {

		ModelAndView mv = new ModelAndView();

		mv.setViewName("/admin/carManage");
		return mv;
	}

}