package com.douzone.bit.pathfinder.model.entity.mongodb;

import java.time.LocalDateTime;
import java.util.List;

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

	private Long index;
	private LocalDateTime regDate;
	private String userName;
	private String dep;
	private String arvl;
	private Double dist;
	private Long fee;
	private LocalDateTime dlvrDate;
	private List<ObjectId> routes;
}
