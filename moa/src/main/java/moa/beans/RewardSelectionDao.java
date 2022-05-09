package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RewardSelectionDao {

	// 상세 조회
	public RewardSelectionDto selectOne(int selectionFundingNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from reward_selection where selection_funding_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, selectionFundingNo);	
		ResultSet rs = ps.executeQuery();
		
		RewardSelectionDto rewardSelectionDto; 
		if(rs.next()) {
			rewardSelectionDto = new RewardSelectionDto();
			
			rewardSelectionDto.setSelectionFundingNo(rs.getInt("selection_funding_no"));
			rewardSelectionDto.setSelectionRewardNo(rs.getInt("selection_reward_no"));
			rewardSelectionDto.setSelectionProjectNo(rs.getInt("selection_project_no"));
			rewardSelectionDto.setSelectionRewardAmount(rs.getInt("selection_reward_amount"));
			rewardSelectionDto.setSelectionPrice(rs.getInt("selection_price"));
		} else {
			rewardSelectionDto = null; 
		}
		
		con.close();
		
		return rewardSelectionDto;
	}
}
