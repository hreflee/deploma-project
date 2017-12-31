package entity;

public class Box {	
	
	public Box(int boxNum, int boxWordNum, String catagloryID, String catagloryName) {
		super();
		this.boxNum = boxNum;
		this.boxWordNum = boxWordNum;
		this.catagloryID = catagloryID;
		this.catagloryName = catagloryName;
	}
	private int boxNum;
	public int getBoxNum() {
		return boxNum;
	}
	public void setBoxNum(int boxNum) {
		this.boxNum = boxNum;
	}
	public int getBoxWordNum() {
		return boxWordNum;
	}
	public void setBoxWordNum(int boxWordNum) {
		this.boxWordNum = boxWordNum;
	}
	public String getCatagloryID() {
		return catagloryID;
	}
	public void setCatagloryID(String catagloryID) {
		this.catagloryID = catagloryID;
	}
	public String getCatagloryName() {
		return catagloryName;
	}
	public void setCatagloryName(String catagloryName) {
		this.catagloryName = catagloryName;
	}
	private int boxWordNum;
	private String catagloryID;
	private String catagloryName;
	

}
