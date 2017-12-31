/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.io.*;

/**
 *
 * @author Naizheng Bian
 */
public class User{   
	private int userid;
	private String username;
	private String password;
	private String realname;
	private String gender;
	private String email;
	private String address;
	private int userType;
	private boolean valid;
    
    public User(boolean valid) {
		super();
		this.valid = valid;
	}

	public User(int userid, String username, String realname, String gender,
			String email, String address, int userType, boolean valid) {
		super();
		this.userid = userid;
		this.username = username;
		this.realname = realname;
		this.gender = gender;
		this.email = email;
		this.address = address;
		this.userType = userType;
		this.valid = valid;
	}
    
    public User(String username, String realname, String gender,
			String email, String address, int userType, boolean valid) {
		super();
		this.username = username;
		this.realname = realname;
		this.gender = gender;
		this.email = email;
		this.address = address;
		this.userType = userType;
		this.valid = valid;
	}

	public User(){
        
    }

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}

	public boolean isValid() {
		return valid;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}
    
 
}
