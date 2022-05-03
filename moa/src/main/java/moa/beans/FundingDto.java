package moa.beans;

import java.util.Date;

public class FundingDto {
	private int fundingNo;
	private int fundingMemberNo;
	private Date fundingDate;
	private String fundingPost;
	private String fundingBasicAddress;
	private String fundingDetailAddress;
	private String fundingPostMessage;
	private String fundingPhone;
	private Date fundingCancelDate;
	private Date fundingPaymentDate;
	
	public FundingDto() {
		super();
	}
	public int getFundingNo() {
		return fundingNo;
	}
	public int getFundingMemberNo() {
		return fundingMemberNo;
	}
	public Date getFundingDate() {
		return fundingDate;
	}
	public String getFundingPost() {
		return fundingPost;
	}
	public String getFundingBasicAddress() {
		return fundingBasicAddress;
	}
	public String getFundingDetailAddress() {
		return fundingDetailAddress;
	}
	public String getFundingPostMessage() {
		return fundingPostMessage;
	}
	public String getFundingPhone() {
		return fundingPhone;
	}
	public Date getFundingCancelDate() {
		return fundingCancelDate;
	}
	public Date getFundingPaymentDate() {
		return fundingPaymentDate;
	}
	public void setFundingNo(int fundingNo) {
		this.fundingNo = fundingNo;
	}
	public void setFundingMemberNo(int fundingMemberNo) {
		this.fundingMemberNo = fundingMemberNo;
	}
	public void setFundingDate(Date fundingDate) {
		this.fundingDate = fundingDate;
	}
	public void setFundingPost(String fundingPost) {
		this.fundingPost = fundingPost;
	}
	public void setFundingBasicAddress(String fundingBasicAddress) {
		this.fundingBasicAddress = fundingBasicAddress;
	}
	public void setFundingDetailAddress(String fundingDetailAddress) {
		this.fundingDetailAddress = fundingDetailAddress;
	}
	public void setFundingPostMessage(String fundingPostMessage) {
		this.fundingPostMessage = fundingPostMessage;
	}
	public void setFundingPhone(String fundingPhone) {
		this.fundingPhone = fundingPhone;
	}
	public void setFundingCancelDate(Date fundingCancelDate) {
		this.fundingCancelDate = fundingCancelDate;
	}
	public void setFundingPaymentDate(Date fundingPaymentDate) {
		this.fundingPaymentDate = fundingPaymentDate;
	}
	
	
}
