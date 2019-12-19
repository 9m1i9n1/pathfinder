package com.douzone.bit.pathfinder.service.algorithm;

import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.Optional;
import java.util.Map.Entry;

import com.douzone.bit.pathfinder.model.MapCost;
import com.douzone.bit.pathfinder.model.Marker;

import com.douzone.bit.pathfinder.model.network.request.RouteSortRequest;
import com.douzone.bit.pathfinder.model.network.response.RouteSortResponse;

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

	public List<RouteSortResponse> getSortList(Map<Integer, Double> sortIndexList) {
		sortList = new ArrayList();

		ListIterator<Entry<Integer, Double>> iterator = new ArrayList<Entry<Integer, Double>>(sortIndexList.entrySet())
				.listIterator(sortIndexList.size());

		while (iterator.hasPrevious()) {
			Entry<Integer, Double> entry = iterator.previous();
			sortList.add(response(unsortList.get(entry.getKey()), entry.getValue()));
		}

		return sortList;
	}

	public void printMap() {
		for (int i = 0; i < map.length; i++) {
			for (int j = 0; j < map.length; j++) {
				System.out.println("i : " + i + " / j : " + j + " / map : " + map[i][j]);
			}
		}
	}
	public void printMap2() {
		for (int i = 0; i < map.length; i++) {
				System.out.printf("{");
			for (int j = 0; j < map.length; j++) {
				if(j ==map.length -1) {
					System.out.printf("%.0f", map[i][j]);
					continue;
				}
				System.out.printf("%.0f,", map[i][j]);
			}
			if(i == map.length-1) {
				System.out.printf("}");
				System.out.println();
				continue;
			}
			System.out.printf("},");
			
			System.out.println();
		}
	}
	public void makeCostMap(boolean mode) {
		int row, col;
		int size = unsortList.size();
		double distance, result;

		List<Integer> costList = new ArrayList();
		LocationDistance locationDistance = new LocationDistance();
		MapCost mapCost = new MapCost();

		map = new double[size][size];

		System.out.println("#size" + size);
		System.out.println("#unsortList");
		System.out.println(unsortList);

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

		if (mode) {
			for (row = 0; row < size - 1; row++) {
				map[row][row] = 0;

				for (col = row + 1; col < size; col++) {
					locationDistance.setDistance(unsortList.get(row).getBranchLat(), unsortList.get(row).getBranchLng(),
							unsortList.get(col).getBranchLat(), unsortList.get(col).getBranchLng());
					distance = locationDistance.getDistance();

					result = mapCost.getResultCost(distance, col);

					map[col][row] = result;
					map[row][col] = result;
				}
			}
		} else {
			for (row = 0; row < size - 1; row++) {
				map[row][row] = 0;

				for (col = row + 1; col < size; col++) {
					locationDistance.setDistance(unsortList.get(row).getBranchLat(), unsortList.get(row).getBranchLng(),
							unsortList.get(col).getBranchLat(), unsortList.get(col).getBranchLng());
					distance = locationDistance.getDistance();

					map[col][row] = distance;
					map[row][col] = distance;
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
}
