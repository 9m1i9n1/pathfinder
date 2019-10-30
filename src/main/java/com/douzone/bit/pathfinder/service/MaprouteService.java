package com.douzone.bit.pathfinder.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.entity.RouteDTO;
import com.douzone.bit.pathfinder.repository.TestDAO;
import com.douzone.bit.pathfinder.service.algorithm.Recursive;
import com.douzone.bit.pathfinder.service.algorithm.createMap;

@Service
public class MaprouteService {

	@SuppressWarnings({ "rawtypes" })
	public List<RouteDTO> tryCalc(ArrayList<Map> list) {
		// TODO Auto-generated method stub
		ArrayList<RouteDTO> testList = new ArrayList<RouteDTO>();
		List<RouteDTO> sucList = new ArrayList<RouteDTO>();

		for (int i = 0; i < list.size(); i++) {
			testList.add(new RouteDTO());
			testList.get(i).setBranch_name(list.get(i).get("branch_name").toString());

			testList.get(i)
					.setBranch_value(Integer.parseInt(list.get(i).get("branch_value").toString()));
			testList.get(i).setBranch_lat(Double.valueOf(list.get(i).get("branch_lat").toString()).doubleValue());
			testList.get(i).setBranch_lng(Double.valueOf(list.get(i).get("branch_lng").toString()).doubleValue());
		}
		
		createMap m = new createMap(list, testList);
		Recursive r = new Recursive(0, m.getmap());

		List<Integer> TourList = r.getTour();
		for (int i = 0; i < testList.size(); i++) {
			sucList.add(testList.get(Integer.parseInt(TourList.get(i).toString())));
			}
		
		return sucList;
	}
	
	@Autowired
	TestDAO testDao;
	
	//list
	public List<BranchTb> search() {
		
		   List<BranchTb> branchs = testDao.findAll();
	        
		
		 // List<BranchTb> branchList = branchs.stream() .collect(Collectors.toList());
		 
	            
	        return branchs;
		
	}
}
