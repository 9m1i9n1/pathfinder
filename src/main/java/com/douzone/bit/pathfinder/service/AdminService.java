package com.douzone.bit.pathfinder.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.controller.Header;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.repository.AreaRepository;
import com.douzone.bit.pathfinder.repository.BranchRepository;

@Service
public class AdminService {
	
	@Autowired
	private BranchRepository branchRepository;
	
	@Autowired
	private AreaRepository areaRepository;
	
	//branch create
	public BranchTb create(Header<BranchTb> request){
		
		BranchTb branchTb = request.getData();
		
		BranchTb branchtb = BranchTb.builder()
				.branchAddr(branchTb.getBranchAddr())
				.branchDaddr(branchTb.getBranchDaddr())
				.branchLat(branchTb.getBranchLat())
				.branchLng(branchTb.getBranchLng())
				.branchName(branchTb.getBranchName())
				.branchOwner(branchTb.getBranchOwner())
				.branchValue(branchTb.getBranchValue())
				.build();
		
		BranchTb newBranchTb = branchRepository.save(branchtb);
		
		return branchResponse(newBranchTb);
		
				//.area(areaRepository.getOne(body.))
			
				
	}
	
	
	
	//branch read
	public Header<BranchTb> read(Long id) {
		
		return branchRepository.findById(id)
				.map(branch -> branchResponse(branch))
				.map(branchResponse -> Header.OK(branchResponse)) 
				.orElseGet(()-> Header.ERROR("데이터 없음"));
		
	}
	

	//branch page
	public List<BranchTb> search(Pageable pageable) {
		
		Page<BranchTb> branchs = branchRepository.findAll(pageable);
		
		List<BranchTb> branchList = branchs.stream()
				.map(branch -> branchResponse(branch))
				.collect(Collectors.toList());
			
		return branchList;
	}
	
	//branch update 대기
	public Header update(Header<BranchTb> request){
		
		BranchTb body = request.getData();
		
		return branchRepository.findById(body.getBranchIndex())
				.map(branch -> {
					branch
					.setArea(body.getArea())
					.setBranchAddr(body.getBranchAddr())
					.setBranchDaddr(body.getBranchDaddr())
					.setBranchLat(body.getBranchLat())
					.setBranchLng(body.getBranchLng())
					.setBranchName(body.getBranchName())
					.setBranchOwner(body.getBranchOwner())
					.setBranchPhone(body.getBranchPhone())
					.setBranchValue(body.getBranchValue());
					
					return branch;
				})
				.map(changeBranch -> branchRepository.save(changeBranch))
				.map(newBranch -> branchResponse(newBranch))
				.map(branch -> Header.OK(branch))
				.orElseGet(() -> Header.ERROR("데이터 없음"));
		
	}
	
	
	//branch delete 대기
	public Header delete(Long id) {
		return branchRepository.findById(id)
				.map(branch -> {
					branchRepository.delete(branch);
					return Header.OK();
				})
				.orElseGet(()->Header.ERROR("데이터없음"));
	}
	
	
	private BranchTb branchResponse(BranchTb branch){
		
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