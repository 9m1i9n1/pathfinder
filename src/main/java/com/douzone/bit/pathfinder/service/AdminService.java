package com.douzone.bit.pathfinder.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.controller.Header;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.repository.BranchRepository;

@Service
public class AdminService {
	@Autowired
	private BranchRepository branchRepository;
	
	//branch read
	public Header<BranchTb> read(Long id) {
		
		return branchRepository.findById(id)
				.map(branch -> response(branch))
				.map(branchResponse -> Header.OK(branchResponse)) 
				.orElseGet(()-> Header.ERROR("데이터 없음"));
		
	}
	

	//branch page
	public Header<List<BranchTb>> search(Pageable pageable) {
		
		Page<BranchTb> branchs = branchRepository.findAll(pageable);
		
		List<BranchTb> branchList = branchs.stream()
				.map(branch -> response(branch))
				.collect(Collectors.toList());
			
		return Header.OK(branchList);
	}
	
	//branch delete
	public Header delete(Long id) {
		return branchRepository.findById(id)
				.map(branch -> {
					branchRepository.delete(branch);
					return Header.OK();
				})
				.orElseGet(()->Header.ERROR("데이터없음"));
	}
	
	
	private BranchTb response(BranchTb branch){
		
		BranchTb body = BranchTb.builder()
				.branchIndex(branch.getBranchIndex())
				.branchName(branch.getBranchName())
				.branchOwner(branch.getBranchOwner())
				.branchValue(branch.getBranchValue())
				.branchAddr(branch.getBranchAddr())
				.branchDaddr(branch.getBranchDaddr())
				.branchPhone(branch.getBranchPhone())
				.branchLng(branch.getBranchLng())
				.branchLat(branch.getBranchLat())
				.build();
		
		return body;
	}
}