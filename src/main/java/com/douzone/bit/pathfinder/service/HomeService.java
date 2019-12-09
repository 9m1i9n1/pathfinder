package com.douzone.bit.pathfinder.service;

import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.douzone.bit.pathfinder.repository.mongodb.HistoryRepository;

@Service
@Transactional
public class HomeService {

	@Autowired
	HistoryRepository historyRepository;
	
	public int[] getTotalCount() {
		int count[] = new int[3];
		
		String userName = SecurityContextHolder.getContext().getAuthentication().getName();
		
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH, 1);
		
		Date thisMonth = cal.getTime();
		
		count[0] = historyRepository.findAllByWillAndUsernameAndDateAndCnt(Calendar.getInstance().getTime(), userName);
		count[1] = historyRepository.findAllByIngAndUsernameAndDateAndCnt(Calendar.getInstance().getTime(), userName);
		count[2] = historyRepository.findAllByPpAndUsernameAndDateAndCnt(Calendar.getInstance().getTime(), userName, thisMonth);
	
		return count;
	}
}