package com.douzone.bit.pathfinder.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class MapCost {
  private double payroll;
  private double distance;
  private double mileage;
  private double mileageCost;
  private double ton;
  private double tonRatio;
  private List<Integer> costList;

  private double resultCost;

  public void setPayroll(double payroll) {
    this.payroll = payroll;
  }

  public void setMileage(double mileage) {
    this.mileage = mileage;
    this.mileageCost = 1700 / mileage;
  }

  public void setTon(double ton) {
    this.ton = ton;
    this.tonRatio = ton / 6;
  }

  public double getResultCost(double distance, int index) {
    resultCost = (distance * (payroll + mileageCost));
    System.out.println("cost : " + index + " - " + resultCost);
    resultCost += (costList.get(index) * tonRatio); 
//    resultCost = resultCost*0.0002; 
    System.out.println(index + " : " + costList.get(index) * tonRatio);
    System.out.println("#resultCost" + resultCost);
 
    return resultCost;
  }

  public double getResultDist(double distance, int index) {
    resultCost = (distance * (payroll + mileageCost));

    return resultCost;
  }
}
