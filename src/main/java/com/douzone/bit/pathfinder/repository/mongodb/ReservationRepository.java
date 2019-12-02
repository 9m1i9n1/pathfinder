package com.douzone.bit.pathfinder.repository.mongodb;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.douzone.bit.pathfinder.model.entity.mongodb.ReservationTb;

public interface ReservationRepository extends MongoRepository<ReservationTb, String> {

	Object findByIndex(String string);
}
