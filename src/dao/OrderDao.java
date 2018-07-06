package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import entity.Order;
import util.DBHelper;

public class OrderDao {

	public boolean addOrder(String username, Date date, String address, String cellphone, String status,float price) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs=null;
		try {
			con = DBHelper.getConn();
			String sql = "insert into Orders(username,date,address,cellphone,status,price) values(?,?,?,?,?,?) ";
			ps = con.prepareStatement(sql);
			ps.setString(1, username);
			ps.setDate(2, new java.sql.Date(date.getTime()));
			ps.setString(3, address);
			ps.setString(4, cellphone);
			ps.setString(5, status);
			ps.setFloat(6, price);
			int flag = ps.executeUpdate();
			if (flag == 1)
				return true;
			return false;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DBHelper.free(rs, ps, con);
		}

	}

	public ArrayList<Order> findAll(String username) {
		ArrayList<Order> list = new ArrayList<Order>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
        try {
			con=DBHelper.getConn();
			String sql="select * from Orders where username=? ";
			ps=con.prepareStatement(sql);
			ps.setString(1, username);
			rs=ps.executeQuery();
			while(rs.next()){
				Order order=new Order();
				order.setId(rs.getInt("id"));
				order.setUsername(rs.getString("username"));
				order.setDate(rs.getDate("date"));
				order.setAddress(rs.getString("address"));
				order.setCellphone(rs.getString("cellphone"));
				order.setStatus(rs.getString("status"));
				order.setPrice(rs.getFloat("price"));
				list.add(order);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally{
			DBHelper.free(rs, ps, con);
			
		}
        
	}
	public boolean deleteOrder(int orderid) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = DBHelper.getConn();
			String sql = "delete  from Orders where id=? ";
			ps = con.prepareStatement(sql);
			ps.setInt(1, orderid);
			int i = ps.executeUpdate();
			if (i == 1)
				return true;
			else
				return false;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DBHelper.free(rs, ps, con);
		}

	}
	
}
