package entity;

public class UserWord 
{
	private String username;
	private int wordID;
	private int currentBox;
	private int currentLevel;
	private int currentLibrary;
	private int isSelected;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getWordID() {
		return wordID;
	}
	public void setWordID(int wordID) {
		this.wordID = wordID;
	}
	public int getCurrentBox() {
		return currentBox;
	}
	public void setCurrentBox(int currentBox) {
		this.currentBox = currentBox;
	}
	public int getCurrentLevel() {
		return currentLevel;
	}
	public void setCurrentLevel(int currentLevel) {
		this.currentLevel = currentLevel;
	}
	public int getCurrentLibrary() {
		return currentLibrary;
	}
	public void setCurrentLibrary(int currentLibrary) {
		this.currentLibrary = currentLibrary;
	}
	public int getIsSelected() {
		return isSelected;
	}
	public void setIsSelected(int isSelected) {
		this.isSelected = isSelected;
	}
    public UserWord()
    {
    }
    public UserWord(String username,int wordID)
    {
    	this.username=username;
    	this.wordID=wordID;
    	this.currentBox=0;
    	this.currentLevel=0;
    	this.currentLibrary=0;
    	this.isSelected=0;
    }
    public UserWord(String username,int wordID,int currentBox,
    		int currentLevel,int currentLibrary,int isSlected)
    {
    	this.username=username;
    	this.wordID=wordID;
    	this.currentBox=currentBox;
    	this.currentLevel=currentLevel;
    	this.currentLibrary=currentLibrary;
    	this.isSelected=isSlected;
    }
}
