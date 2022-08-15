package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class JDBCUtil {
	// 1~2단계 - Connection Pool 사용
		public static Connection getConnection() throws Exception {
			// 커넥션 풀을 사용하는 방법
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource) envCtx.lookup("jdbc/jspmall");
			return ds.getConnection();
		}
		
		// Connection, PreparedStatement를 닫는 메소드 - insert, update, delete 작업일때
		public static void close(Connection conn, PreparedStatement pstmt) {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			
		}
		// Connection, PreparedStatement, ResultSet을 닫는 메소드 - select 작업일때
		public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			
		}
}
