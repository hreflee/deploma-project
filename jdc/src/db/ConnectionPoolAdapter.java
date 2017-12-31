package db;


import java.sql.*;

/** This is a generic database connection pool adapter.
 *
 * If you want a real connection pool, you need to derive
 * from this class and in particular override the
 * getConnection and freeConnection methods to 
 * use your connection pool. For an example, see
 * com.covecomm.deweb.util.ConnectionPoolDbConnectionBroker 
 */

 
public class ConnectionPoolAdapter {


public void destroy(int wait) throws java.sql.SQLException {
}
public java.lang.String freeConnection(java.sql.Connection connection) {
	try {
		connection.close();
	} catch (java.sql.SQLException e) {
		System.out.println("ConnectionPoolAdapter: " + e);
	}
	return null;
}
public java.sql.Connection getConnection() {
	Connection connection = null;
	try {
		connection = DriverManager.getConnection(getDriverUri(),
	        getUserId(),getPassword());
	} catch (SQLException e) {
		System.err.println("ConnectionPoolAdapter.getConnection: " + e.getMessage());
		System.err.println("ConnectionPoolAdapter.getConnection: " + e.getSQLState());
		System.err.println("ConnectionPoolAdapter.getConnection: " + e.getErrorCode());
	}
	return(connection);

}

private java.lang.String driverName;
private java.lang.String driverUri;
private java.lang.String logFile;
private int maxConnections;
private int minConnections;
private java.lang.String password;
private java.lang.String userId;
private double version;

public ConnectionPoolAdapter(
	String newDriverName,
	String newDriverUri,
	String newUserId,
	String newPassword)
	throws java.io.IOException {

	this(newDriverName,newDriverUri,newUserId,newPassword,0,0,"",0);

}

public ConnectionPoolAdapter(
	String newDriverName,
	String newDriverUri,
	String newUserId,
	String newPassword,
	int newMinConnections,
	int newMaxConnections,
	java.lang.String newLogFile,
	double newVersion)
	throws java.io.IOException {

	setDriverName(newDriverName);
	setDriverUri(newDriverUri);
	setUserId(newUserId);
	setPassword(newPassword);
	setMinConnections(newMinConnections);
	setMaxConnections(newMaxConnections);
	setLogFile(newLogFile);
	setVersion(newVersion);

	try {
		Class.forName(driverName).newInstance();
	} catch (ClassNotFoundException e) {
		System.err.println("ConnectionPoolAdapter constructor - class not found: " + e.getMessage());
	} catch (InstantiationException e) {
		System.err.println("ConnectionPoolAdapter constructor - instantation error: " + e.getMessage());
	} catch (IllegalAccessException e) {
		System.err.println("ConnectionPoolAdapter constructor - illegal access error: " + e.getMessage());
	}

}

public java.lang.String getDriverName() {
	return driverName;
}

public java.lang.String getDriverUri() {
	return driverUri;
}

public java.lang.String getLogFile() {
	return logFile;
}

public int getMaxConnections() {
	return maxConnections;
}

public int getMinConnections() {
	return minConnections;
}

public java.lang.String getPassword() {
	return password;
}
public java.lang.String getUserId() {
	return userId;
}
public double getVersion() {
	return version;
}
public void setDriverName(java.lang.String newDriverName) {
	driverName = newDriverName;
}

public void setDriverUri(java.lang.String newDriverUri) {
	driverUri = newDriverUri;
}

public void setLogFile(java.lang.String newLogFile) {
	logFile = newLogFile;
}

public void setMaxConnections(int newMaxConnections) {
	maxConnections = newMaxConnections;
}
public void setMinConnections(int newMinConnections) {
	minConnections = newMinConnections;
}
public void setPassword(java.lang.String newPassword) {
	password = newPassword;
}

public void setUserId(java.lang.String newUserId) {
	userId = newUserId;
}

public void setVersion(double newVersion) {
	version = newVersion;
}
}
