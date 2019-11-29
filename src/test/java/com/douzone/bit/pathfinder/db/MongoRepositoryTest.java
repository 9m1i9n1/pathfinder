package com.douzone.bit.pathfinder.db;

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
}
