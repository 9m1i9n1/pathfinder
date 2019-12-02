package com.douzone.bit.pathfinder.model.entity.mongodb;

import java.util.List;

import javax.persistence.Id;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Document(collection = "routes")
public class RoutesTb {

	private ObjectId hindex;
	@Id
	private ObjectId id;
	private String index;
	private List<Object> detail;
}
