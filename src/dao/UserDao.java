package dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entity.User;
import util.DBHelper;

public class UserDao {
	
   //添加用户
	public boolean add(User user) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = DBHelper.getConn();
			String sql = "insert into Users(username,password,gender,email,address,cellphone) values(?,?,?,?,?,?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getGender());
			ps.setString(4, user.getEmail());
			ps.setString(5, user.getAddress());
			ps.setString(6, user.getCellphone());

			 int flag = ps.executeUpdate();
			 if (flag == 1)
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
  //登录验证
	public User findUser(String name, String password) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		User user = null;
		try {
			con = DBHelper.getConn();
			String sql = "select * from Users where username=? and password=? ";
			ps = con.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, password);
			rs = ps.executeQuery();
			if (rs.next()) {
				user = new User();
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setAddress(rs.getString("address"));
				user.setGender(rs.getString("gender"));
				user.setCellphone(rs.getString("cellphone"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.free(rs, ps, con);
		}
		return user;
	}
  //查看用户名是否注册
	public boolean findName(String username) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DBHelper.getConn();
			String sql = "select username from Users where username=? ";
			ps = con.prepareStatement(sql);
			ps.setString(1, username);
			rs = ps.executeQuery();
			if (rs.next()) {
				return true;
			}
			return false;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DBHelper.free(rs, ps, con);
		}

	}
	//修改个人信息
    public boolean updateInformation(String username,String password,String gender,String email,String address,String cellphone,int id ){
    	Connection con=null;
    	PreparedStatement ps=null;
    	ResultSet rs=null;
    	try {
			con=DBHelper.getConn();
			String sql="update Users set username=?,password=?,gender=?,email=?,address=?,cellphone=? where id=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, password);
			ps.setString(3, gender);
			ps.setString(4, email);
			ps.setString(5, address);
			ps.setString(6, cellphone);
			ps.setInt(7, id);
			int i=ps.executeUpdate();
			if(i==1)return true;
			return false;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}finally{
			DBHelper.free(rs, ps, con);
		}
    	
    }
    //获取所有用户信息
    public ArrayList<User> getAllUser(){
    	ArrayList<User> list=new ArrayList<User>();
    	Connection con=null;
    	PreparedStatement ps=null;
    	ResultSet rs=null;

    	try {
			con=DBHelper.getConn();
			String sql="select * from Users;";
			ps=con.prepareStatement(sql);
            rs=ps.executeQuery();
           while(rs.next()){
            	User u=new User();
            	u.setId(rs.getInt("id"));
            	u.setUsername(rs.getString("username"));
            	u.setPassword(rs.getString("password"));
            	u.setGender(rs.getString("gender"));
            	u.setEmail(rs.getString("email"));
            	u.setAddress(rs.getString("address"));
            	u.setCellphone(rs.getString("cellphone"));
            	list.add(u);
            }
            return list;
		} catch (SQLException e) {
			e.printStackTrace();
          return null;
		}finally{
			DBHelper.free(rs, ps, con);
		}
    }
    //删除某用户
    public boolean delete(int id){
    	  Connection con=null;
    	  PreparedStatement ps=null;
    	  ResultSet rs=null;
    	  try {
			con=DBHelper.getConn();
			String sql="delete from Users where id=? ";
			ps=con.prepareStatement(sql);
			ps.setInt(1, id);
			int i=ps.executeUpdate();
			if(i==1)return true;
			return false;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}finally{
			DBHelper.free(rs, ps, con);
			
		}
    }
    
}
