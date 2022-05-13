package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PjProgressDao {
	
	
	//프로젝트번호를 넣으면 그 프로젝트에 해당하는 진행사항이 리스트로 출력
	public List<PjProgressDto> selectPjProgress(int projectNo) throws Exception{
		String sql = "select * from pj_progress where progress_project_no = ? order by progress_no desc";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		
		ResultSet rs = ps.executeQuery();
		List<PjProgressDto> list = new ArrayList<>();
		
		while(rs.next()) {
			PjProgressDto pjProgressDto = new PjProgressDto();
			pjProgressDto.setProgressNo(rs.getInt("progress_no"));
			pjProgressDto.setProgressProjectNo(rs.getInt("progress_project_no"));
			pjProgressDto.setProgressTitle((rs.getString("progress_title")));;
			pjProgressDto.setProgressContent(rs.getString("progress_content"));
			pjProgressDto.setProgressTime(rs.getDate("progress_time"));
			list.add(pjProgressDto);
		}
		
		con.close();
		
		return list;
	}
	
	public PjProgressDto selectOne(int progressNo) throws Exception {
		String sql = "select * from pj_progress where progress_no = ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, progressNo);
		
		ResultSet rs = ps.executeQuery();
		
		PjProgressDto pjProgressDto;
		if(rs.next()) {
			pjProgressDto = new PjProgressDto();
			pjProgressDto.setProgressNo(rs.getInt("progress_no"));
			pjProgressDto.setProgressProjectNo(rs.getInt("progress_project_no"));
			pjProgressDto.setProgressTitle((rs.getString("progress_title")));;
			pjProgressDto.setProgressContent(rs.getString("progress_content"));
			pjProgressDto.setProgressTime(rs.getDate("progress_time"));
		}else {
			pjProgressDto = null;
		}
		
		con.close();
		
		return pjProgressDto;
	}
	
	public int countByPaging(int projectNo, int p, int s) throws Exception{
		
		String sql = "select count(*) cnt from pj_progress where progress_project_no = ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}
	
	public List<PjProgressDto> select(int projectNo, int p , int s) throws Exception{
		int end = p * s;
		int begin = end - ( s - 1 );
		
		String sql = "select * from("
				+ "select rownum rn, tmp.* from("
				+ "select * from pj_progress where progress_project_no = ? order by progress_no desc)tmp) where rn between ? and ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		
		ResultSet rs = ps.executeQuery();
		List<PjProgressDto> list = new ArrayList<>();
		
		while(rs.next()) {
			PjProgressDto pjProgressDto = new PjProgressDto();
			pjProgressDto.setProgressNo(rs.getInt("progress_no"));
			pjProgressDto.setProgressProjectNo(rs.getInt("progress_project_no"));
			pjProgressDto.setProgressTitle((rs.getString("progress_title")));;
			pjProgressDto.setProgressContent(rs.getString("progress_content"));
			pjProgressDto.setProgressTime(rs.getDate("progress_time"));
			list.add(pjProgressDto);
		}
		
		con.close();
		
		return list;
	}

}
