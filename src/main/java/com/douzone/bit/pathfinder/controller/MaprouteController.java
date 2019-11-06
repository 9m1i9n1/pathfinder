package com.douzone.bit.pathfinder.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.entity.RouteDTO;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.response.AdminBranchResponse;
import com.douzone.bit.pathfinder.service.MaprouteService;

@RestController
@RequestMapping(value = "/maproute")
public class MaprouteController {

	@Autowired
	private MaprouteService MaprouteService;

	@RequestMapping(value = "/maproutesend")
	public List<RouteDTO> test(@RequestBody Map<String, Object> map, Model model) throws Exception {
		
		// 넘어온 것은 jsonObject이다!!
		// 그리고 그 jsonObject의 key값이 data이고
		// value값이 우리가 값을 만들어 넣어준(amu)객체들이 담겨있는 "배열" 이다.

		// 그렇다면 우리의 염원은 value에 해당하는 배열안의 객체(amu)들을 하나하나 분리해야 한다.
		@SuppressWarnings("unchecked")
		ArrayList<Map> list = new ArrayList<Map>(((ArrayList<Map>)map.get("data")));
		
		System.out.println("asdasdsdaasdsadasdasd" + list);
		return MaprouteService.tryCalc(list);
	}
	
  @GetMapping({"","/"})
  public ModelAndView routeMapView() {
	  ModelAndView mv = new ModelAndView();
	  mv.setViewName("/maproute");
	  return mv;

  }
  
  @GetMapping({"/search"})
  public Header<List<AdminBranchResponse>> search() {
	  
//	  Map<String, Object> map = new HashMap<String, Object>();
//	  map.put("list",  map);
//	  System.out.println(map.isEmpty());
//	  mv.addObject("dat1aist", b);
	  //json형태의 객체들을 가지고있는 리스트를 반환
	  //null인 이유가 받을 때 json으로 못받아서
//	  Header.OK(b)
	  
	  return MaprouteService.search();
  }
}



