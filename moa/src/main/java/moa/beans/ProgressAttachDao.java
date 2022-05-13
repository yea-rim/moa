package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProgressAttachDao {
	
	public Integer selectAttachNo(int progressNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select attach_no from progress_attach where progress_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, progressNo);

		ResultSet rs = ps.executeQuery();
		Integer attachNo;
		if (rs.next()) {
			attachNo = rs.getInt("attach_no");
		} else {
			attachNo = null;
		}

		con.close();

		return attachNo;
	} 
	
	public ProgressAttachDto selectOne(int progressNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from progress_attach where progress_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, progressNo);
		
		ResultSet rs = ps.executeQuery();
		
		ProgressAttachDto progressAttachDto;
		if(rs.next()) {
			progressAttachDto = new ProgressAttachDto();
			
			progressAttachDto.setProgressNo(rs.getInt("progress_no"));
			progressAttachDto.setAttachNo(rs.getInt("attach_no"));
		} else {
			progressAttachDto = null;
		}
		
		con.close();
		
		return progressAttachDto; 
	}

}
