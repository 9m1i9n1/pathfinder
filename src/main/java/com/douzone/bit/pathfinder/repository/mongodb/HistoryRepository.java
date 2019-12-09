package com.douzone.bit.pathfinder.repository.mongodb;

import org.bson.types.ObjectId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import com.douzone.bit.pathfinder.model.entity.mongodb.HistoryTb;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public interface HistoryRepository extends MongoRepository<HistoryTb, String> {

	Object findByRoutes(ObjectId routes);
	
	//검색 페이지
	Page<HistoryTb> findByCarnameLike(String carname, Pageable pageable);
	
	Page<HistoryTb> findByRegdate(String regdate, Pageable pageable);
	
	Page<HistoryTb> findByUsernameLike(String username, Pageable pageable);
	
	Page<HistoryTb> findByDep(String dep, Pageable pageable);

	Page<HistoryTb> findByArvl(String arvl, Pageable pageable);

	//오늘 배송할 총갯수
	@Query(value = "{$and :[{'dlvrdate' : {'$gte' : ?0} },{'dlvrdate' :{'$lte' : ?1 } }]}", count = true)
	Integer findAllByTotalToday(Date LocalTime1, Date LocalTime2);
	
	//오늘거배송된 갯수
	@Query(value = "{$and : [{$and :[{'dlvrdate' : {'$gte' : ?0} },{'dlvrdate' :{'$lte' : ?1 } }]}, "
			+ "{'arrivedate' : {'$lte' : ?2} }]}", count = true)
	Integer findAllByDoingToday(Date LocalTime1, Date LocalTime2, Date LocalTime3);
	
	// 전체 검색
	@Query("{'arrivedate' : { '$lt' : ?0 }}")
	Page<HistoryTb> findAllByPp(Pageable pageable, Date LocalTime);
	
	@Query("{$and :[ {arrivedate : {'$gte' : ?0} }, { 'dlvrdate' :{'$lte' : ?0 }}]}")
	Page<HistoryTb> findAllByIng(Pageable pageable, Date LocalTime);
	
	@Query("{'dlvrdate' : { '$gt' : ?0 }}")
	Page<HistoryTb> findAllByWill(Pageable pageable, Date LocalTime);
	
	// 전체 검색 & 날짜로 검색
	@Query("{$and : [{'arrivedate' : { '$lt' : ?0 }}, {'dlvrdate' : { '$gte' : ?1 }}]}")
	Page<HistoryTb> findAllByPpAndDate(Pageable pageable, Date LocalTime, Date keyword);
	

	@Query("{$and :[ {arrivedate : { '$gte' : ?0} }, { 'dlvrdate' : {'$lte' : ?0 } }, { 'dlvrdate' : {'$gte' : ?1 }}]}")
	Page<HistoryTb> findAllByIngAndDate(Pageable pageable, Date LocalTime, Date keyword);
	
	@Query("{$and : [{'dlvrdate' : { '$gt' : ?0 }}, { 'dlvrdate' : {'$gte' : ?1 }}]}")
	Page<HistoryTb> findAllByWillAndDate(Pageable pageable, Date LocalTime, Date keyword);
	
	// 내 글 검색
	@Query("{$and : [ {'dlvrdate' : { '$gt' : ?0 }}, {'username' : ?1}] }")
	Page<HistoryTb> findAllByWillAndUsername(Pageable pageable, Date time, String username);


	@Query("{$and :[ {arrivedate : {'$gte' : ?0} }, { 'dlvrdate' :{'$lte' : ?0 } }, {'username' : ?1} ] }")
	Page<HistoryTb> findAllByIngAndUsername(Pageable pageable, Date time, String username);
	
	@Query("{$and : [ {'arrivedate' : { '$lt' : ?0 }}, {'username' : ?1}]}")
	Page<HistoryTb> findAllByPpAndUsername(Pageable pageable, Date LocalTime, String username);
	
	// 내 글 검색 & 날짜로 검색
	@Query("{$and : [ {'dlvrdate' : { '$gt' : ?0 }}, {'username' : ?1 }, {'dlvrdate' : { '$gte' : ?2 }}] }")
	Page<HistoryTb> findAllByWillAndUsernameAndDate(Pageable pageable, Date time, String username, Date keyword);
	
	@Query("{$and :[ {arrivedate : {'$gte' : ?0} }, { 'dlvrdate' :{'$lte' : ?0 } }, { 'dlvrdate' :{'$gte' : ?2 } }, {'username' : ?1} ] }")
	Page<HistoryTb> findAllByIngAndUsernameAndDate(Pageable pageable, Date time, String username, Date keyword);
	
	@Query("{$and : [ {'arrivedate' : { '$lt' : ?0 }}, {'username' : ?1}, {'dlvrdate' : { '$gte' : ?2 } }]}")
	Page<HistoryTb> findAllByPpAndUsernameAndDate(Pageable pageable, Date LocalTime, String username, Date keyword);
}
