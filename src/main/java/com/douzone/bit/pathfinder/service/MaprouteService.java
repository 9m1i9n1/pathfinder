package com.douzone.bit.pathfinder.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.request.MaprouteRequest;
import com.douzone.bit.pathfinder.model.network.response.AdminBranchResponse;
import com.douzone.bit.pathfinder.model.network.response.MaprouteResponse;
import com.douzone.bit.pathfinder.service.algorithm.CreateMap;
import com.douzone.bit.pathfinder.service.algorithm.Recursive;

@Service
@Transactional
public class MaprouteService {
	public Header<List<MaprouteResponse>> markerSort(List<MaprouteRequest> markerList) {
		CreateMap createMap = new CreateMap(markerList);

		Recursive recursive = new Recursive(createMap.getMap());
		List<Integer> sortList = recursive.getTour();

		System.out.println(sortList);

		return null;
	}

	// @SuppressWarnings({ "rawtypes" })
	// public List<RouteDTO> tryCalc(ArrayList<Map> list) {
	// // TODO Auto-generated method stub
	// ArrayList<RouteDTO> testList = new ArrayList<RouteDTO>();
	// List<RouteDTO> sucList = new ArrayList<RouteDTO>();

	// // 여기서 도시번호를 정해줬다.
	// for (int i = 0; i < list.size(); i++) {
	// testList.add(new RouteDTO());
	// testList.get(i).setBranch_name(list.get(i).get("branch_name").toString());
	// testList.get(i).setBranch_value(Integer.parseInt(list.get(i).get("branch_value").toString()));
	// testList.get(i).setBranch_lat(Double.valueOf(list.get(i).get("branch_lat").toString()).doubleValue());
	// testList.get(i).setBranch_lng(Double.valueOf(list.get(i).get("branch_lng").toString()).doubleValue());
	// }

	// createMap m = new createMap(list, testList);

	// Recursive r = new Recursive(0, m.getmap());

	// List<Integer> TourList = r.getTour();

	// // 여기서 구간 비용이 나온다.
	// for (int i = 0; i < TourList.size() - 1; i++) {
	// testList.get(TourList.get(i)).setPriceBetweenAandB(m.getmap()[TourList.get(i)][TourList.get(i
	// + 1)]);

	// }

	// // 정렬이 된 아이들 DTO LIST
	// for (int i = 0; i < testList.size(); i++) {
	// sucList.add(testList.get(Integer.parseInt(TourList.get(i).toString())));
	// }

	// return sucList;
	// }

	// Response 데이터 파싱
	private AdminBranchResponse response(BranchTb branch) {
		AdminBranchResponse adminBranchResponse = AdminBranchResponse.builder().branchIndex(branch.getBranchIndex())
				.branchName(branch.getBranchName()).branchOwner(branch.getBranchOwner()).branchValue(branch.getBranchValue())
				.branchAddr(branch.getBranchAddr()).branchDaddr(branch.getBranchDaddr()).branchPhone(branch.getBranchPhone())
				.branchLat(branch.getBranchLat()).branchLng(branch.getBranchLng()).area(branch.getArea().getAreaName())
				.areaIndex(branch.getArea().getAreaIndex()).build();
		return adminBranchResponse;
	}
}
