package moa.beans;

public class AttachDto {
	
	private int attachNo;
	private String attachUploadname;
	private String attachSavename;
	private String attachType;
	private long attachSize;
	
	public AttachDto() {
		super();
	}

	public int getAttachNo() {
		return attachNo;
	}

	public void setAttachNo(int attachNo) {
		this.attachNo = attachNo;
	}

	public String getAttachUploadname() {
		return attachUploadname;
	}

	public void setAttachUploadname(String attachUploadname) {
		this.attachUploadname = attachUploadname;
	}

	public String getAttachSavename() {
		return attachSavename;
	}

	public void setAttachSavename(String attachSavename) {
		this.attachSavename = attachSavename;
	}

	public String getAttachType() {
		return attachType;
	}

	public void setAttachType(String attachType) {
		this.attachType = attachType;
	}

	public long getAttachSize() {
		return attachSize;
	}

	public void setAttachSize(long attachSize) {
		this.attachSize = attachSize;
	}

}
