package com.douzone.bit.pathfinder.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.entity.TestDTO;
import com.douzone.bit.pathfinder.service.algorithm.Recursive;
import com.douzone.bit.pathfinder.service.algorithm.createMap;

@Service
public class testService {

	@SuppressWarnings({ "rawtypes" })
	public List<TestDTO> tryCalc(ArrayList<Map> list) {
		System.out.println("서비스");
		// TODO Auto-generated method stub
		List<TestDTO> testList = new ArrayList<TestDTO>();
		List<TestDTO> sucList = new ArrayList<TestDTO>();

		for (int i = 0; i < list.size(); i++) {
			// System.out.println(list.get(i));
			testList.add(new TestDTO());
			testList.get(i).setAreaName(list.get(i).get("areaName").toString());
			/*
			 * testList.get(i).setTransportationExpenses(
			 * Double.valueOf(list.get(i).get("transportationExpenses").toString()).
			 * doubleValue());
			 */
			testList.get(i)
					.setTransportationExpenses(Integer.parseInt(list.get(i).get("transportationExpenses").toString()));
			testList.get(i).setLatitude(Double.valueOf(list.get(i).get("latitude").toString()).doubleValue());
			testList.get(i).setLongitude(Double.valueOf(list.get(i).get("longitude").toString()).doubleValue());
		}

		int n = testList.size();
		String line[] = new String[n];
		for (int i = 0; i < n; i++) {
			line[i] = list.get(i).get("transportationExpenses").toString();
		}

		createMap m = new createMap(n, line);

		System.out.println("정렬전" + testList);
//		if (n <= 2)
//			throw new IllegalStateException("TSP on 0, 1 or 2 nodes doesn't make sense.");
//		if (n != m.getmap()[0].length)
//			throw new IllegalArgumentException("Matrix must be square (N x N)");
//		if (n > 32)
//			throw new IllegalArgumentException(
//					"Matrix too large! A matrix that size for the DP TSP problem with a time complexity of"
//							+ "O(n^2*2^n) requires way too much computation for any modern home computer to handle");

		Recursive r = new Recursive(0, m.getmap());

		List<Integer> TourList = r.getTour();
		System.out.println(TourList);
		System.out.println(r.getTourCost());

		System.out.println();
		System.out.println("테스트");

		for (int i = 0; i < testList.size(); i++) {
			System.out.println(testList.get(Integer.parseInt(TourList.get(i).toString())));
			sucList.add(testList.get(Integer.parseInt(TourList.get(i).toString())));
			System.out.println("sucList = " + sucList.get(i));
		}
		return sucList;
	}
}
