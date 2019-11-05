package com.douzone.bit.pathfinder.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.Pagination;
import com.douzone.bit.pathfinder.model.network.response.AdminUserResponse;
import com.douzone.bit.pathfinder.model.network.response.TreeResponse;
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
	
	public Header<List<AdminUserResponse>> userList(String id, Pageable pageable) {
		
		String treeId[] = id.split(":");
		String nodeType = treeId[0];
		Long nodeIndex = Long.parseLong(treeId[1]);
		
		Page<UserTb> users = null;
		
		switch(nodeType) {
			case "company" :
				users = userRepository.findAll(pageable);
				break;
				
			case "area" :
				List<BranchTb> branchs = branchRepository.findByArea(areaRepository.getOne(nodeIndex));
				users = userRepository.findByBranchIn(branchs, pageable);
				break;
				
			case "branch" :
				users = userRepository.findByBranch(branchRepository.getOne(nodeIndex), pageable);
				break;
				
			default :
				return Header.ERROR("잘못된 TreeIndex 입니다");
		}
		
		List<AdminUserResponse> userResponseList = users.stream().map(user -> userResponse(user)).collect(Collectors.toList());
		
		Pagination pagination = Pagination.builder().totalPages(users.getTotalPages())
				.totalElements(users.getTotalElements()).currentPage(users.getNumber())
				.currentElements(users.getNumberOfElements()).nodeType(nodeType)
				.nodeIndex(nodeIndex).build();
		
		return Header.OK(userResponseList, pagination);
	}
	
	public Header<TreeResponse> readCompany() {
		Map<String, Boolean> state = new HashMap<String, Boolean>();
		
		state.put("opened", true);
		state.put("selected", true);
		
		TreeResponse company = TreeResponse.builder()
				.id("company:1")
				.text("더존공장")
				.state(state)
				.children(readArea())
				.build();
		
		return Header.OK(company);
	}
	
	
	public List<TreeResponse> readArea() {
		
		List<AreaTb> areas = areaRepository.findAll();
		
		List<TreeResponse> areaList = areas.stream().map(area -> areaResponse(area)).collect(Collectors.toList());
		
		return areaList;
	}
	
	public List<TreeResponse> readBranch(Long areaIndex, String parent) {
		
		List<BranchTb> branchs = branchRepository.findByArea(areaRepository.getOne(areaIndex));
		
		List<TreeResponse> branchList = branchs.stream().map(branch -> branchResponse(branch)).collect(Collectors.toList());
		
		return branchList;
	}
	
	private AdminUserResponse userResponse(UserTb user) {
		AdminUserResponse adminUserResponse = AdminUserResponse.builder()
				.userId(user.getUserId()).userName(user.getUserName()).userEmail(user.getUserEmail())
				.userPhone(user.getUserPhone()).branchName(user.getBranch()
				.getBranchName()).userPosition(user.getUserPosition())
				.build();
		
		return adminUserResponse;
	}
	
	private TreeResponse areaOnlyResponse(AreaTb area) {
		TreeResponse treeResponse = TreeResponse.builder().id("area:" + area.getAreaIndex())
				.text(area.getAreaName()).build();
		
		return treeResponse;
	}
	
	private TreeResponse areaResponse(AreaTb area) {
		String childParent = "area:" + area.getAreaIndex();
		
		TreeResponse treeResponse = TreeResponse.builder().id("area:" + area.getAreaIndex())
				.text(area.getAreaName())
				.children(readBranch(area.getAreaIndex(), childParent)).build();
		
		return treeResponse;
	}
	
	private TreeResponse branchResponse(BranchTb branch) {
		TreeResponse treeResponse = TreeResponse.builder().id("branch:" + branch.getBranchIndex())
				.text(branch.getBranchName())
				.build();
		
		return treeResponse;
	}
}