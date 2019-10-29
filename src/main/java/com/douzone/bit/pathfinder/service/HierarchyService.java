package com.douzone.bit.pathfinder.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.controller.Header;
import com.douzone.bit.pathfinder.model.entity.AreaTb;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.repository.AreaRepository;
import com.douzone.bit.pathfinder.repository.BranchRepository;

@Service
public class HierarchyService {

	@Autowired
	private AreaRepository areaRepository;
	
	@Autowired
	private BranchRepository branchRepository;
	
	public List<AreaTb> areaRead() {
		
		List<AreaTb> areaData = areaRepository.findAll();
		
		return areaData;
	}
	
	public List<BranchTb> branchRead(String id) {
		
		return null;
	}
}