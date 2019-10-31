package com.douzone.bit.pathfinder.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.service.AdminBranchService;
import com.douzone.bit.pathfinder.service.AdminUserService;

@RestController
@RequestMapping("/admin")
public class AdminBranchController {

	@Autowired
	AdminBranchService adminBranchService;

	@Autowired
	AdminUserService adminUserService;

	@GetMapping({ "", "/" })
	public String admin(Model model) {
		return "/admin/mainManage";
	}

	// branch create
	@PostMapping("/branchmanage")
	public String branchCreate(@RequestBody BranchTb request) {
		System.out.println(request);
		adminBranchService.create(request);
		return "redirect:/admin/branchmanage";
	}

	// branch read
	@GetMapping("/branchmanage/read/{branchIndex}")
	public Optional<BranchTb> read(@PathVariable Long branchIndex) {
		System.out.println(adminBranchService.read(branchIndex));
		return adminBranchService.read(branchIndex);
	}

	// branch view
	@GetMapping("/branchmanage")
	public ModelAndView branchSearch(
			@PageableDefault(sort = "branchIndex", direction = Sort.Direction.DESC, size = 10) Pageable pageable) {
		ModelAndView mv = new ModelAndView();

		List<BranchTb> b = adminBranchService.search(pageable);

		mv.addObject("initpage", b);
		mv.setViewName("/admin/branchManage");
		return mv;
	}

	// branch data
	@GetMapping("/branchmanage.do")
	public List<BranchTb> branchData(
			@PageableDefault(sort = "branchIndex", direction = Sort.Direction.DESC, size = 15) Pageable pageable) {
		List<BranchTb> b = adminBranchService.search(pageable);
		return adminBranchService.search(pageable);

	}

	// branch update
	@PutMapping("/branchmanage/update")
	public Optional<Object> branchUpdate(@RequestBody BranchTb request) {
		System.out.println(adminBranchService.update(request));
		return adminBranchService.update(request);
	}

	// branch delete
	@DeleteMapping("/branchmanage/delete/{branchIndex}")
	public int branchDelete(@PathVariable Long branchIndex) {
		return adminBranchService.delete(branchIndex);
	}
}