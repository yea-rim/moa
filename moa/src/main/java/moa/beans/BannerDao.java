package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BannerDao {
	
	public void insert(BannerDto bannerDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "INSERT INTO banner(project_no, attach_no, banner_term) VALUES(?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bannerDto.getProjectNo());
		ps.setInt(2, bannerDto.getAttachNo());
		ps.setInt(3, bannerDto.getBannerTerm());
		ps.execute();
		
		con.close();
	}
	
	public List<BannerDto> selectBanner() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from ("
				+ "	select rownum rn, TMP.* from ("
				+ " SELECT * FROM banner WHERE banner_start_date < sysdate AND banner_start_date + banner_term > sysdate "
				+ "	)TMP"
				+ ")where rn <= 4";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<BannerDto> list = new ArrayList<>();
		while(rs.next()) {
			BannerDto bannerDto = new BannerDto();
			bannerDto.setAttachNo(rs.getInt("attach_no"));
			bannerDto.setProjectNo(rs.getInt("project_no"));
		}
		
		con.close();
		
		return list;
	}
	
	public BannerDto selectOne(int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from banner where project_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectNo);
		ResultSet rs = ps.executeQuery();
		
		BannerDto bannerDto;
		if(rs.next()) {
			bannerDto = new BannerDto();
			bannerDto.setAttachNo(rs.getInt("attach_no"));
			bannerDto.setProjectNo(rs.getInt("project_no"));
			bannerDto.setBannerStartDate(rs.getDate("banner_start_date"));
		}
		else {
			bannerDto = null;
		}
		
		con.close();
		
		return bannerDto;
	}
}
