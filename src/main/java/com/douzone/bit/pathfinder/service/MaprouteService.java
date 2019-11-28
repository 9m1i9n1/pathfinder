package com.douzone.bit.pathfinder.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.entity.RouteDTO;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.response.AdminBranchResponse;
import com.douzone.bit.pathfinder.repository.BranchRepository;
import com.douzone.bit.pathfinder.service.algorithm.Recursive;
import com.douzone.bit.pathfinder.service.algorithm.createMap;

@Service
public class MaprouteService {
	Logger logger = LoggerFactory.getLogger(MaprouteService.class);

	@SuppressWarnings({ "rawtypes" })
	public List<RouteDTO> tryCalc(ArrayList<Map> list) {
		// TODO Auto-generated method stub
		ArrayList<RouteDTO> testList = new ArrayList<RouteDTO>();
		List<RouteDTO> sucList = new ArrayList<RouteDTO>();

		for (int i = 0; i < list.size(); i++) {
			testList.add(new RouteDTO());
			testList.get(i).setBranch_name(list.get(i).get("branch_name").toString());
			testList.get(i).setBranch_value(Integer.parseInt(list.get(i).get("branch_value").toString()));
			testList.get(i).setBranch_lat(Double.valueOf(list.get(i).get("branch_lat").toString()).doubleValue());
			testList.get(i).setBranch_lng(Double.valueOf(list.get(i).get("branch_lng").toString()).doubleValue());
		}

		createMap m = new createMap(list, testList);

		Recursive r = new Recursive(0, m.getmap());

		List<Integer> TourList = r.getTour();
		for (int i = 0; i < TourList.size() - 1; i++) {
			testList.get(TourList.get(i)).setPriceBetweenAandB(m.getmap()[TourList.get(i)][TourList.get(i + 1)]);

		}
		for (int i = 0; i < testList.size(); i++) {
			sucList.add(testList.get(Integer.parseInt(TourList.get(i).toString())));
		}

		return sucList;
	}

	@Autowired
	BranchRepository testDao;

	// list
	public Header<List<AdminBranchResponse>> branchLoading() {
		List<BranchTb> branchs = testDao.findAll();

		List<AdminBranchResponse> branchList = branchs.stream().map(branch -> response(branch))
				.collect(Collectors.toList());

		return Header.OK(branchList);
	}

	// Response 데이터 파싱
	private AdminBranchResponse response(BranchTb branch) {
		AdminBranchResponse adminBranchResponse = AdminBranchResponse.builder().branchIndex(branch.getBranchIndex())
				.branchName(branch.getBranchName()).branchOwner(branch.getBranchOwner()).branchValue(branch.getBranchValue())
				.branchAddr(branch.getBranchAddr()).branchDaddr(branch.getBranchDaddr()).branchPhone(branch.getBranchPhone())
				.branchLat(branch.getBranchLat()).branchLng(branch.getBranchLng()).area(branch.getArea().getAreaName())
				.areaIndex(branch.getArea().getAreaIndex()).build();
		return adminBranchResponse;
	}

	public Header<List<AdminBranchResponse>> search(String searchType, String keyword) {
		// TODO Auto-generated method stub
		List<BranchTb> branchs = null;
		List<AdminBranchResponse> branchResponseList = null;
		switch (searchType) {
		case "branchName": {
			branchs = testDao.findByBranchNameLike("%" + keyword + "%");
			branchResponseList = branchs.stream().map(branch -> response(branch)).collect(Collectors.toList());
			break;
		}
		default:
			break;
		}
		return Header.OK(branchResponseList);
	}
}
