package moa.beans;

import java.sql.Date;

public class SellerDto {
	private int sellerNo;
	private String sellerNick;
	private Date sellerRegistDate;
	private String sellerAccountBank;
	private String sellerAccountNo;
	private String sellerType;
	private int sellerPermission;
	private String sellerRefuseMsg;
	
	public SellerDto() {
		super();
	}
	
	public int getSellerPermission() {
		return sellerPermission;
	}
	public void setSellerPermission(int sellerPermission) {
		this.sellerPermission = sellerPermission;
	}
	public int getSellerNo() {
		return sellerNo;
	}

	public void setSellerNo(int sellerNo) {
		this.sellerNo = sellerNo;
	}

	public String getSellerNick() {
		return sellerNick;
	}

	public void setSellerNick(String sellerNick) {
		this.sellerNick = sellerNick;
	}

	public Date getSellerRegistDate() {
		return sellerRegistDate;
	}

	public void setSellerRegistDate(Date sellerRegistDate) {
		this.sellerRegistDate = sellerRegistDate;
	}

	public String getSellerAccountBank() {
		return sellerAccountBank;
	}

	public void setSellerAccountBank(String sellerAccountBank) {
		this.sellerAccountBank = sellerAccountBank;
	}

	public String getSellerAccountNo() {
		return sellerAccountNo;
	}

	public void setSellerAccountNo(String sellerAccountNo) {
		this.sellerAccountNo = sellerAccountNo;
	}

	public String getSellerType() {
		return sellerType;
	}

	public void setSellerType(String sellerType) {
		this.sellerType = sellerType;
	}

	public String getSellerRefuseMsg() {
		return sellerRefuseMsg;
	}

	public void setSellerRefuseMsg(String sellerRefuseMsg) {
		this.sellerRefuseMsg = sellerRefuseMsg;
	}

	

}
