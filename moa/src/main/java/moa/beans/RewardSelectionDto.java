package moa.beans;

public class RewardSelectionDto {
	private int selectionNo;
	private int selectionRewardNo;
	private int selectionRewardAmount;
	private int selectionMemberNo;
	private int selectionOption;
	
	public RewardSelectionDto() {
		super();
	}
	
	public int getSelectionMemberNo() {
		return selectionMemberNo;
	}

	public int getSelectionOption() {
		return selectionOption;
	}

	public void setSelectionMemberNo(int selectionMemberNo) {
		this.selectionMemberNo = selectionMemberNo;
	}

	public void setSelectionOption(int selectionOption) {
		this.selectionOption = selectionOption;
	}
	
	public int getSelectionNo() {
		return selectionNo;
	}

	public void setSelectionNo(int selectionNo) {
		this.selectionNo = selectionNo;
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
