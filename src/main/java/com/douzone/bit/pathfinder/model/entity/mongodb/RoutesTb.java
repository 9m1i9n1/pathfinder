package com.douzone.bit.pathfinder.model.entity.mongodb;

import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Document(collection = "routes")
public class RoutesTb {

	private String hindex;
	private Object[] detail;
}
