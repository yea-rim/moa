package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FundingDao {
	
	// 펀딩 목록 조회 (회원번호) 
	public List<FundingDto> selectList(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from funding where funding_member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		
		ResultSet rs = ps.executeQuery();
		
		List<FundingDto> list = new ArrayList<FundingDto>();
		while(rs.next()) {
			FundingDto fundingDto = new FundingDto();
			
			fundingDto.setFundingNo(rs.getInt("funding_no"));
			fundingDto.setFundingMemberNo(rs.getInt("funding_member_no"));
			fundingDto.setFundingDate(rs.getDate("funding_date"));
			fundingDto.setFundingPost(rs.getString("funding_post"));
			fundingDto.setFundingBasicAddress(rs.getString("funding_basic_address"));
			fundingDto.setFundingPostMessage(rs.getString("funding_post_message"));
			fundingDto.setFundingPhone(rs.getString("funding_phone"));
			fundingDto.setFundingCancelDate(rs.getDate("funding_cancel_date"));
			fundingDto.setFundingPaymentDate(rs.getDate("funding_payment_date"));
			fundingDto.setFundingDetailAddress(rs.getString("funding_detail_address"));
			fundingDto.setFundingTotalprice(rs.getInt("funding_total_price"));
			fundingDto.setFundingTotaldelivery(rs.getInt("funding_total_delivery"));
			
			list.add(fundingDto);
		}
		
		con.close();
		
		return list;
	}

	// 상세 조회 (회원번호) 
	public FundingDto selectOne(int fundingNo, int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from funding where funding_no = ? and funding_member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, fundingNo);
		ps.setInt(2, memberNo);		
		ResultSet rs = ps.executeQuery();
		
		FundingDto fundingDto;
		if(rs.next()) {
			fundingDto = new FundingDto();
			
			fundingDto.setFundingNo(rs.getInt("funding_no"));
			fundingDto.setFundingMemberNo(rs.getInt("funding_member_no"));
			fundingDto.setFundingDate(rs.getDate("funding_date"));
			fundingDto.setFundingPost(rs.getString("funding_post"));
			fundingDto.setFundingBasicAddress(rs.getString("funding_basic_address"));
			fundingDto.setFundingPostMessage(rs.getString("funding_post_message"));
			fundingDto.setFundingPhone(rs.getString("funding_phone"));
			fundingDto.setFundingCancelDate(rs.getDate("funding_cancel_date"));
			fundingDto.setFundingPaymentDate(rs.getDate("funding_payment_date"));
			fundingDto.setFundingDetailAddress(rs.getString("funding_detail_address"));
			fundingDto.setFundingTotalprice(rs.getInt("funding_total_price"));
			fundingDto.setFundingTotaldelivery(rs.getInt("funding_total_delivery"));
		} else {
			fundingDto = null; 
		}
		
		con.close();
		
		return fundingDto;
	}
	
	public int getFundingSequence() throws Exception{
		String sql = "select funding_seq.nextval from dual";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int fundingSeq = rs.getInt(1);
		
		con.close();
		return fundingSeq;
	}
	
	public void insert(FundingDto fundingDto) throws Exception{
		String sql = "insert into funding(funding_no, funding_member_no, funding_getter, funding_post, "
				+ "funding_basic_address, funding_detail_address, funding_phone, funding_post_message, "
				+ "funding_payment_date, funding_totalprice, funding_totaldelivery) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, fundingDto.getFundingNo());
		ps.setInt(2, fundingDto.getFundingMemberNo());
		ps.setString(3, fundingDto.getFundingGetter());
		ps.setString(4, fundingDto.getFundingPost());
		ps.setString(5, fundingDto.getFundingBasicAddress());
		ps.setString(6, fundingDto.getFundingDetailAddress());
		ps.setString(7, fundingDto.getFundingPhone());
		ps.setString(8, fundingDto.getFundingPostMessage());
		ps.setDate(9, fundingDto.getFundingPaymentDate());
		ps.setInt(10, fundingDto.getFundingTotalprice());
		ps.setInt(11, fundingDto.getFundingTotaldelivery());
		
		ps.execute();
		con.close();
	}
	
	//결제 실행 메서드
	public boolean paymentCheck() throws Exception {
		
		String sql = "update (select * from funding where funding_cancel_date is null and funding_payment_date <= sysdate) set funding_ispayment = 1";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
}
