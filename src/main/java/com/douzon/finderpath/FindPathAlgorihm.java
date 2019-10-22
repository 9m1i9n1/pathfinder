package com.douzon.finderpath;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.ArrayList;

public class FindPathAlgorihm {
	static int N = 16; // N*N 경로
	static int[][] money; // 비용
	static String[][] test;
	static int[] visited; // 방문표시
	static String[] test2;
	static int price; // 최소비용
	static ArrayList<String> q = new ArrayList<String>();
	static ArrayList<String> 찐큐 = new ArrayList<String>();

	static void DFS(int n, int s, int v) {

		if (n >= N) { // 모두 방문을 한경우
			if (money[s][0] != 0) { // 처음으로 간다.
				if (price > v) {
					price = v; // 적다 교환 ㄱㄱ
					찐큐.clear();
					찐큐.add("0");
					for (String ss : q) {
						찐큐.add(ss);
					}
				}
			}
			return;
		}

		for (int i = 1; i < N; i++) {
			if (visited[i] == 1)
				continue; // 이미방문 했음
			if (money[s][i] == 0)
				continue; // 0은 벽이다.

			// 지금까지 누적 비용이 작을때만 돌린다.
			if (v + money[s][i] < price) { // 이전에 구한 최소비용보다 저렴한 경우에만 방문
				// 방문 표시 하고
				visited[i] = 1;
				q.add(i + "");
				DFS(n + 1, i, v + money[s][i]);

				visited[i] = 0; // 방문표시 제거
//            System.out.println(Arrays.toString(visited));
				q.remove(q.size() - 1);
			}
		}
	}

	public static void main(String[] args) {
		int 반복횟수 = 100;
		String txt = "";

		String fileName = "C:\\test.txt";
		try {

			BufferedWriter fw = new BufferedWriter(new FileWriter(fileName, true));

		for (int aaa = 0; aaa < 반복횟수; ++aaa) {
			money = new int[N][N];
			visited = new int[N];
			int row, col;
			for (row = 0; row <= money.length - 1; row++) {
				for (col = 0; col <= money.length - 1; col++) {
					if (row == col) {
						money[row][col] = 0;
					} else {
						if (row > col) {
							money[row][col] = money[col][row];
						} else {
							int r = (int) (Math.random() * 1000);
							money[row][col] = r;
						}
					}
				}
			}

			for (row = 0; row <= money.length - 1; row++) {
				for (col = 0; col <= money.length - 1; col++) {
					System.out.printf("%3d\t", money[row][col]);
				}
				System.out.println();
			}

			System.out.println();

			price = Integer.MAX_VALUE; // 최소비용을 구해야 하기 때문에 최대값을 저장해둠

			long startTime = System.currentTimeMillis();
			DFS(1, 0, 0); // 방문도시 개수, 출발도시, 누적 비용
			long endTime = System.currentTimeMillis();

			System.out.println(price);

			System.out.println(찐큐);
			// Total time
			long lTime = endTime - startTime;
			System.out.println("TIME : " + lTime + "(ms)");
			fw.write(lTime + "+");
		}
			fw.flush();
			fw.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}