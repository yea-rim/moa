package moa.beans;

public class AttachDto {
	
	private int attachNo;
	private String attachUploadname;
	private String attachSavename;
	private String attachType;
	private int attachSize;
	
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

	public int getAttachSize() {
		return attachSize;
	}

	public void setAttachSize(int attachSize) {
		this.attachSize = attachSize;
	}

}
