package dao;

import java.sql.Connection;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entity.Items;
import util.DBHelper;

public class ItemsDao {
   //获得所有商品信息
	public ArrayList<Items> getAllItems() {
		ArrayList<Items> list = new ArrayList<Items>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DBHelper.getConn();
			String sql = "select *from Items;";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				Items item = new Items();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setCity(rs.getString("city"));
				item.setPrice(rs.getFloat("price"));
				item.setPicture(rs.getString("picture"));
				item.setCategory(rs.getString("category"));
				item.setType(rs.getString("type"));
				item.setDetail(rs.getString("detail"));
				list.add(item);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			DBHelper.free(rs, ps, con);
		}

	}
	//获得该目录商品信息
	public ArrayList<Items> getCategoryItems(String category) {
		ArrayList<Items> list = new ArrayList<Items>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DBHelper.getConn();
			String sql = "select * from Items where category=? ";
			ps = con.prepareStatement(sql);
			ps.setString(1, category);
			rs = ps.executeQuery();
			while (rs.next()) {
				Items item = new Items();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setCity(rs.getString("city"));
				item.setPrice(rs.getFloat("price"));
				item.setPicture(rs.getString("picture"));
				item.setCategory(rs.getString("category"));
				item.setType(rs.getString("type"));
				item.setDetail(rs.getString("detail"));
				list.add(item);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			DBHelper.free(rs, ps, con);
		}

	}
    //获得该类型商品信息
	public ArrayList<Items> getTypeItems(String type) {
		ArrayList<Items> list = new ArrayList<Items>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DBHelper.getConn();
			String sql = "select * from Items where type=? ";
			ps = con.prepareStatement(sql);
			ps.setString(1, type);
			rs = ps.executeQuery();
			while (rs.next()) {
				Items item = new Items();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setCity(rs.getString("city"));
				item.setPrice(rs.getFloat("price"));
				item.setPicture(rs.getString("picture"));
				item.setCategory(rs.getString("category"));
				item.setType(rs.getString("type"));
				item.setDetail(rs.getString("detail"));
				list.add(item);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			DBHelper.free(rs, ps, con);
		}

	}
     //根据id查找商品
	public Items getItemsById(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Items item = new Items();
		try {
			con = DBHelper.getConn();
			String sql = "select * from Items where id=? ";
			ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setCity(rs.getString("city"));
				item.setPrice(rs.getFloat("price"));
				item.setPicture(rs.getString("picture"));
				item.setCategory(rs.getString("category"));
				item.setType(rs.getString("type"));
				item.setDetail(rs.getString("detail"));
				return item;
			} else
				return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			DBHelper.free(rs, ps, con);
		}

	} 
	//模糊查询
	public ArrayList<Items> search(String itemName){
		ArrayList<Items> list = new ArrayList<Items>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DBHelper.getConn();
			String sql = "select * from Items where name like ? ";
			ps = con.prepareStatement(sql);
			ps.setString(1,"%"+itemName+"%");
			rs = ps.executeQuery();
			while (rs.next()) {
				Items item = new Items();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setCity(rs.getString("city"));
				item.setPrice(rs.getFloat("price"));
				item.setPicture(rs.getString("picture"));
				item.setCategory(rs.getString("category"));
				item.setType(rs.getString("type"));
				item.setDetail(rs.getString("detail"));
				list.add(item);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			DBHelper.free(rs, ps, con);
		}
		
		
	}
	//添加商品
	public boolean addItems(String name,String city,float price,String picture,String category,String type,String detail)
	{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {
			con=DBHelper.getConn();
			String sql="Insert into Items(name,city,price,picture,category,type,detail) values(?,?,?,?,?,?,?)";
			ps=con.prepareStatement(sql);
			ps.setString(1,name);
			ps.setString(2,city);
			ps.setFloat(3, price);
			ps.setString(4,picture);
			ps.setString(5,category);
			ps.setString(6,type);
			ps.setString(7,detail);
			int flag = ps.executeUpdate();
			if(flag==1)
			{
				System.out.println("插入成功！");
				return true;
			}
			else
			{
				System.out.println("插入失败！");
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}finally{
			DBHelper.free(rs, ps, con);
		}		
	}
	
	//删除商品
	public boolean delItems(int id)
	{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {
			con=DBHelper.getConn();
			String sql="delete from Items where id=? ";
			ps=con.prepareStatement(sql);
			ps.setInt(1,id);
			int flag=ps.executeUpdate();
			if(flag==1)
			{
				System.out.println("删除成功！");
				return true;
			}
			else
			{
				System.out.println("删除失败！");
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}finally{
			DBHelper.free(rs, ps, con);
		}		
	}
	
	//获取浏览过的商品视图
	public ArrayList<Items> getViewList(String arr) {

		ArrayList<Items> list = new ArrayList<Items>();
		if (arr != null && arr.length() > 0) {
			String[] a = arr.split(",");
			if (a.length >= 5) {
				for (int i = a.length - 1; i >= a.length - 5; i--) {
					Items item = getItemsById(Integer.parseInt(a[i]));
					list.add(item);
				}
			} else {
				for (int i = a.length - 1; i >= 0; i--) {
					Items item = getItemsById(Integer.parseInt(a[i]));
					list.add(item);
				}
			}

			return list;
		} else
			return null;
	}
	
	//分页
	public ArrayList<Items> getCategoryPageItems(int pageNow,int pageSize,String category) 
	{
		int pre=pageSize*(pageNow-1);
		ArrayList<Items> list = new ArrayList<Items>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DBHelper.getConn();
			String sql = "select top "+pageSize+" * from Items where category=? and id not in (select top "+pre+" id from Items order by id) order by id";
			ps = con.prepareStatement(sql);
			ps.setString(1, category);
			rs = ps.executeQuery();
			while (rs.next()) {
				Items item = new Items();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setCity(rs.getString("city"));
				item.setPrice(rs.getFloat("price"));
				item.setPicture(rs.getString("picture"));
				item.setCategory(rs.getString("category"));
				item.setType(rs.getString("type"));
				item.setDetail(rs.getString("detail"));
				list.add(item);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			DBHelper.free(rs, ps, con);
		}

	}
	
	public ArrayList<Items> getTypePageItems(int pageNow,int pageSize,String type) 
	{
		int pre=pageSize*(pageNow-1);
		ArrayList<Items> list = new ArrayList<Items>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DBHelper.getConn();
			String sql = "select top "+pageSize+" * from Items where type=? and id not in (select top "+pre+" id from Items order by id) order by id";
			ps = con.prepareStatement(sql);
			ps.setString(1, type);
			rs = ps.executeQuery();
			while (rs.next()) {
				Items item = new Items();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setCity(rs.getString("city"));
				item.setPrice(rs.getFloat("price"));
				item.setPicture(rs.getString("picture"));
				item.setCategory(rs.getString("category"));
				item.setType(rs.getString("type"));
				item.setDetail(rs.getString("detail"));
				list.add(item);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			DBHelper.free(rs, ps, con);
		}

	}
	
	

}
