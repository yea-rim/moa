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
				+ "select * from pj_qna where qna_project_no = ? and depth = 0 connect by prior qna_no = super_no start with super_no = 0 order siblings by group_no desc, qna_no asc )"
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
//	프로젝트 번호, 페이지정보 넣으면 문의글 목록 조회 자기글까지 조회
	public List<PjQnaDto> selectOpen(int qnaProjectNo, int p, int s, int memberNo) throws Exception{
		int end = p * s;
		int begin = end - ( s - 1 );
		
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from pj_qna where qna_project_no = ? and depth = 0 and (qna_lock = 0 or qna_member_no = ?) connect by prior qna_no = super_no start with super_no = 0 order siblings by group_no desc, qna_no asc )"
				+ "TMP)"
				+ " where rn between ? and ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, qnaProjectNo);
		ps.setInt(3, begin);
		ps.setInt(4, end);
		ps.setInt(2, memberNo);
		
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
//	프로젝트 번호, 페이지정보 넣으면 문의글 목록 조회 자기글까지 조회(비회원 용)
	public List<PjQnaDto> selectOpen(int qnaProjectNo, int p, int s) throws Exception{
		int end = p * s;
		int begin = end - ( s - 1 );
		
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from pj_qna where qna_project_no = ? and depth = 0 and qna_lock = 0 connect by prior qna_no = super_no start with super_no = 0 order siblings by group_no desc, qna_no asc )"
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
		
		String sql = "select count(*) from pj_qna where qna_project_no = ? and depth = 0";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		int count = rs.getInt(1);
		
		return count;
	}
	
	//프로젝트 번호 넣으면 비밀글 제외한 문의글 수 반환(자기가 쓴 글 포함)
	public int countByPagingOpen(int projectNo, int memberNo) throws Exception{
		
		String sql = "select count(*) from pj_qna where qna_project_no = ? and depth = 0 and (qna_lock = 0 or qna_member_no = ?)";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		ps.setInt(2, memberNo);
		
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		int count = rs.getInt(1);
		
		return count;
	}
	
	//프로젝트 번호 넣으면 비밀글 제외한 문의글 수 반환
		public int countByPagingOpen(int projectNo) throws Exception{
			
			String sql = "select count(*) from pj_qna where qna_project_no = ? and qna_lock = 0 and depth = 0";
			
			Connection con = JdbcUtils.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setInt(1, projectNo);
			
			ResultSet rs = ps.executeQuery();
			
			rs.next();
			
			int count = rs.getInt(1);
			
			return count;
		}
	
	// 상품문의 작성
	public void write(PjQnaDto pjQnaDto) throws Exception{
		
		String sql = "insert into pj_qna(qna_no, qna_member_no, qna_project_no, qna_title, qna_content, qna_lock, group_no, super_no, depth) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, pjQnaDto.getQnaNo());
		ps.setInt(2, pjQnaDto.getQnaMemberNo());
		ps.setInt(3, pjQnaDto.getQnaProjectNo());
		ps.setString(4, pjQnaDto.getQnaTitle());
		ps.setString(5, pjQnaDto.getQnaContent());
		ps.setInt(6, pjQnaDto.getQnaLock());
		ps.setInt(7, pjQnaDto.getGroupNo());
		ps.setInt(8, pjQnaDto.getSuperNo());
		ps.setInt(9, pjQnaDto.getDepth());
		
		
		ps.execute();
		
		con.close();
	}
	
	//상품문의 삭제
	public boolean delete(int qnaNo) throws Exception {
		
		String sql = "delete pj_qna where group_no = (select group_no from pj_qna where qna_no = ?)";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, qnaNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	//상품문의 시퀀스 생성
	public int getSequence() throws Exception {
		
		String sql = "select pj_qna_seq.nextval from dual";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		int num = rs.getInt(1);
		con.close();
		return num;
	}
	
	//상품문의글 번호로 조회
	public PjQnaDto selectOne(int qnaNo) throws Exception{
		String sql = "select * from pj_qna where qna_no = ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, qnaNo);
		
		ResultSet rs = ps.executeQuery();
		
		PjQnaDto pjQnaDto = new PjQnaDto();
		
		if(rs.next()) {
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
		}else {
			pjQnaDto = null;
		}
		con.close();
		
		return pjQnaDto;
	}
	
	//상품 문의글 답글여부 얻는 메서드
	public boolean isAnswer(int QnaNo) throws Exception{
		String sql = "select count(*) from pj_qna where group_no = (select group_no from pj_qna where qna_no = ?)";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, QnaNo);
		
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		
		return count > 1;
		
	}
	
	//답글 내용 조회 메서드
	public PjQnaDto selectOneAnswer(int qnaNo) throws Exception{
		String sql = "select * from pj_qna where depth = 1 and group_no = (select group_no from pj_qna where qna_no = ?)";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		
		ps.setInt(1, qnaNo);
		
		ResultSet rs = ps.executeQuery();
		
		
		PjQnaDto pjQnaDto = new PjQnaDto();
		if(rs.next()) {
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
		}else {
			pjQnaDto = null;
		}
		
		con.close();
		
		return pjQnaDto;
	}
	
	public boolean edit(PjQnaDto pjQnaDto) throws Exception{
		
		String sql = "update pj_qna set qna_title = ?, qna_content = ?, qna_lock = ?  where qna_no = ? ";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(4, pjQnaDto.getQnaNo());
		ps.setString(1, pjQnaDto.getQnaTitle());
		ps.setString(2, pjQnaDto.getQnaContent());
		ps.setInt(3, pjQnaDto.getQnaLock());
		
		int update = ps.executeUpdate();
		
		con.close();
		
		return update > 0;
	}
	
}
