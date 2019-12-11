package com.douzone.bit.pathfinder.model.network.response;

import java.util.Date;

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

	private ObjectId id;
	private String regdate;
	private String username;
	private Long carname;
	private String dep;
	private String arvl;
	private String dist;
	private String fee;
	private String dlvrdate;
	private String arrivedate;
	private String routes;
	private int stat;
}
