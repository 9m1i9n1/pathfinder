package com.douzone.bit.pathfinder.service.algorithm;

import java.util.*;

public class Recursive {

	private final int N;
	private final int START_NODE;
	private final int FINISHED_STATE;

	private int[][] distance;
	private int minTourCost = Integer.MAX_VALUE;

	private List<Integer> tour = new ArrayList<>();
	private boolean ranSolver = false;

	public long startTime, endTime, lTime;

	public Recursive(int[][] distanceMatrix) {
		this(0, distanceMatrix);
	}

	public Recursive(int startNode, int[][] distanceMatrix) {

		this.distance = distanceMatrix;
		N = distanceMatrix.length;
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
	public int getTourCost() {
		if (!ranSolver)
			solve();
		return minTourCost;
	}

	public void solve() {

		// Run the solver
		int state = 1 << START_NODE;
		int[][] memo = new int[N][1 << N];
		Integer[][] prev = new Integer[N][1 << N];
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
//		tour.add(START_NODE);
		ranSolver = true;
	}

	private int tsp(int i, int state, int[][] memo, Integer[][] prev) {

		// Done this tour. Return cost of going back to start node.
		if (state == FINISHED_STATE)
			return distance[0][START_NODE];

		// Return cached answer if already computed.
		if (memo[i][state] != 0)
			return memo[i][state];

		int minCost = Integer.MAX_VALUE;
		int index = -1;
		for (int next = 0; next < N; next++) {

			// Skip if the next node has already been visited.
			if ((state & (1 << next)) != 0)
				continue;

			int nextState = state | (1 << next);
			int newCost = distance[i][next] + tsp(next, nextState, memo, prev);
			if (newCost < minCost) {
				minCost = newCost;
				index = next;
			}
		}

		prev[i][state] = index;
		return memo[i][state] = minCost;
	}
}