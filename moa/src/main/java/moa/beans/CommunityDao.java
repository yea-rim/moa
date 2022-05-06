package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CommunityDao {
	
	// 전체목록 조회(검색어 x)
	public List<CommunityDto> selectList(int p, int s) throws Exception {
		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select*from(" 
				+ "select rownum rn, TMP.* from (" 
				+ "select * from community order by community_no desc"
				+ ") TMP" 
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();

		List<CommunityDto> list = new ArrayList<>();
		while (rs.next()) {
			CommunityDto communityDto = new CommunityDto();
			communityDto.setCommunityNo(rs.getInt("community_no"));
			communityDto.setCommunityProjectNo(rs.getInt("community_project_no"));
			communityDto.setCommunityMemberNo(rs.getInt("community_member_no"));
			communityDto.setCommunityTitle(rs.getString("community_title"));
			communityDto.setCommunityContent(rs.getString("community_content"));
			communityDto.setCommunityTime(rs.getDate("community_time"));
			communityDto.setCommunityReadcount(rs.getInt("community_readcount"));
			communityDto.setCommunityReplycount(rs.getInt("community_replycount"));
			list.add(communityDto);
		}

		con.close();

		return list;
	}

	// 전체목록 조회(검색어 o)
	public List<CommunityDto> selectList(int p, int s, String type, String keyword) throws Exception {
		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select*from(" 
				+ "select rownum rn, TMP.* from ("
				+ "select * from community where instr(#1, ?) > 0 order by community_no desc"
				+ ") TMP" 
				+ ") where rn between ? and ?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();

		List<CommunityDto> list = new ArrayList<>();
		while (rs.next()) {
			CommunityDto communityDto = new CommunityDto();
			communityDto.setCommunityNo(rs.getInt("community_no"));
			communityDto.setCommunityProjectNo(rs.getInt("community_project_no"));
			communityDto.setCommunityMemberNo(rs.getInt("community_member_no"));
			communityDto.setCommunityTitle(rs.getString("community_title"));
			communityDto.setCommunityContent(rs.getString("community_content"));
			communityDto.setCommunityTime(rs.getDate("community_time"));
			communityDto.setCommunityReadcount(rs.getInt("community_readcount"));
			communityDto.setCommunityReplycount(rs.getInt("community_replycount"));
			list.add(communityDto);
		}

		con.close();

		return list;
	}

	public int countByPaging() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from community";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}

	public int countByPaging(String type, String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from community where instr(#1, ?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}
	
	// 커뮤니티 시퀀스 생성
	public int getCommunityNo() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select community_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int communityNo = rs.getInt("community_no");
		
		con.close();
		
		return communityNo;
	}
	
	// 커뮤니티 등록
	public void insert(CommunityDto communityDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into community(community_no, community_project_no, community_member_no, community_title, community_content) values(?, ?, ?, ?,?,)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, communityDto.getCommunityNo());
		ps.setInt(2, communityDto.getCommunityProjectNo());
		ps.setInt(2, communityDto.getCommunityMemberNo());
		ps.setString(4, communityDto.getCommunityTitle());
		ps.setString(5, communityDto.getCommunityContent());
		
		con.close();
	}
	
	
}
