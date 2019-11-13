package com.douzone.bit.pathfinder.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.entity.AreaTb;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.Pagination;
import com.douzone.bit.pathfinder.model.network.request.AdminBranchRequest;
import com.douzone.bit.pathfinder.model.network.response.AdminBranchResponse;
import com.douzone.bit.pathfinder.model.network.response.HierarchyResponse;
import com.douzone.bit.pathfinder.repository.AreaRepository;
import com.douzone.bit.pathfinder.repository.BranchRepository;
import com.douzone.bit.pathfinder.repository.UserRepository;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Service
public class AdminBranchService {

	@Autowired
	private BranchRepository branchRepository;

	@Autowired
	private AreaRepository areaRepository;

	// branch read
	public Optional<BranchTb> read(Long id) {

		return branchRepository.findById(id);
	}

	// branch create
	public Header<AdminBranchResponse> create(AdminBranchRequest request) {

		System.out.println(request);

		BranchTb branch = BranchTb.builder().branchAddr(request.getBranchAddr()).branchDaddr(request.getBranchDaddr())
				.branchLat(request.getBranchLat()).branchLng(request.getBranchLng())
				.branchPhone(request.getBranchPhone()).branchName(request.getBranchName())
				.branchOwner(request.getBranchOwner()).branchValue(request.getBranchValue())
				.area(areaRepository.getOne(request.getAreaIndex())).build();

		BranchTb newBranch = branchRepository.save(branch);

		return Header.OK(response(newBranch));

	}

	// branch page
	public Header<List<AdminBranchResponse>> listpage(Pageable pageable) {

		Page<BranchTb> branchs = branchRepository.findAll(pageable);

		List<AdminBranchResponse> branchResponseList = branchs.stream().map(branch -> response(branch))
				.collect(Collectors.toList());

		Pagination pagination = Pagination.builder().totalPages(branchs.getTotalPages())
				.totalElements(branchs.getTotalElements()).currentPage(branchs.getNumber())
				.currentElements(branchs.getNumberOfElements()).build();
		return Header.OK(branchResponseList, pagination);
	}

	// branch update
	public Header<AdminBranchResponse> update(AdminBranchRequest request) {

		Optional<BranchTb> optional = branchRepository.findById(request.getBranchIndex());

		return optional.map(branch -> {
			branch.setBranchName(request.getBranchName()).setBranchOwner(request.getBranchOwner())
					.setBranchPhone(request.getBranchPhone()).setBranchValue(request.getBranchValue())
					.setArea(areaRepository.getOne(request.getAreaIndex()));

			return branch;
		}).map(newBranch -> branchRepository.save(newBranch)).map(newBranch -> response(newBranch)).map(Header::OK)
				.orElseGet(() -> Header.ERROR("데이터 없음"));
	}

	// branch delete
	public Header delete(Long id) {
		return branchRepository.findById(id).map(branch -> {
			branchRepository.delete(branch);
			return Header.OK();
		}).orElseGet(() -> Header.ERROR("데이터 없음"));
	}

	private AdminBranchResponse response(BranchTb branch) {
		AdminBranchResponse adminBranchResponse = AdminBranchResponse.builder().branchIndex(branch.getBranchIndex())
				.branchName(branch.getBranchName()).branchOwner(branch.getBranchOwner())
				.branchValue(branch.getBranchValue()).branchAddr(branch.getBranchAddr())
				.branchDaddr(branch.getBranchDaddr()).branchPhone(branch.getBranchPhone())
				.branchLat(branch.getBranchLat()).branchLng(branch.getBranchLng()).area(branch.getArea().getAreaName())
				.areaIndex(branch.getArea().getAreaIndex()).build();
		return adminBranchResponse;
	}

	 public Header<HierarchyResponse> readCompany() {
		 Map<String, Boolean> state = new HashMap<String, Boolean>();

			state.put("opened", true);
			state.put("selected", true);
		 HierarchyResponse company = HierarchyResponse.builder()
		    .id("company:1")
		    .text("더존 공장")
		    .state(state)
		    .children(readArea())
		    .build();

		    return Header.OK(company);
		  }
	
	//지점 조직도 
	public List<HierarchyResponse> readArea() {

		List<AreaTb> areas = areaRepository.findAll();
		List<HierarchyResponse> areaList = areas.stream().map(area -> areaOnlyResponse(area)).collect(Collectors.toList());
		return areaList;
	}

	
	// jsTree response
	private HierarchyResponse areaOnlyResponse(AreaTb area) {
		HierarchyResponse treeResponse = HierarchyResponse.builder().id("area:" + area.getAreaIndex()).text(area.getAreaName())
				.build();

		return treeResponse;
	}
	// 지점 중복 검사
	  public Boolean branchCheck(String branchName) {

		    return !(branchRepository.existsByBranchName(branchName));
		  }
	
	// 지점 검색
	public Header<List<AdminBranchResponse>> search(Pageable pageable, String searchType, String keyword) {

		Page<BranchTb> branchs = null;
		List<AdminBranchResponse> branchResponseList = null;
		switch (searchType) {
		case "branchName":
			branchs = branchRepository.findByBranchNameLike("%" + keyword + "%", pageable);
			System.out.println(branchs);
			branchResponseList = branchs.stream().map(branch -> response(branch)).collect(Collectors.toList());
			break;

		case "area":
			//http://localhost:8181/admin/branchmanage/search?searchType=area&keyword=1
			branchs = branchRepository.findByArea(areaRepository.getOne(Long.parseLong(keyword)),pageable);
			branchResponseList = branchs.stream().map(branch -> response(branch)).collect(Collectors.toList());
			break;

		case "branchAddr":
			branchs = branchRepository.findByBranchAddrLike("%" + keyword + "%", pageable);
			branchResponseList = branchs.stream().map(branch -> response(branch)).collect(Collectors.toList());
			break;

		default:
			break;
		}
		
		Pagination pagination = Pagination.builder().totalPages(branchs.getTotalPages())
				.totalElements(branchs.getTotalElements()).currentPage(branchs.getNumber())
				.currentElements(branchs.getNumberOfElements()).build();

		return Header.OK(branchResponseList, pagination);

	}

}