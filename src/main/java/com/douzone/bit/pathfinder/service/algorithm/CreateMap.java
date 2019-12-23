package com.douzone.bit.pathfinder.service.algorithm;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.Optional;
import java.util.Map.Entry;

import com.douzone.bit.pathfinder.model.MapCost;
import com.douzone.bit.pathfinder.model.Marker;

import com.douzone.bit.pathfinder.model.network.request.RouteSortRequest;
import com.douzone.bit.pathfinder.model.network.response.RouteSortResponse;
import com.sun.xml.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;

public class CreateMap {
	private double[][] map;

	private List<Marker> unsortList;
	private List<RouteSortResponse> sortList;
	private Double carName;
	private Double carMileage;

	public CreateMap(List<Marker> unsortList, Double carName, Double carMileage) {
		this.unsortList = unsortList;
		this.carName = carName;
		this.carMileage = carMileage;
	}

	public double[][] getDistanceMap() {
		makeCostMap(false);
		return map;
	}

	public double[][] getCostMap() {
		makeCostMap(true);
		return map;
	}

	public List<RouteSortResponse> getDistSortList(Map<Integer, Double> sortIndexList) {
		double others = 0;
		int count = 0;
		
		List<Entry<Integer, Double>> ar = new ArrayList<Entry<Integer, Double>>();
		
		for (Entry<Integer, Double> item : sortIndexList.entrySet()) {
			ar.add(item);
		}
		
//		for (Entry<Integer, Double> item : ar) {
//			ar.get(i);
//			i++;
//		}
//		System.out.println("ar - " + ar);
		sortList = new ArrayList<RouteSortResponse>();
		
		for (Entry<Integer, Double> item : ar) {
			// item.getValue()에 지점비용 더하면 끝 carName /6 *
			
			if (count < ar.size() - 1) {
				others = unsortList.get(ar.get(count + 1).getKey()).getBranchValue() * (carName / 6);
				count++;
			}

			if (item.getValue() != null) {
				sortList.add(response(unsortList.get(item.getKey()), (item.getValue().doubleValue() * (others*0.0002))));

			} else {
				sortList.add(response(unsortList.get(item.getKey()), item.getValue()));

			}
			
		}
		
//		for (Entry<Integer, Double> item : sortIndexList.entrySet()) {
//			// item.getValue()에 지점비용 더하면 끝 carName /6 *
//			
//			//현재 지점의 값을 * (carName / 6)하는 코드
//			others = unsortList.get(item.getKey()).getBranchValue() * (carName / 6);
//			// 현재 지점의 값  * (carName / 6) 이게 아니라
//			// 다음지점의 값  * (carName / 6)
//			// for문으로해야댐 배열에 넣어서 해당 배열의 아이의 다음애를 들고와서 
//			System.out.println("ohters - " + others);
//
//			if (item.getValue() != null) {
//				System.out.println("널아님");
//				System.out.println("item.getValue() - " + item.getValue());
//				System.out.println("item.getValue() - " + (item.getValue().doubleValue() + others));
//				sortList.add(response(unsortList.get(item.getKey()), (item.getValue().doubleValue() + others)));
//
//			} else {
//
//				System.out.println("널임");
//				System.out.println("item.getValue() - " + item.getValue());
//				sortList.add(response(unsortList.get(item.getKey()), item.getValue()));
//
//			}
//		}

		return sortList;
	}

	public List<RouteSortResponse> getCostSortList(Map<Integer, Double> sortIndexList) {
		sortList = new ArrayList<RouteSortResponse>();

		for (Entry<Integer, Double> item : sortIndexList.entrySet()) {
			sortList.add(response(unsortList.get(item.getKey()), item.getValue()));
		}

		return sortList;
	}

	public void makeCostMap(boolean mode) {
		int row, col;
		int size = unsortList.size();
		double distance, result;

		List<Integer> costList = new ArrayList<Integer>();
		LocationDistance locationDistance = new LocationDistance();
		MapCost mapCost = new MapCost();

		map = new double[size][size];

		for (Marker item : unsortList) {
			costList.add(item.getBranchValue());
		}
		
		// TODO 임의값================
		mapCost.setPayroll(500);
		mapCost.setTon(carName);
		mapCost.setMileage(carMileage);
		mapCost.setCostList(costList);
		// TODO =====================

		// ! map 두개 받아오는 작업하면서 쓰레기코드 됨. 리팩토링 필수
		// map create
		map[size - 1][size - 1] = 0;

		for (row = 0; row < size; row++) {
			map[row][row] = 0;

			for (col = 0; col < size; col++) {
				if (row != col) {
					locationDistance.setDistance(unsortList.get(row).getBranchLat(), unsortList.get(row).getBranchLng(),
							unsortList.get(col).getBranchLat(), unsortList.get(col).getBranchLng());
					distance = locationDistance.getDistance();
					
					result = mode ? mapCost.getResultCost(distance, col) : mapCost.getResultDist(distance, col);

					//TODO 고쳐!
					map[row][col] = result;
				}
			}
		}
	}

	private RouteSortResponse response(Marker marker, Double cost) {
		Optional<Double> oCost = Optional.ofNullable(cost);
		cost = oCost.orElse(0.0);

		RouteSortResponse maprouteResponse = RouteSortResponse.builder().branchIndex(marker.getBranchIndex())
				.branchName(marker.getBranchName()).branchLat(marker.getBranchLat()).branchLng(marker.getBranchLng())
				.routeCost(cost.intValue()).build();

		return maprouteResponse;
	}

	public void printMap() {
		// for (int i = 0; i < map.length; i++) {
		// for (int j = 0; j < map.length; j++) {
		// System.out.println("i : " + i + " / j : " + j + " / map : " + map[i][j]);
		// }
		// }

		for (int i = 0; i < map.length; i++) {
			for (int j = 0; j < map.length; j++) {
				System.out.printf("%f\t\t", map[i][j]);
			}
			System.out.println();
		}
	}

	public void printMap2() {
		for (int i = 0; i < map.length; i++) {
			System.out.printf("{");
			for (int j = 0; j < map.length; j++) {
				if (j == map.length - 1) {
					System.out.printf("%.0f", map[i][j]);
					continue;
				}
				System.out.printf("%.0f,", map[i][j]);
			}
			if (i == map.length - 1) {
				System.out.printf("}");
				System.out.println();
				continue;
			}
			System.out.printf("},");

			System.out.println();
		}
	}
}
