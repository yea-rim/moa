package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AttachDao {

	// 저장 위치를 지정
	public static final String path = System.getProperty("user.home") + "/upload";

	// 등록
	// 시퀀스 번호 생성
	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select attach_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int number = rs.getInt("nextval");

		con.close();

		return number;
	}

	// 등록
	public void insert(AttachDto attachDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into attach(attach_no, attach_uploadname, attach_savename, attach_type, attach_size) values(?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, attachDto.getAttachNo());
		ps.setString(2, attachDto.getAttachUploadname());
		ps.setString(3, attachDto.getAttachSavename());
		ps.setString(4, attachDto.getAttachType());
		ps.setLong(5, attachDto.getAttachSize());
		ps.execute();

		con.close();
	}

	// 단일조회
	public AttachDto selectOne(int attachNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from attach where attach_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, attachNo);
		ResultSet rs = ps.executeQuery();
		
		AttachDto attachDto;
		if (rs.next()) {
			attachDto = new AttachDto();
			
			attachDto.setAttachNo(rs.getInt("attach_no"));
			attachDto.setAttachUploadname(rs.getString("attach_uploadname"));
			attachDto.setAttachSavename(rs.getString("attach_savename"));
			attachDto.setAttachType(rs.getString("attach_type"));
			attachDto.setAttachSize(rs.getLong("attach_size"));
		} else {
			attachDto = null;
		}
		
		con.close();
		
		return attachDto;
	}
	
	
	
	// 파일 삭제 
	public boolean delete(int attachNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "DELETE attach WHERE attach_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, attachNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0; 
	}
	
	public boolean edit(AttachDto attachDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update attach set attach_uploadname = ?, attach_savename =?, attach_type = ?, attach_size =? where attach_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, attachDto.getAttachUploadname());
		ps.setString(2, attachDto.getAttachSavename());
		ps.setString(3, attachDto.getAttachType());
		ps.setLong(4, attachDto.getAttachSize());
		ps.setInt(5, attachDto.getAttachNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}

	
}
