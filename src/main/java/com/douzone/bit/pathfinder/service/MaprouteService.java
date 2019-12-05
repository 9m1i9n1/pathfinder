package com.douzone.bit.pathfinder.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.request.MaprouteRequest;
import com.douzone.bit.pathfinder.model.network.response.MaprouteResponse;
import com.douzone.bit.pathfinder.service.algorithm.CreateMap;
import com.douzone.bit.pathfinder.service.algorithm.Recursive;

@Service
@Transactional
public class MaprouteService {
	private CreateMap createMap;
	private Recursive recursive;

	public Header<List<MaprouteResponse>> markerSort(List<MaprouteRequest> markerList) {
		createMap = new CreateMap(markerList);
		recursive = new Recursive(createMap.getMap());

		List<List<Double>> sortIndexList = recursive.getTour();
		List<MaprouteResponse> sortMarkerList = createMap.getSortList(sortIndexList);

		return Header.OK(sortMarkerList);
	}
}
