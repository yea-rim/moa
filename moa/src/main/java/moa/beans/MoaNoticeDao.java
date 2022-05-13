package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MoaNoticeDao {

	// 전체목록 조회(검색어 x)
	public List<MoaNoticeDto> selectList(int p, int s) throws Exception {
		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select*from(" + "select rownum rn, TMP.* from ("
				+ "select * from moa_notice order by notice_no desc" + ") TMP" + ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();

		List<MoaNoticeDto> list = new ArrayList<>();
		while (rs.next()) {
			MoaNoticeDto moaNoticeDto = new MoaNoticeDto();
			moaNoticeDto.setNoticeNo(rs.getInt("notice_no"));
			moaNoticeDto.setNoticeTitle(rs.getString("notice_title"));
			moaNoticeDto.setNoticeTime(rs.getDate("notice_time"));
			moaNoticeDto.setNoticeReadcount(rs.getInt("notice_readcount"));
			list.add(moaNoticeDto);
		}

		con.close();

		return list;
	}

	// 메인용 
	public List<MoaNoticeDto> selectMain() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select*from(" 
				+ "select rownum rn, TMP.* from ("
				+ "select * from moa_notice order by notice_no desc" 
				+ ") TMP" 
				+ ") where rn <= 10";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<MoaNoticeDto> list = new ArrayList<>();
		while (rs.next()) {
			MoaNoticeDto moaNoticeDto = new MoaNoticeDto();
			moaNoticeDto.setNoticeNo(rs.getInt("notice_no"));
			moaNoticeDto.setNoticeTitle(rs.getString("notice_title"));
			moaNoticeDto.setNoticeTime(rs.getDate("notice_time"));
			moaNoticeDto.setNoticeReadcount(rs.getInt("notice_readcount"));
			list.add(moaNoticeDto);
		}

		con.close();

		return list;
	}

	// 전체목록 조회(검색어 o)
	public List<MoaNoticeDto> selectList(int p, int s, String type, String keyword) throws Exception {
		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select*from(" + "select rownum rn, TMP.* from ("
				+ "select * from moa_notice where instr(#1, ?) > 0 order by notice_no desc" + ") TMP"
				+ ") where rn between ? and ?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();

		List<MoaNoticeDto> list = new ArrayList<>();
		while (rs.next()) {
			MoaNoticeDto moaNoticeDto = new MoaNoticeDto();
			moaNoticeDto.setNoticeNo(rs.getInt("notice_no"));
			moaNoticeDto.setNoticeTitle(rs.getString("notice_title"));
			moaNoticeDto.setNoticeTime(rs.getDate("notice_time"));
			moaNoticeDto.setNoticeReadcount(rs.getInt("notice_readcount"));
			list.add(moaNoticeDto);
		}

		con.close();

		return list;
	}

	public int countByPaging() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from moa_notice";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}

	public int countByPaging(String type, String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from moa_notice where instr(#1, ?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}

	public MoaNoticeDto selectOne(int noticeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from moa_notice where notice_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, noticeNo);
		ResultSet rs = ps.executeQuery();

		MoaNoticeDto moaNoticeDto;
		if (rs.next()) {
			moaNoticeDto = new MoaNoticeDto();

			moaNoticeDto.setNoticeNo(rs.getInt("notice_no"));
			moaNoticeDto.setNoticeTitle(rs.getString("notice_title"));
			moaNoticeDto.setNoticeContent(rs.getString("notice_content"));
			moaNoticeDto.setNoticeTime(rs.getDate("notice_time"));
			moaNoticeDto.setNoticeReadcount(rs.getInt("notice_readcount"));
			moaNoticeDto.setNoticeAdminNo(rs.getInt("notice_admin_no"));
		} else {
			moaNoticeDto = null;
		}

		con.close();

		return moaNoticeDto;
	}

	// 공지사항 시퀀스 생성
	public int getMoaNoticeyNo() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select moa_notice_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();

		int communityNo = rs.getInt("nextval");

		con.close();

		return communityNo;
	}

	// 공지사항 등록
	public void insert(MoaNoticeDto moaNoticeDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "INSERT INTO moa_notice(notice_no, notice_title, notice_content, notice_admin_no) values(?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, moaNoticeDto.getNoticeNo());
		ps.setString(2, moaNoticeDto.getNoticeTitle());
		ps.setString(3, moaNoticeDto.getNoticeContent());
		ps.setInt(4, moaNoticeDto.getNoticeAdminNo());
		ps.execute();

		con.close();
	}

	public boolean delete(int noticeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "delete moa_notice where notice_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, noticeNo);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

	public boolean edit(MoaNoticeDto moaNoticeDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update moa_notice set notice_title =?, notice_content = ? where notice_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, moaNoticeDto.getNoticeTitle());
		ps.setString(2, moaNoticeDto.getNoticeContent());
		ps.setInt(3, moaNoticeDto.getNoticeNo());
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

	// 조회수
	public boolean editReadCount(int noticeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update moa_notice set notice_readcount = notice_readcount+1 where notice_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, noticeNo);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

}
