package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class ProjectAttachDao {
	// 등록
	public void insert(ProjectAttachDto projectAttachDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into project_attach(project_no, attachment_no, attach_type) values(?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectAttachDto.getProjectNo());
		ps.setInt(2, projectAttachDto.getAttachNo());
		ps.setString(3, projectAttachDto.getAttachType());
		ps.execute();
		
		con.close();
	}
	
	// 프로필 단일조회
	public ProjectAttachDto selectOneProfile(int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "SELECT * FROM("
				+ "SELECT rownum rn, TMP.*from("
				+ "SELECT* FROM PROJECT_ATTACH WHERE project_no = ? AND attach_type = '프로필'"
				+ ")TMP"
				+ ") WHERE rn = 1;";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectNo);
		ResultSet rs = ps.executeQuery();
		
		ProjectAttachDto projectAttachDto;
		if (rs.next()) {
			projectAttachDto = new ProjectAttachDto();

			projectAttachDto.setAttachNo(rs.getInt("attach_no"));
			projectAttachDto.setProjectNo(rs.getInt("project_no"));
			projectAttachDto.setAttachType(rs.getString("attach_type"));
		} else {
			projectAttachDto = null;
		}

		con.close();

		return projectAttachDto;
	}
}
