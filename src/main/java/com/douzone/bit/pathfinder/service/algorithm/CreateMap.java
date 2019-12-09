package com.douzone.bit.pathfinder.service.algorithm;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.douzone.bit.pathfinder.model.MapCost;
import com.douzone.bit.pathfinder.model.network.request.MaprouteRequest;
import com.douzone.bit.pathfinder.model.network.response.MaprouteResponse;

public class CreateMap {
	// public static int map[][], d[][], MAX = 987654321;
	private double[][] map;
	private List<MaprouteRequest> unsortList;
	private List<MaprouteResponse> sortList;

	public CreateMap(List<MaprouteRequest> unsortList) {
		this.unsortList = unsortList;
	}

	public double[][] getMap() {
		makeCostMap();
		return map;
	}

	public List<MaprouteResponse> getSortList(List<List<Double>> sortIndexList) {
		sortList = new ArrayList();

		int listIndex, index = 0;

		for (List<Double> item : sortIndexList) {
			listIndex = item.get(0).intValue();

			sortList.add(response(unsortList.get(listIndex), item.get(1)));
			index++;
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

	public void makeCostMap() {
		int row, col;
		int size = unsortList.size();
		double distance, result;

		List<Integer> costList = new ArrayList();
		LocationDistance locationDistance = new LocationDistance();
		MapCost mapCost = new MapCost();

		map = new double[size][size];

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

	private MaprouteResponse response(MaprouteRequest marker, Double cost) {
		Optional<Double> oCost = Optional.ofNullable(cost);
		cost = oCost.orElse(0.0);

		MaprouteResponse maprouteResponse = MaprouteResponse.builder().branchIndex(marker.getBranchIndex())
				.branchName(marker.getBranchName()).branchLat(marker.getBranchLat()).branchLng(marker.getBranchLng())
				.routeCost(cost.intValue()).build();

		return maprouteResponse;
	}
}
