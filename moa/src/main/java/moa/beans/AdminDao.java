package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDao {

	public AdminDto selectOne(String adminId) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from admin where admin_id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, adminId);
		
		ResultSet rs = ps.executeQuery();
		
		AdminDto adminDto;
		if(rs.next()) {
			adminDto = new AdminDto();
			adminDto.setAdminId(rs.getString("admin_id"));
			adminDto.setAdminPw(rs.getString("admin_pw"));
		} else {
			adminDto = null; 
		}
		
		con.close();
		
		return adminDto; 
	}
}
