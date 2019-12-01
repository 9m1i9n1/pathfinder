package com.douzone.bit.pathfinder.model.network.response;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class HistoryRoutesResponse {

	private String index;
	private List<Object> detail;
}
