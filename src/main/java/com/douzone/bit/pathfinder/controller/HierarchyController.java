package com.douzone.bit.pathfinder.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.service.HierarchyService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Controller
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

	@ResponseBody
	@GetMapping("/tree")
	public JsonArray getHierarchyChild(
			@RequestParam(value = "id", required = false, defaultValue = "#") String id) {

		JsonArray resultJson = new JsonArray();;
		
		if (id.equals("#")) {
			resultJson = hierarchyService.areaRead();
		} else {
			resultJson = hierarchyService.branchRead(id);
		}

		return resultJson;
	}

}