package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JoaDao {
	
	public boolean isSearch(int projectNo, int memberNo) throws Exception{
		String sql = "select count(*) from joa where project_no = ? and member_no = ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		ps.setInt(2, memberNo);
		
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		
		return count > 0;
	}

	public void insert(int projectNo, int memberNo) throws Exception{
		String sql = "insert into joa(project_no, member_no) values(?, ?)";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		ps.setInt(2, memberNo);
		
		ps.execute();
		
		con.close();
	}
	
	public boolean delete(int projectNo, int memberNo) throws Exception{
		String sql = "delete joa where project_no = ? and member_no = ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		ps.setInt(2, memberNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
}
