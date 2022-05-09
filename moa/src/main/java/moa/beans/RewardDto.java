package moa.beans;

public class RewardDto {
	private int rewardNo;
	private int rewardProjectNo;
	private String rewardName;
	private String rewardContent;
	private int rewardPrice;
	private int rewardStock;
	private int rewardDelivery;
	private int rewardEach;
	
	public RewardDto() {
		super();
	}
	
	
	public int getRewardDelivery() {
		return rewardDelivery;
	}
	public int getRewardEach() {
		return rewardEach;
	}
	public void setRewardDelivery(int rewardDelivery) {
		this.rewardDelivery = rewardDelivery;
	}
	public void setRewardEach(int rewardEach) {
		this.rewardEach = rewardEach;
	}
	public int getRewardNo() {
		return rewardNo;
	}
	public void setRewardNo(int rewardNo) {
		this.rewardNo = rewardNo;
	}
	public int getRewardProjectNo() {
		return rewardProjectNo;
	}
	public void setRewardProjectNo(int rewardProjectNo) {
		this.rewardProjectNo = rewardProjectNo;
	}
	public String getRewardName() {
		return rewardName;
	}
	public void setRewardName(String rewardName) {
		this.rewardName = rewardName;
	}
	public String getRewardContent() {
		return rewardContent;
	}
	public void setRewardContent(String rewardContent) {
		this.rewardContent = rewardContent;
	}
	public int getRewardPrice() {
		return rewardPrice;
	}
	public void setRewardPrice(int rewardPrice) {
		this.rewardPrice = rewardPrice;
	}
	public int getRewardStock() {
		return rewardStock;
	}
	public void setRewardStock(int rewardStock) {
		this.rewardStock = rewardStock;
	}
	
	
	
}
