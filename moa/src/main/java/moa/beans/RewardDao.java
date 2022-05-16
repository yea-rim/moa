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
		
		String sql = "insert into reward(reward_no,reward_project_no,reward_name,reward_content,reward_price,reward_stock,reward_delivery,reward_each,reward_isoption)"
				+ " values(reward_seq.nextval,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, rewardDto.getRewardProjectNo());
		ps.setString(2, rewardDto.getRewardName());
		ps.setString(3, rewardDto.getRewardContent());
		ps.setInt(4, rewardDto.getRewardPrice());
		ps.setInt(5, rewardDto.getRewardStock());
		ps.setInt(6, rewardDto.getRewardDelivery());
		ps.setInt(7, rewardDto.getRewardEach());
		ps.setInt(8, rewardDto.getRewardIsoption());
		
		ps.execute();
		
		con.close();
	}
	
	//프로젝트 번호 입력하면 그에 속하는 리워드 리스트 반환
	public List<RewardDto> selectProject(int projectNo) throws Exception{
		String sql = "select * from reward where reward_project_no = ? order by reward_no asc";
		
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
			rewardDto.setRewardDelivery(rs.getInt("reward_delivery"));
			rewardDto.setRewardEach(rs.getInt("reward_each"));
			rewardDto.setRewardIsoption(rs.getInt("reward_isoption"));
			list.add(rewardDto);
		}
		
		con.close();
		
		return list;
	}
	
	
	//리워드 수정
	public boolean edit(RewardDto rewardDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update reward set reward_name=?,reward_content=?,reward_price=?,reward_stock=?,reward_delivery=?,reward_each=?,reward_isoption=? where reward_no =?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, rewardDto.getRewardName());
		ps.setString(2, rewardDto.getRewardContent());	
		ps.setInt(3, rewardDto.getRewardPrice());
		ps.setInt(4, rewardDto.getRewardStock());
		ps.setInt(5, rewardDto.getRewardDelivery());
		ps.setInt(6, rewardDto.getRewardEach());
		ps.setInt(7, rewardDto.getRewardIsoption());
		ps.setInt(8, rewardDto.getRewardNo());
		int count = ps.executeUpdate();
				
		con.close();
		return count>0;
	}
	
	// 프로젝트 번호랑 리워드번호 넣으면 그 리워드 정보(가격,재고,배송비,개별배송여부)반환
	public RewardDto selectOne(int projectNo, int rewardNo) throws Exception {
		String sql = "select reward_price, reward_stock, reward_delivery, reward_each from reward where reward_no = ? and reward_project_no = ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, rewardNo);
		ps.setInt(2, projectNo);
		
		ResultSet rs = ps.executeQuery();
		
		RewardDto rewardDto = new RewardDto();
		if(rs.next()) {
			rewardDto.setRewardPrice(rs.getInt(1));
			rewardDto.setRewardStock(rs.getInt(2));
			rewardDto.setRewardDelivery(rs.getInt(3));
			rewardDto.setRewardEach(rs.getInt(4));
		}else {
			rewardDto = null;
		}
		con.close();
		return rewardDto;
	}
	
	//프로젝트 번호를 넣으면 묶음배송이 가능한 목록중 가장 높은 배송비 하나만 반환
	public int selectDeliveryOne(int projectNo) throws Exception {
		String sql = "select reward_delivery from reward where reward_project_no = ? and reward_each = 0 order by reward_delivery desc";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, projectNo);
		
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		int delivery = rs.getInt(1);
		
		con.close();
		
		return delivery;
	}
	
	
	//리워드 삭제
	public boolean delete(int rewardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete reward where reward_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, rewardNo);
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
	}
	
	//리워드 재고조절 DAO
	public boolean stockCount(int rewardNo, int amount) throws Exception{
		String sql = "update reward set reward_stock = reward_stock + ? where reward_no = ?";
		
		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, amount);
		ps.setInt(2, rewardNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	
	// 특정 프로젝트 관련 리워드 전체 삭제 
	public boolean deleteAll(int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete reward where reward_project_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, projectNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0; 
	}
	
	
	// 특정 리워드의 세부 구성 내용 조회 (리워드 번호)
	public RewardDto selectReward(int rewardNo, int projectNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from reward where reward_no = ? and reward_project_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, rewardNo);
		ps.setInt(2, projectNo);
		ResultSet rs = ps.executeQuery();
		
		RewardDto rewardDto;
		if(rs.next()) {
			rewardDto = new RewardDto();
			
			rewardDto.setRewardNo(rs.getInt("reward_no"));
			rewardDto.setRewardProjectNo(rs.getInt("reward_project_no"));
			rewardDto.setRewardName(rs.getString("reward_name"));
			rewardDto.setRewardContent(rs.getString("reward_content"));
			rewardDto.setRewardPrice(rs.getInt("reward_price"));
			rewardDto.setRewardStock(rs.getInt("reward_stock"));
			rewardDto.setRewardDelivery(rs.getInt("reward_delivery"));
			rewardDto.setRewardEach(rs.getInt("reward_each"));
			rewardDto.setRewardIsoption(rs.getInt("reward_isoption"));
		} else {
			rewardDto = null; 
		}
		
		con.close();
		
		return rewardDto;
	}
}
