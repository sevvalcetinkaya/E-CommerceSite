package com.cds.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import jakarta.servlet.http.HttpServlet;

public class DBConnection extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private static Connection connection;

	public static Connection getConnection() {

		try {
			if (connection == null) {
				//Class.forName("com.mysql.cj.jdbc.Driver");
				Class.forName("com.mysql.cj.jdbc.Driver");
				connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstoresystem", "root", "");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}

}