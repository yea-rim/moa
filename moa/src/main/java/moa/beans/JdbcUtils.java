package moa.beans;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class JdbcUtils {
	private static DataSource src;
	static { 
		
		try {
			// 1. 자원 탐색 도구를 생성
			Context ctx = new InitialContext();
			
			// 2. 자원 탐색 도구를 이용하여 등록된 자원 중 name = "jdbc/oracle"인 Resource를 찾도록 지시 
			src = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
			
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
	}
	
	public static Connection getConnection() throws Exception {
		return src.getConnection();
	}
	
//	public static Connection getConnection() throws Exception {
//		Class.forName("oracle.jdbc.OracleDriver");
//		return DriverManager.getConnection("jdbc:oracle:thin:@www.sysout.co.kr:11521:xe", "kh20", "kh20");
//	}
}
