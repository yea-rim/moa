package moa.beans;

import java.sql.Date;

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
	private int fundingTotalprice;
	private int fundingTotaldelivery;
	private String fundingGetter;
	private String fundingIspayment;
	
	
	
	public FundingDto() {
	}
	
	public int getFundingMemberNo() {
		return fundingMemberNo;
	}

	public void setFundingMemberNo(int fundingMemberNo) {
		this.fundingMemberNo = fundingMemberNo;
	}

	public int getFundingTotalprice() {
		return fundingTotalprice;
	}
	public int getFundingTotaldelivery() {
		return fundingTotaldelivery;
	}
	public void setFundingTotalprice(int fundingTotalprice) {
		this.fundingTotalprice = fundingTotalprice;
	}
	public void setFundingTotaldelivery(int fundingTotaldelivery) {
		this.fundingTotaldelivery = fundingTotaldelivery;
	}
	public int getFundingNo() {
		return fundingNo;
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

	public String getFundingGetter() {
		return fundingGetter;
	}

	public void setFundingGetter(String fundingGetter) {
		this.fundingGetter = fundingGetter;
	}

	public String getFundingIspayment() {
		return fundingIspayment;
	}

	public void setFundingIspayment(String fundingIspayment) {
		this.fundingIspayment = fundingIspayment;
	}
	
	
}
