package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import entity.Admin;
import util.DBHelper;

public class AdminDao {

	public AdminDao() {
	}
	public Admin findAdmin(String name, String password) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Admin admin = null;
		try {
			con = DBHelper.getConn();
			String sql = "select * from Admin where name=? and password=? ";
			ps = con.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, password);
			rs = ps.executeQuery();
			if (rs.next()) {
				admin=new Admin();
				admin.setName(rs.getString("name"));
				admin.setPassword(rs.getString("password"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.free(rs, ps, con);
		}
		return admin;
	}
}
