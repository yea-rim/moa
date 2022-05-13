package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProgressAttachDao {
	
	public void insert(ProgressAttachDto progressAttachDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into progress_attach(attach_no,progress_no) values(?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, progressAttachDto.getAttachNo());
		ps.setInt(2, progressAttachDto.getProgressNo());
		ps.execute();

		con.close();
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
			progressAttachDto.setAttachNo(rs.getInt("attach_no"));
			progressAttachDto.setProgressNo(rs.getInt("progress_no"));
		}
		else {
			progressAttachDto = null;
		}

		con.close();
		
		return progressAttachDto;
	}
	
	public boolean delete(int progressNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete progress_attach where progress_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, progressNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
}
