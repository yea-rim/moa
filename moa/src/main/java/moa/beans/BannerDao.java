package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BannerDao {
	//전체 목록 조회
	public List<BannerDto> selectList(int p, int s) throws Exception {
		int end = p * s;
		int begin = end - (s - 1);
		
		Connection con = JdbcUtils.getConnection();

		String sql ="select*from(" 
				+ "select rownum rn, TMP.* from (" 
				+ "select * from banner"
				+ ") TMP" 
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();

		List<BannerDto> list = new ArrayList<>();
		while (rs.next()) {
			BannerDto bannerDto = new BannerDto();
			bannerDto.setAttachNo(rs.getInt("attach_no"));
			bannerDto.setProjectNo(rs.getInt("project_no"));
			bannerDto.setBannerTerm(rs.getInt("banner_term"));
			bannerDto.setBannerStartDate(rs.getDate("banner_start_date"));
			bannerDto.setBannerPermission(rs.getInt("banner_permission"));
			
			list.add(bannerDto);
		}
		con.close();
		return list;
	}
	
	//배너 관리 페이지 페이지네이션
	public int CountByPaging() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from banner";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}
	
	//배너 승인 처리
	public boolean bannerPermit(int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update banner set banner_permission = 1 where project_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectNo);
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}
}
