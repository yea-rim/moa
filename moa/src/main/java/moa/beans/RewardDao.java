package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RewardDao {
	
	//리워드 생성
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
	
	//프로젝트 번호 입력하면 그에 속하는 리워드 리스트 반환
	public List<RewardDto> selectProject(int projectNo) throws Exception{
		String sql = "select * from reward where reward_project_no = ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		
		ResultSet rs = ps.executeQuery();
		
		
		List<RewardDto> list = new ArrayList<>();
		while(rs.next()) {
			RewardDto rewardDto = new RewardDto();
			rewardDto.setRewardNo(rs.getInt("reward_no"));
			rewardDto.setRewardProjectNo(rs.getInt("reward_project_no"));
			rewardDto.setRewardName(rs.getString("reward_name"));
			rewardDto.setRewardContent(rs.getString("reward_content"));
			rewardDto.setRewardPrice(rs.getInt("reward_price"));
			rewardDto.setRewardStock(rs.getInt("reward_stock"));
			list.add(rewardDto);
		}
		
		con.close();
		
		return list;
	}


}
