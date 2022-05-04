package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProjectDao {

	// 진행중인 펀딩 목록(검색어 o, 정렬x)
	public List<ProjectDto> ongoingSelectList(int p, int s, String type, String keyword) throws Exception {
		
		int end = p * s;
		int begin = end - (s - 1);
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from (" + "select rownum rn, TMP.* from ("
				+ "SELECT * FROM project WHERE project_permission = 1 AND project_start_date < sysdate AND project_semi_finish > sysdate AND instr(#1,?) > 0 order by project_no desc"
				+ ")TMP" + ")where rn BETWEEN ? AND ?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();
		
		List<ProjectDto> list = new ArrayList<>();
		while (rs.next()) {
			ProjectDto projectDto = new ProjectDto();
			projectDto.setProjectNo(rs.getInt("project_no"));
			projectDto.setProjectSellerNo(rs.getInt("project_seller_no"));
			projectDto.setProjectCategory(rs.getString("project_category"));
			projectDto.setProjectName(rs.getString("project_name"));
			projectDto.setProjectSummary(rs.getString("project_summary"));
			projectDto.setProjectTargetMoney(rs.getInt("project_target_money"));
			projectDto.setProjectPresentMoney(rs.getInt("project_present_money"));
			projectDto.setProjectSponsorNo(rs.getInt("project_sponsor_no"));
			projectDto.setProjectStartDate(rs.getDate("project_start_date"));
			projectDto.setProjectSemiFinish(rs.getDate("project_semi_finish"));
			projectDto.setProjectFinishDate(rs.getDate("project_finish_date"));
			projectDto.setProjectPermission(rs.getString("project_permission"));
			
			list.add(projectDto);
		}
		
		return list;
	}
	
	// 진행중인 펀딩 목록(검색어 x, 정렬 o)
	public List<ProjectDto> ongoingSelectList(int p, int s, String sort) throws Exception {
		
		String standard;
		if (sort.equals("마감임박순")) {
			standard = "PROJECT_FINISH_DATE ASC";
		} else if (sort.equals("펀딩액순")) {
			standard = "PROJECT_PRESENT_MONEY DESC";
		} else {
			standard = "PROJECT_NO DESC";
		}
		
		int end = p * s;
		int begin = end - (s - 1);
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from (" + "select rownum rn, TMP.* from ("
				+ "SELECT * FROM project WHERE project_permission = 1 AND project_start_date < sysdate AND project_semi_finish > sysdate order by #2"
				+ ")TMP" + ")where rn BETWEEN ? AND ?";
		sql = sql.replace("#2", standard);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();
		
		List<ProjectDto> list = new ArrayList<>();
		while (rs.next()) {
			ProjectDto projectDto = new ProjectDto();
			projectDto.setProjectNo(rs.getInt("project_no"));
			projectDto.setProjectSellerNo(rs.getInt("project_seller_no"));
			projectDto.setProjectCategory(rs.getString("project_category"));
			projectDto.setProjectName(rs.getString("project_name"));
			projectDto.setProjectSummary(rs.getString("project_summary"));
			projectDto.setProjectTargetMoney(rs.getInt("project_target_money"));
			projectDto.setProjectPresentMoney(rs.getInt("project_present_money"));
			projectDto.setProjectSponsorNo(rs.getInt("project_sponsor_no"));
			projectDto.setProjectStartDate(rs.getDate("project_start_date"));
			projectDto.setProjectSemiFinish(rs.getDate("project_semi_finish"));
			projectDto.setProjectFinishDate(rs.getDate("project_finish_date"));
			projectDto.setProjectPermission(rs.getString("project_permission"));
			
			list.add(projectDto);
		}
		
		return list;
	}
	
	// 진행중인 펀딩 목록(검색어 o, 정렬 o)
	public List<ProjectDto> ongoingSelectList(int p, int s, String type, String keyword, String sort) throws Exception {
		
		String standard;
		if (sort.equals("마감임박순")) {
			standard = "PROJECT_FINISH_DATE ASC";
		} else if (sort.equals("펀딩액순")) {
			standard = "PROJECT_PRESENT_MONEY DESC";
		} else {
			standard = "PROJECT_NO DESC";
		}
		
		int end = p * s;
		int begin = end - (s - 1);
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from (" + "select rownum rn, TMP.* from ("
				+ "SELECT * FROM project WHERE project_permission = 1 AND project_start_date < sysdate AND project_semi_finish > sysdate AND instr(#1,?) > 0 order by #2"
				+ ")TMP" + ")where rn BETWEEN ? AND ?";
		sql = sql.replace("#1", type);
		sql = sql.replace("#2", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();
		
		List<ProjectDto> list = new ArrayList<>();
		while (rs.next()) {
			ProjectDto projectDto = new ProjectDto();
			projectDto.setProjectNo(rs.getInt("project_no"));
			projectDto.setProjectSellerNo(rs.getInt("project_seller_no"));
			projectDto.setProjectCategory(rs.getString("project_category"));
			projectDto.setProjectName(rs.getString("project_name"));
			projectDto.setProjectSummary(rs.getString("project_summary"));
			projectDto.setProjectTargetMoney(rs.getInt("project_target_money"));
			projectDto.setProjectPresentMoney(rs.getInt("project_present_money"));
			projectDto.setProjectSponsorNo(rs.getInt("project_sponsor_no"));
			projectDto.setProjectStartDate(rs.getDate("project_start_date"));
			projectDto.setProjectSemiFinish(rs.getDate("project_semi_finish"));
			projectDto.setProjectFinishDate(rs.getDate("project_finish_date"));
			projectDto.setProjectPermission(rs.getString("project_permission"));
			
			list.add(projectDto);
		}
		
		return list;
	}
	
	
	
	// 마감된 펀딩 목록(검색어 o, 정렬x)
	public List<ProjectDto> closingSelectList(int p, int s, String type, String keyword) throws Exception {
		
		int end = p * s;
		int begin = end - (s - 1);
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from (" + "select rownum rn, TMP.* from ("
				+ "SELECT * FROM project WHERE project_permission = 1 AND project_start_date < sysdate AND project_semi_finish < sysdate AND instr(#1,?) > 0 order by project_no desc"
				+ ")TMP" + ")where rn BETWEEN ? AND ?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();
		
		List<ProjectDto> list = new ArrayList<>();
		while (rs.next()) {
			ProjectDto projectDto = new ProjectDto();
			projectDto.setProjectNo(rs.getInt("project_no"));
			projectDto.setProjectSellerNo(rs.getInt("project_seller_no"));
			projectDto.setProjectCategory(rs.getString("project_category"));
			projectDto.setProjectName(rs.getString("project_name"));
			projectDto.setProjectSummary(rs.getString("project_summary"));
			projectDto.setProjectTargetMoney(rs.getInt("project_target_money"));
			projectDto.setProjectPresentMoney(rs.getInt("project_present_money"));
			projectDto.setProjectSponsorNo(rs.getInt("project_sponsor_no"));
			projectDto.setProjectStartDate(rs.getDate("project_start_date"));
			projectDto.setProjectSemiFinish(rs.getDate("project_semi_finish"));
			projectDto.setProjectFinishDate(rs.getDate("project_finish_date"));
			projectDto.setProjectPermission(rs.getString("project_permission"));
			
			list.add(projectDto);
		}
		
		return list;
	}
	
	// 마감된 펀딩 목록(검색어 x, 정렬 o)
	public List<ProjectDto> closingSelectList(int p, int s, String sort) throws Exception {
		
		String standard;
		if (sort.equals("펀딩액순")) {
			standard = "PROJECT_PRESENT_MONEY DESC";
		} else {
			standard = "PROJECT_NO DESC";
		}
		
		int end = p * s;
		int begin = end - (s - 1);
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from (" + "select rownum rn, TMP.* from ("
				+ "SELECT * FROM project WHERE project_permission = 1 AND project_start_date < sysdate AND project_semi_finish < sysdate order by #2"
				+ ")TMP" + ")where rn BETWEEN ? AND ?";
		sql = sql.replace("#2", standard);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();
		
		List<ProjectDto> list = new ArrayList<>();
		while (rs.next()) {
			ProjectDto projectDto = new ProjectDto();
			projectDto.setProjectNo(rs.getInt("project_no"));
			projectDto.setProjectSellerNo(rs.getInt("project_seller_no"));
			projectDto.setProjectCategory(rs.getString("project_category"));
			projectDto.setProjectName(rs.getString("project_name"));
			projectDto.setProjectSummary(rs.getString("project_summary"));
			projectDto.setProjectTargetMoney(rs.getInt("project_target_money"));
			projectDto.setProjectPresentMoney(rs.getInt("project_present_money"));
			projectDto.setProjectSponsorNo(rs.getInt("project_sponsor_no"));
			projectDto.setProjectStartDate(rs.getDate("project_start_date"));
			projectDto.setProjectSemiFinish(rs.getDate("project_semi_finish"));
			projectDto.setProjectFinishDate(rs.getDate("project_finish_date"));
			projectDto.setProjectPermission(rs.getString("project_permission"));
			
			list.add(projectDto);
		}
		
		return list;
	}
	
	// 마감된 펀딩 목록(검색어 o, 정렬 o)
	public List<ProjectDto> closingSelectList(int p, int s, String type, String keyword, String sort) throws Exception {
		
		String standard;
		if (sort.equals("펀딩액순")) {
			standard = "PROJECT_PRESENT_MONEY DESC";
		} else {
			standard = "PROJECT_NO DESC";
		}
		
		int end = p * s;
		int begin = end - (s - 1);
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from (" + "select rownum rn, TMP.* from ("
				+ "SELECT * FROM project WHERE project_permission = 1 AND project_start_date < sysdate AND project_semi_finish < sysdate AND instr(#1,?) > 0 order by #2"
				+ ")TMP" + ")where rn BETWEEN ? AND ?";
		sql = sql.replace("#1", type);
		sql = sql.replace("#2", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();
		
		List<ProjectDto> list = new ArrayList<>();
		while (rs.next()) {
			ProjectDto projectDto = new ProjectDto();
			projectDto.setProjectNo(rs.getInt("project_no"));
			projectDto.setProjectSellerNo(rs.getInt("project_seller_no"));
			projectDto.setProjectCategory(rs.getString("project_category"));
			projectDto.setProjectName(rs.getString("project_name"));
			projectDto.setProjectSummary(rs.getString("project_summary"));
			projectDto.setProjectTargetMoney(rs.getInt("project_target_money"));
			projectDto.setProjectPresentMoney(rs.getInt("project_present_money"));
			projectDto.setProjectSponsorNo(rs.getInt("project_sponsor_no"));
			projectDto.setProjectStartDate(rs.getDate("project_start_date"));
			projectDto.setProjectSemiFinish(rs.getDate("project_semi_finish"));
			projectDto.setProjectFinishDate(rs.getDate("project_finish_date"));
			projectDto.setProjectPermission(rs.getString("project_permission"));
			
			list.add(projectDto);
		}
		
		return list;
	}
	
	
	// 예정된 펀딩 목록(검색어 o, 정렬x)
	public List<ProjectDto> comingSelectList(int p, int s, String type, String keyword) throws Exception {

		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select * from (" + "select rownum rn, TMP.* from ("
				+ "SELECT * FROM project WHERE project_permission = 1 AND project_start_date > sysdate AND instr(#1,?) > 0 order by project_no desc"
				+ ")TMP" + ")where rn BETWEEN ? AND ?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();

		List<ProjectDto> list = new ArrayList<>();
		while (rs.next()) {
			ProjectDto projectDto = new ProjectDto();
			projectDto.setProjectNo(rs.getInt("project_no"));
			projectDto.setProjectSellerNo(rs.getInt("project_seller_no"));
			projectDto.setProjectCategory(rs.getString("project_category"));
			projectDto.setProjectName(rs.getString("project_name"));
			projectDto.setProjectSummary(rs.getString("project_summary"));
			projectDto.setProjectTargetMoney(rs.getInt("project_target_money"));
			projectDto.setProjectPresentMoney(rs.getInt("project_present_money"));
			projectDto.setProjectSponsorNo(rs.getInt("project_sponsor_no"));
			projectDto.setProjectStartDate(rs.getDate("project_start_date"));
			projectDto.setProjectSemiFinish(rs.getDate("project_semi_finish"));
			projectDto.setProjectFinishDate(rs.getDate("project_finish_date"));
			projectDto.setProjectPermission(rs.getString("project_permission"));

			list.add(projectDto);
		}

		return list;
	}

	// 예정된 펀딩 목록(검색어 x, 정렬 o)
	public List<ProjectDto> comingSelectList(int p, int s, String sort) throws Exception {

		String standard = "PROJECT_NO DESC";

		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select * from (" + "select rownum rn, TMP.* from ("
				+ "SELECT * FROM project WHERE project_permission = 1 AND project_start_date > sysdate order by #2"
				+ ")TMP" + ")where rn BETWEEN ? AND ?";
		sql = sql.replace("#2", standard);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();

		List<ProjectDto> list = new ArrayList<>();
		while (rs.next()) {
			ProjectDto projectDto = new ProjectDto();
			projectDto.setProjectNo(rs.getInt("project_no"));
			projectDto.setProjectSellerNo(rs.getInt("project_seller_no"));
			projectDto.setProjectCategory(rs.getString("project_category"));
			projectDto.setProjectName(rs.getString("project_name"));
			projectDto.setProjectSummary(rs.getString("project_summary"));
			projectDto.setProjectTargetMoney(rs.getInt("project_target_money"));
			projectDto.setProjectPresentMoney(rs.getInt("project_present_money"));
			projectDto.setProjectSponsorNo(rs.getInt("project_sponsor_no"));
			projectDto.setProjectStartDate(rs.getDate("project_start_date"));
			projectDto.setProjectSemiFinish(rs.getDate("project_semi_finish"));
			projectDto.setProjectFinishDate(rs.getDate("project_finish_date"));
			projectDto.setProjectPermission(rs.getString("project_permission"));

			list.add(projectDto);
		}

		return list;
	}

	// 예정된 펀딩 목록(검색어 o, 정렬 o)
	public List<ProjectDto> comingSelectList(int p, int s, String type, String keyword, String sort) throws Exception {

		String standard = "PROJECT_NO DESC";

		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select * from (" + "select rownum rn, TMP.* from ("
				+ "SELECT * FROM project WHERE project_permission = 1 AND project_start_date > sysdate AND instr(#1,?) > 0 order by #2"
				+ ")TMP" + ")where rn BETWEEN ? AND ?";
		sql = sql.replace("#1", type);
		sql = sql.replace("#2", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();

		List<ProjectDto> list = new ArrayList<>();
		while (rs.next()) {
			ProjectDto projectDto = new ProjectDto();
			projectDto.setProjectNo(rs.getInt("project_no"));
			projectDto.setProjectSellerNo(rs.getInt("project_seller_no"));
			projectDto.setProjectCategory(rs.getString("project_category"));
			projectDto.setProjectName(rs.getString("project_name"));
			projectDto.setProjectSummary(rs.getString("project_summary"));
			projectDto.setProjectTargetMoney(rs.getInt("project_target_money"));
			projectDto.setProjectPresentMoney(rs.getInt("project_present_money"));
			projectDto.setProjectSponsorNo(rs.getInt("project_sponsor_no"));
			projectDto.setProjectStartDate(rs.getDate("project_start_date"));
			projectDto.setProjectSemiFinish(rs.getDate("project_semi_finish"));
			projectDto.setProjectFinishDate(rs.getDate("project_finish_date"));
			projectDto.setProjectPermission(rs.getString("project_permission"));

			list.add(projectDto);
		}

		return list;
	}

	public int countByPaging() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from project";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}

	public int countByPaging(String type, String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from project where instr(#1,?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}

}
