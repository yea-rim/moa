package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PjQnaDao {
	
	
//	프로젝트 번호, 페이지정보 넣으면 문의글 목록 조회
	public List<PjQnaDto> select(int qnaProjectNo, int p, int s) throws Exception{
		int end = p * s;
		int begin = end - ( s - 1 );
		
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from pj_qna where qna_project_no = ? connect by prior qna_no = super_no start with super_no = 0 order siblings by group_no desc, qna_no asc )"
				+ "TMP)"
				+ " where rn between ? and ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, qnaProjectNo);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		
		ResultSet rs = ps.executeQuery();
		
		List<PjQnaDto> list = new ArrayList<>();
		while(rs.next()) {
			PjQnaDto pjQnaDto = new PjQnaDto();
			pjQnaDto.setQnaNo(rs.getInt("qna_no"));
			pjQnaDto.setQnaMemberNo(rs.getInt("qna_member_no"));
			pjQnaDto.setQnaProjectNo(rs.getInt("qna_project_no"));
			pjQnaDto.setQnaTime(rs.getDate("qna_time"));
			pjQnaDto.setGroupNo(rs.getInt("group_no"));
			pjQnaDto.setSuperNo(rs.getInt("super_no"));
			pjQnaDto.setDepth(rs.getInt("depth"));
			pjQnaDto.setQnaLock(rs.getInt("qna_lock"));
			pjQnaDto.setQnaTitle(rs.getString("qna_title"));
			pjQnaDto.setQnaContent(rs.getString("qna_content"));
			list.add(pjQnaDto);
		}
		
		con.close();
		
		return list;
	}
//	프로젝트 번호, 페이지정보 넣으면 문의글 목록 조회
	public List<PjQnaDto> selectOpen(int qnaProjectNo, int p, int s) throws Exception{
		int end = p * s;
		int begin = end - ( s - 1 );
		
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from pj_qna where qna_project_no = ? and qna_lock = 0 connect by prior qna_no = super_no start with super_no = 0 order siblings by group_no desc, qna_no asc )"
				+ "TMP)"
				+ " where rn between ? and ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, qnaProjectNo);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		
		ResultSet rs = ps.executeQuery();
		
		List<PjQnaDto> list = new ArrayList<>();
		while(rs.next()) {
			PjQnaDto pjQnaDto = new PjQnaDto();
			pjQnaDto.setQnaNo(rs.getInt("qna_no"));
			pjQnaDto.setQnaMemberNo(rs.getInt("qna_member_no"));
			pjQnaDto.setQnaProjectNo(rs.getInt("qna_project_no"));
			pjQnaDto.setQnaTime(rs.getDate("qna_time"));
			pjQnaDto.setGroupNo(rs.getInt("group_no"));
			pjQnaDto.setSuperNo(rs.getInt("super_no"));
			pjQnaDto.setDepth(rs.getInt("depth"));
			pjQnaDto.setQnaLock(rs.getInt("qna_lock"));
			pjQnaDto.setQnaTitle(rs.getString("qna_title"));
			pjQnaDto.setQnaContent(rs.getString("qna_content"));
			list.add(pjQnaDto);
		}
		
		con.close();
		
		return list;
	}
	
	//프로젝트 번호 넣으면 문의글 수 반환
	public int countByPaging(int projectNo) throws Exception {
		
		String sql = "select count(*) from pj_qna where qna_project_no = ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		int count = rs.getInt(1);
		
		return count;
	}
	
	//프로젝트 번호 넣으면 비밀글 제외한 문의글 수 반환
	public int countByPagingOpen(int projectNo) throws Exception{
		
		String sql = "select count(*) from pj_qna where qna_project_no = ? and qna_lock = 0";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		int count = rs.getInt(1);
		
		return count;
	}
	
	
}
