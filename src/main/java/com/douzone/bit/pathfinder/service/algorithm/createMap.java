package com.douzone.bit.pathfinder.service.algorithm;

import java.util.ArrayList;
import java.util.List;

import com.douzone.bit.pathfinder.model.MapCost;
import com.douzone.bit.pathfinder.model.network.request.MaprouteRequest;

public class CreateMap {
	// public static int map[][], d[][], MAX = 987654321;
	private double[][] map;
	private List<MaprouteRequest> unsortList;

	public CreateMap(List<MaprouteRequest> unsortList) {
		this.unsortList = unsortList;
	}

	public double[][] getMap() {
		makeCostMap();

		return map;
	}

	public void printMap() {
		for (int i = 0; i < map.length; i++) {
			for (int j = 0; j < map.length; j++) {
				System.out.println("i : " + i + " / j : " + j + " / map : " + map[i][j]);
			}
		}
	}

	// public int[][] getmap() {
	// makeCostMap();
	// return map;
	// }

	public void makeCostMap() {
		List<Integer> costList = new ArrayList();
		LocationDistance locationDistance = new LocationDistance();
		MapCost mapCost = new MapCost();

		int row, col;

		int size = unsortList.size();
		map = new double[size][size];

		double distance, result;

		for (MaprouteRequest item : unsortList) {
			costList.add(item.getBranchValue());
		}

		// TODO 임의값================
		mapCost.setPayroll(500);
		mapCost.setMileage(11);
		mapCost.setTon(10);
		mapCost.setCostList(costList);
		// TODO =====================

		// map create
		map[size - 1][size - 1] = 0;

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
	}

	// TestList = sortList, list = unsortList
	// public void mapmap() {
	// LocationDistance distance;
	// int n = list.size();

	// String line[] = new String[n];

	// for (int i = 0; i < n; i++) {
	// line[i] = list.get(i).get("branch_value").toString();
	// }

	// // map
	// map = new int[n][n];

	// // visted
	// d = new int[n][1 << n]; // 비트마스킹을 사용하므로 2^n개 만큼 사용

	// // map 초기화 해주는 부분
	// for (int col = 0; col <= n - 1; col++) {
	// for (int row = 0; row <= n - 1; row++) {
	// if (row == col) {
	// map[row][col] = 0;
	// } else {

	// int r = Integer.parseInt(line[col]);
	// map[row][col] = r;
	// java.util.Arrays.fill(d[row], MAX); // 거리를 모두 MAX로 초기화
	// }
	// }
	// }

	// // 비용계산
	// 직선거리 + (운반비 *(거리 * 0.1))
	// for (int i = 0; i < n; i++) {
	// for (int j = 0; j < n; j++) {
	// if (i == j)
	// map[i][j] = 0;
	// else {
	// distance = new LocationDistance(testList.get(i).getBranch_lat(),
	// testList.get(i).getBranch_lng(),
	// testList.get(j).getBranch_lat(), testList.get(j).getBranch_lng());

	// map[i][j] = (int) Math.ceil((distance.getdistance() + (map[i][j] *
	// (distance.getdistance() * 0.1))));
	// }
	// }
	// }
}
