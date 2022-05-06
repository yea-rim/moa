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

//		String sql = "select seller_regist_date from seller where seller_no = ?"; // 원래 쓰여져있던 코드 
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
		while(rs.next()) {
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
		
		while(rs.next()) {
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
