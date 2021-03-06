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
				+ "select distinct i.funding_no, i.funding_member_no from member_funding_info i inner join funding f on f.funding_no = i.funding_no where i.project_no = ? and f.funding_cancel_date is null order by i.funding_no desc"
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
		public List<FundingDto> selectWaitList(int p, int s, int memberNo) throws Exception {
			int end = p * s;
			int begin = end - (s - 1);
			
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from ("
					+ "    select rownum rn, TMP.* from ("
					+ "        select * from funding where funding_member_no = ? and funding_ispayment = 0 and funding_cancel_date is null order by funding_no desc"
					+ "    ) TMP"
					+ ") where rn between ? and ? ";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, memberNo);
			ps.setInt(2, begin);
			ps.setInt(3, end);
			
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
		
		// 펀딩 예정 목록 카운팅 
		public int countWaitList(int memberNo) throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select count(*) from funding where funding_member_no = ? and funding_ispayment = 0 and funding_cancel_date is null order by funding_no desc";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, memberNo);
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
		
		
		//회원번호를 넣으면 펀딩 목록을 반환 결제가 된것
		public List<FundingDto> selectSuccessList(int memberNo) throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from funding where funding_member_no = ? and funding_ispayment = 1 and funding_cancel_date is null order by funding_no desc";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, memberNo);
			
			ResultSet rs = ps.executeQuery();
			
			List<FundingDto> list = new ArrayList<>();
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
	

	//결제 실행 메서드
	public boolean paymentCheck() throws Exception {
		
		String sql = "update funding set funding_ispayment = 1 where funding_no = (select pro.funding_no from ("
				+ "select f.*, project_no from funding f inner join ("
				+ "select project_no, funding_no from member_funding_info)s on f.funding_no = s.funding_no) pro inner join ("
				+ "select p.project_no, v.percent from project p inner join project_vo v on p.project_no = v.project_no) vo on pro.project_no = vo.project_no where vo.percent >= 100 and pro.funding_cancel_date is null and pro.funding_payment_date <= sysdate)";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	
	//펀딩 예약 메서드 트랜잭션 관리(펀딩예약 생성 -> 선택한 리워드 목록 생성 -> 리워드 재고감소)
	public void fundingReserve(FundingDto fundingDto, List<RewardSelectionDto> list) throws Exception{
			
			Connection con = JdbcUtils.getConnection();
			con.setAutoCommit(false);
			
		try {
			String sql = "insert into funding(funding_no, funding_member_no, funding_getter, funding_post, "
					+ "funding_basic_address, funding_detail_address, funding_phone, funding_post_message, "
					+ "funding_payment_date, funding_totalprice, funding_totaldelivery) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			
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
			ps.close();
			
			
			for(RewardSelectionDto rewardSelectionDto : list) {
				
			if(rewardSelectionDto.getSelectionOption() != null) {
				sql = "insert into reward_selection(selection_funding_no, selection_reward_no, selection_reward_amount, selection_option) "
						+ "values(?, ?, ?, ?)";
			}else {
				sql = "insert into reward_selection(selection_funding_no, selection_reward_no, selection_reward_amount) "
						+ "values(?, ?, ?)";
			}
				
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, rewardSelectionDto.getSelectionFundingNo());
			ps.setInt(2, rewardSelectionDto.getSelectionRewardNo());
			ps.setInt(3, rewardSelectionDto.getSelectionRewardAmount());
			if(rewardSelectionDto.getSelectionOption() != null) {
			ps.setString(4, rewardSelectionDto.getSelectionOption());
			}
			ps.execute();
			ps.close();
			
			
			sql = "update reward set reward_stock = reward_stock + ? where reward_no = ?";
			
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, -(rewardSelectionDto.getSelectionRewardAmount()));
			ps.setInt(2, rewardSelectionDto.getSelectionRewardNo());
			
			int count = ps.executeUpdate();
			
			if(count == 0) {
				throw new Exception();
			}
			
			ps.close();
			}
			
			con.commit();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			con.rollback();
			throw new Exception();
		}
		
	}
	
	
	//펀딩 취소 메소드 최종본(펀딩취소시 취소날짜 업데이트 -> 수량 재고 업데이트)
	public void fundingCancel(int fundingNo) throws Exception{
		
		Connection con = JdbcUtils.getConnection();
		con.setAutoCommit(false);
		
		try {
			//펀딩번호에대한 리워드 선택정보 받아오기
			String sql = "select selection_reward_no, selection_reward_amount from reward_selection where selection_funding_no = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setInt(1, fundingNo);
			
			ResultSet rs = ps.executeQuery();
			
			List<RewardSelectionDto> list = new ArrayList<>();
			while(rs.next()) {
				RewardSelectionDto rewardSelectionDto = new RewardSelectionDto();
				rewardSelectionDto.setSelectionRewardNo(rs.getInt(1));
				rewardSelectionDto.setSelectionRewardAmount(rs.getInt(2));
				
				list.add(rewardSelectionDto);
			}
			
			ps.close();
			
			//펀딩취소 날짜 업데이트
			sql = "update funding set funding_cancel_date = sysdate where funding_no = ?";
			
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, fundingNo);
			
			int count = ps.executeUpdate();
			
			if(count == 0) {
				throw new Exception();
			}
			ps.close();
			
			//취소된 펀딩 리워드 재고 증가
			for(RewardSelectionDto rewardSelectionDto : list) {
			sql = "update reward set reward_stock = reward_stock + ? where reward_no = ?";
			
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, rewardSelectionDto.getSelectionRewardAmount());
			ps.setInt(2, rewardSelectionDto.getSelectionRewardNo());
			int stockCount = ps.executeUpdate();
			
			if(stockCount == 0) {
				throw new Exception();
			}
			
			ps.close();
			}
			
			
			con.commit();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			con.rollback();
			throw new Exception();
		}
		
		
		
	}
	
	
	
	
	
	// 펀딩 취소 메소드
	public boolean cancelFunding(int fundingNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update funding set funding_cancel_date = sysdate where funding_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, fundingNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0; 
	}
	
	// 펀딩 취소 목록 조회 (회원번호) 
			public List<FundingDto> selectCancelList(int p, int s, int memberNo) throws Exception {
				int end = p * s;
				int begin = end - (s - 1);
				
				Connection con = JdbcUtils.getConnection();
				
				String sql = "select * from ("
						+ "    select rownum rn, TMP.* from ("
						+ "        select * from funding where funding_member_no = ? and funding_cancel_date is not null order by funding_no desc"
						+ "    ) TMP"
						+ ") where rn between ? and ?";
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, memberNo);
				ps.setInt(2, begin);
				ps.setInt(3, end);
				
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
			
			// 펀딩 취소 목록 카운팅 
			public int countFinishList(int memberNo) throws Exception {
				Connection con = JdbcUtils.getConnection();
				
				String sql = "select count(*) from funding where funding_member_no = ? and funding_cancel_date is not null order by funding_no desc";
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, memberNo);
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
}
