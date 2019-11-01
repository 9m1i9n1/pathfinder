package com.douzone.bit.pathfinder.service.algorithm;

import java.util.ArrayList;
import java.util.Map;

import com.douzone.bit.pathfinder.model.entity.RouteDTO;

public class createMap {
	public static int map[][], d[][], MAX = 987654321;
	public ArrayList<Map> list;
	public ArrayList<RouteDTO> testList;

	public createMap(String[] line) {
	}

	public createMap(ArrayList<Map> list, ArrayList<RouteDTO> testList) {
		this.list = list;
		this.testList = testList;
	};

	public int[][] getmap() {
		mapmap();
		return map;
	}

	public int[][] mapmap() {
		LocationDistance distance;

		int n = testList.size();
		String line[] = new String[n];

		for (int i = 0; i < n; i++) {
			line[i] = list.get(i).get("branch_value").toString();
}

		map = new int[n][n];
		d = new int[n][1 << n]; // 비트마스킹을 사용하므로 2^n개 만큼 사용
		for (int col = 0; col <= n - 1; col++) {
			for (int row = 0; row <= n - 1; row++) {
				if (row == col) {
					map[row][col] = 0;
				} else {

						int r = Integer.parseInt(line[col]);
						map[row][col] = r;
					java.util.Arrays.fill(d[row], MAX); // 거리를 모두 MAX로 초기화
				}
			}
		}

		// 비용계산
		// 직선거리 + (운반비 *(거리 * 0.1))//
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				if (i == j)
					map[i][j] = 0;
				else {
					distance = new LocationDistance(testList.get(i).getBranch_lat(), testList.get(i).getBranch_lng(),
							testList.get(j).getBranch_lat(), testList.get(j).getBranch_lng());
					map[i][j] = (int) Math.ceil((distance.getdistance() + (map[i][j] * (distance.getdistance() * 0.1))));
				}
			}
		}
		return map;
	}
}
