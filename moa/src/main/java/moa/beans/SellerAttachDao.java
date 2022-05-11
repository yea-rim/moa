package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SellerAttachDao {

	// 추가
	public void insert(SellerAttachDto sellerAttachDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into seller_attach(attach_no, seller_no) values(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, sellerAttachDto.getAttachNo());
		ps.setInt(2, sellerAttachDto.getSellerNo());
		ps.execute();

		con.close();
	}

	// 삭제
	public boolean delete(int sellerNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "delete seller_attach where seller_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, sellerNo);
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}

	// 특정 판매자가 등록한 attachNo 가져오기
	public Integer selectAttachNo(int sellerNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select attach_no from seller_attach where seller_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, sellerNo);

		ResultSet rs = ps.executeQuery();
		Integer attachNo;
		if (rs.next()) {
			attachNo = rs.getInt("attach_no");
		} else {
			attachNo = null;
		}

		con.close();

		return attachNo;
	}
	
	public SellerAttachDto selectOne(int sellerNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from seller_attach where seller_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, sellerNo);
		
		ResultSet rs = ps.executeQuery();
		
		SellerAttachDto sellerAttachDto;
		if(rs.next()) {
			sellerAttachDto = new SellerAttachDto();
			
			sellerAttachDto.setSellerNo(rs.getInt("seller_no"));
			sellerAttachDto.setAttachNo(rs.getInt("attach_no"));
		} else {
			sellerAttachDto = null;
		}
		
		con.close();
		
		return sellerAttachDto; 
	}

}
