package com.douzone.bit.pathfinder.controller;

import java.util.List;
import java.util.function.Function;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.response.AdminUserResponse;
import com.douzone.bit.pathfinder.model.network.response.HierarchyResponse;
import com.douzone.bit.pathfinder.service.AdminUserService;
import com.douzone.bit.pathfinder.service.HierarchyService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@RestController
@RequestMapping("/hierarchy")
public class HierarchyController {

	@Autowired
	HierarchyService hierarchyService;

	@Autowired
	AdminUserService adminUserService;

	@GetMapping({ "", "/" })
	public ModelAndView getHierarchy() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/hierarchy");

		return mv;
	}

	@GetMapping("/treelist.do")
	public Header<HierarchyResponse> treeList() {

		return hierarchyService.readCompany();
	}

	@GetMapping("/userlist.do")
	public Header<List<AdminUserResponse>> userList(@RequestParam("id") String id,
			@PageableDefault(size = 10) Pageable pageable) {

		return adminUserService.list(id, pageable);
	}
}