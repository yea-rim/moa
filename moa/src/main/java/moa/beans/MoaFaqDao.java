package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MoaFaqDao {

	// 시퀀스 생성
	public int getFaqNo() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select moa_faq_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();

		int faqNo = rs.getInt("nextval");

		con.close();
		return faqNo;
	}

	// FAQ 등록
	public void insert(MoaFaqDto moaFaqDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "INSERT INTO moa_faq(faq_no, faq_title, faq_category, faq_content) values(?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, moaFaqDto.getFaqNo());
		ps.setString(2, moaFaqDto.getFaqTitle());
		ps.setString(3, moaFaqDto.getFaqCategory());
		ps.setString(4, moaFaqDto.getFaqContent());
		ps.execute();

		con.close();
	}

	// FAQ 조회
	public MoaFaqDto selectOne(int faqNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from moa_faq where faq_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, faqNo);
		ResultSet rs = ps.executeQuery();

		MoaFaqDto moaFaqDto;
		if (rs.next()) {
			moaFaqDto = new MoaFaqDto();

			moaFaqDto.setFaqNo(rs.getInt("faq_no"));
			moaFaqDto.setFaqTitle(rs.getString("faq_title"));
			moaFaqDto.setFaqContent(rs.getString("faq_content"));
			moaFaqDto.setFaqContent(rs.getString("faq_category"));
		} else {
			moaFaqDto = null;
		}

		con.close();
		return moaFaqDto;
	}

	// 수정
	public boolean edit(MoaFaqDto moaFaqDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update moa_faq set faq_title =?, faq_content = ?, faq_category = ? where faq_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, moaFaqDto.getFaqTitle());
		ps.setString(2, moaFaqDto.getFaqContent());
		ps.setString(3, moaFaqDto.getFaqCategory());
		ps.setInt(4, moaFaqDto.getFaqNo());
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

	// 전체 목록
	public List<MoaFaqDto> allSelectList(int p, int s, String sort) throws Exception {

		String standard;
		if (sort.equals("회원정보")) {
			standard = "where faq_category = '회원정보'";
		} else if (sort.equals("운영정책")) {
			standard = "where faq_category = '운영정책'";
		} else if (sort.equals("이용문의")) {
			standard = "where faq_category = '이용문의'";
		} else if (sort.equals("기타")) {
			standard = "where faq_category = '기타'";
		} else {
			standard = "order by moa_faq desc";
		}

		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select * from "
				+ "(select rownum rn, tmp.* from moa_faq tmp #1) "
				+ "where rn between ? and ?";

		sql = sql.replace("#1", standard);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();

		List<MoaFaqDto> list = new ArrayList<>();
		while (rs.next()) {
			MoaFaqDto moaFaqDto = new MoaFaqDto();

			moaFaqDto.setFaqNo(rs.getInt("faq_no"));
			moaFaqDto.setFaqTitle(rs.getString("faq_title"));
			moaFaqDto.setFaqContent(rs.getString("faq_content"));
			moaFaqDto.setFaqContent(rs.getString("faq_category"));

			list.add(moaFaqDto);
		}

		return list;
	}
	
	// 목록(전체목록) 페이지 네이션
	public int countByPaging() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from moa_faq";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}

}
