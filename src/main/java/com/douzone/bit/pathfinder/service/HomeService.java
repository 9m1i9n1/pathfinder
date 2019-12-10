package com.douzone.bit.pathfinder.service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.repository.BranchRepository;
import com.douzone.bit.pathfinder.repository.UserRepository;
import com.douzone.bit.pathfinder.repository.mongodb.HistoryRepository;

@Service
@Transactional
public class HomeService {

	@Autowired
	HistoryRepository historyRepository;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	BranchRepository branchRepository;
	
	public int[] getTotalCount(boolean myDelivery) {
		int count[] = new int[3];
		
		String userName = SecurityContextHolder.getContext().getAuthentication().getName();
		
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH, 1);
		
		Date thisMonth = cal.getTime();
		
		if (myDelivery) {
			count[0] = historyRepository.findAllByWillAndUsernameAndDateAndCnt(Calendar.getInstance().getTime(), userName);
			count[1] = historyRepository.findAllByIngAndUsernameAndDateAndCnt(Calendar.getInstance().getTime(), userName);
			count[2] = historyRepository.findAllByPpAndUsernameAndDateAndCnt(Calendar.getInstance().getTime(), userName, thisMonth);
		} else {
			count[0] = historyRepository.findAllByWillAndDateAndCnt(Calendar.getInstance().getTime());
			count[1] = historyRepository.findAllByIngAndDateAndCnt(Calendar.getInstance().getTime());
			count[2] = historyRepository.findAllByPpAndDateAndCnt(Calendar.getInstance().getTime(), thisMonth);
		}
		
		return count;
	}

	public Long userCount() {
		Long userTotalCount =userRepository.findAllUserCount();
		System.out.println("총원 : "+userTotalCount);
		return userTotalCount;
	}

	public Long branchCount() {
		Long branchTotalCount =branchRepository.findAllBranchCount();
		System.out.println("지점수 : "+branchTotalCount);
		return branchTotalCount;
	}

	public Long historyAll() {
		Long historyTotalCount = historyRepository.findAllCount();
		System.out.println("히스토리 수 : " + historyTotalCount);
		return historyTotalCount;
	}
}