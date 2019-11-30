package com.douzone.bit.pathfinder.model.entity.mongodb;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Document(collection="history")
public class HistoryTb {
	private ObjectId _id;
	private String regdate;
	private String username;
	private String carname;
	private String dep;
	private String arvl;
	private String dist;
	private String fee;
	private String dlvrdate;
	private String arrivedate;
	private String routes;
}
