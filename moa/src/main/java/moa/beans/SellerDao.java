package moa.beans;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SellerDao {

	// 판매자 신청
	public void insert(SellerDto sellerDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into seller(seller_no, seller_regist_date, seller_account_bank, seller_account_no, "
				+ "seller_nick, seller_type) values (?, ?, ?, ?, ?, ?)";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, sellerDto.getSellerNo());
		ps.setDate(2, (Date) sellerDto.getSellerRegistDate());
		ps.setString(3, sellerDto.getSellerAccountBank());
		ps.setString(4, sellerDto.getSellerAccountNo());
		ps.setString(5, sellerDto.getSellerNick());
		ps.setString(6, sellerDto.getSellerType());
		ps.execute();

		con.close();
	}

	// 상세 조회 (회원 번호로 조회)
	public SellerDto selectOne(int sellerNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from seller where seller_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, sellerNo);

		ResultSet rs = ps.executeQuery();

		SellerDto sellerDto;

		if (rs.next()) {
			sellerDto = new SellerDto();

			sellerDto.setSellerNo(rs.getInt("seller_no"));
			sellerDto.setSellerRegistDate(rs.getDate("seller_regist_date"));
			sellerDto.setSellerAccountBank(rs.getString("seller_account_bank"));
			sellerDto.setSellerAccountNo(rs.getString("seller_account_no"));
			sellerDto.setSellerNick(rs.getString("seller_nick"));
			sellerDto.setSellerType(rs.getString("seller_type"));
		} else {
			sellerDto = null;
		}

		con.close();

		return sellerDto;
	}

	public boolean selectRegistDate(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select seller_regist_date from seller where seller_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, memberNo);
		int registDate = ps.executeUpdate();

		con.close();

		return registDate > 0;
	}

//	목록
	public List<SellerDto> selectList() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from seller order by seller_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<SellerDto> list = new ArrayList<>();
		while (rs.next()) {
			SellerDto sellerDto = new SellerDto();
			sellerDto.setSellerNo(rs.getInt("seller_no"));
			sellerDto.setSellerRegistDate(rs.getDate("seller_regist_date"));
			sellerDto.setSellerAccountBank(rs.getString("seller_account_bank"));
			sellerDto.setSellerAccountNo(rs.getString("seller_account_no"));
			sellerDto.setSellerNick(rs.getString("seller_nick"));
			sellerDto.setSellerType(rs.getString("seller_type"));

			list.add(sellerDto);
		}

		con.close();

		return list;
	}

//	검색
	public List<SellerDto> selectList(String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from exam where instr(seller_nick, ?) > 0 order by seller_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();

		List<SellerDto> list = new ArrayList<>();

		while (rs.next()) {
			SellerDto sellerDto = new SellerDto();
			sellerDto.setSellerNo(rs.getInt("seller_no"));
			sellerDto.setSellerRegistDate(rs.getDate("seller_regist_date"));
			sellerDto.setSellerAccountBank(rs.getString("seller_account_bank"));
			sellerDto.setSellerAccountNo(rs.getString("seller_account_no"));
			sellerDto.setSellerNick(rs.getString("seller_nick"));
			sellerDto.setSellerType(rs.getString("seller_type"));

			list.add(sellerDto);
		}

		con.close();
		return list;
	}

// 승인
	public boolean approve(int sellerNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update seller set seller_regist_date = sysdate where seller_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, sellerNo);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

//	목록 (admin 판매자 관리 페이지 : 승인 날짜 순)
	public List<SellerDto> selectSeller() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from seller order by seller_regist_date asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<SellerDto> list = new ArrayList<>();
		while (rs.next()) {
			SellerDto sellerDto = new SellerDto();
			sellerDto.setSellerNo(rs.getInt("seller_no"));
			sellerDto.setSellerRegistDate(rs.getDate("seller_regist_date"));
			sellerDto.setSellerAccountBank(rs.getString("seller_account_bank"));
			sellerDto.setSellerAccountNo(rs.getString("seller_account_no"));
			sellerDto.setSellerNick(rs.getString("seller_nick"));
			sellerDto.setSellerType(rs.getString("seller_type"));

			list.add(sellerDto);
		}

		con.close();
		return list;
	}

//	검색 (admin 판매자 관리 페이지 : 승인 날짜 순)
	public List<SellerDto> selectSeller(String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from seller where instr(seller_nick, ?) > 0 order by seller_regist_date asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();

		List<SellerDto> list = new ArrayList<>();

		while (rs.next()) {
			SellerDto sellerDto = new SellerDto();
			sellerDto.setSellerNo(rs.getInt("seller_no"));
			sellerDto.setSellerRegistDate(rs.getDate("seller_regist_date"));
			sellerDto.setSellerAccountBank(rs.getString("seller_account_bank"));
			sellerDto.setSellerAccountNo(rs.getString("seller_account_no"));
			sellerDto.setSellerNick(rs.getString("seller_nick"));
			sellerDto.setSellerType(rs.getString("seller_type"));

			list.add(sellerDto);
		}

		con.close();
		return list;
	}

//	목록 (admin 판매자 승인 관리 페이지 : 미승인 상태)
	public List<SellerDto> selectSellerList() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from seller where seller_regist_date = null order by seller_regist_date asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<SellerDto> list = new ArrayList<>();
		while (rs.next()) {
			SellerDto sellerDto = new SellerDto();
			sellerDto.setSellerNo(rs.getInt("seller_no"));
			sellerDto.setSellerRegistDate(rs.getDate("seller_regist_date"));
			sellerDto.setSellerAccountBank(rs.getString("seller_account_bank"));
			sellerDto.setSellerAccountNo(rs.getString("seller_account_no"));
			sellerDto.setSellerNick(rs.getString("seller_nick"));
			sellerDto.setSellerType(rs.getString("seller_type"));

			list.add(sellerDto);
		}

		con.close();
		return list;
	}

//	검색 (admin 판매자 승인 관리 페이지 : 미승인 상태) 검색 구현 X
	public List<SellerDto> selectSellerList(String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from seller where instr(seller_nick, ?) > 0 order by seller_regist_date asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();

		List<SellerDto> list = new ArrayList<>();

		while (rs.next()) {
			SellerDto sellerDto = new SellerDto();
			sellerDto.setSellerNo(rs.getInt("seller_no"));
			sellerDto.setSellerRegistDate(rs.getDate("seller_regist_date"));
			sellerDto.setSellerAccountBank(rs.getString("seller_account_bank"));
			sellerDto.setSellerAccountNo(rs.getString("seller_account_no"));
			sellerDto.setSellerNick(rs.getString("seller_nick"));
			sellerDto.setSellerType(rs.getString("seller_type"));

			list.add(sellerDto);
		}

		con.close();
		return list;
	}

}
