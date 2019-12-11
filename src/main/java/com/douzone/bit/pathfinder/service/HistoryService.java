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
						? historyRepository.findAllByWillAndUsername(pageable, Calendar.getInstance().getTime(),
								userName)
						: historyRepository.findAllByWill(pageable, Calendar.getInstance().getTime());
			} else {
				historys = (myhistory)
						? historyRepository.findAllByWillAndUsernameAndDate(pageable, Calendar.getInstance().getTime(),
								userName, date)
						: historyRepository.findAllByWillAndDate(pageable, Calendar.getInstance().getTime(), date);
			}

			break;
		case "ing":
			pageable = PageRequest.of(page, 10, Sort.by("arrivedate").ascending());
			if (keyword == null) {
				historys = (myhistory)
						? historyRepository.findAllByIngAndUsername(pageable, Calendar.getInstance().getTime(),
								userName)
						: historyRepository.findAllByIng(pageable, Calendar.getInstance().getTime());
			} else {
				historys = (myhistory)
						? historyRepository.findAllByIngAndUsernameAndDate(pageable, Calendar.getInstance().getTime(),
								userName, date)
						: historyRepository.findAllByIngAndDate(pageable, Calendar.getInstance().getTime(), date);
			}

			break;
		case "pp":
			pageable = PageRequest.of(page, 10, Sort.by("arrivedate").descending());
			if (keyword == null) {
				historys = (myhistory)
						? historyRepository.findAllByPpAndUsername(pageable, Calendar.getInstance().getTime(), userName)
						: historyRepository.findAllByPp(pageable, Calendar.getInstance().getTime() );
			} else {
				historys = (myhistory)
						? historyRepository.findAllByPpAndUsernameAndDate(pageable, Calendar.getInstance().getTime(),
								userName, date)
						: historyRepository.findAllByPpAndDate(pageable, Calendar.getInstance().getTime(), date);
			}

			break;
		}

		if (historys.getTotalElements() == 0) {
			return Header.ERROR("조회 결과가 없습니다.");
		}

		List<HistoryResponse> historyList = historys.stream().map(history -> historyResponse(history))
				.collect(Collectors.toList());

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
		System.out.println("PageRequest - " + pageable);
		Page<HistoryTb> historys = historyRepository.findByUsernameLike(username, pageable);

		List<HistoryResponse> historyList = historys.stream().map(history -> historyResponse(history))
				.collect(Collectors.toList());
		
		for (int i = 0; i < historyList.size(); i++) {
			try {
				Date start = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(historyList.get(i).getDlvrdate());// 출발
				Date end = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(historyList.get(i).getArrivedate());// 도착

				// end가 currnt보다 느림
				if (currentTime.compareTo(end) > 0){
					historyList.get(i).setStat(-1);
				} else if (currentTime.compareTo(start) > 0){
					historyList.get(i).setStat(0);
				} else {
					historyList.get(i).setStat(1);				
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return Header.OK(historyList);
	}

	public Header<List<HistoryResponse>> readTodayHistoryUseHome() {

		SecurityContext securityContext = SecurityContextHolder.getContext();

		String username = securityContext.getAuthentication().getName();

		Date currentTime = Calendar.getInstance().getTime();
		
		Pageable pageable = PageRequest.of(0, 5, Sort.by("arrivedate").descending());
		Page<HistoryTb> historys = historyRepository.findAllByIng(pageable, Calendar.getInstance().getTime());

		List<HistoryResponse> historyList = historys.stream().map(history -> historyResponse(history))
				.collect(Collectors.toList());

		for (int i = 0; i < historyList.size(); i++) {
			try {
				Date start = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(historyList.get(i).getDlvrdate());// 출발
				Date end = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(historyList.get(i).getArrivedate());// 도착

				// end가 currnt보다 느림
				if (currentTime.compareTo(end) > 0){
					historyList.get(i).setStat(-1);
				} else if (currentTime.compareTo(start) > 0){
					historyList.get(i).setStat(0);
				} else {
					historyList.get(i).setStat(1);				
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		
		Pagination pagination = Pagination.builder().totalPages(historys.getTotalPages())
				.totalElements(historys.getTotalElements()).currentPage(historys.getNumber())
				.currentElements(historys.getNumberOfElements()).build();

		return Header.OK(historyList, pagination);
	}

	public Header<HistoryRoutesResponse> readRoutes(ObjectId id) {

		RoutesTb routesTb = routesRepository.findById(id);

		HistoryRoutesResponse routes = routesResponse(routesTb);

		return Header.OK(routes);
	}

	public Header<String> removeRoutes(HistoryTb history) {

		historyRepository.deleteById((history.getId().toString()));
		routesRepository.deleteByHindex(history.getId());

		return Header.OK();
	}

	public ArrayList<String> calcDate(String startDate, String EndDate) {
		String DATE_PATTERN = "yyyy-MM-dd";
		ArrayList<String> dates = new ArrayList<String>();

		try {
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);

			Date start = sdf.parse(startDate);
			Date end = sdf.parse(EndDate);

			Date currentDate = start;

			while (currentDate.compareTo(end) <= 0) {
				dates.add(sdf.format(currentDate));
				Calendar c = Calendar.getInstance();
				c.setTime(currentDate);
				c.add(Calendar.DAY_OF_MONTH, 1);
				currentDate = c.getTime();
			}

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dates;
	}

	private HistoryResponse historyResponse(HistoryTb history) {

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		HistoryResponse response = HistoryResponse.builder().id(history.getId()).regdate(history.getRegdate())
				.username(history.getUsername()).carname(history.getCarname()).dep(history.getDep())
				.arvl(history.getArvl()).dist(history.getDist()).fee(history.getFee())
				.dlvrdate(format.format(history.getDlvrdate())).arrivedate(format.format(history.getArrivedate()))
				.routes(history.getRoutes()).build();

		return response;
	}

	private HistoryRoutesResponse routesResponse(RoutesTb routes) {

		HistoryRoutesResponse response = HistoryRoutesResponse.builder().hindex(routes.getHindex())

				.detail(routes.getDetail()).build();

		return response;
	}
	

	public Header<List<HistoryResponse>> readHistoryTest(Pageable pageable) {

		Page<HistoryTb> historys = historyRepository.findAll(pageable);
		List<HistoryResponse> historyList = historys.stream().map(history -> historyResponse(history))
				.collect(Collectors.toList());

		Pagination pagination = Pagination.builder().totalPages(historys.getTotalPages())
				.totalElements(historys.getTotalElements()).currentPage(historys.getNumber())
				.currentElements(historys.getNumberOfElements()).build();

		return Header.OK(historyList, pagination);
	}

	public Header<List<HistoryTb>> historyAll() {
		System.out.println(historyRepository.findAll());
		return Header.OK(historyRepository.findAll());
	}

	
	public double todayHistoryPercent() {
	

	
	//현재시간
	Calendar nowTime = Calendar.getInstance();
	
	//오늘날짜 2019-12-10 00:00:00 
	Calendar todayDate = Calendar.getInstance();
	todayDate.set(Calendar.HOUR_OF_DAY, 0 );
	todayDate.set(Calendar.MINUTE, 0 );
	todayDate.set(Calendar.SECOND, 0 );
	
	//내일날짜 2019-12-11 00:00:00
	Calendar tomorrowDate = Calendar.getInstance();
	tomorrowDate.add(Calendar.DAY_OF_MONTH ,1);
	tomorrowDate.set(Calendar.HOUR_OF_DAY, 0 );
	tomorrowDate.set(Calendar.MINUTE, 0 );
	tomorrowDate.set(Calendar.SECOND, 0 );
	
	System.out.println("현재시간 : " + nowTime.getTime());
	System.out.println("오늘날짜" +todayDate.getTime());
	System.out.println("내일날짜" +tomorrowDate.getTime());
	
	int denominator = historyRepository.findAllByTotalToday(todayDate.getTime(), tomorrowDate.getTime());
	int molecular = historyRepository.findAllByDoingToday(todayDate.getTime(), tomorrowDate.getTime(), nowTime.getTime());
		System.out.println((double)denominator);
		System.out.println((double)molecular);
	double result = Math.round(((double)molecular/(double)denominator)*1000) /10.00;
	System.out.println(result);
	return result;
	}


}