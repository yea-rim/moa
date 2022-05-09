package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
	// 목록 조회 
	public List<JoaDto> selectList(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from joa J "
				+ "inner join project P on P.project_no = J.project_no "
				+ "where J.member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		
		ResultSet rs = ps.executeQuery();
		
		List<JoaDto> list = new ArrayList<>();
		
		while(rs.next()) {
			JoaDto joaDto = new JoaDto();
			
			joaDto.setProjectNo(rs.getInt("project_no"));
			joaDto.setMemberNo(rs.getInt("member_no"));
			
			list.add(joaDto);
		}
		
		con.close();
		
		return list; 
	}
	
	
	// 좋아요 취소
	public boolean delete(int memberNo, int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete joa where member_no = ? and project_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ps.setInt(2, projectNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0; 
	}
}

