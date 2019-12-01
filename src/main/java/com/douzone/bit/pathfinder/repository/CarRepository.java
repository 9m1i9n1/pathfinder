package com.douzone.bit.pathfinder.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

import com.douzone.bit.pathfinder.model.entity.AreaTb;
import com.douzone.bit.pathfinder.model.entity.CarTb;

@Repository
public interface CarRepository extends JpaRepository<CarTb, Long> {

	// 조직도 클릭 정렬
	public Page<CarTb> findBycarArea(AreaTb area, Pageable pageable);

	// 해당 지점 지역의 차량 리스트
	public List<CarTb> findBycarArea(AreaTb area);

	// 차종검색
	public Page<CarTb> findByCarNameLike(String carName, Pageable pageable);

	// 차량번호검색
	public Page<CarTb> findByCarNumberLike(String carNumber, Pageable pageable);

	public Boolean existsByCarNumber(String carNumber);
}
