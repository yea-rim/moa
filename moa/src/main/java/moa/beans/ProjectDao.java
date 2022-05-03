package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ProjectDao {

	//프로젝트 생성(신청)
	public void insert(ProjectDto projectDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into project(project_no, project_seller_no, project_category, project_name, project_summary, project_target_money, project_start_date, project_semi_finish, project_finish_date)"
					+ " values(project_seq.nextval,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, 23);
		ps.setString(2, projectDto.getProjectCategory());
		ps.setString(3, projectDto.getProjectName());
		ps.setString(4, projectDto.getProjectSummary());
		ps.setInt(5, projectDto.getProjectTargetMoney());
		ps.setDate(6, projectDto.getProjectStartDate());
		ps.setDate(7, projectDto.getProjectSemiFinish());
		ps.setDate(8, projectDto.getProjectFinishDate());
		ps.execute();
		
		con.close();
		
	}
}
