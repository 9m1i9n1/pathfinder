package com.douzone.bit.pathfinder.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.douzone.bit.pathfinder.model.entity.HistoryTb;

public interface MongoTestRepository extends MongoRepository<HistoryTb, String> {
	public HistoryTb findByName(String name);
}
