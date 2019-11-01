package com.douzone.bit.pathfinder.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.entity.AreaTb;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.model.network.response.AdminUserResponse;
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
			sObject.addProperty("id", "area:" + areaData.get(i).getAreaIndex());
			sObject.addProperty("text", areaData.get(i).getAreaName());
			sObject.addProperty("children", true);
			jArray.add(sObject);
		}
		
		return jArray;
	}
	
	public JsonArray branchRead(String id) {
		
		String index[] = id.split(":");
		
		List<BranchTb> branchData = branchRepository.findByArea(
				areaRepository.getOne(Long.parseLong(index[1])));	
		
		JsonArray jArray = new JsonArray();
		
		for (int i = 0; i < branchData.size(); i++) {
			JsonObject sObject = new JsonObject();
			sObject.addProperty("id", "branch:" + branchData.get(i).getBranchIndex());
			sObject.addProperty("text", branchData.get(i).getBranchName());
			jArray.add(sObject);
		}
		
		return jArray;
	}
	
	public JsonObject userRead(String id, Pageable pageable) {
		
		int page = (pageable.getPageNumber() == 0) ? 0 : (pageable.getPageNumber() - 1);
		pageable = PageRequest.of(page, 5);
		
		JsonObject jObject = new JsonObject();
		JsonArray jArray = new JsonArray();
		
		Page<UserTb> userData;
		List<BranchTb> branchIdData;
		
		String index[] = id.split(":");
		
		if (index[0].equals("area")) {
			branchIdData = branchRepository.findByArea(
					areaRepository.getOne(Long.parseLong(index[1])));
			
			userData = userRepository.findByBranchIn(branchIdData, pageable);
		} else {
			userData = userRepository.findByBranch(
					branchRepository.getOne(Long.parseLong(index[1])), pageable);
		}
		
		jObject.addProperty("totalCount", userData.getTotalElements());
		jObject.addProperty("totalPage", userData.getTotalPages());
		jObject.addProperty("index", userData.getNumber());
		jObject.addProperty("next", userData.hasNext());
		jObject.addProperty("prev", userData.hasPrevious());
		
		List<UserTb> userList = userData.toList();
		
		for (int i = 0; i < userList.size(); i++) {
			JsonObject sObject = new JsonObject();
			sObject.addProperty("userName", userList.get(i).getUserName());
			sObject.addProperty("userPosition", userList.get(i).getUserPosition());
			sObject.addProperty("userEmail", userList.get(i).getUserEmail());
			sObject.addProperty("userPhone", userList.get(i).getUserPhone());
			
			jArray.add(sObject);
		}
		
		jObject.add("contents", jArray);
		
		return jObject;
	}
}