package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;


public class ProjectAttachDao {
	public void insert(ProjectAttachDto projectAttachDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into project_attach(attach_no,project_no,attach_type) values(?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectAttachDto.getAttachNo());
		ps.setInt(2,projectAttachDto.getProjectNo());
		ps.setString(3,projectAttachDto.getAttachType());
		ps.execute();
		
		con.close();
	}
}
