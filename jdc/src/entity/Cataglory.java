package entity;

public class Cataglory {
	
	private int catagloryID;
	public int getCatagloryID() {
		return catagloryID;
	}
	public void setCatagloryID(int catagloryID) {
		this.catagloryID = catagloryID;
	}
	public String getCatagloryName() {
		return catagloryName;
	}
	public void setCatagloryName(String catagloryName) {
		this.catagloryName = catagloryName;
	}
	public int getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(int totalNum) {
		this.totalNum = totalNum;
	}
	public int getRemenberNum() {
		return remenberNum;
	}
	public void setRemenberNum(int remenberNum) {
		this.remenberNum = remenberNum;
	}
	public int getCurrentDay() {
		return currentDay;
	}
	public void setCurrentDay(int currentDay) {
		this.currentDay = currentDay;
	}
	
	public Cataglory(int catagloryID, String catagloryName, int totalNum,
			int remenberNum, int currentDay) {
		super();
		this.catagloryID = catagloryID;
		this.catagloryName = catagloryName;
		this.totalNum = totalNum;
		this.remenberNum = remenberNum;
		this.currentDay = currentDay;
	}
	
	
	public Cataglory() {
		super();
	}


	private String catagloryName;
	private int totalNum;
	private int remenberNum;
	private int currentDay;
	
	

}
