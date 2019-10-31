package com.douzone.bit.pathfinder.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.service.HierarchyService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@RestController
@RequestMapping("/hierarchy")
public class HierarchyController {

	@Autowired
	HierarchyService hierarchyService;

	@GetMapping({ "", "/" })
	public ModelAndView getHierarchy() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/hierarchy");

		return mv;
	}

	@GetMapping("/gettree.do")
	public JsonArray getHierarchyChild(
			@RequestParam(value = "id", required = false, defaultValue = "#") String id) {

		return (id.equals("#")) ? hierarchyService.areaRead() :
			hierarchyService.branchRead(id);
	}
	
	@GetMapping("/getuser.do")
	public JsonArray getUser(
			@RequestParam("id") String id) {
		
		return hierarchyService.userRead(id);
	}
}