package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MoaNoticeAttachDao {
	
	public void insert(MoaNoticeAttachDto moaNoticeAttachDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into moa_notice_attach(attach_no,notice_no, attach_type) values(?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, moaNoticeAttachDto.getAttachNo());
		ps.setInt(2, moaNoticeAttachDto.getNoticeNo());
		ps.setString(3, moaNoticeAttachDto.getAttachType());
		ps.execute();

		con.close();
	}
	
	public MoaNoticeAttachDto selectOne(int noticeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "SELECT * FROM MOA_NOTICE_ATTACH WHERE notice_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, noticeNo);
		ResultSet rs = ps.executeQuery();
		
		MoaNoticeAttachDto moaNoticeAttachDto;
		if(rs.next()) {
			moaNoticeAttachDto = new MoaNoticeAttachDto();
			moaNoticeAttachDto.setAttachNo(rs.getInt("attach_no"));
			moaNoticeAttachDto.setNoticeNo(rs.getInt("notice_no"));
		}
		else {
			moaNoticeAttachDto = null;
		}
		con.close();
		
		return moaNoticeAttachDto;
	}
	
	public MoaNoticeAttachDto selectProfile(int noticeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "SELECT * FROM MOA_NOTICE_ATTACH WHERE notice_no = ? and attach_type = '프로필'";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, noticeNo);
		ResultSet rs = ps.executeQuery();
		
		MoaNoticeAttachDto moaNoticeAttachDto;
		if(rs.next()) {
			moaNoticeAttachDto = new MoaNoticeAttachDto();
			moaNoticeAttachDto.setAttachNo(rs.getInt("attach_no"));
			moaNoticeAttachDto.setNoticeNo(rs.getInt("notice_no"));
		}
		else {
			moaNoticeAttachDto = null;
		}
		
		con.close();
		
		return moaNoticeAttachDto;
	}
	
	public MoaNoticeAttachDto selectContent(int noticeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "SELECT * FROM MOA_NOTICE_ATTACH WHERE notice_no = ? and attach_type = '본문'";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, noticeNo);
		ResultSet rs = ps.executeQuery();
		
		MoaNoticeAttachDto moaNoticeAttachDto;
		if(rs.next()) {
			moaNoticeAttachDto = new MoaNoticeAttachDto();
			moaNoticeAttachDto.setAttachNo(rs.getInt("attach_no"));
			moaNoticeAttachDto.setNoticeNo(rs.getInt("notice_no"));
		}
		else {
			moaNoticeAttachDto = null;
		}

		con.close();
		
		return moaNoticeAttachDto;
	}
	
	public boolean delete(int noticeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete moa_notice_attach where notice_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, noticeNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public boolean deleteProfile(int noticeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete moa_notice_attach where notice_no = ? and attach_type = '프로필'";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, noticeNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public boolean deleteContent(int noticeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete moa_notice_attach where notice_no = ? attach_type = '본문'";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, noticeNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
}
