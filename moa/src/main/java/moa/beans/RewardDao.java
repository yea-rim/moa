package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class RewardDao {
	public void insert(RewardDto rewardDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into reward values(reward_seq.nextval,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, rewardDto.getRewardProjectNo());
		ps.setString(2, rewardDto.getRewardName());
		ps.setString(3, rewardDto.getRewardContent());
		ps.setInt(4, rewardDto.getRewardPrice());
		ps.setInt(5, rewardDto.getRewardStock());
		ps.execute();
		
		con.close();
	}
}
