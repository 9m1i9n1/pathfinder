package com.douzone.bit.pathfinder.repository.mongodb;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

import com.douzone.bit.pathfinder.model.entity.mongodb.RoutesTb;

public interface RoutesRepository extends MongoRepository<RoutesTb, String> {

	Object findByHindex(ObjectId hindex);

}
