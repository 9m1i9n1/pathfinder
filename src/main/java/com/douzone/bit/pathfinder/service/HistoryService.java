package com.douzone.bit.pathfinder.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.repository.support.QuerydslRepositorySupport;
import org.springframework.data.repository.support.PageableExecutionUtils;

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



	public Header<List<HistoryResponse>> readHistory(Pageable pageable, String id) {

		Page<HistoryTb> historys = null;
		

		switch(id) {
			case "will" :
				historys = historyRepository.findAllByWill(pageable, Calendar.getInstance().getTime());
				break;
			case "ing" :
				historys = historyRepository.findAllByIng(pageable, Calendar.getInstance().getTime());
				break;
			case "pp" :
				historys = historyRepository.findAllByPp(pageable, Calendar.getInstance().getTime());
				break;
		}
		
		List<HistoryResponse> historyList = historys.stream().map(history -> historyResponse(history))
				.collect(Collectors.toList());

		System.out.println("totalpage: " + historys.getTotalPages());
		System.out.println("totalelements: " + historys.getTotalElements());
		System.out.println("getNumber: " + historys.getNumber());
		System.out.println("NumberOfElements: " + historys.getNumberOfElements());
		
		Pagination pagination = Pagination.builder()
				.totalPages(historys.getTotalPages())
				.totalElements(historys.getTotalElements())
				.currentPage(historys.getNumber())
				.currentElements(historys.getNumberOfElements()).build();

		return Header.OK(historyList, pagination);
	}


	//검색
	public Header<List<HistoryResponse>> searchHistory(Pageable pageable, String searchType, String keyword) {

		List<HistoryResponse> historyResponseList = null;
		Page<HistoryTb> historys = null;

		switch (searchType) {
		case "carname":
			historys = historyRepository.findByCarnameLike(keyword, pageable);
			System.out.println(historys);
			historyResponseList = historys.stream().map(history -> historyResponse(history))
					.collect(Collectors.toList());
			break;

		case "regdate": 
			historys = historyRepository.findByRegdate(keyword , pageable);
			System.out.println(historys);
			historyResponseList = historys.stream().map(history -> historyResponse(history))
					.collect(Collectors.toList());
			break;

		case "username":
			historys = historyRepository.findByUsernameLike(keyword, pageable);
			historyResponseList = historys.stream().map(history -> historyResponse(history))
					.collect(Collectors.toList());
			break;

		case "dep":
			historys = historyRepository.findByDep(keyword, pageable);
			historyResponseList = historys.stream().map(history -> historyResponse(history))
					.collect(Collectors.toList());
			break;

		case "arvl":
			historys = historyRepository.findByArvl(keyword, pageable);
			historyResponseList = historys.stream().map(history -> historyResponse(history))
					.collect(Collectors.toList());
			break;
		}

		Pagination pagination = Pagination.builder().totalPages(historys.getTotalPages())
				.totalElements(historys.getTotalElements()).currentPage(historys.getNumber())
				.currentElements(historys.getNumberOfElements()).build();

		return Header.OK(historyResponseList, pagination);
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

	public ArrayList<String> calcDate (String startDate, String EndDate) {
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

		HistoryResponse response = HistoryResponse.builder().id(history.getId()).regdate(history.getRegdate())

				.username(history.getUsername()).carname(history.getCarname()).dep(history.getDep())
				.arvl(history.getArvl()).dist(history.getDist()).fee(history.getFee()).dlvrdate(history.getDlvrdate())
				.arrivedate(history.getArrivedate()).routes(history.getRoutes()).build();

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
}