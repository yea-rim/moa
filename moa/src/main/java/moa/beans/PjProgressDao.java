package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PjProgressDao {

	// 프로젝트번호를 넣으면 그 프로젝트에 해당하는 진행사항이 리스트로 출력
	public List<PjProgressDto> selectPjProgress(int projectNo) throws Exception {
		String sql = "select * from pj_progress where progress_project_no = ?";

		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, projectNo);

		ResultSet rs = ps.executeQuery();
		List<PjProgressDto> list = new ArrayList<>();

		while (rs.next()) {
			PjProgressDto pjProgressDto = new PjProgressDto();
			pjProgressDto.setProgressNo(rs.getInt("progress_no"));
			pjProgressDto.setProgressProjectNo(rs.getInt("progress_project_no"));
			pjProgressDto.setProgressTitle((rs.getString("progress_title")));
			;
			pjProgressDto.setProgressContent(rs.getString("progress_content"));
			pjProgressDto.setProgressTime(rs.getDate("progress_time"));
			list.add(pjProgressDto);
		}

		con.close();

		return list;
	}

	public PjProgressDto selectOne(int progressNo) throws Exception {

		Connection con = JdbcUtils.getConnection();

		String sql = "select * from pj_progress where progress_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, progressNo);

		ResultSet rs = ps.executeQuery();

		PjProgressDto pjProgressDto;
		if (rs.next()) {
			pjProgressDto = new PjProgressDto();
			pjProgressDto.setProgressNo(rs.getInt("progress_no"));
			pjProgressDto.setProgressProjectNo(rs.getInt("progress_project_no"));
			pjProgressDto.setProgressTitle((rs.getString("progress_title")));
			;
			pjProgressDto.setProgressContent(rs.getString("progress_content"));
			pjProgressDto.setProgressTime(rs.getDate("progress_time"));
		} else {
			pjProgressDto = null;
		}

		con.close();

		return pjProgressDto;
	}

	// 프로젝트 진행상황 번호 시퀀스 생성
	public int getProgressNo() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select pj_progress_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();
		rs.next(); // 데이터가 무조건 1개이기 때문에 바로 이동 지시 (무조건 true가 나옴)
		int rewardNo = rs.getInt("nextval");

		con.close();
		return rewardNo;
	}

	public void insert(PjProgressDto pjProgressDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into pj_progress(progress_no, progress_project_no, progress_title, progress_content) values(?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, pjProgressDto.getProgressNo());
		ps.setInt(2, pjProgressDto.getProgressProjectNo());
		ps.setString(3, pjProgressDto.getProgressTitle());
		ps.setString(4, pjProgressDto.getProgressContent());
		ps.execute();

		con.close();
	}

	public boolean edit(PjProgressDto pjProgressDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update pj_progress set progress_title = ?, progress_content = ? where progress_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, pjProgressDto.getProgressTitle());
		ps.setString(2, pjProgressDto.getProgressContent());
		ps.setInt(3, pjProgressDto.getProgressNo());
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

	public boolean delete(int progressNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "delete pj_progress where progress_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, progressNo);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

}
