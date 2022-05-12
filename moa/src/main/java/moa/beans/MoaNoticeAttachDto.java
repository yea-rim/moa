package moa.beans;

public class MoaNoticeAttachDto {

	private int noticeNo;
	private int attachNo;
	private String attachType;
	

	public String getAttachType() {
		return attachType;
	}

	public void setAttachType(String attachType) {
		this.attachType = attachType;
	}

	public MoaNoticeAttachDto() {
		super();
	}
	
	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public int getAttachNo() {
		return attachNo;
	}

	public void setAttachNo(int attachNo) {
		this.attachNo = attachNo;
	}
	
	
	
}
