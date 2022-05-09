package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CommunityReplyDao {
	public int getCommunityReplySeq() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select community_reply_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();

		int communityReplyNo = rs.getInt("nextval");

		con.close();

		return communityReplyNo;
	}
	
	public void insert(CommunityReplyDto communityReplyDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "INSERT INTO community_reply(community_reply_no,community_no, community_member_no, community_reply_content) values(?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, communityReplyDto.getCommunityReplyNo());
		ps.setInt(2, communityReplyDto.getCommunityNo());
		ps.setInt(3, communityReplyDto.getCommunityMemberNo());
		ps.setString(4, communityReplyDto.getCommunityReplyContent());
		ps.execute();
		
		con.close();
	}
	
	public List<CommunityReplyDto> selectAll(int communityNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "SELECT * FROM COMMUNITY_REPLY WHERE community_no = ? order by community_reply_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, communityNo);
		ResultSet rs = ps.executeQuery();
		
		List<CommunityReplyDto> list = new ArrayList<>();
		
		while(rs.next()) {
			CommunityReplyDto communityReplyDto = new CommunityReplyDto();
			communityReplyDto.setCommunityReplyNo(rs.getInt("community_reply_no"));
			communityReplyDto.setCommunityNo(rs.getInt("community_no"));
			communityReplyDto.setCommunityMemberNo(rs.getInt("community_member_no"));
			communityReplyDto.setCommunityReplyTime(rs.getDate("community_reply_date"));
			communityReplyDto.setCommunityReplyContent(rs.getString("community_reply_content"));
			
			list.add(communityReplyDto);
		}
		
		con.close();
		
		return list;
	}
}
