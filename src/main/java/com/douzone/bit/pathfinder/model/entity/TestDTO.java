package com.douzone.bit.pathfinder.model.entity;

public class TestDTO {
	private String areaName;
	private int transportationExpenses;
	private double latitude; // 위도
	private double longitude; // 경도

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	public int getTransportationExpenses() {
		return transportationExpenses;
	}

	public void setTransportationExpenses(int transportationExpenses) {
		this.transportationExpenses = transportationExpenses;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	@Override
	public String toString() {
		return "testDTO [areaName=" + areaName + ", transportationExpenses=" + transportationExpenses + ", latitude="
				+ latitude + ", longitude=" + longitude + "]";
	}
}
