package dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entity.Cart;
import entity.Items;
import util.DBHelper;

public class CartDao {

	private int flag;
	private int count;
	private float totalPrice;

	public boolean addGoods(Items item, int num, int userId) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		if (!findItems(userId, item)) {
			try {
				con = DBHelper.getConn();
				String sql = "insert into Cart(UserId,ItemsId,Count,TotalPrice) values(?,?,?,?) ";
				ps = con.prepareStatement(sql);
				ps.setInt(1, userId);
				ps.setInt(2, item.getId());
				ps.setInt(3, num);
				ps.setDouble(4, (item.getPrice() * num));
				flag = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBHelper.free(rs, ps, con);
			}
			if (flag == 1)
				return true;
			else
				return false;
		} else {
			try {
				con = DBHelper.getConn();
				String sql = "select Count,TotalPrice from Cart where ItemsId=? and UserId=? ";
				ps = con.prepareStatement(sql);
				ps.setInt(1, item.getId());
				ps.setInt(2, userId);
				rs = ps.executeQuery();
				if (rs.next()) {
					count = rs.getInt("Count");
					totalPrice = rs.getFloat("TotalPrice");
				}
				String sql2 = "update Cart set Count=?,TotalPrice=? where ItemsId=? and UserId=? ";
				ps = con.prepareStatement(sql2);
				ps.setInt(3, item.getId());
				ps.setInt(4, userId);
				ps.setInt(1, num + count);
				ps.setDouble(2, (totalPrice + num * item.getPrice()));
				flag = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBHelper.free(rs, ps, con);
			}
			if (flag == 1)
				return true;
			else
				return false;
		}
	}

	public ArrayList<Cart> getAllCart(int userId) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Cart> list = new ArrayList<Cart>();
		try {
			con = DBHelper.getConn();
			String sql = "select * from Cart where UserId=? ";
			ps = con.prepareStatement(sql);
			ps.setInt(1, userId);
			rs = ps.executeQuery();
			while (rs.next()) {
				Cart cart = new Cart();
				cart.setUserId(userId);
				cart.setItemsId(rs.getInt("ItemsId"));
				cart.setCount(rs.getInt("Count"));
				cart.setTotalPrice(rs.getFloat("TotalPrice"));
				list.add(cart);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			DBHelper.free(rs, ps, con);
		}
	}

	public boolean findItems(int userId, Items item) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = DBHelper.getConn();
			String sql = "select * from Cart where ItemsId=? and UserId=? ";
			ps = con.prepareStatement(sql);
			ps.setInt(1, item.getId());
			ps.setInt(2, userId);
			rs = ps.executeQuery();
			if (rs.next())
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

	public boolean deleteGoods(int userId, int itemsId) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = DBHelper.getConn();
			String sql = "delete  from Cart where userId=? and itemsId=? ";
			ps = con.prepareStatement(sql);
			ps.setInt(1, userId);
			ps.setInt(2, itemsId);
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
	public boolean deleteGoodsByUserId(int userId) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DBHelper.getConn();
			String sql = "delete  from Cart where userId=?  ";
			ps = con.prepareStatement(sql);
			ps.setInt(1, userId);;
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