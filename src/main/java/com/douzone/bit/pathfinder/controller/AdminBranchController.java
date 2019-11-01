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
import com.douzone.bit.pathfinder.model.network.request.AdminBranchRequest;
import com.douzone.bit.pathfinder.model.network.response.AdminBranchResponse;
import com.douzone.bit.pathfinder.service.AdminBranchService;
import com.douzone.bit.pathfinder.service.AdminUserService;

@RestController
@RequestMapping("/admin/branchmanage")
public class AdminBranchController {

	@Autowired
	AdminBranchService adminBranchService;

	@Autowired
	AdminUserService adminUserService;



	// branch create
	@PostMapping("")
	public AdminBranchResponse branchCreate(@RequestBody AdminBranchRequest request) {
		
		System.out.println(request);
		
		return adminBranchService.create(request);
	}

	// branch read
	@GetMapping("/read/{branchIndex}")
	public Optional<BranchTb> read(@PathVariable Long branchIndex) {
		System.out.println(adminBranchService.read(branchIndex));
		return adminBranchService.read(branchIndex);
	}

	// branch view
	@GetMapping("")
	public ModelAndView branchManage() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/branchManage");
		
		return mv;
	}

	//branch data
	@GetMapping("/branchlist.do")
	public List<AdminBranchResponse> branchList(
			@PageableDefault(sort = "branchIndex", direction = Sort.Direction.DESC, size = 10) Pageable pageable) {
		return adminBranchService.search(pageable);
	}

	// branch update
	@PutMapping("/update")
	public Optional<AdminBranchResponse> branchUpdate(@RequestBody AdminBranchRequest request) {
		System.out.println(adminBranchService.update(request));
		return adminBranchService.update(request);
	}

	// branch delete
	@DeleteMapping("/delete/{branchIndex}")
	public int branchDelete(@PathVariable Long branchIndex) {
		return adminBranchService.delete(branchIndex);
	}
}