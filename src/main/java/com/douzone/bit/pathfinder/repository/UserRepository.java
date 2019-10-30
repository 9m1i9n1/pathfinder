package com.douzone.bit.pathfinder.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.entity.UserTb;

@Repository
public interface UserRepository extends JpaRepository<UserTb, Long> {
  
	public List<UserTb> findByBranch(BranchTb branch);
	
	public List<UserTb> findByBranchIn(List<BranchTb> branch);
}
