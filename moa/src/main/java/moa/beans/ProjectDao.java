package moa.beans;

import java.sql.Connection;
import java.sql.Date;
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
			projectDto.setProjectPermission(rs.getInt("project_permission"));
			projectDto.setProjectReadcount(rs.getInt("project_readcount"));

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
		} else if (sort.equals("좋아요순")) {
			standard = "PROJECT_NO DESC";
		} else if (sort.equals("인기순")) {
			standard = "PROJECT_READCOUNT DESC";
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
			projectDto.setProjectPermission(rs.getInt("project_permission"));
			projectDto.setProjectReadcount(rs.getInt("project_readcount"));

			list.add(projectDto);
		}

		return list;
	}
	
	// 진행중인 펀딩 목록(검색어 x, 정렬 o, 판매자 번호)
		public List<ProjectDto> ongoingSelectList(int p, int s, int sellerNo) throws Exception {
			
			int end = p * s;
			int begin = end - (s - 1);
			
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from (" 
					+ "select rownum rn, TMP.* from ("
					+ "SELECT * FROM project WHERE project_seller_no = ? AND project_permission = 1 AND project_start_date < sysdate AND project_semi_finish > sysdate order by PROJECT_NO DESC"
					+ ")TMP" 
					+ ")where rn BETWEEN ? AND ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, sellerNo);
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
				projectDto.setProjectPermission(rs.getInt("project_permission"));
				projectDto.setProjectReadcount(rs.getInt("project_readcount"));
				
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
		} else if (sort.equals("좋아요순")) {
			standard = "PROJECT_NO DESC";
		} else if (sort.equals("인기순")) {
			standard = "PROJECT_READCOUNT DESC";
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
		sql = sql.replace("#2", standard);
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
			projectDto.setProjectPermission(rs.getInt("project_permission"));
			projectDto.setProjectReadcount(rs.getInt("project_readcount"));

			list.add(projectDto);
		}

		return list;
	}

	// 진행중인 펀딩 페이지네이션(검색어 x)
	public int ongoingCountByPaging() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from project WHERE project_permission = 1 AND project_start_date < sysdate AND project_semi_finish > sysdate";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}

	// 진행중인 펀딩 페이지네이션(검색어 o)
	public int ongoingCountByPaging(String type, String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from project WHERE project_permission = 1 AND project_start_date < sysdate AND project_semi_finish > sysdate and instr(#1,?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
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
			projectDto.setProjectPermission(rs.getInt("project_permission"));
			projectDto.setProjectReadcount(rs.getInt("project_readcount"));

			list.add(projectDto);
		}

		return list;
	}

	// 마감된 펀딩 목록(검색어 x, 정렬 o)
	public List<ProjectDto> closingSelectList(int p, int s, String sort) throws Exception {

		String standard;
		if (sort.equals("펀딩액순")) {
			standard = "PROJECT_PRESENT_MONEY DESC";
		} else if (sort.equals("좋아요순")) {
			standard = "PROJECT_NO DESC";
		} else if (sort.equals("인기순")) {
			standard = "PROJECT_READCOUNT DESC";
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
			projectDto.setProjectPermission(rs.getInt("project_permission"));
			projectDto.setProjectReadcount(rs.getInt("project_readcount"));

			list.add(projectDto);
		}

		return list;
	}

	// 마감된 펀딩 목록(검색어 o, 정렬 o)
	public List<ProjectDto> closingSelectList(int p, int s, String type, String keyword, String sort) throws Exception {

		String standard;
		if (sort.equals("펀딩액순")) {
			standard = "PROJECT_PRESENT_MONEY DESC";
		} else if (sort.equals("좋아요순")) {
			standard = "PROJECT_NO DESC";
		} else if (sort.equals("인기순")) {
			standard = "";
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
		sql = sql.replace("#2", standard);
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
			projectDto.setProjectPermission(rs.getInt("project_permission"));
			projectDto.setProjectReadcount(rs.getInt("project_readcount"));

			list.add(projectDto);
		}

		return list;
	}

	// 마감된 펀딩 페이지네이션(검색어 x)
	public int closingCountByPaging() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from project WHERE project_permission = 1 AND project_start_date < sysdate AND project_semi_finish < sysdate";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}

	// 마감된 펀딩 페이지네이션(검색어 x)
	public int closingCountByPaging(String type, String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from project WHERE project_permission = 1 AND project_start_date < sysdate AND project_semi_finish < sysdate AND instr(#1,?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
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
			projectDto.setProjectPermission(rs.getInt("project_permission"));
			projectDto.setProjectReadcount(rs.getInt("project_readcount"));

			list.add(projectDto);
		}

		return list;
	}

	// 예정된 펀딩 목록(검색어 x, 정렬 o)
	public List<ProjectDto> comingSelectList(int p, int s, String sort) throws Exception {

		String standard;
		if (sort.equals("좋아요순")) {
			standard = "PROJECT_NO DESC";
		} else if (sort.equals("인기순")) {
			standard = "PROJECT_READCOUNT DESC";
		} else {
			standard = "PROJECT_NO DESC";
		}

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
			projectDto.setProjectPermission(rs.getInt("project_permission"));
			projectDto.setProjectReadcount(rs.getInt("project_readcount"));

			list.add(projectDto);
		}

		return list;
	}

	// 예정된 펀딩 목록(검색어 o, 정렬 o)
	public List<ProjectDto> comingSelectList(int p, int s, String type, String keyword, String sort) throws Exception {

		String standard;
		if (sort.equals("좋아요순")) {
			standard = "PROJECT_NO DESC";
		} else if (sort.equals("인기순")) {
			standard = "PROJECT_READCOUNT DESC";
		} else {
			standard = "PROJECT_NO DESC";
		}

		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select * from (" + "select rownum rn, TMP.* from ("
				+ "SELECT * FROM project WHERE project_permission = 1 AND project_start_date > sysdate AND instr(#1,?) > 0 order by #2"
				+ ")TMP" + ")where rn BETWEEN ? AND ?";
		sql = sql.replace("#1", type);
		sql = sql.replace("#2", standard);
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
			projectDto.setProjectPermission(rs.getInt("project_permission"));
			projectDto.setProjectReadcount(rs.getInt("project_readcount"));

			list.add(projectDto);
		}

		return list;
	}

	// 편딩예정 페이지네이션(검색어 x)
	public int comingCountByPaging() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from project WHERE project_permission = 1 AND project_start_date > sysdate";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}

	// 편딩예정 페이지네이션(검색어 x)
	public int comingCountByPaging(String type, String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from project WHERE project_permission = 1 AND project_start_date > sysdate AND instr(#1,?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}

	// 인기 프로젝트 top
	public List<ProjectDto> selectTop() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "SELECT * FROM(" + "SELECT rownum rn, TMP.*from("
				+ "SELECT * FROM project WHERE project_permission = 1 ORDER BY project_readcount DESC" + ")TMP"
				+ ") WHERE rn <= 5";
		PreparedStatement ps = con.prepareStatement(sql);
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
			projectDto.setProjectPermission(rs.getInt("project_permission"));
			projectDto.setProjectReadcount(rs.getInt("project_readcount"));

			list.add(projectDto);
		}

		return list;
	}
	
	// 신규 프로젝트
	public List<ProjectDto> selectNew() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "SELECT * FROM("
				+ "SELECT rownum rn, TMP.*from("
				+ "SELECT * FROM project WHERE project_permission = 1 and project_start_date < sysdate ORDER BY project_no desc"
				+ ")TMP"
				+ ") WHERE rn <= 5";
		PreparedStatement ps = con.prepareStatement(sql);
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
			projectDto.setProjectPermission(rs.getInt("project_permission"));
			projectDto.setProjectReadcount(rs.getInt("project_readcount"));

			list.add(projectDto);
		}

		return list;
	}

	// 프로젝트 번호 시퀀스 생성
	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select project_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();
		rs.next(); // 데이터가 무조건 1개이기 때문에 바로 이동 지시 (무조건 true가 나옴)
		int rewardNo = rs.getInt("nextval");

		con.close();
		return rewardNo;
	}

	// 프로젝트 생성(신청)
	public void insert(ProjectDto projectDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into project(project_no, project_seller_no, project_category, project_name, project_summary,"
				+ " project_target_money, project_start_date, project_semi_finish, project_finish_date)"
				+ " values(?,?,?,?,?,?,?,?,?+30)";
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

	// 프로젝트 번호를 넣으면 해당 프로젝트 한개 조회
	public ProjectDto selectOne(int ProjectNo) throws Exception {
		String sql = "select * from project where project_no = ?";

		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, ProjectNo);

		ResultSet rs = ps.executeQuery();

		ProjectDto projectDto;

		if (rs.next()) {
			projectDto = new ProjectDto();
			projectDto.setProjectNo(rs.getInt("project_no"));
			projectDto.setProjectSellerNo(rs.getInt("project_seller_no"));
			projectDto.setProjectName(rs.getString("project_name"));
			projectDto.setProjectSummary(rs.getString("project_summary"));
			projectDto.setProjectTargetMoney(rs.getInt("project_target_money"));
			projectDto.setProjectPresentMoney(rs.getInt("project_present_money"));
			projectDto.setProjectSponsorNo(rs.getInt("project_sponsor_no"));
			projectDto.setProjectStartDate(rs.getDate("project_start_date"));
			projectDto.setProjectSemiFinish(rs.getDate("project_semi_finish"));
			projectDto.setProjectFinishDate(rs.getDate("project_finish_date"));
			projectDto.setProjectPermission(rs.getInt("project_permission"));
			projectDto.setProjectCategory(rs.getString("project_category"));
			projectDto.setProjectReadcount(rs.getInt("project_readcount"));
		} else {
			projectDto = null;
		}

		con.close();

		return projectDto;

	}

	public ProjectVo selectVo(int ProjectNo) throws Exception {
		String sql = "select " + "project_no, " + "(project_semi_finish - trunc(sysdate) + 1) daycount, "
				+ "trunc(project_present_money/project_target_money*100, 1) percent, "
				+ "(select count(j.member_no) from project p left outer join joa j on p.project_no = j.project_no where p.project_no=?) joacount "
				+ "from project where project_no = ?";

		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, ProjectNo);
		ps.setInt(2, ProjectNo);

		ResultSet rs = ps.executeQuery();

		ProjectVo projectVo;
		if (rs.next()) {
			projectVo = new ProjectVo();
			projectVo.setProjectNo(rs.getInt("project_no"));
			projectVo.setDaycount(rs.getInt("daycount"));
			projectVo.setPercent(rs.getInt("percent"));
			projectVo.setJoacount(rs.getInt("joacount"));
		} else {
			projectVo = null;
		}

		con.close();

		return projectVo;
	}

	// 전체 목록
	public List<ProjectDto> allSelectList(int p, int s, String sort) throws Exception {

		String standard;
		if (sort.equals("펀딩액순")) {
			standard = "order by PROJECT_PRESENT_MONEY DESC";
		} else if (sort.equals("최신순")) {
			standard = "order by PROJECT_NO DESC";
		} else if (sort.equals("시작일임박순")) {
			standard = "where sysdate < project_start_date order by project_start_date asc";
		} else {
			standard = "order by project_permission asc";
		}

		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select * from (" + "select rownum rn, TMP.* from (" + "SELECT * FROM project #1" + ")TMP"
				+ ")where rn BETWEEN ? AND ?";
		sql = sql.replace("#1", standard);
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
			projectDto.setProjectPermission(rs.getInt("project_permission"));

			list.add(projectDto);
		}

		return list;
	}

	// 승인이 필요한 프로젝트 목록
	public List<ProjectDto> permitSelectList(int p, int s) throws Exception {

		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select * from (" + "select rownum rn, TMP.* from ("
				+ "SELECT * FROM project WHERE project_permission = 0 order by project_no desc" + ")TMP"
				+ ")where rn BETWEEN ? AND ?";
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
			projectDto.setProjectPermission(rs.getInt("project_permission"));

			list.add(projectDto);
		}

		return list;
	}

	// 프로젝트 승인 (permission update)
	public boolean projectPermit(int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update project set project_permission = 1 where project_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectNo);
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}

	// 프로젝트 거절 (permission update)
	public boolean projectRefuse(int projectNo, String projectRefuseMsg) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update project set project_permission = 2, project_refuse_msg=? where project_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, projectRefuseMsg);
		ps.setInt(2, projectNo);
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}

	// 프로젝트 삭제
	public boolean delete(int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "delete project where project_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, projectNo);
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}

	// 프로젝트 수정
	public boolean edit(ProjectDto projectDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update project set project_category=?,project_name=?,project_summary=?,project_target_money=?,"
				+ "project_start_date=?,project_semi_finish=?,project_finish_date=?+30 where project_no =?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, projectDto.getProjectCategory());
		ps.setString(2, projectDto.getProjectName());
		ps.setString(3, projectDto.getProjectSummary());
		ps.setInt(4, projectDto.getProjectTargetMoney());
		ps.setDate(5, projectDto.getProjectStartDate());
		ps.setDate(6, projectDto.getProjectSemiFinish());
		ps.setDate(7, projectDto.getProjectFinishDate());
		ps.setInt(8, projectDto.getProjectNo());
		int count = ps.executeUpdate();

		con.close();
		return count > 0;

	}

	// 관리자 프로젝트 목록(전체목록) 페이지 네이션
	public int adminCountByPaging() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from project";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}
	
	public Date paymentDate(int projectNo) throws Exception {
		String sql = "select project_semi_finish + 1 from project where project_no = ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		Date paymentDate = rs.getDate(1);
		
		con.close();
		
		return paymentDate;
	}
	
	//프로젝트 후원자수+1 현재모금액 업데이트
	public boolean fundingUpdate(int totalPrice) throws Exception {
		String sql = "update project set project_present_money = project_present_money + ?";
		
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, totalPrice);
		
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
	
	// 진행중인 펀딩 목록(검색어 x, 정렬 o)
		public List<ProjectDto> ongoingSelectList(int p, int s, String sort, int sellerNo) throws Exception {
			
			String standard;
			if (sort.equals("마감임박순")) {
				standard = "PROJECT_FINISH_DATE ASC";
			} else if (sort.equals("펀딩액순")) {
				standard = "PROJECT_PRESENT_MONEY DESC";
			} else if (sort.equals("좋아요순")) {
				standard = "PROJECT_NO DESC";
			} else if (sort.equals("인기순")) {
				standard = "PROJECT_READCOUNT DESC";
			} else {
				standard = "PROJECT_NO DESC";
			}
			
			int end = p * s;
			int begin = end - (s - 1);
			
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from (" 
					+ "select rownum rn, TMP.* from ("
					+ "SELECT * FROM project WHERE project_seller_no = ? AND project_permission = 1 AND project_start_date < sysdate AND project_semi_finish > sysdate order by #2"
					+ ")TMP" 
					+ ")where rn BETWEEN ? AND ?";
			sql = sql.replace("#2", standard);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, sellerNo);
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
				projectDto.setProjectPermission(rs.getInt("project_permission"));
				projectDto.setProjectReadcount(rs.getInt("project_readcount"));
				
				list.add(projectDto);
			}
			
			return list;
		}

}
