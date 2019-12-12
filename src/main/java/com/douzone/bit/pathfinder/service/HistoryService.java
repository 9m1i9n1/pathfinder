package com.douzone.bit.pathfinder.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.repository.support.QuerydslRepositorySupport;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.entity.mongodb.HistoryTb;
import com.douzone.bit.pathfinder.model.entity.mongodb.RoutesTb;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.Pagination;
import com.douzone.bit.pathfinder.model.network.response.HistoryResponse;
import com.douzone.bit.pathfinder.model.network.response.HistoryRoutesResponse;
import com.douzone.bit.pathfinder.repository.CarRepository;
import com.douzone.bit.pathfinder.repository.mongodb.HistoryRepository;
import com.douzone.bit.pathfinder.repository.mongodb.RoutesRepository;

@Service
@Transactional
public class HistoryService extends QuerydslRepositorySupport {

	@Autowired
	private MongoOperations mongoOperations;

	public HistoryService(MongoOperations operations) {
		super(operations);
		// TODO Auto-generated constructor stub
	}

	@Autowired
	private HistoryRepository historyRepository;

	@Autowired
	private RoutesRepository routesRepository;

	@Autowired
	private CarRepository carRepository;

	public Header<List<HistoryResponse>> readHistory(int page, String id, boolean myhistory, String keyword) {
		Pageable pageable;
		Page<HistoryTb> historys = null;
		String userName = null;
		Date date = null;
		if (myhistory) {
			userName = SecurityContextHolder.getContext().getAuthentication().getName();
		}

		try {
			if (keyword != null) {
				SimpleDateFormat transDate = new SimpleDateFormat("yyyy-MM-dd");

				date = transDate.parse(keyword);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}

		switch (id) {
		case "will":
			pageable = PageRequest.of(page, 10, Sort.by("dlvrdate").ascending());
			if (keyword == null) {
				historys = (myhistory)
						? historyRepository.findAllByWillAndUsername(pageable, Calendar.getInstance().getTime(), userName)
						: historyRepository.findAllByWill(pageable, Calendar.getInstance().getTime());
			} else {
				historys = (myhistory)
						? historyRepository.findAllByWillAndUsernameAndDate(pageable, Calendar.getInstance().getTime(), userName,
								date)
						: historyRepository.findAllByWillAndDate(pageable, Calendar.getInstance().getTime(), date);
			}

			break;
		case "ing":
			pageable = PageRequest.of(page, 10, Sort.by("arrivedate").ascending());
			if (keyword == null) {
				historys = (myhistory)
						? historyRepository.findAllByIngAndUsername(pageable, Calendar.getInstance().getTime(), userName)
						: historyRepository.findAllByIng(pageable, Calendar.getInstance().getTime());
			} else {
				historys = (myhistory)
						? historyRepository.findAllByIngAndUsernameAndDate(pageable, Calendar.getInstance().getTime(), userName,
								date)
						: historyRepository.findAllByIngAndDate(pageable, Calendar.getInstance().getTime(), date);
			}

			break;
		case "pp":
			pageable = PageRequest.of(page, 10, Sort.by("arrivedate").descending());
			if (keyword == null) {
				historys = (myhistory)
						? historyRepository.findAllByPpAndUsername(pageable, Calendar.getInstance().getTime(), userName)
						: historyRepository.findAllByPp(pageable, Calendar.getInstance().getTime());
			} else {
				historys = (myhistory)
						? historyRepository.findAllByPpAndUsernameAndDate(pageable, Calendar.getInstance().getTime(), userName,
								date)
						: historyRepository.findAllByPpAndDate(pageable, Calendar.getInstance().getTime(), date);
			}

			break;
		}

		if (historys.getTotalElements() == 0) {
			return Header.ERROR("조회 결과가 없습니다.");
		}

		List<HistoryResponse> historyList = historys.stream().map(history -> historyResponse(history))
				.collect(Collectors.toList());

		if (historyList == null) {
			return Header.ERROR("에러가 발생하였습니다.");
		}

		Pagination pagination = Pagination.builder().totalPages(historys.getTotalPages())
				.totalElements(historys.getTotalElements()).currentPage(historys.getNumber())
				.currentElements(historys.getNumberOfElements()).build();

		return Header.OK(historyList, pagination);
	}

	public Header<List<HistoryResponse>> readRecentlyHistoryUseHome() {

		SecurityContext securityContext = SecurityContextHolder.getContext();

		String username = securityContext.getAuthentication().getName();
		Date currentTime = Calendar.getInstance().getTime();

		Pageable pageable = PageRequest.of(0, 5, Sort.by("regdate").descending());
		Page<HistoryTb> historys = historyRepository.findByUsernameLike(username, pageable);
		if (historys.getTotalElements() == 0) {
			return Header.ERROR("조회 결과가 없습니다.");
		}

		List<HistoryResponse> historyList = historys.stream().map(history -> historyResponse(history))
				.collect(Collectors.toList());

		if (historyList == null) {
			return Header.ERROR("에러가 발생하였습니다.");
		}

		for (int i = 0; i < historyList.size(); i++) {
			try {
				Date start = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(historyList.get(i).getDlvrdate());// 출발
				Date end = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(historyList.get(i).getArrivedate());// 도착

				// end가 currnt보다 느림
				if (currentTime.compareTo(end) > 0) {
					historyList.get(i).setStat(-1);
				} else if (currentTime.compareTo(start) > 0) {
					historyList.get(i).setStat(0);
				} else {
					historyList.get(i).setStat(1);
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if (historys.getTotalElements() == 0) {
			return Header.ERROR("조회 결과가 없습니다.");
		}
		return Header.OK(historyList);
	}

	public Header<List<HistoryResponse>> readTodayHistoryUseHome() {

		SecurityContext securityContext = SecurityContextHolder.getContext();

		String username = securityContext.getAuthentication().getName();

		Date currentTime = Calendar.getInstance().getTime();

		Pageable pageable = PageRequest.of(0, 5, Sort.by("arrivedate").descending());
		Page<HistoryTb> historys = historyRepository.findAllByIng(pageable, Calendar.getInstance().getTime());
		if (historys.getTotalElements() == 0) {
			return Header.ERROR("조회 결과가 없습니다.");
		}

		List<HistoryResponse> historyList = historys.stream().map(history -> historyResponse(history))
				.collect(Collectors.toList());

		if (historyList == null) {
			return Header.ERROR("에러가 발생하였습니다.");
		}

		for (int i = 0; i < historyList.size(); i++) {
			try {
				Date start = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(historyList.get(i).getDlvrdate());// 출발
				Date end = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(historyList.get(i).getArrivedate());// 도착

				// end가 currnt보다 느림
				if (currentTime.compareTo(end) > 0) {
					historyList.get(i).setStat(-1);
				} else if (currentTime.compareTo(start) > 0) {
					historyList.get(i).setStat(0);
				} else {
					historyList.get(i).setStat(1);
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		if (historys.getTotalElements() == 0) {
			return Header.ERROR("조회 결과가 없습니다.");
		}

		return Header.OK(historyList);
	}

	public Header<HistoryRoutesResponse> readRoutes(ObjectId id) {

		RoutesTb routesTb = routesRepository.findById(id);

		HistoryRoutesResponse routes = routesResponse(routesTb);

		return Header.OK(routes);
	}

	// TODO hindex로 제거하는게 아니라 부모가 가지고 있던 Routes의 Index 값으로 삭제 구현
	public Header<String> removeRoutes(ObjectId id) {

		HistoryTb history = historyRepository.findById(id);
		historyRepository.deleteById(id.toString());
		routesRepository.deleteById(history.getRoutes().toString());

		return Header.OK();
	}

	private HistoryResponse historyResponse(HistoryTb history) {

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String carNumber = carRepository.findByCarIndex(history.getCarIndex()).getCarNumber();

		try {
			// HistoryResponse response =
			// HistoryResponse.builder().id(history.getId()).regdate(format.format(history.getRegdate()))
			// .username(history.getUsername()).carname(carNumber).dep(history.getDep())
			// .arvl(history.getArvl()).dist(history.getDist()).fee(history.getFee())
			// .dlvrdate(format.format(history.getDlvrdate())).arrivedate(format.format(history.getArrivedate()))
			// .routes(history.getRoutes().toString()).build();

			// return response;
		} catch (Exception e) {

			return null;
		}
		// 삭제요망
		return null;
	}

	private HistoryRoutesResponse routesResponse(RoutesTb routes) {

		HistoryRoutesResponse response = HistoryRoutesResponse.builder()/* .hindex(routes.getHindex()) */
				.detail(routes.getDetail()).build();

		return response;
	}

	public Header<List<HistoryTb>> historyAll() {
		return Header.OK(historyRepository.findAll());
	}

	public double todayHistoryPercent() {
		// 현재시간
		Calendar nowTime = Calendar.getInstance();

		// 오늘날짜 2019-12-10 00:00:00
		Calendar todayDate = Calendar.getInstance();
		todayDate.set(Calendar.HOUR, 0);
		todayDate.set(Calendar.MINUTE, 0);
		todayDate.set(Calendar.SECOND, 0);

		// 내일날짜 2019-12-11 00:00:00
		Calendar tomorrowDate = Calendar.getInstance();
		tomorrowDate.add(Calendar.DAY_OF_MONTH, 1);
		tomorrowDate.set(Calendar.HOUR, 0);
		tomorrowDate.set(Calendar.MINUTE, 0);
		tomorrowDate.set(Calendar.SECOND, 0);

		int denominator = historyRepository.findAllByTotalToday(todayDate.getTime(), tomorrowDate.getTime());
		int molecular = historyRepository.findAllByDoingToday(todayDate.getTime(), tomorrowDate.getTime(),
				nowTime.getTime());
		if (molecular == 0)
			return 0;
		double result = Math.round(((double) molecular / (double) denominator) * 1000) / 10.00;
		return result;
	}

}