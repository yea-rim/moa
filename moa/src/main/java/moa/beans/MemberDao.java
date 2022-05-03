package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDao {
	
	// 등록 (1) 시퀀스 번호 생성
		public int getSequence() throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select member_seq.nextval from dual";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int number = rs.getInt("nextval");
			
			con.close();
			
			return number;
		}
		
		public void join(MemberDto memberDto) throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			
			String sql = "insert into member("
					+ "member_no, member_nick, member_phone, member_join_date, "
					+ "member_post, member_basic_address, member_detail_address, member_route, "
					+ "member_email, member_pw) values (member_seq.nextval, ?, ?, sysdate, ?, ?, ?, ?, ?, ?)";
			
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, memberDto.getMemberNick());
			ps.setString(2, memberDto.getMemberPhone());
			ps.setString(3, memberDto.getMemberPost());
			ps.setString(4, memberDto.getMemberBasicAddress());
			ps.setString(5, memberDto.getMemberDetailAddress());
			ps.setString(6, memberDto.getMemberRoute());
			ps.setString(7, memberDto.getMemberEmail());
			ps.setString(8, memberDto.getMemberPw());
			ps.execute();
			
			con.close();
			
		}

	// 상세 조회 
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
