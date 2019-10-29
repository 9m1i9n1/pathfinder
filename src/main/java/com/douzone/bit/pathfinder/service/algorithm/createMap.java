package com.douzone.bit.pathfinder.service.algorithm;

public class createMap {
	public static int map[][], d[][], MAX = 987654321;
	public int n;
	public String line[];
	public createMap(String[] line) {
	}

	public createMap(int n, String[] line) {
		this.n = n;
		this.line = line;
	};
	
	public int[][] getmap(){
		mapmap();
		return map;
	}
	
	public int[][] mapmap() {
		map = new int[n][n];
		d = new int[n][1 << n]; // 비트마스킹을 사용하므로 2^n개 만큼 사용
		for (int row = 0; row <= n - 1; row++) {
			for (int col = 0; col <= n - 1; col++) {
				if (row == col) {
					map[row][col] = 0;
				} else {
					if (row > col) {
						map[row][col] = map[col][row];
					} else {
						int r = Integer.parseInt(line[col]);
						map[row][col] = r;
					}
					java.util.Arrays.fill(d[row], MAX); // 거리를 모두 MAX로 초기화
				}
			}
		}

		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				System.out.printf("%3d\t", map[i][j]);
			}
			System.out.println();
		}
		return map;
	}
}
