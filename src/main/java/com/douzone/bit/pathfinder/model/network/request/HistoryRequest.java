package com.douzone.bit.pathfinder.model.network.request;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HistoryRequest {

	private Long carIndex;
	private String dep;
	private String arvl;
	private Date dlvrdate;
	private Date arrivedate;
	private String fee;
	private String time;
	private String dist;
	private List<Object> routes;
}
