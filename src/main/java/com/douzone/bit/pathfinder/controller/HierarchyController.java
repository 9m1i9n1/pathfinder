package com.douzone.bit.pathfinder.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.model.entity.AreaTb;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.service.HierarchyService;

@Controller
@RequestMapping("/hierarchy")
public class HierarchyController {

	@Autowired
	HierarchyService hierarchyService;
	
	@ResponseBody
	@GetMapping({ "", "/" })
	public ModelAndView getHierarchy(
			@RequestParam("id") String id) {

		ModelAndView mv = new ModelAndView();
		
		if (id.equals("#") || id.equals("1")) {
			List<AreaTb> areaData = hierarchyService.areaRead();
		}else {
			List<BranchTb> brachData = hierarchyService.branchRead(id);
		}
		
//		mv.addObject("result", attributeValue);
		mv.setViewName("/hierarchy");
		
		return mv;
	}

}