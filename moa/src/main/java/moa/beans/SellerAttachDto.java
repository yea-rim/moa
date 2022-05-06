package moa.beans;

public class SellerAttachDto {
	private int attachNo;
	private int sellerNo;
	private String attachType;

	public SellerAttachDto() {
		super();
	}

	public int getAttachNo() {
		return attachNo;
	}

	public void setAttachNo(int attachNo) {
		this.attachNo = attachNo;
	}

	public int getSellerNo() {
		return sellerNo;
	}

	public void setSellerNo(int sellerNo) {
		this.sellerNo = sellerNo;
	}

	public String getAttachType() {
		return attachType;
	}

	public void setAttachType(String attachType) {
		this.attachType = attachType;
	}

}
