package moa.beans;

public class RewardSelectionDto {
	private int selectionFundingNo;
	private int selectionRewardNo;
	private int selectionRewardAmount;
	private String selectionOption;
	
	
	public RewardSelectionDto() {
		super();
	}
	
	public int getSelectionFundingNo() {
		return selectionFundingNo;
	}

	public void setSelectionFundingNo(int selectionFundingNo) {
		this.selectionFundingNo = selectionFundingNo;
	}

	public String getSelectionOption() {
		return selectionOption;
	}

	public void setSelectionOption(String selectionOption) {
		this.selectionOption = selectionOption;
	}

	public int getSelectionRewardNo() {
		return selectionRewardNo;
	}
	public void setSelectionRewardNo(int selectionRewardNo) {
		this.selectionRewardNo = selectionRewardNo;
	}
	public int getSelectionRewardAmount() {
		return selectionRewardAmount;
	}
	public void setSelectionRewardAmount(int selectionRewardAmount) {
		this.selectionRewardAmount = selectionRewardAmount;
	}
	
	
}
