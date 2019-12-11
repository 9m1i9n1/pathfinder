package com.douzone.bit.pathfinder.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.entity.mongodb.HistoryTb;
import com.douzone.bit.pathfinder.model.entity.mongodb.RoutesTb;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.request.HistoryRequest;
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
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		RoutesTb routesTb = RoutesTb.builder().detail(routeList.getRoutes()).build();
		routesTb = routesRepository.save(routesTb);

		if (routesTb != null) {
			try {
				HistoryTb historyTb = HistoryTb.builder().username(userName).carname(routeList.getCarIndex())
						.dep(routeList.getDep()).arvl(routeList.getArvl()).dist(routeList.getDist()).fee(routeList.getFee())
						.dlvrdate(formatter.parse(routeList.getDlvrdate())).arrivedate(formatter.parse(routeList.getArrivedate()))
						.routes(routesTb.getId()).build();

				historyRepository.save(historyTb);
			} catch (Exception e) {
				routesRepository.deleteById(routesTb.getId().toString());

				return Header.ERROR("데이터 삽입에 실패했습니다!");
			}
		}

		return Header.OK("데이터 삽입에 성공했습니다!");
	}

	public Header<List<String>> getDate(Long carIndex) {
		SimpleDateFormat format = new SimpleDateFormat("yyy-MM-dd");

		List<String> disableDate = new ArrayList<String>();

		Calendar startCal = Calendar.getInstance();
		startCal.set(Calendar.HOUR_OF_DAY, 0);
		startCal.set(Calendar.MINUTE, 0);
		startCal.set(Calendar.SECOND, 0);

		Calendar endCal = Calendar.getInstance();
		endCal.add(Calendar.MONTH, 3);
		endCal.set(Calendar.HOUR_OF_DAY, 0);
		endCal.set(Calendar.MINUTE, 0);
		endCal.set(Calendar.SECOND, 0);

		Calendar sample = Calendar.getInstance();

		Date start = startCal.getTime();
		Date end = endCal.getTime();

		List<HistoryTb> dateList = historyRepository.findAllByCarnameAndDate(carIndex, start, end);

		// if (dateList != null) {
		// for (int date = 0; date < dateList.size(); date++) {
		// Date listStart = dateList.get(date).getDlvrdate();
		// Date listEnd = dateList.get(date).getArrivedate();

		// sample.setTime(listStart);

		// while (sample.getTime().before(listEnd)) {
		// disableDate.add(format.format(sample.getTime()));
		// sample.add(Calendar.DATE, 1);
		// }
		// }
		// } else {
		// return Header.ERROR("Empty Date");
		// }

		return Header.OK(disableDate);
	}
}
