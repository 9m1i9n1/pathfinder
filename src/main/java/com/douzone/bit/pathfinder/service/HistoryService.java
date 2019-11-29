package com.douzone.bit.pathfinder.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.entity.mongodb.HistoryTb;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.response.HistoryResponse;
import com.douzone.bit.pathfinder.repository.mongodb.HistoryRepository;

@Service
public class HistoryService {

	@Autowired
	private HistoryRepository historyRepository;
	
	public Header<List<HistoryResponse>> readHistory() {
		
		List<HistoryTb> historys = historyRepository.findAll();
		
		List<HistoryResponse> historyList = historys.stream().map(history -> historyResponse(history))
				.collect(Collectors.toList());
		
		return Header.OK(historyList);
	}
	
	private HistoryResponse historyResponse(HistoryTb history) {
		
		HistoryResponse response = HistoryResponse.builder()
				._id(history.get_id()).regdate(history.getRegdate())
				.username(history.getUsername()).carname(history.getCarname())
				.dep(history.getDep()).arvl(history.getArvl())
				.dist(history.getDist()).fee(history.getFee())
				.dlvrdate(history.getDlvrdate()).arrivedate(history.getArrivedate())
				.routes(history.getRoutes())
				.build();
		
		return response;
	}
}