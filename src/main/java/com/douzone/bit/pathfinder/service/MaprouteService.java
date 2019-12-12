package com.douzone.bit.pathfinder.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.entity.mongodb.HistoryTb;
import com.douzone.bit.pathfinder.model.entity.mongodb.RoutesTb;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.request.MaprouteInsertRequest;
import com.douzone.bit.pathfinder.model.network.request.MaprouteSortRequest;
import com.douzone.bit.pathfinder.model.network.response.MaprouteResponse;
import com.douzone.bit.pathfinder.repository.mongodb.HistoryRepository;
import com.douzone.bit.pathfinder.repository.mongodb.RoutesRepository;
import com.douzone.bit.pathfinder.service.algorithm.CreateMap;
import com.douzone.bit.pathfinder.service.algorithm.Recursive;

@Service
@Transactional
public class MaprouteService {

	@Autowired
	HistoryRepository historyRepository;

	@Autowired
	RoutesRepository routesRepository;

	private CreateMap createMap;
	private Recursive recursive;

	// sortData 처리
	public Header<List<MaprouteResponse>> markerSort(List<MaprouteSortRequest> markerList) {
		createMap = new CreateMap(markerList);
		recursive = new Recursive(createMap.getMap());

		List<List<Double>> sortIndexList = recursive.getTour();
		List<MaprouteResponse> sortMarkerList = createMap.getSortList(sortIndexList);

		return Header.OK(sortMarkerList);
	}

	// route정보 Insert
	public Header<String> insertPlan(MaprouteInsertRequest routeList) {
		String userName = SecurityContextHolder.getContext().getAuthentication().getName();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

		// RoutesTb도 Exception 처리 해야함.
		RoutesTb routesTb = RoutesTb.builder().detail(routeList.getRoutes()).build();
		routesTb = routesRepository.save(routesTb);

		if (routesTb != null) {
			try {
				HistoryTb history = HistoryTb.builder().regdate(LocalDateTime.now()).username(userName)
						.carIndex(routeList.getCarIndex()).dep(routeList.getDep()).arvl(routeList.getArvl())
						.dist(routeList.getDist()).fee(routeList.getFee())
						.dlvrdate(LocalDateTime.parse(routeList.getDlvrdate(), formatter))
						.arrivedate(LocalDateTime.parse(routeList.getArrivedate(), formatter)).routes(routesTb.getId()).build();

				System.out.println("#historytb" + history);

				historyRepository.save(history);
			} catch (Exception e) {
				routesRepository.deleteById(routesTb.getId().toString());

				return Header.ERROR("예약되지 못했습니다.");
			}
		}

		return Header.OK("예약되었습니다.");
	}

	// 차량선택시 예약 날짜 던지기
	public Header<List<String>> getReserveDate(Long carIndex) {
		LocalDateTime startDate = LocalDate.now().atTime(0, 0);
		LocalDateTime endDate = startDate.plusMonths(3);

		List<HistoryTb> historyList = historyRepository.findAllByCarnameAndDate(carIndex, startDate, endDate);

		List<String> disableDates = new ArrayList<>();

		for (HistoryTb history : historyList) {
			LocalDateTime start = history.getDlvrdate();
			LocalDateTime end = history.getArrivedate();

			for (LocalDateTime d = start; !d.isAfter(end); d = d.plusDays(1)) {
				disableDates.add(d.toString());
			}
		}

		return Header.OK(disableDates);
	}
}
