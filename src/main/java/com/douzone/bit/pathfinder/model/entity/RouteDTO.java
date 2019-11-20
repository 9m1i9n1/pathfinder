package com.douzone.bit.pathfinder.model.entity;

public class RouteDTO {
	private String branch_name;
	private int branch_value;
	private double branch_lat; // 위도
	private double branch_lng; // 경도
	private int priceBetweenAandB;
	public String getBranch_name() {
		return branch_name;
	}
	public void setBranch_name(String branch_name) {
		this.branch_name = branch_name;
	}
	public int getBranch_value() {
		return branch_value;
	}
	public void setBranch_value(int branch_value) {
		this.branch_value = branch_value;
	}
	public double getBranch_lat() {
		return branch_lat;
	}
	public void setBranch_lat(double branch_lat) {
		this.branch_lat = branch_lat;
	}
	public double getBranch_lng() {
		return branch_lng;
	}
	public void setBranch_lng(double branch_lng) {
		this.branch_lng = branch_lng;
	}
	public int getPriceBetweenAandB() {
		return priceBetweenAandB;
	}
	public void setPriceBetweenAandB(int priceBetweenAandB) {
		this.priceBetweenAandB = priceBetweenAandB;
	}
	
}
