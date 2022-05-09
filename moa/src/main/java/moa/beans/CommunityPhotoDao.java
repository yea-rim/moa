package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CommunityPhotoDao {
	public void insert(CommunityPhotoDto communityPhotoDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into community_photo(attach_no,community_no) values(?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, communityPhotoDto.getAttachNo());
		ps.setInt(2, communityPhotoDto.getCommunityNo());
		ps.execute();

		con.close();
	}

	public CommunityPhotoDto selectOne(int communityNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from community_photo where community_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, communityNo);
		ResultSet rs = ps.executeQuery();
		
		CommunityPhotoDto communityPhotoDto;
		if(rs.next()) {
			communityPhotoDto = new CommunityPhotoDto();
			communityPhotoDto.setAttachNo(rs.getInt("attach_no"));
			communityPhotoDto.setCommunityNo(rs.getInt("community_no"));
		}
		else {
			communityPhotoDto = null;
		}

		con.close();
		
		return communityPhotoDto;
	}
	
	public boolean delete(int communityNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete community_photo where community_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, communityNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public boolean edit(CommunityPhotoDto communityPhotoDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update community_photo set attach_no=? where community_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, communityPhotoDto.getAttachNo());
		ps.setInt(2, communityPhotoDto.getCommunityNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
}
