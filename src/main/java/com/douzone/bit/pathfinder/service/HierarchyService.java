package com.douzone.bit.pathfinder.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.entity.AreaTb;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.repository.AreaRepository;
import com.douzone.bit.pathfinder.repository.BranchRepository;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Service
public class HierarchyService {

	@Autowired
	private AreaRepository areaRepository;
	
	@Autowired
	private BranchRepository branchRepository;
	
	public JsonArray areaRead() {
		
		List<AreaTb> areaData = areaRepository.findAll();
		
		JsonArray jArray = new JsonArray();
		
		for (int i = 0; i < areaData.size(); i++) {
			JsonObject sObject = new JsonObject();
			sObject.addProperty("id", areaData.get(i).getAreaIndex());
			sObject.addProperty("text", areaData.get(i).getAreaName());
			sObject.addProperty("children", true);
			jArray.add(sObject);
		}
		
		return jArray;
	}
	
	public JsonArray branchRead(String id) {
		
		List<BranchTb> branchData = branchRepository.findByArea(
				areaRepository.getOne(Long.parseLong(id)));	
		
		JsonArray jArray = new JsonArray();
		
		for (int i = 0; i < branchData.size(); i++) {
			JsonObject sObject = new JsonObject();
			sObject.addProperty("subid", branchData.get(i).getBranchIndex());
			sObject.addProperty("text", branchData.get(i).getBranchName());
			jArray.add(sObject);
		}
		
		return jArray;
	}
}