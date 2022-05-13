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
		
		String sql = "select * from funding where funding_member_no = ? order by funding_date desc";
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
			fundingDto.setFundingDetailAddress(rs.getString("funding_detail_address"));
			fundingDto.setFundingPostMessage(rs.getString("funding_post_message"));
			fundingDto.setFundingPhone(rs.getString("funding_phone"));
			fundingDto.setFundingCancelDate(rs.getDate("funding_cancel_date"));
			fundingDto.setFundingPaymentDate(rs.getDate("funding_payment_date"));
			fundingDto.setFundingTotalprice(rs.getInt("funding_totalprice"));
			fundingDto.setFundingTotaldelivery(rs.getInt("funding_totaldelivery"));
			fundingDto.setFundingGetter(rs.getString("funding_getter"));
			fundingDto.setFundingIspayment(rs.getString("funding_ispayment"));
			
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
			fundingDto.setFundingDetailAddress(rs.getString("funding_detail_address"));
			fundingDto.setFundingPostMessage(rs.getString("funding_post_message"));
			fundingDto.setFundingPhone(rs.getString("funding_phone"));
			fundingDto.setFundingCancelDate(rs.getDate("funding_cancel_date"));
			fundingDto.setFundingPaymentDate(rs.getDate("funding_payment_date"));
			fundingDto.setFundingTotalprice(rs.getInt("funding_totalprice"));
			fundingDto.setFundingTotaldelivery(rs.getInt("funding_totaldelivery"));
			fundingDto.setFundingGetter(rs.getString("funding_getter"));
			fundingDto.setFundingIspayment(rs.getString("funding_ispayment"));
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
	
	
	// 특정 프로젝트에 대한 펀딩 번호들 가져오기 
	public List<FundingDto> selectFundingNo (int p, int s, int projectNo) throws Exception {
		int end = p * s;
		int begin = end - (s - 1);
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select distinct funding_no, funding_member_no from member_funding_info where project_no = ? order by funding_no desc "
				+ ") TMP"
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectNo);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();
		
		List<FundingDto> list = new ArrayList<>();
		while(rs.next()) {
			FundingDto fundingDto = new FundingDto();
			
			fundingDto.setFundingNo(rs.getInt("funding_no"));
			fundingDto.setFundingMemberNo(rs.getInt("funding_member_no"));
			
			list.add(fundingDto);
		}
		
		con.close();
		
		return list; 
	}

	
	// 총 결제 금액 조회
	public int getTotalPay(int fundingNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select funding_totalprice + funding_totaldelivery from funding where funding_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, fundingNo);
		ResultSet rs = ps.executeQuery();
		
		int totalPay; 
		if(rs.next()) {
			totalPay = rs.getInt(1);
		} else {
			totalPay = 0; 
		}
		
		con.close();
		
		return totalPay;
	}
	
	
	// 특정 프로젝트에 대한 펀딩 카운트 가져오기 
	public int countByPaging(int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from member_funding_info where project_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectNo);
		ResultSet rs = ps.executeQuery();
		
		int count; 
		if(rs.next()) {
			count = rs.getInt(1);
		} else {
			count = 0; 
		}
		
		con.close();
		
		return count; 
	}
	
	
	// 펀딩 번호로 프로젝트 번호 가져오기 
	public int getProjectNo(int fundingNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select distinct project_no from member_funding_info where funding_no = ? order by funding_no desc";
		PreparedStatement ps  = con.prepareStatement(sql);
		ps.setInt(1, fundingNo);
		ResultSet rs = ps.executeQuery();
		
		
		int projectNo;
		if(rs.next()) {
			projectNo = rs.getInt(1);
		} else {
			projectNo = 0; 
		}
		
		con.close();
		
		return projectNo;
	}
	
	// 펀딩 예정 목록 조회 (회원번호) 
		public List<FundingDto> selectWaitList(int memberNo) throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from funding where funding_member_no = ? and project_semi_finish < sysdate order by funding_date desc";
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
				fundingDto.setFundingDetailAddress(rs.getString("funding_detail_address"));
				fundingDto.setFundingPostMessage(rs.getString("funding_post_message"));
				fundingDto.setFundingPhone(rs.getString("funding_phone"));
				fundingDto.setFundingCancelDate(rs.getDate("funding_cancel_date"));
				fundingDto.setFundingPaymentDate(rs.getDate("funding_payment_date"));
				fundingDto.setFundingTotalprice(rs.getInt("funding_totalprice"));
				fundingDto.setFundingTotaldelivery(rs.getInt("funding_totaldelivery"));
				fundingDto.setFundingGetter(rs.getString("funding_getter"));
				fundingDto.setFundingIspayment(rs.getString("funding_ispayment"));
				
				list.add(fundingDto);
			}
			
			con.close();
			
			return list;
		}
		
	
 }
