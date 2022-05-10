package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class ProjectAttachDao {
	
	//추가
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
	
	// 해당 프로젝트 프로필중에 하나의 attachNo만 가져오는 메소드 
	public int getAttachNo(int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "SELECT * FROM("
				+ "SELECT rownum rn, TMP.*from("
				+ "SELECT* FROM PROJECT_ATTACH WHERE project_no = ? AND attach_type = '프로필' order by attach_no asc"
				+ ")TMP"
				+ ") WHERE rn = 1";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectNo);
		ResultSet rs = ps.executeQuery();
		rs.next();

		int attachNo = rs.getInt("attach_no");
		con.close();

		return attachNo;
	}

	//프로젝트 첨부파일 삭제
	public boolean delete(int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete project_attach where project_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectNo);
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
	}
	
}
