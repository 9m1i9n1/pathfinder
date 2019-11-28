package com.douzone.bit.pathfinder.db;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.douzone.bit.pathfinder.PathfinderApplicationTests;
import com.douzone.bit.pathfinder.repository.MongoTestRepository;

public class MongoRepositoryTest extends PathfinderApplicationTests {

	@Autowired
	private MongoTestRepository mongoTestRepository;
	
	@Test
	public void printTest() {
		System.out.println(mongoTestRepository.findAll());
	}
}
