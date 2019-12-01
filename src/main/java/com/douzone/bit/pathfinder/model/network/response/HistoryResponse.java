package com.douzone.bit.pathfinder.model.network.response;

import org.bson.types.ObjectId;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class HistoryResponse {

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
