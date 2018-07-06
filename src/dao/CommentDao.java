package dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import entity.Comment;
import util.DBHelper;

public class CommentDao {

	public boolean addComment(String username, int itemId, String text, Date date) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = DBHelper.getConn();
			String sql = "insert into Comment values(?,?,?,?) ";
			ps = con.prepareStatement(sql);
			ps.setString(1, username);
			ps.setInt(2, itemId);
			ps.setString(3, text);

			ps.setTimestamp(4, new java.sql.Timestamp(date.getTime()));

			int i = ps.executeUpdate();
			if (i == 1)
				return true;
			return false;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DBHelper.free(rs, ps, con);
		}

	}

	public ArrayList<Comment> fianAll(int itemId) {
		ArrayList<Comment> list = new ArrayList<Comment>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DBHelper.getConn();
			String sql = "select * from Comment where itemsId=? ";
			ps = con.prepareStatement(sql);
			ps.setInt(1, itemId);
			rs = ps.executeQuery();
			while (rs.next()) {
				Comment comment = new Comment();
				comment.setUsername(rs.getString("username"));
				comment.setItemsId(rs.getInt("itemsId"));
				comment.setMessage(rs.getString("message"));
				comment.setDate(rs.getTimestamp("date"));
				list.add(comment);
			}
			return list;
		} catch (SQLException e) {
			return null;
		} finally {
			DBHelper.free(rs, ps, con);

		}

	}
}
