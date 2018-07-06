package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBHelper {
   private static String DRIVER="com.microsoft.sqlserver.jdbc.SQLServerDriver";
   private static String URL="jdbc:sqlserver://localhost:1433;databaseName=Eshop";
   private static String USERNAME="sa";
   private static String PASSWORD="123123123";
   static{
	   try {
		Class.forName(DRIVER);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
   }
	private  DBHelper() {

	}
	public static Connection getConn() throws SQLException{
		return DriverManager.getConnection(URL, USERNAME, PASSWORD);
	}
	public static void free(ResultSet rs,Statement st,Connection con){
		 try {
			   if(rs!=null)
			   rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(st!=null)
				st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					if(con!=null)
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

}
