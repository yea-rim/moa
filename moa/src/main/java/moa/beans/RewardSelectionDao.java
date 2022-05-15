package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RewardSelectionDao {
	
	public void insert(RewardSelectionDto rewardSelectionDto) throws Exception {
		String sql;
		if(rewardSelectionDto.getSelectionOption() != null) {
			sql = "insert into reward_selection(selection_funding_no, selection_reward_no, selection_reward_amount, selection_option) "
					+ "values(?, ?, ?, ?)";
		}else {
			sql = "insert into reward_selection(selection_funding_no, selection_reward_no, selection_reward_amount) "
					+ "values(?, ?, ?)";
		}
			
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, rewardSelectionDto.getSelectionFundingNo());
		ps.setInt(2, rewardSelectionDto.getSelectionRewardNo());
		ps.setInt(3, rewardSelectionDto.getSelectionRewardAmount());
		if(rewardSelectionDto.getSelectionOption() != null) {
		ps.setString(4, rewardSelectionDto.getSelectionOption());
		}
		
		ps.execute();
		
		con.close();
	}
	
	// 리워드 번호 리스트 조회 (펀딩 번호)
	public List<RewardSelectionDto> getRewardNo(int fundingNo) throws Exception {
		Connection con = JdbcUtils.getConnection();	
		
		String sql = "select * from reward_selection where selection_funding_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, fundingNo);
		ResultSet rs = ps.executeQuery();
		
		List<RewardSelectionDto> list = new ArrayList<>(); 
		
		while(rs.next()) {
			RewardSelectionDto rewardSelectionDto = new RewardSelectionDto();
			
			rewardSelectionDto.setSelectionFundingNo(rs.getInt("selection_funding_no"));
			rewardSelectionDto.setSelectionOption(rs.getString("selection_option"));
			rewardSelectionDto.setSelectionRewardAmount(rs.getInt("selection_reward_amount"));
			rewardSelectionDto.setSelectionRewardNo(rs.getInt("selection_reward_no"));
			
			list.add(rewardSelectionDto);
		}
		
		con.close();
		
		return list; 
	}
	
	// 펀딩 번호로 리워드 셀렉션 삭제 (펀딩 취소)
	public boolean deleteRewardSelection(int fundingNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete reward_selection where selection_funding_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, fundingNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0; 
	}
}
