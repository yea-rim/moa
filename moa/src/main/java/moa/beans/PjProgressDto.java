package moa.beans;

import java.sql.Date;

public class PjProgressDto {
	private int progressNo;
	private int progressProjectNo;
	private String progressTitle;
	private String progressContent;
	private Date progressTime;
	
	public int getProgressNo() {
		return progressNo;
	}
	public int getProgressProjectNo() {
		return progressProjectNo;
	}
	public String getProgressTitle() {
		return progressTitle;
	}
	public String getProgressContent() {
		return progressContent;
	}
	public Date getProgressTime() {
		return progressTime;
	}
	public void setProgressNo(int progressNo) {
		this.progressNo = progressNo;
	}
	public void setProgressProjectNo(int progressProjectNo) {
		this.progressProjectNo = progressProjectNo;
	}
	public void setProgressTitle(String progressTitle) {
		this.progressTitle = progressTitle;
	}
	public void setProgressContent(String progressContent) {
		this.progressContent = progressContent;
	}
	public void setProgressTime(Date progressTime) {
		this.progressTime = progressTime;
	}

	public PjProgressDto() {
	}
	
}
