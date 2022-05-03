package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDao {

	public MemberDto selectOne(String memberEmail) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from member where member_email = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, memberEmail);
		
		ResultSet rs = ps.executeQuery();
		
		MemberDto memberDto;
		
		if(rs.next()) {
			memberDto = new MemberDto();
			
			memberDto.setMemberNo(rs.getInt("member_no"));
			memberDto.setMemberEmail(rs.getString("member_email"));
			memberDto.setMemberPw(rs.getString("member_pw"));
			memberDto.setMemberNick(rs.getString("member_nick"));
			memberDto.setMemberPhone(rs.getString("member_phone"));
			memberDto.setMemberJoinDate(rs.getDate("member_join_date"));
			memberDto.setMemberPost(rs.getString("member_post"));
			memberDto.setMemberBasicAddress(rs.getString("member_basic_address"));
			memberDto.setMemberDetailAddress(rs.getString("member_detail_address"));
			memberDto.setMemberRoute(rs.getString("member_route"));
		} else {
			memberDto = null; 
		}
		
		con.close();
		
		return memberDto; 
		
	}
}
