package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProjectDao {

	//프로젝트 번호 시퀀스 생성
	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select project_seq.nextval from dual";
		PreparedStatement ps =  con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		rs.next(); //데이터가 무조건 1개이기 때문에 바로 이동 지시 (무조건 true가 나옴)
		int rewardNo = rs.getInt("nextval");
		
		con.close();
		return rewardNo;
	}
	
	//프로젝트 생성(신청)
	public void insert(ProjectDto projectDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into project(project_no, project_seller_no, project_category, project_name, project_summary, project_target_money, project_start_date, project_semi_finish, project_finish_date)"
					+ " values(?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectDto.getProjectNo());
		ps.setInt(2, 23);
		ps.setString(3, projectDto.getProjectCategory());
		ps.setString(4, projectDto.getProjectName());
		ps.setString(5, projectDto.getProjectSummary());
		ps.setInt(6, projectDto.getProjectTargetMoney());
		ps.setDate(7, projectDto.getProjectStartDate());
		ps.setDate(8, projectDto.getProjectSemiFinish());
		ps.setDate(9, projectDto.getProjectFinishDate());
		ps.execute();
		
		con.close();
	}
}
