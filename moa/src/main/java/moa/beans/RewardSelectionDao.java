package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
	
}
