package moa.beans;

public class FundingStatusDto {
	private String fundingDate;
	private int total;
	
	public FundingStatusDto() {
		super();
	}
	public String getFundingDate() {
		return fundingDate;
	}
	public void setFundingDate(String fundingDate) {
		this.fundingDate = fundingDate;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	
}
