package com.douzone.bit.pathfinder.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.request.RouteInsertRequest;
import com.douzone.bit.pathfinder.model.network.request.RouteSortRequest;
import com.douzone.bit.pathfinder.model.network.response.AdminBranchResponse;
import com.douzone.bit.pathfinder.model.network.response.AdminCarResponse;
import com.douzone.bit.pathfinder.model.network.response.MaprouteResponse;
import com.douzone.bit.pathfinder.service.AdminBranchService;
import com.douzone.bit.pathfinder.service.AdminCarService;
import com.douzone.bit.pathfinder.service.MaprouteService;

@RestController
@RequestMapping(value = "/maproute")
public class MaprouteController {

	@Autowired
	private MaprouteService MaprouteService;

	@Autowired
	private AdminBranchService adminBranchService;

	@Autowired
	private AdminCarService adminCarService;

	@GetMapping({ "", "/" })
	public ModelAndView routeMapView() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/maproute");

		return mv;
	}

	@PostMapping("/mapsort")
	public Header<List<MaprouteResponse>> mapsort(@RequestBody List<RouteSortRequest> markerList) {

		return MaprouteService.markerSort(markerList);
	}

	@GetMapping("/branchLoding")
	public Header<List<AdminBranchResponse>> branchLoading() {

		return adminBranchService.branchlist();
	}

	@GetMapping("/carLoading")
	public Header<List<AdminCarResponse>> carLoading(
			@RequestParam(required = false, defaultValue = "branch") String searchType, @RequestParam String areaIndex) {

		return adminCarService.search(null, searchType, areaIndex);
	}

	@GetMapping("/getReserve.do")
	public Header<List<String>> getReserveDate(@RequestParam Long carIndex) {

		return MaprouteService.getReserveDate(carIndex);
	}

	@PostMapping("/insertPlan.do")
	public Header<String> insertPlan(@RequestBody RouteInsertRequest request) {

		return MaprouteService.insertPlan(request);
	}
}
