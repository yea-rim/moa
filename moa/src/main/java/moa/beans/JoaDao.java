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
	
	
	// 기본 좋아요 목록 
	public List<JoaDto> selectList(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from joa where member_no = ? order by joa_date desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ResultSet rs = ps.executeQuery();
		
		List<JoaDto> list = new ArrayList<>();
		
		while(rs.next()) {
			JoaDto joaDto = new JoaDto();
			
			joaDto.setProjectNo(rs.getInt("project_no"));
			joaDto.setMemberNo(rs.getInt("member_no"));
			joaDto.setJoaDate(rs.getDate("joa_date"));
			
			list.add(joaDto);
		}
		
		con.close();
		
		return list;
	}
	
	
	// 좋아요 목록 + 페이징
	public List<JoaDto> selectList(int p, int s, int memberNo) throws Exception {
		
		int end = p * s;
		int begin = end - (s - 1);
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from joa where member_no = ? order by joa_date desc"
				+ ")TMP"
				+ ")where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		
		ResultSet rs = ps.executeQuery();
		
		List<JoaDto> list = new ArrayList<>();
		
		while(rs.next()) {
			JoaDto joaDto = new JoaDto();
			
			joaDto.setProjectNo(rs.getInt("project_no"));
			joaDto.setMemberNo(rs.getInt("member_no"));
			joaDto.setJoaDate(rs.getDate("joa_date"));
			
			list.add(joaDto);
		}
		
		con.close();
		
		return list; 
	}
	
	// 좋아요 페이징 카운트 
	public int JoaCountByPaging(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from joa where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}
	
	
	
	// 좋아요 취소
	public boolean delete(int projectNo, int memberNo) throws Exception {
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

