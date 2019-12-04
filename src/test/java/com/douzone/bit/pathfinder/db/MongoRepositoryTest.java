package com.douzone.bit.pathfinder.db;

import java.util.Calendar;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import com.douzone.bit.pathfinder.PathfinderApplicationTests;
import com.douzone.bit.pathfinder.model.entity.mongodb.HistoryTb;
import com.douzone.bit.pathfinder.repository.mongodb.HistoryRepository;
import com.douzone.bit.pathfinder.repository.mongodb.RoutesRepository;
import com.douzone.bit.pathfinder.service.HistoryService;

public class MongoRepositoryTest extends PathfinderApplicationTests {

	@Autowired
	private HistoryRepository historyRepository;

	@Autowired
	private RoutesRepository routesRepository;

	@Autowired
	private HistoryService historyService;
	
	@Autowired
	private MongoTemplate mongo;

	// 다 들고오기
	// ------------------------------------------------------------------------------------------

	@Test
	public void printTest() {
		Query q = new Query();
		
		q.addCriteria(Criteria.where("arrivedate").gte(Calendar.getInstance().getTime()));
		
		List<HistoryTb> a = mongo.find(q, HistoryTb.class, "history");
		
		System.out.println("historyRepository - " + a);
	}

//	@Test
//	public void printReser() {
//		System.out.println("reservationRepository - " + reservationRepository.findAll());
//	}

//	@Test
//	public void printRoutes() {
//		System.out.println("routesRepository - " + routesRepository.findAll());		
//	}
	// ------------------------------------------------------------------------------------------

	// h인덱스로 값 찾기
//	@Test
//	public void printRoutesByHistoryId() {
//		System.out.println("h인덱스로 루트 전체 찾기 - " + routesRepository.findByHindex(new ObjectId("5de0a549c5b7970d02de8fea")));
//	}

//	@Test
//	public void printHistoryByRoutesId() {
//		System.out.println("루트로 히스토리 전체 찾기 - " + historyRepository.findByRoutes(new ObjectId("5de0a5a6c5b7970d02de8feb")));
//	}

//	@Test
//	public void insertTime() {
//		HistoryTb history = new HistoryTb();
//		
//		history.setArrivedate(Calendar.getInstance().getTime());
//		
//		historyRepository.save(history);
//	}
}
