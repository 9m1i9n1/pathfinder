package com.douzone.bit.pathfinder.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.entity.UserTb;

@Repository
public interface UserRepository extends JpaRepository<UserTb, Long> {

	public Boolean existsByuserId(String userId);

	// 검색기능 쿼리
	public Page<UserTb> findByUserNameLike(String userName, Pageable pageable);

	public Page<UserTb> findByUserPositionLike(String userPosition, Pageable pageable);

	public Page<UserTb> findByBranch(BranchTb branch, Pageable pageable);

	public Page<UserTb> findByBranchAndUserNameLike(BranchTb branch, String username, Pageable pageable);

	public Page<UserTb> findByBranchAndUserPositionLike(BranchTb branch, String userposition, Pageable pageable);

	public Page<UserTb> findByBranchIn(List<BranchTb> branch, Pageable pageable);

	public Page<UserTb> findByBranchInAndUserNameLike(List<BranchTb> branch, String username, Pageable pageable);

	public Page<UserTb> findByBranchInAndUserPositionLike(List<BranchTb> branch, String position, Pageable pageable);;
}
