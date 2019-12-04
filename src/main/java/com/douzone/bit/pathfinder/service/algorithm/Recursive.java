package com.douzone.bit.pathfinder.service.algorithm;

import java.util.*;

public class Recursive {

	private final int N;
	private final int START_NODE;
	private final int FINISHED_STATE;

	private double[][] map;
	private double minTourCost = Double.POSITIVE_INFINITY;
	// private int minTourCost = Integer.MAX_VALUE;

	private List<Integer> tour = new ArrayList<>();
	private boolean ranSolver = false;

	public long startTime, endTime, lTime;

	public Recursive(double[][] map) {
		this(0, map);
	}

	public Recursive(int startNode, double[][] map) {

		this.map = map;
		N = map.length;
		START_NODE = startNode;

		// Validate inputs.

		// The finished state is when the finished state mask has all bits are set to
		// one (meaning all the nodes have been visited).
		FINISHED_STATE = (1 << N) - 1;
	}

	// Returns the optimal tour for the traveling salesman problem.
	public List<Integer> getTour() {
		if (!ranSolver)
			solve();
		return tour;
	}

	// Returns the minimal tour cost.
	public double getTourCost() {
		if (!ranSolver)
			solve();
		return minTourCost;
	}

	// int cnt = 0;

	public void solve() {

		// Run the solver
		int state = 1 << START_NODE;

		Double[][] memo = new Double[N][1 << N];
		Integer[][] prev = new Integer[N][1 << N];

		// for (Double[] row : memo)
		// Arrays.fill(row, 0);
		// for (Integer[] row : prev)
		// Arrays.fill(row, 0);

		minTourCost = tsp(START_NODE, state, memo, prev);

		// Regenerate path
		int index = START_NODE;
		while (true) {
			tour.add(index);
			Integer nextIndex = prev[index][state];
			if (nextIndex == null)
				break;
			int nextState = state | (1 << nextIndex);
			state = nextState;
			index = nextIndex;
		}
		// tour.add(START_NODE);
		ranSolver = true;

	}

	private double tsp(int i, int state, Double[][] memo, Integer[][] prev) {
		// Done this tour. Return cost of going back to start node.
		// System.out.println(cnt++);

		if (state == FINISHED_STATE)
			return map[0][START_NODE];

		// Return cached answer if already computed.
		if (memo[i][state] != null)
			return memo[i][state];

		double minCost = Double.POSITIVE_INFINITY;
		int index = -1;
		for (int next = 0; next < N; next++) {

			// Skip if the next node has already been visited.
			if ((state & (1 << next)) != 0)
				continue;

			int nextState = state | (1 << next);
			double newCost = map[i][next] + tsp(next, nextState, memo, prev);
			if (newCost < minCost) {
				minCost = newCost;
				index = next;
			}
		}

		prev[i][state] = index;
		return memo[i][state] = minCost;
	}
}