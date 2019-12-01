package com.douzone.bit.pathfinder.db;

import org.bson.types.ObjectId;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.douzone.bit.pathfinder.PathfinderApplicationTests;
import com.douzone.bit.pathfinder.repository.mongodb.HistoryRepository;
import com.douzone.bit.pathfinder.repository.mongodb.ReservationRepository;
import com.douzone.bit.pathfinder.repository.mongodb.RoutesRepository;

public class MongoRepositoryTest extends PathfinderApplicationTests {

	@Autowired
	private HistoryRepository historyRepository;
	
	@Autowired
	private ReservationRepository reservationRepository;
	
	@Autowired
	private RoutesRepository routesRepository;
	
	//다 들고오기
	//------------------------------------------------------------------------------------------
	
	@Test
	public void printTest() {
		System.out.println("historyRepository - " + historyRepository.findAll());
	}
	
	@Test
	public void printReser() {
		System.out.println("reservationRepository - " + reservationRepository.findAll());
	}
	
	@Test
	public void printRoutes() {
		System.out.println("routesRepository - " + routesRepository.findAll());		
	}
	//------------------------------------------------------------------------------------------
	
	//h인덱스로 값 찾기
	@Test
	public void printRoutesByHistoryId() {
		System.out.println("h인덱스로 루트 전체 찾기 - " + routesRepository.findByHindex(new ObjectId("5de0a549c5b7970d02de8fea")));
	}

	@Test
	public void printHistoryByRoutesId() {
		System.out.println("루트로 히스토리 전체 찾기 - " + historyRepository.findByRoutes(new ObjectId("5de0a5a6c5b7970d02de8feb")));
	}
}
