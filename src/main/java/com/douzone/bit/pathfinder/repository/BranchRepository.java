package com.douzone.bit.pathfinder.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.douzone.bit.pathfinder.model.entity.AreaTb;
import com.douzone.bit.pathfinder.model.entity.BranchTb;

@Repository
public interface BranchRepository extends JpaRepository<BranchTb, Long> {
	public List<BranchTb> findByArea(AreaTb area);

	@Query(value = "select b.branchIndex, b.branchName from BranchTb b where area = ?1")
	public List<Object> findValueByArea(AreaTb area);
}
