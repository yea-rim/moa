package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberProfileDao {

	public MemberProfileDto selectOne(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from member_profile where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		
		ResultSet rs = ps.executeQuery();
		
		MemberProfileDto memberProfileDto;
		if(rs.next()) {
			memberProfileDto = new MemberProfileDto();
			
			memberProfileDto.setMemberNo(rs.getInt("member_no"));
			memberProfileDto.setAttachNo(rs.getInt("attach_no"));
		} else {
			memberProfileDto = null; 
		}
		
		con.close();
		
		return memberProfileDto; 
	}
	
	public void insert(MemberProfileDto memberProfileDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into member_profile(member_no, attach_no) values(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberProfileDto.getMemberNo());
		ps.setInt(2, memberProfileDto.getAttachNo());
		
		ps.execute();
		
		con.close();
	}
	
	public boolean delete(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete member_profile where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
}
