package com.douzone.bit.pathfinder.model.network.response;

import java.util.List;

import org.bson.types.ObjectId;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class HistoryRoutesResponse {

//	private ObjectId hindex;
	private List<Object> detail; 
}
