/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedHashMap;

import entity.*;
import db.*;

/**
 * 
 * @author Naizheng Bian
 */
public class UserMgr {

	public UserMgr() {
	}

	public int register(String studentname, String pairname, String password,
			int[] cataID) {
		int result = 1;
		int cataNum = 0;
		if (checkUser(studentname, pairname) != 1) {
			result = -1;
			return result;
		}
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = DBBean.getConnection();
			stmt = conn.createStatement();
			String sql = "select count(*) as totalNum from table_cataglory";
			rset = stmt.executeQuery(sql);
			while (rset.next()) {
				cataNum = rset.getInt("totalNum") ;
			}
			// insert table_user
			sql = "insert into table_user(username,password,userType,valid,pair,isOnline,isLoged)values('"
					+ studentname
					+ "','"
					+ password
					+ "',0,1"
					+ ",'"
					+ pairname + "',0,0)";
			DBBean.update(sql);
			sql = "insert into table_user(username,password,userType,valid,pair,isOnline,isLoged)values('"
					+ pairname + "','" + password + "',1,1" + ",'" + "',0,0)";
			DBBean.update(sql);
			// insert table_usercataglorysetting
			for (int i = 1; i <= cataNum ; i++) {
				sql = "insert into table_usercataglorysetting (username,catagloryID,stduent_new_word_num,subCatagloryID,haultNum,currentDay,isSelected, Student_rem_word_num,previouseDay,isCurrentCata) values('"
						+ studentname + "'," + i + ",50,1,-1,0,0,50,-1,0)";
				DBBean.update(sql);
			}
			//set cuurrent cataglory
			sql = "update table_usercataglorysetting set isCurrentCata=1 where username='" + studentname + "' and catagloryID='" + cataID[0] + "'";
			DBBean.update(sql);
			
			// insert table_word_user
			sql = "insert into table_word_user(username,WordID,currentBox,currentLevel,everKnow,isHault) "
					+ " select uc.username,w.wordID,-4,0,0,0 "
					+ " from table_usercataglorysetting uc,table_word w"
					+ " where uc.catagloryID=w.catagloryID and uc.username='"
					+ studentname + "'";
			DBBean.update(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				rset.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public void changeCata(String studentname, int cataID) {
	
		Connection conn = null;
		Statement stmt = null;
		String sql = "";
		try {
			conn = DBBean.getConnection();
			stmt = conn.createStatement();
			
			//set cuurrent cataglory
			sql = "update table_usercataglorysetting set isCurrentCata=0 where username='" + studentname + "'";
			DBBean.update(sql);
			sql = "update table_usercataglorysetting set isCurrentCata=1 where username='" + studentname + "' and catagloryID='" + cataID + "'";
			DBBean.update(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public int changePair(String studentname, String newPairname,
			String password) {
		int result = 1;
		if (checkUser(studentname, newPairname) == 2
				|| checkUser(studentname, newPairname) == 4) {
			result = -1;
			return result;
		}
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = DBBean.getConnection();
			stmt = conn.createStatement();
			ResultSet rset = null;
			// find old pair name
			String oldPairname = "";
			String sql = "select * from table_user where username='"
					+ studentname + "'";
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			if (rset.next()) {
				oldPairname = rset.getString("pair");
			}
			// insert table_user
			sql = "delete from table_user where username='" + oldPairname + "'";
			DBBean.update(sql);
			sql = "insert into table_user(username,password,userType,valid,pair,isOnline,isLoged)values('"
					+ newPairname
					+ "','"
					+ password
					+ "',1,1"
					+ ",'"
					+ "',0,0)";
			DBBean.update(sql);
			sql = "update table_user set pair='" + newPairname + "' where username='" + studentname + "'";
			DBBean.update(sql);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public int changePassword(String username, String oldPassword,
			String newPassword) {
		int result = -1;// default, wrong old password
		Connection conn = null;
		conn = DBBean.getConnection();
		Statement stmt = null;
		ResultSet rset = null;
		String sql = "";
		try {
			sql = "select * from table_user where username='" + username
					+ "' and password='" + oldPassword + "'";
			// System.out.println("sql=" + sql);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			if (rset.next()) {
				result = 1;// old password correct
				sql = "update table_user set password='" + newPassword
						+ "' where username='" + username + "'";
				DBBean.update(sql);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				rset.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public HashMap getUserCatagloryList(String username) {
		HashMap userCatagloryList = new HashMap();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		conn = DBBean.getConnection();
		String sql = "";

		Connection conn2 = null;
		conn2 = DBBean.getConnection();
		Statement stmt2 = null;
		ResultSet rset2 = null;
		String sql2 = "";

		Connection conn3 = null;
		conn3 = DBBean.getConnection();
		Statement stmt3 = null;
		ResultSet rset3 = null;
		String sql3 = "";

		Cataglory usercata = null;
		try {

			sql = "select table_user.username, table_usercataglorysetting.catagloryID,table_cataglory.catagloryName, "
					+ "table_usercataglorysetting.currentDay from table_user, table_usercataglorysetting, "
					+ "table_cataglory where table_user.username=table_usercataglorysetting.username and "
					+ "table_cataglory.catagloryID=table_usercataglorysetting.catagloryID and table_user.username='"
					+ username + "'";

			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while (rset.next()) {
				sql2 = "select count(*) as totalNum from table_word_user, table_word where table_word_user.username='"
						+ username
						+ "' and table_word.catagloryID='"
						+ rset.getInt("catagloryID")
						+ "' and table_word.wordID=table_word_user.wordID";

				stmt2 = conn2.createStatement();
				rset2 = stmt2.executeQuery(sql2);
				int totalNum = 0;
				int everKnow = 0;
				while (rset2.next()) {
					totalNum = rset2.getInt("totalNum");
				}

				sql3 = "select count(*) as everKnowNum from table_word_user, table_word where table_word_user.username='"
						+ username
						+ "' and table_word.catagloryID='"
						+ rset.getInt("catagloryID")
						+ "' and table_word_user.everKnow=1 and "
						+ "table_word.wordID=table_word_user.wordID";

				stmt3 = conn3.createStatement();
				rset3 = stmt3.executeQuery(sql3);
				while (rset3.next()) {
					everKnow = rset3.getInt("everKnowNum");
				}
				usercata = new Cataglory(rset.getInt("catagloryID"),
						rset.getString("catagloryName"), totalNum, everKnow,
						rset.getInt("currentDay"));

				userCatagloryList
						.put(rset.getString("catagloryName"), usercata);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				rset.close();
				stmt.close();
				conn.close();
				rset2.close();
				stmt2.close();
				conn2.close();
				rset3.close();
				stmt3.close();
				conn3.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return userCatagloryList;
	}
	
	public HashMap getUserCurrentCataglory(String username) {
		HashMap userCatagloryList = new HashMap();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		conn = DBBean.getConnection();
		String sql = "";

		Connection conn2 = null;
		conn2 = DBBean.getConnection();
		Statement stmt2 = null;
		ResultSet rset2 = null;
		String sql2 = "";

		Connection conn3 = null;
		conn3 = DBBean.getConnection();
		Statement stmt3 = null;
		ResultSet rset3 = null;
		String sql3 = "";

		Cataglory usercata = null;
		try {

			sql = "select table_user.username, table_usercataglorysetting.catagloryID,table_cataglory.catagloryName, "
					+ "table_usercataglorysetting.currentDay from table_user, table_usercataglorysetting, "
					+ "table_cataglory where table_user.username=table_usercataglorysetting.username and "
					+ "table_cataglory.catagloryID=table_usercataglorysetting.catagloryID and table_user.username='"
					+ username + "' and table_usercataglorysetting.isCurrentCata=1";

			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while (rset.next()) {
				sql2 = "select count(*) as totalNum from table_word_user, table_word where table_word_user.username='"
						+ username
						+ "' and table_word.catagloryID='"
						+ rset.getInt("catagloryID")
						+ "' and table_word.wordID=table_word_user.wordID";

				stmt2 = conn2.createStatement();
				rset2 = stmt2.executeQuery(sql2);
				int totalNum = 0;
				int everKnow = 0;
				while (rset2.next()) {
					totalNum = rset2.getInt("totalNum");
				}

				sql3 = "select count(*) as everKnowNum from table_word_user, table_word where table_word_user.username='"
						+ username
						+ "' and table_word.catagloryID='"
						+ rset.getInt("catagloryID")
						+ "' and table_word_user.everKnow=1 and "
						+ "table_word.wordID=table_word_user.wordID";

				stmt3 = conn3.createStatement();
				rset3 = stmt3.executeQuery(sql3);
				while (rset3.next()) {
					everKnow = rset3.getInt("everKnowNum");
				}
				usercata = new Cataglory(rset.getInt("catagloryID"),
						rset.getString("catagloryName"), totalNum, everKnow,
						rset.getInt("currentDay"));

				userCatagloryList
						.put(rset.getString("catagloryName"), usercata);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				rset.close();
				stmt.close();
				conn.close();
				rset2.close();
				stmt2.close();
				conn2.close();
				rset3.close();
				stmt3.close();
				conn3.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return userCatagloryList;
	}
	
	public LinkedHashMap getUserWordDetailInfo(String username, String cataID, String cataName) {
		LinkedHashMap<String, Box> userWordDetailList = new LinkedHashMap<String, Box>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		conn = DBBean.getConnection();
		String sql = "";
		try {
            //find current maxium box number
			int maxboxNum = -4;
			sql =  "select MAX(currentBox) as currentBoxMax from table_word_user, table_word where table_word_user.username='"
				+ username + "' and table_word.catagloryID='"
				+ cataID + "' and table_word.wordID=table_word_user.wordID";
            //System.out.println("sql-1=" + sql);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while (rset.next()) {
				maxboxNum = rset.getInt("currentBoxMax");
			}
			//get number of words in each box,and put into hashtable
			int total = 0;
			for(int i = -4; i <= maxboxNum;i++){
				
				if( i == -2 || i == 0 || i == 1){
					continue;
				}
				sql = "select count(*) as totalNum from table_word_user, table_word where username='"
						+ username + "' and table_word.catagloryID='"
						+ cataID + "' and table_word_user.currentBox='" + i 
						+"' and table_word.wordID=table_word_user.wordID";
				
				
				stmt = conn.createStatement();
				rset = stmt.executeQuery(sql);	
				while (rset.next()) {
					total = rset.getInt("totalNum");
					Box box = new Box(i,total,cataID,cataName);
					if(total != 0 && (i==-4 || i==-3 || i==-1 ||i==2 || i==3  || i==6 || i==8 || i==16 || i==46 || i==106 || i==196)){
						userWordDetailList.put(i+"", box);
						//System.out.println("box=" + box.getBoxNum());
					}
				}
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				rset.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return userWordDetailList;
	}


	public HashMap getCatagloryList() {
		HashMap catagloryList = new HashMap();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		Cataglory usercata = null;
		try {
			conn = DBBean.getConnection();
			String sql = "select * from table_cataglory";

			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while (rset.next()) {
				usercata = new Cataglory(rset.getInt("catagloryID"),
						rset.getString("catagloryName"), 0, 0, 0);

				catagloryList.put(rset.getString("catagloryName"), usercata);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				rset.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return catagloryList;
	}

	public int getHaultWordNum(String username, String catagloryID) {
		int haultWordNum = 0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = DBBean.getConnection();
			String sql = "select count(*) as totalNum from table_word_user,table_word where username='"
					+ username
					+ "' and table_word.catagloryID='"
					+ catagloryID
					+ "' and table_word.wordID=table_word_user.wordID and table_word_user.isHault=1";

			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while (rset.next()) {
				haultWordNum = rset.getInt("totalNum");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				rset.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return haultWordNum;
	}

	public String getStudentName(String teachername) {
		String studentName = "";
		;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		Cataglory usercata = null;
		try {
			conn = DBBean.getConnection();
			String sql = "select * from table_user where pair='" + teachername
					+ "'";

			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while (rset.next()) {
				studentName = rset.getString("username");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				rset.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return studentName;
	}

	public String getTeacherName(String studentName) {
		String teacherName = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = DBBean.getConnection();
			String sql = "select * from table_user where username='"
					+ studentName + "'";

			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while (rset.next()) {
				teacherName = rset.getString("pair");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				rset.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return teacherName;
	}

	public int judgeStudentLogin(String teachername) {
		int result = 0;
		;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		Cataglory usercata = null;
		try {
			conn = DBBean.getConnection();
			String sql = "select * from table_user where pair='" + teachername
					+ "'";

			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while (rset.next()) {
				result = rset.getInt("isOnline");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				rset.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	// 1 - no student and no pair; 2 - no student but has pair; 3- has student
	// but no pair;4 - has student and has pair
	// either studentname and pairname can not conflict with current username
	public int checkUser(String studentname, String pairname) {
		int result = -1;
		String sql = "select * from Table_user where username='" + studentname
				+ "'";
         
		if (DBBean.hasRecord(sql)) {// has student
			result = 3;// has student but no pair
			sql = "select * from Table_user where username='" + pairname + "'";

			if (DBBean.hasRecord(sql)) {
				result = 4;// has student and has pair
			}
		} else {// no student
			result = 1;// no student and no pair
			sql = "select * from Table_user where username='" + pairname + "'";

			if (DBBean.hasRecord(sql)) {
				result = 2;// no student but has pair
			}
		}

		return result;
	}

	// 1 - pairname as same as old
	// but no pair;4 - has student and has pair
	// either studentname and pairname can not conflict with current username
	public int checkPair(String studentname, String pairname) {
		int result = -1;
		String sql = "select * from Table_user where username='" + studentname
				+ "' and pair='" + pairname + "'";

		if (DBBean.hasRecord(sql)) {// has student
			result = 1;// pairname as same as old
		} 
		else {
			sql = "select * from Table_user where username='" + pairname + "'";

			if (DBBean.hasRecord(sql)) {
				result = 2;// conflict with other username or pairname
			}
		}

		return result;
	}

	public int verifyUser(String username, String password) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		int isOnline = 0;
		int result = -1;//
		try {
			conn = DBBean.getConnection();
			String sql = "select * from table_user where username='" + username
					+ "' and password='" + password + "'";
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			if (rset.next()) {
				result = rset.getInt("userType");
				isOnline = rset.getInt("isLoged");
				/*
				 * if(isOnline == 1){//alreay login result = -5; }else{//if not,
				 * update login info sql =
				 * "update table_user set isLoged=1 where username='" + username
				 * + "'"; DBBean.update(sql); }
				 */

			} else {
				sql = "select * from table_user where username='" + username
						+ "'";
				stmt = conn.createStatement();
				rset = stmt.executeQuery(sql);
				if (rset.next()) {
					result = -2;
				}
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			try {
				rset.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public boolean logout(String username) {
		boolean result = true;
		;
		Connection conn = null;
		String sql = "";
		conn = DBBean.getConnection();
		sql = "update table_user set isLoged=0 where username='" + username
				+ "'";
		result = DBBean.update(sql);
		return result;
	}

}
