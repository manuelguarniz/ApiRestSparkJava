package com.oneseven.app.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionDataBase {
	private static final String HOST = "localhost:1433";
	private static final String DATABASE = "dbblog";
	private static final String USER = "sa";
	private static final String PASSWORD = "Cruzemg95";
	
	private Connection connection = null;
	
	public ConnectionDataBase() {
		// TODO Auto-generated constructor stub
	}
	private static ConnectionDataBase _instance;

	public static ConnectionDataBase Instance() {
		if (_instance == null) _instance = new ConnectionDataBase();
		return _instance;
	}
	public Connection getConnection() throws Exception {
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			connection = DriverManager.
					getConnection("jdbc:sqlserver://".concat(HOST).concat(";databaseName=".concat(DATABASE)), USER, PASSWORD);
		} catch (Exception e) {}
		return connection;
	}
}
