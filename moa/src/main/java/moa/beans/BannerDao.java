package moa.beans;

import java.sql.Connection;
import java.sql.Date;
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
				+ "select * from banner order by banner_no desc nulls last"
				+ ") TMP" 
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();

		List<BannerDto> list = new ArrayList<>();
		while (rs.next()) {
			BannerDto bannerDto = new BannerDto();
			bannerDto.setBannerNo(rs.getInt("banner_no"));
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
	
	//배너 등록 처리
	public boolean bannerRegist(int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update banner set banner_start_date = sysdate where project_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectNo);
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}
	
	//단일 조회
	public BannerDto selectOne(int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from banner where project_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectNo);
		ResultSet rs = ps.executeQuery();
		
		BannerDto bannerDto;
		if(rs.next()) {
			bannerDto = new BannerDto();
			bannerDto.setBannerNo(rs.getInt("banner_no"));
			bannerDto.setAttachNo(rs.getInt("attach_no"));
			bannerDto.setBannerPermission(rs.getInt("banner_permission"));
			bannerDto.setBannerStartDate(rs.getDate("banner_start_date"));
			bannerDto.setBannerTerm(rs.getInt("banner_term"));
		}
		else {
			bannerDto = null;
		}
		
		con.close();
		
		return bannerDto;
	}
	
	//마감날짜 조회
	public Date getBannerFinishDate(int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select banner_start_date + banner_term f from banner where project_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectNo);
		ResultSet rs = ps.executeQuery();
		
		Date finishDate;
		if(rs.next()) {
			finishDate = rs.getDate("f");
		}
		else {
			finishDate = null;
		}
		
		con.close();
		
		return finishDate;
	}
	
	// 배너 시퀀스 생성
	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select banner_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();
		rs.next(); // 데이터가 무조건 1개이기 때문에 바로 이동 지시 (무조건 true가 나옴)
		int bannerNo = rs.getInt("nextval");

		con.close();
		
		return bannerNo;
		
	}
	
	//배너 신청
	public void insert(BannerDto bannerDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "INSERT INTO banner(banner_no, project_no, attach_no, banner_term) VALUES(?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bannerDto.getBannerNo());
		ps.setInt(2, bannerDto.getProjectNo());
		ps.setInt(3, bannerDto.getAttachNo());
		ps.setInt(4, bannerDto.getBannerTerm());
		ps.execute();
		
		con.close();
	}
	
	//배너에 올라갈 이미지
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
			
			list.add(bannerDto);
		}
		
		con.close();
		
		return list;
	}
	
}
