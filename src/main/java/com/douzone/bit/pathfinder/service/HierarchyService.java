package com.douzone.bit.pathfinder.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.controller.Header;
import com.douzone.bit.pathfinder.model.entity.AreaTb;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.repository.AreaRepository;
import com.douzone.bit.pathfinder.repository.BranchRepository;
import com.douzone.bit.pathfinder.repository.UserRepository;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Service
public class HierarchyService {

	@Autowired
	private AreaRepository areaRepository;
	@Autowired
	private BranchRepository branchRepository;
	@Autowired
	private UserRepository userRepository;
	
	public JsonArray areaRead() {
		
		List<AreaTb> areaData = areaRepository.findAll();
		
		JsonArray jArray = new JsonArray();
		
		for (int i = 0; i < areaData.size(); i++) {
			JsonObject sObject = new JsonObject();
			sObject.addProperty("id", "area=" + areaData.get(i).getAreaIndex());
			sObject.addProperty("text", areaData.get(i).getAreaName());
			sObject.addProperty("children", true);
			jArray.add(sObject);
		}
		
		return jArray;
	}
	
	public JsonArray branchRead(String id) {
		
		String index[] = id.split("=");
		
		List<BranchTb> branchData = branchRepository.findByArea(
				areaRepository.getOne(Long.parseLong(index[1])));	
		
		JsonArray jArray = new JsonArray();
		
		for (int i = 0; i < branchData.size(); i++) {
			JsonObject sObject = new JsonObject();
			sObject.addProperty("id", "branch=" + branchData.get(i).getBranchIndex());
			sObject.addProperty("text", branchData.get(i).getBranchName());
			jArray.add(sObject);
		}
		
		return jArray;
	}
	
	public JsonArray userRead(String id) {
		
		JsonArray jArray = new JsonArray();
		
		List<UserTb> userData;
		List<BranchTb> branchIdData;
		
		String index[] = id.split("=");
		
		if (index[0].equals("area")) {
			branchIdData = branchRepository.findByArea(
					areaRepository.getOne(Long.parseLong(index[1])));
			
			userData = userRepository.findByBranchIn(
					branchIdData);
			
		} else {
			userData = userRepository.findByBranch(
					branchRepository.getOne(Long.parseLong(index[1])));
			
		}
		
		return jArray;
	}
}