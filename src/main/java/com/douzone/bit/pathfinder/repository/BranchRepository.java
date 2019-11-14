package com.douzone.bit.pathfinder.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.douzone.bit.pathfinder.model.entity.AreaTb;
import com.douzone.bit.pathfinder.model.entity.BranchTb;

@Repository
public interface BranchRepository extends JpaRepository<BranchTb, Long> {

	public Boolean existsByBranchName(String branchName);
	
	public List<BranchTb> findByArea(AreaTb area);

	@Query(value = "select branch_index, branch_name from branch_tb", nativeQuery = true)
	public List<Object> findBranchName();

	// 지점이름검색
	public List<BranchTb> findByBranchNameLike(String branchName);

	// 지점주소검색
	public List<BranchTb> findByBranchAddrLike(String branchAddr);

	@Query(value = "select b.branchIndex, b.branchName from BranchTb b where area = ?1")
	public List<Object> findValueByArea(AreaTb area);

	public Page<BranchTb> findByBranchAddrLike(String branchAddr, Pageable pageable);

	public Page<BranchTb> findByBranchNameLike(String branchName, Pageable pageable);

	public Page<BranchTb> findByArea(AreaTb area, Pageable pageable);

}
