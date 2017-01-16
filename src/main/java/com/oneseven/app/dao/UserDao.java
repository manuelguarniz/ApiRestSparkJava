package com.oneseven.app.dao;

import java.sql.*;
import java.util.ArrayList;

import com.oneseven.app.config.ConnectionDataBase;
import com.oneseven.app.model.User;

public class UserDao {
	
	private Connection conn = null;
	private User user = null;
	private CallableStatement callableStatement = null;
	private ResultSet resultSet = null;
	
	public UserDao() {
		// TODO Auto-generated constructor stub
	}
	private static UserDao _instance;

	public static UserDao Instance() {
		if (_instance == null) _instance = new UserDao();
		return _instance;
	}
	
	public ArrayList<User> listUsers() throws Exception {
		ArrayList<User> list = new ArrayList<User>();
		try {
			String query = "SELECT authorId, name, email, dbo.functionDecrypt(password) [password] FROM authors";
			conn = ConnectionDataBase.Instance().getConnection();
			callableStatement = conn.prepareCall(query);
			resultSet = callableStatement.executeQuery();
			while (resultSet.next()) {
				user = new User();
				user.setAuthorId(resultSet.getInt("authorId"));
				user.setName(resultSet.getString("name"));
				user.setEmail(resultSet.getString("email"));
				user.setPassword(resultSet.getString("password"));
				list.add(user);
			}
		} catch (Exception ex) {}
		finally {
			conn.close();
			callableStatement.close();
			resultSet.close();
		}
		return list;
	}
}
