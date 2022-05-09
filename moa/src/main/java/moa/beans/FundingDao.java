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
		
		String sql = "select * from funding F"
				+ "	inner join member M on M.member_no = F.funding_member_no"
				+ "	where F.funding_member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		
		ResultSet rs = ps.executeQuery();
		
		List<FundingDto> list = new ArrayList<FundingDto>();
		while(rs.next()) {
			FundingDto fundingDto = new FundingDto();
			
			fundingDto.setFundingNo(rs.getInt("funding_no"));
			fundingDto.setFundingPackageNo(rs.getInt("funding_package_no"));
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
	public FundingDto selectOne(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from funding where funding_member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		
		ResultSet rs = ps.executeQuery();
		
		FundingDto fundingDto;
		if(rs.next()) {
			fundingDto = new FundingDto();
			
			fundingDto.setFundingNo(rs.getInt("funding_no"));
			fundingDto.setFundingPackageNo(rs.getInt("funding_package_no"));
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
	
	
}
