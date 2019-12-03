package com.douzone.bit.pathfinder.repository.mongodb;

import org.bson.types.ObjectId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;

import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.entity.mongodb.HistoryTb;

public interface HistoryRepository extends MongoRepository<HistoryTb, String> {

	Object findByRoutes(ObjectId routes);
	
	//검색 페이지
	public Page<HistoryTb> findByCarnameLike(String carname, Pageable pageable);
	
	public Page<HistoryTb> findByRegdate(String carname, Pageable pageable);
	
	public Page<HistoryTb> findByUsernameLike(String carname, Pageable pageable);
	
	public Page<HistoryTb> findByDep(String carname, Pageable pageable);

	public Page<HistoryTb> findByArvl(String carname, Pageable pageable);
}
